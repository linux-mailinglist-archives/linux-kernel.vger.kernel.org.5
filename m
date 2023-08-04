Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7B176FD57
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjHDJcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjHDJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:32:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615D74C22
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:32:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe4f5290daso3189451e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691141520; x=1691746320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YJcUmqfH4he3+bj4rk9cnVccev5fkfdS9FI/A70DRUM=;
        b=cCylAwlhK/Nj+MiccN4dGpLcZdR67okmXEdejoGLTfpXZ/mc+QXp0t48Ofw5xHg4yc
         ne1BbGyQsqIxZl8ZOMGfCOVqrCxZWkKKKevKXfREcDpH5yBngWvQxEl3hyoK/PoNaN+G
         O3nteNbaR50yDvqNHclMoYEXmkYN6yETvCmds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691141520; x=1691746320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJcUmqfH4he3+bj4rk9cnVccev5fkfdS9FI/A70DRUM=;
        b=JT/5DIhsxYHJ4QkF3ohvQCIZl6HKF7ajfzShCGopFSqOZ8u698I+B5E7CjY/1GF7Yo
         yrz1xQUrM2yJtjH8Wj1EzT+Ib/cnJQRHcRdU4xzabbb3sVGIsMF6+mICeGQ8ixp5cCm2
         1KpgJAHbMqDlPwijpK0ESWiK+seoH76zpGQwZFSr/VgowFyFSI4pHgRdDZ2aYPunvan0
         StY98yEPk3kEgUAdg04P+OjjfmdLHTluWhAFwAIJ77kYh/WIKMC7Vi6CWctT45P0IA6q
         XOIzvkGG4ltskq0qbAoRofKcjrLPmGsjKsrQBPSTUAf0S1oX3RMP6C9C9kKDezxPFSOr
         kYWA==
X-Gm-Message-State: AOJu0Yx8YvNrbzQTIjb2ehzsXLcg2qVzKsY6BmJz8iKua9+acAPm5Uxp
        uoxwmU3EMhTFTUTC//8nLOVuVA==
X-Google-Smtp-Source: AGHT+IGsqil9ckKmE45ZEi9RLr7R3/pogXB0t2FoWx2GpBX6OwB+NH3pxc17YH3E8MnXBP4sNaqz/g==
X-Received: by 2002:a05:6512:158f:b0:4f8:67f0:7253 with SMTP id bp15-20020a056512158f00b004f867f07253mr1071071lfb.49.1691141520453;
        Fri, 04 Aug 2023 02:32:00 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t4-20020ac24c04000000b004fe09920fe5sm304024lfq.47.2023.08.04.02.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 02:31:59 -0700 (PDT)
Message-ID: <71ce8516-21cb-32c6-84d3-b3f9bb3d625b@rasmusvillemoes.dk>
Date:   Fri, 4 Aug 2023 11:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 4/4] lib/vsprintf: Split out sprintf() and friends
Content-Language: en-US, da
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
 <20230804082619.61833-5-andriy.shevchenko@linux.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230804082619.61833-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 10.26, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> sprintf() and friends are used in many drivers without need of the full
> kernel.h dependency train with it.
> 
> Here is the attempt on cleaning it up by splitting out sprintf() and
> friends.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/kernel.h  | 30 +-----------------------------
>  include/linux/sprintf.h | 24 ++++++++++++++++++++++++
>  lib/vsprintf.c          |  1 +
>  3 files changed, 26 insertions(+), 29 deletions(-)
>  create mode 100644 include/linux/sprintf.h
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index b9e76f717a7e..cee8fe87e9f4 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -29,6 +29,7 @@
>  #include <linux/panic.h>
>  #include <linux/printk.h>
>  #include <linux/build_bug.h>
> +#include <linux/sprintf.h>
>  #include <linux/static_call_types.h>
>  #include <linux/instruction_pointer.h>
>  #include <asm/byteorder.h>
> @@ -203,35 +204,6 @@ static inline void might_fault(void) { }
>  
>  void do_exit(long error_code) __noreturn;
>  
> -extern int num_to_str(char *buf, int size,
> -		      unsigned long long num, unsigned int width);
> -
> -/* lib/printf utilities */
> -
> -extern __printf(2, 3) int sprintf(char *buf, const char * fmt, ...);
> -extern __printf(2, 0) int vsprintf(char *buf, const char *, va_list);
> -extern __printf(3, 4)
> -int snprintf(char *buf, size_t size, const char *fmt, ...);
> -extern __printf(3, 0)
> -int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
> -extern __printf(3, 4)
> -int scnprintf(char *buf, size_t size, const char *fmt, ...);
> -extern __printf(3, 0)
> -int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
> -extern __printf(2, 3) __malloc
> -char *kasprintf(gfp_t gfp, const char *fmt, ...);
> -extern __printf(2, 0) __malloc
> -char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
> -extern __printf(2, 0)
> -const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
> -
> -extern __scanf(2, 3)
> -int sscanf(const char *, const char *, ...);
> -extern __scanf(2, 0)
> -int vsscanf(const char *, const char *, va_list);
> -
> -extern int no_hash_pointers_enable(char *str);
> -
>  extern int get_option(char **str, int *pint);
>  extern char *get_options(const char *str, int nints, int *ints);
>  extern unsigned long long memparse(const char *ptr, char **retptr);
> diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
> new file mode 100644
> index 000000000000..00d1fdc70a3e
> --- /dev/null
> +++ b/include/linux/sprintf.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_KERNEL_SPRINTF_H_
> +#define _LINUX_KERNEL_SPRINTF_H_
> +
> +#include <linux/types.h>
> +

Shouldn't this at least also include compiler_attributes.h, to make it
self-contained?

As Marco said, please just declare no_hash_pointers in this file as
well. Perhaps with a comment about not accessing it unless one has good
reason, but I suppose that's true in general for all kernel global
variables, so maybe not worth it for this one.

Rasmus

