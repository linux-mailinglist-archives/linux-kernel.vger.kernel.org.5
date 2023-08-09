Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6408C775369
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjHIHDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjHIHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:03:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CA5E7D;
        Wed,  9 Aug 2023 00:03:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8208262FBF;
        Wed,  9 Aug 2023 07:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2156BC433C9;
        Wed,  9 Aug 2023 07:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691564587;
        bh=P2+3vf+gBALf2UGu15Ac/T463go2awfYas36ymRipBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jod8fe3hOqqkL3j5kbVUq2qQm+GHBF8hrvNay9C/ZMfrd3yi7fSMXkpSOPrssAYyY
         XULvJ6XtdjS/wtWa0Bj2EYj3VTHUWzs/cqVrGjhHdP/bfuvz2/3u+HllwdGK28edUm
         f537bCuDOhyGl74bvCgASsIme1km/1zAFRKT667qJWOuRBgA6vTnI8B8k4IkxLq57P
         D5d0EisXO8GDSz/9Y6dXfMPwBo2XjVUekxGr/QqBoLiBVRDrCN/VWs55a2djm6qO0C
         Wny/oRsqOQHaA1/3fJZyqczIUAdKCTmEfoRqEgGI56CAb/aNHJDR3VgDTEfNXDjHvp
         gcXSlRpk/JCUQ==
Date:   Wed, 9 Aug 2023 10:03:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, chenhao418@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net] net: hns3: fix strscpy causing content truncation
 issue
Message-ID: <20230809070302.GR94631@unreal>
References: <20230809020902.1941471-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809020902.1941471-1-shaojijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:09:02AM +0800, Jijie Shao wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> hns3_dbg_fill_content()/hclge_dbg_fill_content() is aim to integrate some
> items to a string for content, and we add '\n' and '\0' in the last
> two bytes of content.
> 
> strscpy() will add '\0' in the last byte of destination buffer(one of
> items), it result in finishing content print ahead of schedule and some
> dump content truncation.
> 
> One Error log shows as below:
> cat mac_list/uc
> UC MAC_LIST:
> 
> Expected:
> UC MAC_LIST:
> FUNC_ID  MAC_ADDR            STATE
> pf       00:2b:19:05:03:00   ACTIVE
> 
> The destination buffer is length-bounded and not required to be
> NUL-terminated, so just change strscpy() to memcpy() to fix it.

I think that you should change to strtomem() and not use plain memcpy().

Thanks
