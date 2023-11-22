Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1167F5039
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjKVTHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjKVTHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:07:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38E6C1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:07:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517C8C433C7;
        Wed, 22 Nov 2023 19:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700680052;
        bh=uVl7nTlOM0+msqDAdm3xWe+pC9hYDXS7ELazxBmwybM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzgTnDuKDNNI2dRTWMKvM5zYKH+Hpi+NupYJ34h4+8zUd1hf6idxMdSswFWMqeKfU
         48rcSLdxqrCZZIL9AP39WVkFTub17R8lcUv2l7mDetSSotS6IooqzdjIkMxuTN9FZ6
         olz7dYNj7+jdqCIbOvOhmlo1r3Uhepy1nsPgrLnpdUHME2+WdM5mKP5tVu0oEeZ2t9
         uhWw8IXHpVujmXqiytKyBY0V569vdYww4ToNiLHMz6T5Bi+Gnrg9hR8DDqpfUIrdhv
         30/uvy/m/YYen77xPm0Ey3ZlsswsI+qLuGwurfs4LvvnBWOaUKgKsajKeECn5WNvMs
         1xzHjSWZwIFRg==
Date:   Wed, 22 Nov 2023 19:07:25 +0000
From:   Simon Horman <horms@kernel.org>
To:     Wen Gu <guwen@linux.alibaba.com>
Cc:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/7] net/smc: compatible with 128-bits extend
 GID of virtual ISM device
Message-ID: <20231122190725.GB6731@kernel.org>
References: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
 <1700402277-93750-6-git-send-email-guwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700402277-93750-6-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 09:57:55PM +0800, Wen Gu wrote:
> According to virtual ISM support feature defined by SMCv2.1, GIDs of
> virtual ISM device are UUIDs defined by RFC4122, which are 128-bits
> long. So some adaptation work is required. And note that the GIDs of
> existing platform firmware ISM devices still remain 64-bits long.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>

...

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c

...

> @@ -1522,7 +1527,10 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
>  	/* run common cleanup function and build free list */
>  	spin_lock_bh(&dev->lgr_lock);
>  	list_for_each_entry_safe(lgr, l, &dev->lgr_list, list) {
> -		if ((!peer_gid || lgr->peer_gid == peer_gid) &&
> +		if ((!peer_gid->gid ||

Hi Wen Gu,

Previously this condition assumed that peer could be NULL,
and that is still the case in the next condition, a few lines down.
But with this patch peer is unconditionally dereferenced here.

As flagged by Smatch.

> +		     (lgr->peer_gid.gid == peer_gid->gid &&
> +		      !smc_ism_is_virtual(dev) ? 1 :
> +		      lgr->peer_gid.gid_ext == peer_gid->gid_ext)) &&
>  		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
>  			if (peer_gid) /* peer triggered termination */
>  				lgr->peer_shutdown = 1;

...
