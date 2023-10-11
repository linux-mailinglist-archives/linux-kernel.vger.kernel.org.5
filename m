Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722767C613E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjJKXud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjJKXub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:50:31 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA24E90
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:50:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690bd8f89baso300364b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697068229; x=1697673029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N14ViMNZS6P+iEZeidv5FyK1+HS9kSNQcsZN8mQr+KY=;
        b=k8m8GbUbLU6zmXCzbnHgmYmy9f8XTrZKyEumoIBbVTtJIFhQzVynF/S/OB188PYUxf
         RyvCXesBtDCpN+Vyc8XUej1WgLOwgrAohYrJi8GkstkAD081aO4hY86HdvfAcKo4cnCq
         H+HLQ3sILhr9sKkOdA0F4Emg7TuWvdR31tbxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697068229; x=1697673029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N14ViMNZS6P+iEZeidv5FyK1+HS9kSNQcsZN8mQr+KY=;
        b=aPPcauePUSylKNU5A12M2NfLoTPfCi9AkC5z/SqlBlzEbRS8bAD1uzd1zzqc2O006r
         sSqeH55TJPnwNxuA1aEif8xl+PmLn56x+CMaYvqT7I6HdBDrcsyaxY5NIjyCgO1riTah
         MTEKoP/WiolDYOtaJ75wVgHSnXq6DVa3IvG40ymNpUcTGAEvzRIWyM2/fvblD7Vu/pf4
         Had4HwNQItxi8SxYYW6mPBRdCuXDe4K4efDo9gTOvpsCFcrSzOVLXFbYZWdkmo1KDJaU
         Nu76jk1QtwKrC6oEimolvYth7DRkhhjS7M3lmu6jyD+i3IElrSj2mc1IV9pdmFWgTmGa
         GxJg==
X-Gm-Message-State: AOJu0Yzv+GY6+ONzDa1HEv5AycEJ+cLLZCgXZNz3NnQ/IKovxmZbFjNo
        iopqJvVUTlDnb0fZJKE/DlCD1Q==
X-Google-Smtp-Source: AGHT+IF542sbtJvVPZyRnnbbrtD9b41uqbTLaZjDauYk4qhBvSz4+9ehzFzVITdi7ekFH6kRKUh4Wg==
X-Received: by 2002:a05:6a00:2e20:b0:690:2ad9:1436 with SMTP id fc32-20020a056a002e2000b006902ad91436mr25112341pfb.7.1697068229164;
        Wed, 11 Oct 2023 16:50:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx9-20020a056a001e0900b00692b2a63cccsm10621208pfb.210.2023.10.11.16.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:50:28 -0700 (PDT)
Date:   Wed, 11 Oct 2023 16:50:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Louis Peens <louis.peens@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, oss-drivers@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nfp: replace deprecated strncpy with strscpy
Message-ID: <202310111649.B1F6BD4159@keescook>
References: <20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-v1-1-7d1c984f0eba@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-v1-1-7d1c984f0eba@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:48:39PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect res->name to be NUL-terminated based on its usage with format
> strings:
> |       dev_err(cpp->dev.parent, "Dangling area: %d:%d:%d:0x%0llx-0x%0llx%s%s\n",
> |               NFP_CPP_ID_TARGET_of(res->cpp_id),
> |               NFP_CPP_ID_ACTION_of(res->cpp_id),
> |               NFP_CPP_ID_TOKEN_of(res->cpp_id),
> |               res->start, res->end,
> |               res->name ? " " : "",
> |               res->name ? res->name : "");
> ... and with strcmp()
> |       if (!strcmp(res->name, NFP_RESOURCE_TBL_NAME)) {
> 
> Moreover, NUL-padding is not required as `res` is already
> zero-allocated:
> |       res = kzalloc(sizeof(*res), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also opt to use the more idiomatic strscpy() usage of (dest, src,
> sizeof(dest)) rather than (dest, src, SOME_LEN).
> 
> Typically the pattern of 1) allocate memory for string, 2) copy string
> into freshly-allocated memory is a candidate for kmemdup_nul() but in
> this case we are allocating the entirety of the `res` struct and that
> should stay as is. As mentioned above, simple 1:1 replacement of strncpy
> -> strscpy :)
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
> index ce7492a6a98f..279ea0b56955 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
> @@ -159,7 +159,7 @@ nfp_resource_acquire(struct nfp_cpp *cpp, const char *name)
>  	if (!res)
>  		return ERR_PTR(-ENOMEM);
>  
> -	strncpy(res->name, name, NFP_RESOURCE_ENTRY_NAME_SZ);
> +	strscpy(res->name, name, sizeof(res->name));

struct nfp_resource {
        char name[NFP_RESOURCE_ENTRY_NAME_SZ + 1];

Yup, this is doing the implicit string size reduction.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
