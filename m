Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC7789161
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjHYWDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjHYWCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:02:53 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CBE19B7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:02:51 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a3082c771so1012737b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693000970; x=1693605770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8sxkfkNcDH+wFlFnMtVGrz62yixCGCGYoyhNiXjDks=;
        b=h73a6BdP5hC/NqXKwgNtxZ0ubyM33hSEmLZj/0M/2wvcGKL/pUFy6QQohX2ri1WGhW
         pg6b1sANdFoyI37/JwBk/OZPWXaVGgD6L/Vb90HSJWIlpoMjG13DypVq0/G2X/SGM353
         lRc9ByR0MOyTDsFYfYDK1l7/nzB9YHZcRw9Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000970; x=1693605770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8sxkfkNcDH+wFlFnMtVGrz62yixCGCGYoyhNiXjDks=;
        b=PwlbeFjJnXNgJVu35P7Dp71mVwGRlwXZWx2cpdoyesL42IFReFdekhdqZHyeYbKV89
         ifkzBosxV8sjnAE32b++A55JNHqJLj48ZKR4NaSmM3wXk9yauBQ4g+8UUVVS13FNQLd2
         xOqM9a3+ig5/QMHTmxVhvbTFDIEm13h2TZtwgrApdUSs4u/TFQAETWLcP9rRvP/IulK3
         /lh/giPwwQVVeJbSsUCzZOjAs8D87AtCQAPz84yjTbBDolByHlSMeR6DszYgSvCu4Dbr
         K0KzgUrYOQJr03TFWRtga18mXtX47DI62nUtQOcuEbQQgaI0Fp/DdImq7qMPDvycCNS+
         R9Rg==
X-Gm-Message-State: AOJu0YyvM4LGjIPq8ak7PGVIyGJwlfxA1PSg7MabhMY24OljiGNCeIf3
        flqYmV3jfGQtvAt4UjrA+BDNgA==
X-Google-Smtp-Source: AGHT+IFMVu8jqfZIV7WjrQfMJho3P8PW/9yNoHnzP85DTUpWN/wAksLtv+0nRiTvNaZ1CvCaYUqnFw==
X-Received: by 2002:a05:6a00:14cf:b0:68a:5e3c:79e0 with SMTP id w15-20020a056a0014cf00b0068a5e3c79e0mr26838586pfu.4.1693000970558;
        Fri, 25 Aug 2023 15:02:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b00660d80087a8sm2027494pfn.187.2023.08.25.15.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 15:02:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yonghong Song <yonghong.song@linux.dev>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] kallsyms: Change func signature for cleanup_symbol_name()
Date:   Fri, 25 Aug 2023 15:02:41 -0700
Message-Id: <169300095959.944583.10380141849424753586.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825202036.441212-1-yonghong.song@linux.dev>
References: <20230825202036.441212-1-yonghong.song@linux.dev>
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

On Fri, 25 Aug 2023 13:20:36 -0700, Yonghong Song wrote:
> All users of cleanup_symbol_name() do not use the return value.
> So let us change the return value of cleanup_symbol_name() to
> 'void' to reflect its usage pattern.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] kallsyms: Change func signature for cleanup_symbol_name()
      https://git.kernel.org/kees/c/76903a964874

Take care,

-- 
Kees Cook

