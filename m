Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBA976011C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjGXVWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGXVWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:22:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7FC1993
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABC2C611BE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DFDC433C7;
        Mon, 24 Jul 2023 21:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690233717;
        bh=KcmOvjdsIerNh9iSPOIWnJQYWkn+4DhLR22pWifJh68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wb0PN3QFq+FC5EzT5PMzMn8X3+hXurSz7N4oj71as22oZ5BheFT6FS7tYLQyIqwy0
         FFtVf5qKLvDaIzk2hUrAC/PrgOAfrawHIgRoKeNiIoAGscZTYq1YgvfcWUjDV7FxBc
         qrHZwJx2r0AFP3NldFG4SwYZPD6ryn72aV373L9iENvpkM9WnJ0A67xVCzbme8tsqJ
         A0max3XRxjfoKurA51JQGiaZgb8pKH8Dc3JaKinewdlcORonMTipSfk6V/8nKTYcKx
         5WNcGhpuU3jjItgdoNOO/fNQqTqvfjoUlv+7Ig2Es4zGrsYSR3yazkHm3Axs3Op8R4
         PVkynMm2fhx2g==
Date:   Mon, 24 Jul 2023 14:21:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>, Lin Ma <linma@zju.edu.cn>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i40e: Add length check for IFLA_AF_SPEC parsing
Message-ID: <20230724142155.13c83625@kernel.org>
In-Reply-To: <20230724174435.GA11388@unreal>
References: <20230723075042.3709043-1-linma@zju.edu.cn>
        <20230724174435.GA11388@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 20:44:35 +0300 Leon Romanovsky wrote:
> > @@ -13186,6 +13186,9 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
> >  		if (nla_type(attr) != IFLA_BRIDGE_MODE)
> >  			continue;
> >  
> > +		if (nla_len(attr) < sizeof(mode))
> > +			return -EINVAL;
> > +  
> 
> I see that you added this hunk to all users of nla_for_each_nested(), it
> will be great to make that iterator to skip such empty attributes.
> 
> However, i don't know nettlink good enough to say if your change is
> valid in first place.

Empty attributes are valid, we can't do that.

But there's a loop in rtnl_bridge_setlink() which checks the attributes.
We can add the check there instead of all users, as Leon points out.
(Please just double check that all ndo_bridge_setlink implementation
expect this value to be a u16, they should/)
-- 
pw-bot: cr
