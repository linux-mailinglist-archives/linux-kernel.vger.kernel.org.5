Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C3781365A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjLNQfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjLNQfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:35:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AFD11D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:35:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d075392ff6so6555755ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702571718; x=1703176518; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=luawVzpNb+QxL668ocEaZVPjlwFQcIxmSlMsAYgwWS4=;
        b=RUWcVQ1YHbWs+RsKvjl8kD81OtgOmQQEWEY8Ku88pfAnPQpxkdAGcGz5HjlACheAQD
         GtcmqQUJpqJWMRNAJacLGcTqsBx4PEUKIsiqspW9WJZSc/o9WCKxT6IS5P/n9M/qgezj
         FBh/AHGLiKM4OPwAcI81S6Nx6Gru5pdkTUdQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571718; x=1703176518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=luawVzpNb+QxL668ocEaZVPjlwFQcIxmSlMsAYgwWS4=;
        b=CixKYW+ODNjAjeWJyP+D2tFIUOAx+efdBHvilZ20dbujB52lvyi/zLymh25CJu8cG4
         7zOpInssH2rfrffRgrJWZZeNe5XRBmL8p3a/XzMGCSA5J4f0rUVK+LNDY4Q2vOLwUlmd
         kibbK2nVrY1ggv262DByRff4Bhmd7ninfZddl4FZOCLflNj4rnxcehGYZe5gl1QXku+e
         3AR0pSWtM++3kTKNBCT1G+s1DCXuzk0BnYpy9LL0opvrEcG1xnCJ5vrxw1/YuMglWQD2
         pWH4uimMb8RGpUtf/8dAxyw+zjmqWfv4zLTDvg/CcS25fcGhLDEwhfoOV9V2I2c2Rt9H
         UrIg==
X-Gm-Message-State: AOJu0YyTBha7fK4H/3Hka9B7Mo78gMWV5sDsg65VSq7MJt/wskU4YFKm
        xBbIWjjGYoQSkQtdO52kgkcXiQ==
X-Google-Smtp-Source: AGHT+IGMWhJzEdepoAGmiKRWvixiMXZQ5VqwgLuRg6NDcnO9mPPEhzlmlU+yN2Yxf/7Q1lbZjCM1dg==
X-Received: by 2002:a17:902:f283:b0:1d3:3676:c9d with SMTP id k3-20020a170902f28300b001d336760c9dmr4808777plc.19.1702571718563;
        Thu, 14 Dec 2023 08:35:18 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001cfb4d36eb1sm12611665plg.215.2023.12.14.08.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:35:17 -0800 (PST)
Date:   Thu, 14 Dec 2023 08:35:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: Fix -Warray-bounds warnings
Message-ID: <202312140830.953C55AC9@keescook>
References: <ZCTrutoN+9TiJM8u@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCTrutoN+9TiJM8u@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 07:54:02PM -0600, Gustavo A. R. Silva wrote:
> GCC-13 (and Clang) does not like having a partially allocated object,
> since it cannot reason about it for bounds checking.
> 
> Notice that the compiler is legitimately complaining about accessing
> an object (params, in this case) for which not enough memory was
> allocated.
> 
> The object is of size 20 bytes:
> 
> struct ec_params_vbnvcontext {
> 	uint32_t                   op;                   /*     0     4 */
> 	uint8_t                    block[16];            /*     4    16 */
> 
> 	/* size: 20, cachelines: 1, members: 2 */
> 	/* last cacheline: 20 bytes */
> };
> 
> but only 16 bytes are allocated:
> 
> sizeof(struct ec_response_vbnvcontext) == 16
> 
> In this case, as only enough space for the op field is allocated,
> we can use an object of type uint32_t instead of a whole
> struct ec_params_vbnvcontext (for which not enough memory is
> allocated).
> 
> Fix the following warning seen under GCC 13:
> drivers/platform/chrome/cros_ec_vbc.c: In function ‘vboot_context_read’:
> drivers/platform/chrome/cros_ec_vbc.c:36:15: warning: array subscript ‘struct ec_params_vbnvcontext[1]’ is partly outside array bounds of ‘unsigned char[36]’ [-Warray-bounds=]
>    36 |         params->op = EC_VBNV_CONTEXT_OP_READ;
>       |               ^~
> In file included from drivers/platform/chrome/cros_ec_vbc.c:12:
> In function ‘kmalloc’,
>     inlined from ‘vboot_context_read’ at drivers/platform/chrome/cros_ec_vbc.c:30:8:
> ./include/linux/slab.h:580:24: note: at offset 20 into object of size 36 allocated by ‘kmalloc_trace’
>   580 |                 return kmalloc_trace(
>       |                        ^~~~~~~~~~~~~~
>   581 |                                 kmalloc_caches[kmalloc_type(flags)][index],
>       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   582 |                                 flags, size);
>       |                                 ~~~~~~~~~~~~
> 
> Link: https://github.com/KSPP/linux/issues/278
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

This patch seems to have gotten lost? Looking at the conversation, I
think it should land as-is rather than changing the allocation size.

I can pick this up via my tree if that helps...

-Kees

> ---
>  drivers/platform/chrome/cros_ec_vbc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
> index c859c862d7ac..b5a584f5469a 100644
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -20,10 +20,14 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>  	struct cros_ec_device *ecdev = ec->ec_dev;
> -	struct ec_params_vbnvcontext *params;
>  	struct cros_ec_command *msg;
> +	/*
> +	 * This should be a pointer to the same type as op field in
> +	 * struct ec_params_vbnvcontext.
> +	 */
> +	uint32_t *params_op;
>  	int err;
> -	const size_t para_sz = sizeof(params->op);
> +	const size_t para_sz = sizeof(*params_op);
>  	const size_t resp_sz = sizeof(struct ec_response_vbnvcontext);
>  	const size_t payload = max(para_sz, resp_sz);
>  
> @@ -32,8 +36,8 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
>  		return -ENOMEM;
>  
>  	/* NB: we only kmalloc()ated enough space for the op field */
> -	params = (struct ec_params_vbnvcontext *)msg->data;
> -	params->op = EC_VBNV_CONTEXT_OP_READ;
> +	params_op = (uint32_t *)msg->data;
> +	*params_op = EC_VBNV_CONTEXT_OP_READ;
>  
>  	msg->version = EC_VER_VBNV_CONTEXT;
>  	msg->command = EC_CMD_VBNV_CONTEXT;
> -- 
> 2.34.1
> 

-- 
Kees Cook
