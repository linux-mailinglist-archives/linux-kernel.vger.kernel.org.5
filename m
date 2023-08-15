Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D486E77D5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbjHOV7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbjHOV6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:58:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46751FEC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:58:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6887c3aac15so109187b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692136716; x=1692741516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z8K31bkMTbdIni3NCgyAAMv9oewxKBq0qkaddr2kYE=;
        b=P5OEd4Nl1vFHMOZX0kiCCsg+ALdbM3Jq7SfXh8p09T5kt+BwT3N3A+WU/8d7eCFd2O
         LhOZTvl4ubIun+RbYT+844ggRTfu97S+QvSvLYZmQxkd8QzSViGI+4eiZUxpV4gS+ntY
         ZYn+0xq6abTK4+oIdkRuBdtGRoW6CGc4TDtu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692136716; x=1692741516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z8K31bkMTbdIni3NCgyAAMv9oewxKBq0qkaddr2kYE=;
        b=I9bNgrlLilo0lSLEXeORFMGhbE3ptgjzrzoTf7D9z9SNi6ThPw0Y5D43S29llh41XU
         zx9qyl+xnJqoio6w6V7iQYp7JBVYb2iwwxE0waGAwuKuy01cl8QbDpyc4S/keFbinqLQ
         5BTrRG5C56DZAdT25f0Ltpvd/InvEBuryuxRSfY+cTFAq6qlYI2umioGLBo81SP44Uls
         LBo2bshPracrjkQ3lEfS26rQdLfPfOGOO4gRxwS942E7LBZcIbfsfdRsKnKR4985BZ/W
         F3bPvmNUPg2CYfEjQthwWukWEUupayeiJ9WU1/5gDgXsXng0SJZIOHXmbHeVEAvwRfZk
         LxFQ==
X-Gm-Message-State: AOJu0YynLn/gzLg/g56n/bQc+cY4n9YOuoUO7AqRGCBdvMtG49jFD4Ww
        FwC2ijyilwbO5zuZ0y2KBXRQ2A==
X-Google-Smtp-Source: AGHT+IGIGJcDqcADsYQ9H0lWCBGqrfD4exL5cuoWWqNOlf/hsRbDS674HVOPC9PdGLNB8RfKgc3Qug==
X-Received: by 2002:a05:6a20:938b:b0:141:69d:8041 with SMTP id x11-20020a056a20938b00b00141069d8041mr158650pzh.48.1692136716284;
        Tue, 15 Aug 2023 14:58:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z17-20020a637e11000000b0056129129ef8sm10583401pgc.18.2023.08.15.14.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 14:58:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v4 1/4] compiler_types: Introduce the Clang __preserve_most function attribute
Date:   Tue, 15 Aug 2023 14:58:29 -0700
Message-Id: <169213670578.656151.9756083800563304743.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811151847.1594958-1-elver@google.com>
References: <20230811151847.1594958-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 17:18:38 +0200, Marco Elver wrote:
> [1]: "On X86-64 and AArch64 targets, this attribute changes the calling
> convention of a function. The preserve_most calling convention attempts
> to make the code in the caller as unintrusive as possible. This
> convention behaves identically to the C calling convention on how
> arguments and return values are passed, but it uses a different set of
> caller/callee-saved registers. This alleviates the burden of saving and
> recovering a large register set before and after the call in the caller.
> If the arguments are passed in callee-saved registers, then they will be
> preserved by the callee across the call. This doesn't apply for values
> returned in callee-saved registers.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/4] compiler_types: Introduce the Clang __preserve_most function attribute
      https://git.kernel.org/kees/c/7a0fd5e16785
[2/4] list_debug: Introduce inline wrappers for debug checks
      https://git.kernel.org/kees/c/b16c42c8fde8
[3/4] list: Introduce CONFIG_LIST_HARDENED
      https://git.kernel.org/kees/c/aebc7b0d8d91
[4/4] hardening: Move BUG_ON_DATA_CORRUPTION to hardening options
      https://git.kernel.org/kees/c/aa9f10d57056

Take care,

-- 
Kees Cook

