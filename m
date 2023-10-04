Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B0A7B7599
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 02:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbjJDAA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 20:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjJDAAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 20:00:24 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F9AB4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 17:00:19 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1dce0f9e222so1031237fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696377619; x=1696982419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5SO7W7SD5TygXSLIRDkjMdwOJ3KiN1WzQFniH5ipwQ=;
        b=ffTkfy1Z8cvmDLeYVRVOrvxbXR3Uo59s6VVZSTe5HYnKDXAttnScWbVbPajMH8HCVX
         9UgF4v2X+RzlGf1xBzCK482KYYQymjJrOEF2Pg07HAQkI+QTObabHf7HCE1sXrnvRoIN
         JFVp9U/s1V9AKVts6NU33xLT8yX9CBZBv4N2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696377619; x=1696982419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5SO7W7SD5TygXSLIRDkjMdwOJ3KiN1WzQFniH5ipwQ=;
        b=QQ8yfappnVsrgbBGLJe0Se9xs/gGsJU071Dnb8q/7gg8P3IbUUod8nzC0P4VPSbpiO
         Ug3wxiOaH7uzq6aw8hZw6qsYQlhI/0Yk/+qpvKYKcUpnr21K7LeOWL6GmMPg7gpY9RgO
         yUBeZ5AwbL04GAppN6t/RQk+VBN9y2F6mnsaIfOD+JvMqIqf24yFzckMMMLA/6N/pQ/u
         2uz5j1tJnnquLevY974DwxZv9H8WxuXgZxPMA4HjCediEY+0FMjSaR3BCBkBeygNkGN/
         fgISTuLlP1tVVc1pZW5aWQANOlM7r4WGFAwQewuDhSmg9BYt+phJ8q8z4F6lYD9p2Tp7
         xPuQ==
X-Gm-Message-State: AOJu0YwBlIu6fuaNqZFaveZ13fDfvpAJSfkMEo2SdUyqlu9jT11TpfVT
        STJYZDNfDurijxejvZOVurySbQ==
X-Google-Smtp-Source: AGHT+IESunAi1JY0py7CKhvc9kyhRQyA051984ihrMB/CuP8SVwPNcQucfz1gCvwrlcCJzN3q5nMeA==
X-Received: by 2002:a05:6870:b688:b0:1d6:790e:dacc with SMTP id cy8-20020a056870b68800b001d6790edaccmr1166457oab.6.1696377619068;
        Tue, 03 Oct 2023 17:00:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78691000000b0068883728c16sm2002942pfo.144.2023.10.03.17.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 17:00:18 -0700 (PDT)
Date:   Tue, 3 Oct 2023 17:00:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Stitt <justinstitt@google.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3] null_blk: replace strncpy with strscpy
Message-ID: <202310031658.9F0DB21C@keescook>
References: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 05:30:35AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should favor a more robust and less ambiguous interface.
> 
> We expect that both `nullb->disk_name` and `disk->disk_name` be
> NUL-terminated:
> |     snprintf(nullb->disk_name, sizeof(nullb->disk_name),
> |              "%s", config_item_name(&dev->group.cg_item));
> ...
> |       pr_info("disk %s created\n", nullb->disk_name);
> 
> It seems like NUL-padding may be required due to __assign_disk_name()
> utilizing a memcpy as opposed to a `str*cpy` api.
> | static inline void __assign_disk_name(char *name, struct gendisk *disk)
> | {
> | 	if (disk)
> | 		memcpy(name, disk->disk_name, DISK_NAME_LEN);
> | 	else
> | 		memset(name, 0, DISK_NAME_LEN);
> | }
> 
> Then we go and print it with `__print_disk_name` which wraps `nullb_trace_disk_name()`.
> | #define __print_disk_name(name) nullb_trace_disk_name(p, name)
> 
> This function obviously expects a NUL-terminated string.
> | const char *nullb_trace_disk_name(struct trace_seq *p, char *name)
> | {
> | 	const char *ret = trace_seq_buffer_ptr(p);
> |
> | 	if (name && *name)
> | 		trace_seq_printf(p, "disk=%s, ", name);
> | 	trace_seq_putc(p, 0);
> |
> | 	return ret;
> | }
> 
> >From the above, we need both 1) a NUL-terminated string and 2) a
> NUL-padded string. So, let's use strscpy_pad() as per Kees' suggestion
> from v1.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Ping on this one too. Jens, can you pick this up?

Thanks!

-Kees

-- 
Kees Cook
