Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4712F76450A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjG0EqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjG0EqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DF2719
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4828D61D23
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43147C433C7;
        Thu, 27 Jul 2023 04:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690433174;
        bh=jJ20dTz0Ym/WtEBrhoTt2d94CftbA+6S89ow3P/mlHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pgQpzzB/RMyil955eazEmMtK4Qjjx8AUa3A+ajzsNcmsUSIl6UmVeFzQTxIK8UrvB
         0/2epuF3Cv08aLngfCQg/af9vhAKkvPvpy8yPiNNQqLOR3I7eUBNuR4VxCG3H0Ec+4
         QTs/uco97fYzWvdAIaZ7PCu173jYhqOKbXXcjICdjwLnAuOmQYEn3MsprOlrLpfjLr
         45k0ZmYGDLCb3/5hjK8MffP9nBU4fA8Q+QvZt+4Gt6JkCcJmPb5UxcmFzC8TZA0nzS
         tbtqbw00ZDvtxJLDuM23NFE5Jj3OrLIj4znIckTSPIpnLdAhhd95TiVZYqyxoE5Wfx
         9uVYqjmg+XI6w==
Date:   Wed, 26 Jul 2023 21:46:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     isdn@linux-pingi.de, alexanderduyck@fb.com, duoming@zju.edu.cn,
        yangyingliang@huawei.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mISDN: hfcpci: Fix potential deadlock on &hc->lock
Message-ID: <20230726214613.7fee0d7b@kernel.org>
In-Reply-To: <20230725173728.13816-1-dg573847474@gmail.com>
References: <20230725173728.13816-1-dg573847474@gmail.com>
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

On Tue, 25 Jul 2023 17:37:28 +0000 Chengfeng Ye wrote:
> As &hc->lock is acquired by both timer _hfcpci_softirq() and hardirq
> hfcpci_int(), the timer should disable irq before lock acquisition
> otherwise deadlock could happen if the timmer is preemtped by the hadr irq.
> 
> Possible deadlock scenario:
> hfcpci_softirq() (timer)
>     -> _hfcpci_softirq()
>     -> spin_lock(&hc->lock);  
>         <irq interruption>
>         -> hfcpci_int()
>         -> spin_lock(&hc->lock); (deadlock here)  
> 
> This flaw was found by an experimental static analysis tool I am developing
> for irq-related deadlock.
> 
> The tentative patch fixes the potential deadlock by spin_lock_irq()
> in timer.
> 
> But the patch could be not enough since between the lock critical section
> inside the timer, tx_birq() is called in which a lot of stuff is executed
> such as dev_kfree_skb(). I am not sure what's the best way to solve this
> potential deadlock problem.

Yeah, the dev_kfree_skb() should be dev_kfree_skb_any() or _irq()

> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

LGTM, but please repost with a Fixes tag added.
-- 
pw-bot: cr
