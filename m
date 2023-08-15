Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE2B77CE03
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbjHOOYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbjHOOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:24:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F51010CF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:24:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe98583a6fso6195234e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692109470; x=1692714270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFWA95c42RBIrQLYV18T5DEc5ehm2HCDhXp85wqQ4iA=;
        b=NS7omE9RVASsERF8mX8AY71wl4v0Oc8GyjTRL6/aavvGYJyP2650mse3gy1aeYyBBD
         SkhBFFfw0tpFVPSsXH31xztGicsBOLli2gX8Dtcnjg30E1lu8O1Fha5Y/1aLza8ZZrAi
         6qwBlw8Vb5P5r3kFjH6kTBbGApUIRIjozBelrOKBes0PsYiOjjfBpBhSlXLZ2KbdcI9j
         lCVCIHvtqYukdNwKxlvRvr238PNihG07wAr6BZj3nHxJqqBTCSlCuz/nQjOfu3zARtq2
         nvZNBibwS0K4gr9Lj68jmlz5mmF8TT+PWZE9p/cLwrnVgVBtJthYhnG1+nr0r8Q7vIFe
         +JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109470; x=1692714270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFWA95c42RBIrQLYV18T5DEc5ehm2HCDhXp85wqQ4iA=;
        b=FY3g7CyAYyqR1UAz5m1Y6WbpYPuYXEQTUuvOpS4b7AKTRUAQVj7tNKeuKmex+jBqeq
         pbPXOCi+IpBCpBED+ZBLvAWMSfjeUsR37TO8nxeIhhaVWbrI+S1LenH9O4ndb4QjkZdy
         OTqpjHCX+fCuTnWcIWmdvXb8Ghqxl+ULmTVnn8kRNTje+Bp0q91exTLdRT4jlwjiNsAD
         ELVTrHCKyEC7X7Od1ZDDJEdWn2sNGAw3kr6TkCN73Cc8ukNuiIUnJLapbA7NLYpSpFh/
         AvxRID98VeLw23HSTPinIXVxkANqUL5xZeys8OCECK93KJ59s/j03Rx21Xze8SJc1ToO
         em2A==
X-Gm-Message-State: AOJu0Yy0H0uvaYXzA4GTAEZSX5isxb0vp78N8qw0QkA/yLoMzLpZORnz
        SCC+NUxpulZRMug+C5uGWF5oreEnBg==
X-Google-Smtp-Source: AGHT+IGR4LEaTA8n/YvFF2yOclGdT1SI/LCFkh09wcbzIHbymRMNKxhwPEeUQKJtHYCmmHo5MA61QA==
X-Received: by 2002:a05:6512:318b:b0:4fd:bec3:776a with SMTP id i11-20020a056512318b00b004fdbec3776amr10484549lfe.61.1692109469725;
        Tue, 15 Aug 2023 07:24:29 -0700 (PDT)
Received: from p183 ([46.53.254.179])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7c995000000b005234011bb44sm6930188edt.11.2023.08.15.07.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:24:29 -0700 (PDT)
Date:   Tue, 15 Aug 2023 17:24:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
        rostedt@goodmis.org, pmladek@suse.com, linux@rasmusvillemoes.dk,
        glider@google.com, elver@google.com, dvyukov@google.com,
        andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Subject: Re: + lib-vsprintf-split-out-sprintf-and-friends.patch added to
 mm-nonmm-unstable branch
Message-ID: <893b27ec-3f78-47fc-8298-903f991d5aaa@p183>
References: <20230814183752.0E34CC433C8@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814183752.0E34CC433C8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:37:51AM -0700, Andrew Morton wrote:
> Some patches that reduce the mess with the header inclusions related to
> vsprintf.c module.  Each patch has its own description, and has no
> dependencies to each other, except the collisions over modifications of
> the same places.  Hence the series.
> 
> 
> This patch (of 2):
> 
> kernel.h is being used as a dump for all kinds of stuff for a long time. 
> sprintf() and friends are used in many drivers without need of the full
> kernel.h dependency train with it.
> 
> Here is the attempt on cleaning it up by splitting out sprintf() and
> friends.


> --- /dev/null
> +++ a/include/linux/sprintf.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_KERNEL_SPRINTF_H_
> +#define _LINUX_KERNEL_SPRINTF_H_
> +
> +#include <linux/compiler_attributes.h>
> +#include <linux/types.h>
> +
> +int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
> +
> +__printf(2, 3) int sprintf(char *buf, const char * fmt, ...);
> +__printf(2, 0) int vsprintf(char *buf, const char *, va_list);
> +__printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
> +__printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
> +__printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
> +__printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
> +__printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
> +__printf(2, 0) __malloc char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
> +__printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
> +
> +__scanf(2, 3) int sscanf(const char *, const char *, ...);
> +__scanf(2, 0) int vsscanf(const char *, const char *, va_list);

I'd suggest to leave scanf alone and rename file to printf.h
Some archs have such files already (printf.c)
