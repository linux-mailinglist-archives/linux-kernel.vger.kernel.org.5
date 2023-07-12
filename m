Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AEF750EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjGLQe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjGLQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BCE1711
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 288A1617E4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B40CC433C8;
        Wed, 12 Jul 2023 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689179691;
        bh=7xPP/0QNsw8FxyEoVruE+jvZjL/nmchj4VyUCIqaxko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=saAOJRmrebp1v5jKle+getmG9WAN17OhRHCHSUi6MDdiwp40hZioLcjNXrHaIv68t
         U++UGOpbVE9VfHCedyg4ZW5VtZlF2MrfBXNw7de0Wtxke67W9MmKUuHxhFXNkPKyDi
         D0TvdtnGW79VbG3UBAKZ1nOrtHcsdyIF7VgURkaE=
Date:   Wed, 12 Jul 2023 18:34:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Ming <machel@vivo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] lib:Fix an NULL vs IS_ERR() bug for
 debugfs_create_dir() in err_inject_init()
Message-ID: <2023071202-varsity-evasion-580b@gregkh>
References: <20230712135226.10041-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712135226.10041-1-machel@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:52:11PM +0800, Wang Ming wrote:
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. Most incorrect error checks were fixed,
> but the one in err_inject_init() was forgotten.
> 
> Fix the remaining error check.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  lib/notifier-error-inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/notifier-error-inject.c b/lib/notifier-error-inject.c
> index 2b24ea6c9497..c49354c23802 100644
> --- a/lib/notifier-error-inject.c
> +++ b/lib/notifier-error-inject.c
> @@ -83,7 +83,7 @@ static int __init err_inject_init(void)
>  	notifier_err_inject_dir =
>  		debugfs_create_dir("notifier-error-inject", NULL);
>  
> -	if (!notifier_err_inject_dir)
> +	if (IS_ERR(notifier_err_inject_dir))
>  		return -ENOMEM;

Please do not do any different codepath if a debugfs_*() call fails or
succeeds.

Why do you need to check this at all?

And why are you creating this directory at the root of debugfs?

thanks,

greg k-h
