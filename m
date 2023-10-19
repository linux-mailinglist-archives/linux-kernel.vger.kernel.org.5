Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9617CED94
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJSBZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSBZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:25:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996BA124
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:25:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6704C433C8;
        Thu, 19 Oct 2023 01:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697678756;
        bh=Bo2rNx1P5rqGaRjEElKR9ESp+uBQTFt4srxoPCP49qg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sMU+hWZx+AHKSSgK5/4oSCK2E6eC9t2jpi3nyN5NybU+tl2tCFztBba96/APfBvvq
         u/qJp3EtjORVy7stL42taf3tyMTEI213hGi0U+r5iH2qAwdLwTfxURxu9Z29EDSRnS
         5Kfkm6s2DzVngw5z1tzt9dguOMfONFXhab5MIE590zpON8/3hJnjVjg1JdmaSwcYe9
         RwIxwSU+x+FGYErCc5CwSe3ipiRRhmkAOM0F8me9v/oioEr+u+JZBe08YCfSfA8CJW
         HxPgYb+V5eGyrExTi/yKZG3TKXYJWyVcJQ4cSvoEreID/PpI8fhCDPx6Gj51r8/ym3
         u22ebC2xUj6+A==
Date:   Wed, 18 Oct 2023 18:25:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com,
        Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH v2] net/tls: Fix slab-use-after-free in tls_encrypt_done
Message-ID: <20231018182555.28f1a774@kernel.org>
In-Reply-To: <VI1P193MB0752321F24623E024C87886A99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
References: <VI1P193MB0752321F24623E024C87886A99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 00:22:15 +0800 Juntong Deng wrote:
> In the current implementation, ctx->async_wait.completion is completed
> after spin_lock_bh, which causes tls_sw_release_resources_tx to
> continue executing and return to tls_sk_proto_cleanup, then return
> to tls_sk_proto_close, and after that enter tls_sw_free_ctx_tx to kfree
> the entire struct tls_sw_context_tx (including ctx->encrypt_compl_lock).
> 
> Since ctx->encrypt_compl_lock has been freed, subsequent spin_unlock_bh
> will result in slab-use-after-free error. Due to SMP, even using
> spin_lock_bh does not prevent tls_sw_release_resources_tx from continuing
> on other CPUs. After tls_sw_release_resources_tx is woken up, there is no
> attempt to hold ctx->encrypt_compl_lock again, therefore everything
> described above is possible.

Whoever triggered the Tx should wait for all outstanding encryption 
to finish before exiting sendmsg() (or alike).  This looks like 
a band-aid. Sabrina is working on fixes for the async code, lets
get those in first before attempting spot fixes.
-- 
pw-bot: cr
