Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E157B3A94
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjI2TVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjI2TVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:21:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B70113
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5c91bec75so110733725ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015278; x=1696620078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+9SXcyvjGd+Gta4/O6IN/DD1n96uskx63gniN4z8Ko=;
        b=J9o9b/NjYmsjgtuyStYQHP/wbSF1A3ASaehD6RrX2TWAk5QqQJR86JzC+/fQuIUEC5
         8Tf6b0COysH4GrEmrRrOX4+Hu1Su6zAxCWTKs0yDcj1oMxjFdIV65lnWINXGWHr6BSO3
         XYtRwID9EFXsI3hZpKSLgGfuu6vbNT2yeO7E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015278; x=1696620078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+9SXcyvjGd+Gta4/O6IN/DD1n96uskx63gniN4z8Ko=;
        b=ssL6gF1ZdzY0zHsZVGYUaaJtceLuFIBSfkEPEgFuIMyKVEG4f2Xv20Kx2EYVIx8kNB
         3VTfybROd94fZOEsb2WoJLjfbwQGAC1od+0etHu0Dji69vgBbZmh7T2jJj2wW/SxpS0E
         4EKiODT66I50y1J1wosB/TYaAeIYkhtq3krT7eXRvT6CdQ3SAglPwcLJLQGL+xoFVKyb
         otUmOILNUkikdq4jG58lHtnPZl/IrwOk2R/iAp0nO8HcVAN7yczdtP2rUABwjy1hFw36
         961UyuzaTuq8bwAz3ottZBnZifzQ1bNnfMa0+vDWAsnz1quOUME+h6w4Hk2uW0FiMJcB
         rSwA==
X-Gm-Message-State: AOJu0YzhiDBQ8dkFPt1Lb2SaHPLe6gkF3zgDdqP1wEqxOIcAYt273Wrp
        P36LD5xJr4yVoKSfobhIakXmWA==
X-Google-Smtp-Source: AGHT+IEL4QFJkNtYGTd3LQFr4m9MDVzMcU8D/M+Brl5u7rqE/vHdG8ltVoVEVCzLGwOap+25wTol5Q==
X-Received: by 2002:a17:902:bc4a:b0:1c4:486f:5939 with SMTP id t10-20020a170902bc4a00b001c4486f5939mr3964184plz.3.1696015278078;
        Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001b54d064a4bsm17218730plg.259.2023.09.29.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drbd: Annotate struct fifo_buffer with __counted_by
Date:   Fri, 29 Sep 2023 12:21:08 -0700
Message-Id: <169601526972.3013632.16591134753215081850.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915200316.never.707-kees@kernel.org>
References: <20230915200316.never.707-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 13:03:16 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct fifo_buffer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] drbd: Annotate struct fifo_buffer with __counted_by
      https://git.kernel.org/kees/c/f246956ca8f3

Take care,

-- 
Kees Cook

