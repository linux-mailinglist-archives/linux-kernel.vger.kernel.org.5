Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B669C7ADE92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjIYSWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjIYSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:22:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AFD95
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:22:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso5397595b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695666150; x=1696270950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SpNbWbvzS2q57dWxeknHKSNngDyC+YXA3SyUyIcqgV0=;
        b=oEdicces7SIKnRCNSI+ZmPuThpa0jogvbZ/fpoOl9Pkw2L+opVdOwVeI85NQGP/dHv
         vAdlU91eRrWLRkphF5JVOvrs7K4MV+L/YH0RVXyxGP8SkM/UjFg3CGSykotzbIU9xnis
         E9Y1p6I2tJWluky7QdVy3jEdw7oQR4IcrONQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695666150; x=1696270950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpNbWbvzS2q57dWxeknHKSNngDyC+YXA3SyUyIcqgV0=;
        b=hqQ5o2I2MtP3dkteB0Wd1teLgjX0/i6PI34KW940d6+NOZG+dnnrl1SaQS1oyg4fO4
         PDK+gb1OKhG5kSw1jUceEknbjz6Do6EygTo2F0dDhxZDSGuWiIus5B9t5on0i/Q7VaLW
         EXUV2G0RfzY0CVGb/AE617EyUnJ2tPA7EyRSACfb9gvAENLBWT7xIthZIk+ZKj6GxyY/
         IHXbsBdE1IJfBQIocFNdY9ZbL5f9InzOuMkVn88QwQ2aWQSnOtjrqvRGoFIZDqNl8waU
         QUbpxqQsmX5hKNSj8R3g54CEKlFmVLC81aWTur3w8bF6w+QLEfp/fgUOqBjTpIWUIJdr
         rudQ==
X-Gm-Message-State: AOJu0Yw/FzsSeaCTcB00BqnwBZUvMSFMNd0M9X+X9yjmdyblpI7zjklW
        nbwHp3Wxv/ZLB7h/0MDuqa3N8A==
X-Google-Smtp-Source: AGHT+IHd4QFtesolKcSPxo1IJZdVv7PWj/npeJjsBWAqDvfwr0jS1184WR5bwEWepbECZb+2TGN04g==
X-Received: by 2002:a05:6a00:134b:b0:692:780a:de89 with SMTP id k11-20020a056a00134b00b00692780ade89mr6391028pfu.33.1695666150071;
        Mon, 25 Sep 2023 11:22:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fk22-20020a056a003a9600b0068a30f6cf32sm8604713pfb.143.2023.09.25.11.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:22:29 -0700 (PDT)
Date:   Mon, 25 Sep 2023 11:22:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] md: replace deprecated strncpy with memcpy
Message-ID: <202309251122.6E3E678140@keescook>
References: <20230925-strncpy-drivers-md-md-c-v1-1-2b0093b89c2b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-strncpy-drivers-md-md-c-v1-1-2b0093b89c2b@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 09:49:17AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> There are three such strncpy uses that this patch addresses:
> 
> The respective destination buffers are:
> 1) mddev->clevel
> 2) clevel
> 3) mddev->metadata_type
> 
> We expect mddev->clevel to be NUL-terminated due to its use with format
> strings:
> |       ret = sprintf(page, "%s\n", mddev->clevel);
> 
> Furthermore, we can see that mddev->clevel is not expected to be
> NUL-padded as `md_clean()` merely set's its first byte to NULL -- not
> the entire buffer:
> |       static void md_clean(struct mddev *mddev)
> |       {
> |       	mddev->array_sectors = 0;
> |       	mddev->external_size = 0;
> |               ...
> |       	mddev->level = LEVEL_NONE;
> |       	mddev->clevel[0] = 0;
> |               ...
> 
> A suitable replacement for this instance is `memcpy` as we know the
> number of bytes to copy and perform manual NUL-termination at a
> specified offset. This really decays to just a byte copy from one buffer
> to another. `strscpy` is also a considerable replacement but using
> `slen` as the length argument would result in truncation of the last
> byte unless something like `slen + 1` was provided which isn't the most
> idiomatic strscpy usage.
> 
> For the next case, the destination buffer `clevel` is expected to be
> NUL-terminated based on its usage within kstrtol() which expects
> NUL-terminated strings. Note that, in context, this code removes a
> trailing newline which is seemingly not required as kstrtol() can handle
> trailing newlines implicitly. However, there exists further usage of
> clevel (or buf) that would also like to have the newline removed. All in
> all, with similar reasoning to the first case, let's just use memcpy as
> this is just a byte copy and NUL-termination is handled manually.
> 
> The third and final case concerning `mddev->metadata_type` is more or
> less the same as the other two. We expect that it be NUL-terminated
> based on its usage with seq_printf:
> |       seq_printf(seq, " super external:%s",
> |       	   mddev->metadata_type);
> ... and we can surmise that NUL-padding isn't required either due to how
> it is handled in md_clean():
> |       static void md_clean(struct mddev *mddev)
> |       {
> |       ...
> |       mddev->metadata_type[0] = 0;
> |       ...
> 
> So really, all these instances have precisely calculated lengths and
> purposeful NUL-termination so we can just use memcpy to remove ambiguity
> surrounding strncpy.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

I agree on the analysis of the replacements. Thanks for all the detail!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
