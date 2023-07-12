Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75380750EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjGLQfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGLQfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:35:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B361E1711
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 485B86183B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B854C433CA;
        Wed, 12 Jul 2023 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689179712;
        bh=lEOMrk2R8PBpUbiIy/xxH/SlLLTYsrBU5sRxDqjf7rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZaB37I0s4Q0o7G57kLJC9B0sVkua69J9BzJ24Pi09bG0toae+Uzc47t3PcSWGXTh
         vqgfRjZIaxOQyR0hnO+TKpNLRtPU3EHNCMfdx2wkTIhaCTkSQAiPGv4j7TaA18cP1S
         cOvjtQtMrodIsiO5Q1TyAB+9hfAXRgrquUu8hDew=
Date:   Wed, 12 Jul 2023 18:35:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] android:Fix error checking for debugfs_create_dir()
 in binder_init()
Message-ID: <2023071257-patronize-unfeeling-cbe5@gregkh>
References: <20230712133920.9509-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712133920.9509-1-machel@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:39:07PM +0800, Wang Ming wrote:
> debugfs_create_dir() does not return NULL,but it is
> possible to return error pointer. Most incorrect error checks
> were fixed,but the one in binder_init() was forgotten.
> 
> Fix the remaining error check.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 486c8271cab7..3b5309484df6 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6566,7 +6566,7 @@ static int __init binder_init(void)
>  	atomic_set(&binder_transaction_log_failed.cur, ~0U);
>  
>  	binder_debugfs_dir_entry_root = debugfs_create_dir("binder", NULL);
> -	if (binder_debugfs_dir_entry_root) {
> +	if (!IS_ERR(binder_debugfs_dir_entry_root)) {

Again, no need to check this at all.

thanks,

greg k-h
