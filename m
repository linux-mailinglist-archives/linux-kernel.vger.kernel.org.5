Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576067B3A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjI2Sek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjI2Sei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:34:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23BB1B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:34:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68c576d35feso12766771b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696012476; x=1696617276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB0rJAp0zg9JOPur8i8NsK/kuHM5BlZt26jybAyks+8=;
        b=R4Bm1s2YMDNb8i6t9eeaPRJ8BU9BL2z2660ZgaUZiopxwwI0MT9l3WjfOptgGYvo3v
         3Q44/h6kKhWuA2IR/y3BGr9qnItKzdWQVJqN0PrzT11nATFlhA1IIvCY2jbMoBB5Xr2K
         a5V3YSY5fAH0gimUYPyhggy5XLF2VB7hhxGmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696012476; x=1696617276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eB0rJAp0zg9JOPur8i8NsK/kuHM5BlZt26jybAyks+8=;
        b=o3WmnISDGS6ER3tW4yJVkkDP6Nv4TBVKHRiufiPar0Xuz43Wx3uniInQ1lBWW6Or8Q
         BbG52q2kPRpMm7jVv2/NoZJ3oITGnj0LcfYy3CLjfTTRUpA67/xcLvFGxJSKtTG+gL5U
         lVYBCnSg/YlIsq3nAtmKG4vxSBfNGhqoWKBfU/+icl1xUj76D8ge94gA2V0UOYMQ8SNn
         joblvhmHvidIRUEBAePFts2Ng9xKy+X4+JrgUPZhl/0sz6WthkiKa7GbSLtQk6HzkI6Q
         9DzYDB7P0DJjiFaqJCitRJFKPOzBpqHqPnP7PYpHvZq57TDWYbkD8oXC+KuAulyRNwBx
         YJpg==
X-Gm-Message-State: AOJu0YwuulGuSZeh0mRS1ywMwyz8bvGVSoMVLKk8E49scW73aS4viXnG
        cWOZt6BYHyM8fSaqofq7CQJIOg==
X-Google-Smtp-Source: AGHT+IF2Huj+7CtO7jU1UHaoN/b3RP+BS7arEzCw35sdCLa1Kq6KkDAUvYLxeedGWg9tisSKDFxpYQ==
X-Received: by 2002:a05:6a21:3d88:b0:15d:f3ae:665b with SMTP id bj8-20020a056a213d8800b0015df3ae665bmr4493650pzc.28.1696012476128;
        Fri, 29 Sep 2023 11:34:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78047000000b006879493aca0sm4082161pfm.26.2023.09.29.11.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:34:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
Date:   Fri, 29 Sep 2023 11:33:46 -0700
Message-Id: <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 18:27:25 +0000, Justin Stitt wrote:
> `strncpy` is deprecated and we should prefer more robust string apis.
> 
> In this case, `message.str` is not expected to be NUL-terminated as it
> is simply a buffer of characters residing in a union which allows for
> named fields representing 8 bytes each. There is only one caller of
> `tdx_panic()` and they use a 59-length string for `msg`:
> |	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> 
> [...]

This appears to be trivially correct, so I can take it via my tree.

Applied to for-next/hardening, thanks!

[1/1] x86/tdx: refactor deprecated strncpy
      https://git.kernel.org/kees/c/e32c46753312

Take care,

-- 
Kees Cook

