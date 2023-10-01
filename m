Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72707B48F1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 19:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjJARqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 13:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjJARqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 13:46:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBC7C9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 10:46:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B0DC433C7;
        Sun,  1 Oct 2023 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696182389;
        bh=YiZtbJcNhba/FnrOoweiMtTxQ8gd/lsjKmXTBE+vY+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/tkNt2PigdOcZY9y6/dEg6esD8e+2u5pg/1Jhss6mXGSAFpZaHCTwf3AkFc7cXCT
         YzIM94Ut+K9YczwebYxrcIUQNWWR/xaVFtiw/nxJPphO9B3Vz8ru56uRhpRuJ76PTU
         kdZdge/r+V6WX7p3xIxPGz1xTbEm41NpIQMPqzJMmR+uWAeKfBc27z/V6zEq1rzpYq
         zBMneWhBVr8a8gA3hk4MEOyA5/XeS/UcRtcmxHmX6+geYf/YlCxrCSt8XvEnoG1QSv
         k8cQT6p/Hey7pYMih2bQdmUUUKa1Vvyilw/HfFunERZRw1abLtMW4c1QM/ldkeLQ9E
         uOZ1Ax/tYIaow==
Date:   Sun, 1 Oct 2023 19:46:25 +0200
From:   Simon Horman <horms@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: fix a potential deadlock on &tx->lock
Message-ID: <20231001174625.GR92317@kernel.org>
References: <20230927181414.59928-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927181414.59928-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 06:14:14PM +0000, Chengfeng Ye wrote:
> It seems that tipc_crypto_key_revoke() could be be invoked by
> wokequeue tipc_crypto_work_rx() under process context and
> timer/rx callback under softirq context, thus the lock acquisition
> on &tx->lock seems better use spin_lock_bh() to prevent possible
> deadlock.
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> tipc_crypto_work_rx() <workqueue>
> --> tipc_crypto_key_distr()
> --> tipc_bcast_xmit()
> --> tipc_bcbase_xmit()
> --> tipc_bearer_bc_xmit()
> --> tipc_crypto_xmit()
> --> tipc_ehdr_build()
> --> tipc_crypto_key_revoke()
> --> spin_lock(&tx->lock)
> <timer interrupt>
>    --> tipc_disc_timeout()
>    --> tipc_bearer_xmit_skb()
>    --> tipc_crypto_xmit()
>    --> tipc_ehdr_build()
>    --> tipc_crypto_key_revoke()
>    --> spin_lock(&tx->lock) <deadlock here>
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>


Hi Chengfeng Ye,

thanks for your patch.

As a fix for Networking this should probably be targeted at the
'net' tree. Which should be denoted in the subject.

        Subject: [PATCH net] ...

And as a fix this patch should probably have a Fixes tag.
This ones seem appropriate to me, but I could be wrong.

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")

I don't think it is necessary to repost just to address these issues,
but the Networking maintainers may think otherwise.

The code change itself looks good to me.
