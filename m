Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE03C76D8BC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjHBUgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjHBUgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:36:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA3C2701
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:36:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bbc06f830aso2018575ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691008564; x=1691613364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWr3jcRSEU+gA9r0PBD80WJbMi+ArPrQmYYMKJHmB6U=;
        b=nzPAChC03qv+JjeCfHD3Xsgh7kOt1lPa9r4xyzDxMcstE90i2vukMw/8sXH/02aje3
         2otS1qRbhNkAjWyhIbAU++WUZ6yCQqFvvwE0SM4I+99qUJEqDvwnleDRCjb4+gIWskpm
         kT/uFCmzfT6YzJ6Qh64mXRXv8r01SRYwdq9n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691008564; x=1691613364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWr3jcRSEU+gA9r0PBD80WJbMi+ArPrQmYYMKJHmB6U=;
        b=kU9ioCxeOQ5TQW0F2a/yUxjEbrk0fJZBzePwdSn2LwnD9QREQbYT1I+4NLZnNTGfAL
         rT0oIiY5msXLHSeUHC6QqRnlPUOCEUKTo2qFOW9URCb6VibKGKN7vrAxJ/kkJ2UVfJkU
         /r0xksnOBSmKuI8ciP+aJI6jE8SGXRpQXHJMZozZuzl5OP/SLyYY3A7arj2/j/kLeiFb
         +n/KhFbuVt5hER2kwCwaeEqAdax7fNVYl736QT7xw/wOohA6PNjosSxAzSGXP5+GvKsZ
         q3AZaov4tdtpWz3gTNwvFeDQZlVhwcbQMl3iqGAABSqDWa/vLzChnHtxAnhubcyqiy4B
         Eo8g==
X-Gm-Message-State: ABy/qLYv43LHb6l0dSZ/cxKxB7TY1UqUmqT95+ADdOaCY7N6WZ6uN/Tf
        mmIIUOR5njdvQBQXyrLY11j3HA==
X-Google-Smtp-Source: APBJJlHH8aWxfFwHQY80htCurxfVMh/0WroGpPj2sjy9e7ql/D3TXKv/ojhEZ6OgabqItgbTCA1eOA==
X-Received: by 2002:a17:902:c404:b0:1b9:c61c:4c01 with SMTP id k4-20020a170902c40400b001b9c61c4c01mr23391628plk.9.1691008564550;
        Wed, 02 Aug 2023 13:36:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a18472sm12772104plb.117.2023.08.02.13.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 13:36:04 -0700 (PDT)
Date:   Wed, 2 Aug 2023 13:36:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
Message-ID: <202308021335.8010D08B@keescook>
References: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 12:21:58AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Favor not copying strings onto stack and instead use strings directly.
> This avoids hard-coding sizes and buffer lengths all together.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

I like it! ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
