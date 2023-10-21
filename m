Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381907D1CF0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 13:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjJUL6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 07:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJUL6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 07:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DA01A4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 04:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697889436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8A5YPNn+IwEItuJ1G2OC4z10xXdMM8+6p/08c4lncco=;
        b=W3nghjZcUpHI6UR+rrPvtNvoqT0bfKMtaW1oskB0u7S9T+ko7XOi9waorEU6Vq7/1tsZVw
        BwZBGwW924H4QIF35AvKGOldk9C2ksB+faUi9CsBQlKek9dHdPwFbFYBXGUB0eSIMHPg4X
        OQN8GvEgfqN9BgmSynmlnBx9sH3TAbQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-vvbtxOsqPlCQ7JjE3rmTkA-1; Sat, 21 Oct 2023 07:57:10 -0400
X-MC-Unique: vvbtxOsqPlCQ7JjE3rmTkA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507cb169766so1651819e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 04:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697889429; x=1698494229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8A5YPNn+IwEItuJ1G2OC4z10xXdMM8+6p/08c4lncco=;
        b=URch8uCovVcQkuxlO+UJi/XkxnpcD0JrDrCKQzvwTtlOOZ5+SU2bZ9fOPrFoS3JFvb
         29ilSQmIpEtYRGVqYgqrO/MC5GYD/5zZM3+9SN9qv4v0Luhgp6Tw9Ce69DWnd+ipAXfn
         rUz0SPRy77aykHcLSXkMBAZ4rgFCi7SuRnax/0HvBU/+Hv/eekQU2pj336IqfDjeIvp8
         8PPfL4t1bmdHYK0n/vZtmf2dMEq7NDEVbnQ/AYF6F7QG10gTM8c36O9p0rxskxw0vnUl
         ruYUW/EdprJOzxPG+XeE0jMY5jcIA6wRjKCYhXA7/92JZ4SdgHK1hkuTNcK7JdAmLJ1T
         QCpg==
X-Gm-Message-State: AOJu0YyeL6L9ZlOdRzArbqJNLamuJAhvBGtA9f+8Wx+I2SwBeNLV1+y0
        AV4byWMgU4pDtY1vMgYKc8EdUSDQ7IeeZ4Ye8yImRSEY/fR3ipuaEwROE5dNtzMNFAERlbmCwB+
        zfGAlMvXQlP3//pqV6sGwiH0n
X-Received: by 2002:a19:6742:0:b0:507:9a00:c169 with SMTP id e2-20020a196742000000b005079a00c169mr3461927lfj.5.1697889428944;
        Sat, 21 Oct 2023 04:57:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRg2tiyoJnYcPUczv2CKzX9otDeCiprhYPsEiOsrC6j2ShP6Mn99ICxaoSBra/sl4K9VMnBw==
X-Received: by 2002:a19:6742:0:b0:507:9a00:c169 with SMTP id e2-20020a196742000000b005079a00c169mr3461922lfj.5.1697889428601;
        Sat, 21 Oct 2023 04:57:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id w21-20020a50d795000000b0053e4d1cbc6esm3392994edi.55.2023.10.21.04.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 04:57:06 -0700 (PDT)
Message-ID: <acf1fade-7693-9332-03b1-626f4949f9ff@redhat.com>
Date:   Sat, 21 Oct 2023 13:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND] staging: media: atomisp: Removed duplicate comment
 and fixed comment format
To:     Jonathan Bergh <bergh.jonathan@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231021110058.85013-1-bergh.jonathan@gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231021110058.85013-1-bergh.jonathan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 10/21/23 13:00, Jonathan Bergh wrote:
> Fixed the following issues:
>  * Removed a duplicate comment
>  * Fixed up minor comment format issue
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>

Thank you for your patch, but please don't resend
it every week.

I did see the original patch and it looks fine but
I have not had any time to work in atomisp support
recently and this does not seem like something
which needs to get merged urgently.

I'll pick this up next time I have time to do
a bunch of atomisp work.

Regards,

Hans


> ---
>  drivers/staging/media/atomisp/i2c/gc2235.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/i2c/gc2235.h b/drivers/staging/media/atomisp/i2c/gc2235.h
> index 55ea422291ba..ade28950db73 100644
> --- a/drivers/staging/media/atomisp/i2c/gc2235.h
> +++ b/drivers/staging/media/atomisp/i2c/gc2235.h
> @@ -74,9 +74,6 @@
>  #define GC2235_COARSE_INTG_TIME_MIN 1
>  #define GC2235_COARSE_INTG_TIME_MAX_MARGIN 6
>  
> -/*
> - * GC2235 System control registers
> - */
>  /*
>   * GC2235 System control registers
>   */
> @@ -167,7 +164,7 @@ enum gc2235_tok_type {
>  	GC2235_TOK_MASK = 0xfff0
>  };
>  
> -/**
> +/*
>   * struct gc2235_reg - MI sensor  register format
>   * @type: type of the register
>   * @reg: 8-bit offset to register

