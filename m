Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF2A7D5F24
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjJYAmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJYAmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:42:15 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BF6D7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:42:13 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-581de3e691dso2944027eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698194532; x=1698799332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FnAEcz0Pm6rwXLiqbg9EQq+SejnOHmDm7vB765x6ZI=;
        b=AMCwj95qtRLVPgrnexb179RQhCdCz2o0cpZGwf6rcclMjCYntjUf6Fw9UsDUmMo6jJ
         bMdxVfrtPCPKTSLovlrDgYfjBJf7BkUe7E/B9O4RkqvcklIlmPUxkFHLNbum+YBzyvG4
         eO7T7K6k9Oyzw0+PKxYqngKtJTzlbuLWU/zCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698194532; x=1698799332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FnAEcz0Pm6rwXLiqbg9EQq+SejnOHmDm7vB765x6ZI=;
        b=VyvPaVuJmp08JNsun1pr4Q56rrN6aDXKs5IKT0BSrKi83FvccaVngx6q5FqkmZryJO
         kOEAtIwCBnnRwQMrzmt3GzI6b7E52c/sOZRxIlUuEXCTAE8RFhV/643lmIqY2cRZSuxz
         rDZwj3Svb1kFt5HmR137/vwUn1dQCjTrKNFrzbCEHCPdy13RdO0Ol3ti0ms8/6N7WI0X
         sKOhCXr4RnwWxtOxZ2hwbOHbMRO6gY2zLxhfiWDfwwf8QpmxKR4VeYZb/+sHz+f8mT95
         vzyxxnpE+DbpDlRcwb240YBPNUrA2U1p2ouOuc5BEGGSJE/wVfvFdAVNfFvCZuLcbaVj
         uFSQ==
X-Gm-Message-State: AOJu0Yw/zdKyjnYBpbuwHAmhjJ7A5wm1J6y17yySKDY7/Ov0L06M3mnt
        DRv0Z9W5KOfxXRRGqUmQ0fUSAw==
X-Google-Smtp-Source: AGHT+IGH5gFCLNw5hepkhxKvaGvJWtvDDKqCFVy++lU1SJUYvicyfPYz5myLthfyacybbSPx7R9KDg==
X-Received: by 2002:a05:6358:c323:b0:168:d382:1446 with SMTP id fk35-20020a056358c32300b00168d3821446mr7219249rwb.11.1698194532346;
        Tue, 24 Oct 2023 17:42:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id by2-20020a056a02058200b0058c1383fa8bsm6750257pgb.0.2023.10.24.17.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:42:11 -0700 (PDT)
Date:   Tue, 24 Oct 2023 17:42:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: elx: libefc: replace deprecated strncpy with
 strscpy
Message-ID: <202310241733.9CBC2251@keescook>
References: <20231023-strncpy-drivers-scsi-elx-libefc-efc_node-h-v1-1-8b66878b6796@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-scsi-elx-libefc-efc_node-h-v1-1-8b66878b6796@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 09:58:32PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> There seems to not be any uses of `current_state_name` other than in
> these assignments. Judging from context surrounding these assignments,
> especially considering the string literal "invalid" being assigned, we
> want both current_state_name and prev_state_name to be NUL-terminated
> strings.

I'm nervous that "node" may be either passed over the link or in
IO memory, so the behavior change of not %NUL-padding these may trip
something at run-time. Unless someone says otherwise, let's stay on the
safe side and use strscpy_pad() for "invalid" and handler, and memcpy()
for the swap.

Looking at "handler", it's always less than 64, so we don't need to
worry about early truncation -- it's always __func__, and none of them
are very long:

$ git grep efc_node_evt_set | grep -v __func__
drivers/scsi/elx/libefc/efc_node.h:efc_node_evt_set(struct efc_sm_ctx *ctx, enum efc_sm_event evt,

$ git grep efc_node_evt_set | grep __func__ | cut -d: -f1 | sort -u
drivers/scsi/elx/libefc/efc_device.c
drivers/scsi/elx/libefc/efc_fabric.c
drivers/scsi/elx/libefc/efc_node.c

$ grep -E '^_?_?efc' drivers/scsi/elx/libefc/efc_{fabric,device,node}.c \
  | cut -d'(' -f1 | cut -d: -f2 | wc -L
37

-Kees

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
>  drivers/scsi/elx/libefc/efc_node.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/elx/libefc/efc_node.h b/drivers/scsi/elx/libefc/efc_node.h
> index e9c600ac45d5..3a16703d0f97 100644
> --- a/drivers/scsi/elx/libefc/efc_node.h
> +++ b/drivers/scsi/elx/libefc/efc_node.h
> @@ -26,12 +26,12 @@ efc_node_evt_set(struct efc_sm_ctx *ctx, enum efc_sm_event evt,
>  	struct efc_node *node = ctx->app;
>  
>  	if (evt == EFC_EVT_ENTER) {
> -		strncpy(node->current_state_name, handler,
> +		strscpy(node->current_state_name, handler,
>  			sizeof(node->current_state_name));
>  	} else if (evt == EFC_EVT_EXIT) {
> -		strncpy(node->prev_state_name, node->current_state_name,
> +		strscpy(node->prev_state_name, node->current_state_name,
>  			sizeof(node->prev_state_name));
> -		strncpy(node->current_state_name, "invalid",
> +		strscpy(node->current_state_name, "invalid",
>  			sizeof(node->current_state_name));
>  	}
>  	node->prev_evt = node->current_evt;
> 
> ---
> base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
> change-id: 20231023-strncpy-drivers-scsi-elx-libefc-efc_node-h-cbbf753197b7
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook
