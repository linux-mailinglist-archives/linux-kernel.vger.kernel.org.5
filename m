Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC17CA484
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjJPJu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjJPJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:50:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE26AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:50:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1929C433C9;
        Mon, 16 Oct 2023 09:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697449819;
        bh=3qu5yONyWa09qHBA5krufIoFjAXIFT/JnmHaxFdNKbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRflpb9iTrQMM1roVvBLDaaRC/btPdgwE+P5YkY0ui/HfGIgWe422OSHysA8DAeAY
         XbLUi+vCbF1lVsHHtr+bUFY11iQXK9sJiTjNuHX9jL5P8Lm54roOwSkHCB1HUqQAyY
         A7DZ3lGgY8HTvtlHq8hhPkhD+X9px3M4k3HcLZPxehfS4z+bQqWj4+iinJPl+QZixF
         2NoNSGs1CDFItkr8+X9xqwu5CQ/OhYvEM1Fnh7u1Z9BhZUOvJR1ChRSQgLHupg0Y03
         sNMQp9mpUfuPSGvpWcjn/CbhPDY2Q1UemvacMhWvS6kggtPqwuTXSqfYG5/F/XYK49
         sG3yOKByvNj+Q==
Date:   Mon, 16 Oct 2023 11:50:15 +0200
From:   Simon Horman <horms@kernel.org>
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
Subject: Re: [PATCH] net/tls: Fix slab-use-after-free in tls_encrypt_done
Message-ID: <20231016095015.GJ1501712@kernel.org>
References: <VI1P193MB0752428D259D066379242BD099D3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1P193MB0752428D259D066379242BD099D3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 07:02:51PM +0800, Juntong Deng wrote:
> In the current implementation, ctx->async_wait.completion is completed
> after spin_lock_bh, which causes tls_sw_release_resources_tx to
> continue executing and return to tls_sk_proto_cleanup, then return

Hi Juntong Deng,

I'm slightly confused by "causes tls_sw_release_resources_tx to  continue
executing".

What I see in tls_sw_release_resources_tx() is:

        /* Wait for any pending async encryptions to complete */   
        spin_lock_bh(&ctx->encrypt_compl_lock);
        ctx->async_notify = true;
        pending = atomic_read(&ctx->encrypt_pending);
        spin_unlock_bh(&ctx->encrypt_compl_lock);  

Am I wrong in thinking the above will block because
(the same) ctx->encrypt_compl_lock is held in tls_encrypt_done?

> to tls_sk_proto_close, and after that enter tls_sw_free_ctx_tx to kfree
> the entire struct tls_context (including ctx->encrypt_compl_lock).
> 
> Since ctx->encrypt_compl_lock has been freed, subsequent spin_unlock_bh
> will result in slab-use-after-free error. Due to SMP, even using
> spin_lock_bh does not prevent tls_sw_release_resources_tx from continuing
> on other CPUs. After tls_sw_release_resources_tx is woken up, there is no
> attempt to hold ctx->encrypt_compl_lock again, therefore everything
> described above is possible.
> 
> The fix is to put complete(&ctx->async_wait.completion) after
> spin_unlock_bh, making the release after the unlock. Since complete is
> only executed if pending is 0, which means this is the last record, there
> is no need to worry about race condition causing duplicate completes.
> 
> Reported-by: syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=29c22ea2d6b2c5fd2eae
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  net/tls/tls_sw.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 270712b8d391..7abe5a6aa989 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -441,6 +441,7 @@ static void tls_encrypt_done(void *data, int err)
>  	struct sk_msg *msg_en;
>  	bool ready = false;
>  	struct sock *sk;
> +	int async_notify;
>  	int pending;
>  
>  	msg_en = &rec->msg_encrypted;
> @@ -482,10 +483,11 @@ static void tls_encrypt_done(void *data, int err)
>  
>  	spin_lock_bh(&ctx->encrypt_compl_lock);
>  	pending = atomic_dec_return(&ctx->encrypt_pending);
> +	async_notify = ctx->async_notify;
> +	spin_unlock_bh(&ctx->encrypt_compl_lock);
>  
> -	if (!pending && ctx->async_notify)
> +	if (!pending && async_notify)
>  		complete(&ctx->async_wait.completion);
> -	spin_unlock_bh(&ctx->encrypt_compl_lock);
>  
>  	if (!ready)
>  		return;
> -- 
> 2.39.2
> 
> 
