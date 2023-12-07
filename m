Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70512809244
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjLGU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGU0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:26:37 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11441710;
        Thu,  7 Dec 2023 12:26:43 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1fae23895c9so808549fac.3;
        Thu, 07 Dec 2023 12:26:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701980803; x=1702585603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9lpuRz8xgzIpYOLdLwP6N72RPUVO8edknaVSNWe9tg=;
        b=rS6y4wlItg+LDSPuXIqBIAR+hufHxZ14HSuAO7grLd8IjSeA6Uwgiv564DDO+sWAil
         r31MSa8G7TeO/PCpFuggMQ7wDw2IbBF5CLGFI8sc/7S1cK+JR/BKMT+vNoF6E3wUWUV8
         yyn6B6o8q2bvQejbIWRO/4KpnsPYNFrsDAHbXK4K6D5wtKvryeazEcteuNH3CiBxnf8J
         XEjhCo5hWOR02EtMSZFkNXFECGSDwuFvVSbPhXKQ0wn2K8xBq/UHhI4ruQQlAbd2Afjc
         /1/urSvq+0L1db+GpZjeNvui0m7LZiWSu95Ke7YqEfP/ojPAqXZx4wHkP3DF+Q1hMBcd
         ImOg==
X-Gm-Message-State: AOJu0YwDNIiLOYODaE006FLKihNr5yao1iXQskT7ARHyyBvDo7gaOBsm
        /svQbjTQG7ijd+I85iY6Gsn7q62PAA==
X-Google-Smtp-Source: AGHT+IFth89DyMvMdi4/1mmsWDl31uoQ+gS3bRbW+RLkvA/Sg7XzLPp13/mNiTx+HHTQ2zOeqG+Ijw==
X-Received: by 2002:a05:6870:b246:b0:1fb:75a:6d1c with SMTP id b6-20020a056870b24600b001fb075a6d1cmr3229254oam.67.1701980802834;
        Thu, 07 Dec 2023 12:26:42 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id qa18-20020a056871e71200b001fb36f71f3csm111013oac.31.2023.12.07.12.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:26:42 -0800 (PST)
Received: (nullmailer pid 3362416 invoked by uid 1000);
        Thu, 07 Dec 2023 20:26:41 -0000
Date:   Thu, 7 Dec 2023 14:26:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/4] of: Reimplement of_machine_is_compatible() using
 of_machine_compatible_match()
Message-ID: <20231207202641.GA3351234-robh@kernel.org>
References: <e6cf01d41502b15e688b6f5aa5c3b68c62b8ac64.1701878821.git.christophe.leroy@csgroup.eu>
 <ea64ede738fe51d46ab6be6aa1fc74029372f6e9.1701878821.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea64ede738fe51d46ab6be6aa1fc74029372f6e9.1701878821.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:13:33PM +0100, Christophe Leroy wrote:
> of_machine_compatible_match() works with a table of strings.
> of_machine_is_compatible() is a simplier version with only one string.
> 
> Re-implement of_machine_is_compatible() by setting a table of strings
> with a single string then using of_machine_compatible_match().
> 
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/of/base.c  | 22 +---------------------
>  include/linux/of.h | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 9020be2eb4d5..73c3a754bad1 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -414,27 +414,7 @@ bool of_machine_compatible_match(const char *const *compats)
>  
>  	return rc != 0;
>  }
> -
> -/**
> - * of_machine_is_compatible - Test root of device tree for a given compatible value
> - * @compat: compatible string to look for in root node's compatible property.
> - *
> - * Return: A positive integer if the root node has the given value in its
> - * compatible property.
> - */
> -int of_machine_is_compatible(const char *compat)
> -{
> -	struct device_node *root;
> -	int rc = 0;
> -
> -	root = of_find_node_by_path("/");
> -	if (root) {
> -		rc = of_device_is_compatible(root, compat);
> -		of_node_put(root);
> -	}
> -	return rc;
> -}
> -EXPORT_SYMBOL(of_machine_is_compatible);
> +EXPORT_SYMBOL(of_machine_compatible_match);
>  
>  /**
>   *  __of_device_is_available - check if a device is available for use
> diff --git a/include/linux/of.h b/include/linux/of.h
> index e3418babc203..a0f70be5007f 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -402,9 +402,22 @@ extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
>  extern int of_alias_get_id(struct device_node *np, const char *stem);
>  extern int of_alias_get_highest_id(const char *stem);
>  
> -extern int of_machine_is_compatible(const char *compat);
>  bool of_machine_compatible_match(const char *const *compats);
>  
> +/**
> + * of_machine_is_compatible - Test root of device tree for a given compatible value
> + * @compat: compatible string to look for in root node's compatible property.
> + *
> + * Return: A positive integer if the root node has the given value in its
> + * compatible property.

There is a subtle change that we really only return true/false instead 
of a score. In a quick scan, I don't see any callers caring. Lots of 
places we could use a list of compatibles instead though. Maybe this 
should just return a bool instead of int? Either way:

Reviewed-by: Rob Herring <robh@kernel.org>
