Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35397788F79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjHYT5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjHYT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:57:40 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A084211B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:57:38 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bca66e6c44so1009728a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692993458; x=1693598258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mePwIFaicKFWsl6ibRudilBKZz+qKLFtCl5QafnyfWE=;
        b=X9ikIgs6RjTlbJDKiB37yRFNG90brOxIV7BD2AkrdkoWCZx/bWil1UGbmt9SRwZfa8
         TMKptnjuwFVJDkdvfKxWIgjjOtRX9gZ4XY1t7wDe1mpnI038hrX4DiJ6FgRpZHVITc8r
         DOhazlR+aS//Atabz7/FyZXdTsug6kQbWZnmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692993458; x=1693598258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mePwIFaicKFWsl6ibRudilBKZz+qKLFtCl5QafnyfWE=;
        b=Ky1qIg9l4YPlOoKSaSj2r5NDEOq2VavLrhUsunPZ15FEGkutm6yQggtcdK1gEEtjZZ
         8BOB3ylIEFAQSBWNG4rhHP/GFCbSEQ4TZVK/84rv7pS6wbhtZWmJm+WbFFmvUGIWpvcA
         M9vM+GSZhWV7OhPi4lTyDfqehoN4Eh4uoINItZwQHeYoIDq5sD4sF+4kY1/48x3LCjbt
         WEdRBICWmzo+B0ctSTNaAcqe74QpQyqXCXnfiGC7u2MZGppmFCvr8ennoCo0vjOBcO83
         45RCRyW70c84OJYzz2+nzhJUDlH4FHL+KXoQGYTun/Vy46bIMn27vfjfYgkmZCzRWnNo
         H2Zg==
X-Gm-Message-State: AOJu0Yy9jXm0R3dFacm+ApBV4YN45KmMEEjSSUYcZ1SXbrNfMHUXJisz
        xwJ+ixQu4KjlbLdeGg1nCMqVSA==
X-Google-Smtp-Source: AGHT+IF2AmrIyOFdCtOu4lQqcqRfSYEn1ZKqp0rLeQq0ItsLA/CXd+FEC9Mnkl/pTNeWDOnDWHrKuQ==
X-Received: by 2002:a05:6830:12d8:b0:6b9:8357:6150 with SMTP id a24-20020a05683012d800b006b983576150mr6460451otq.35.1692993457958;
        Fri, 25 Aug 2023 12:57:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o6-20020a63a806000000b0056368adf5e2sm2047172pgf.87.2023.08.25.12.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 12:57:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yonghong Song <yonghong.song@linux.dev>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] kallsyms: Fix kallsyms_selftest failure
Date:   Fri, 25 Aug 2023 12:57:32 -0700
Message-Id: <169299344984.855265.133054189640822333.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825034659.1037627-1-yonghong.song@linux.dev>
References: <20230825034659.1037627-1-yonghong.song@linux.dev>
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

On Thu, 24 Aug 2023 20:46:59 -0700, Yonghong Song wrote:
> Kernel test robot reported a kallsyms_test failure when clang lto is
> enabled (thin or full) and CONFIG_KALLSYMS_SELFTEST is also enabled.
> I can reproduce in my local environment with the following error message
> with thin lto:
>   [    1.877897] kallsyms_selftest: Test for 1750th symbol failed: (tsc_cs_mark_unstable) addr=ffffffff81038090
>   [    1.877901] kallsyms_selftest: abort
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kallsyms: Fix kallsyms_selftest failure
      https://git.kernel.org/kees/c/33f0467fe069

Take care,

-- 
Kees Cook

