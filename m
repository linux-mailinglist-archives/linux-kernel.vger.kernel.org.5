Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A2E76D111
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjHBPIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjHBPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:07:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BEB2D63
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:07:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c647150c254so1841646276.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690988848; x=1691593648;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ODlQqQRL7j+ioqTq3MDMk7BwHCUeRlM+arLr48y6tNA=;
        b=SlPCrS1xmbnWErc1CKgkJPNCNs7mvtB7anzE5xNQkivhTRzEbUhgWQnPMVMtb3VXh+
         ZBtkHFgVBWyYK9aJXUFag88OyruHvsTDz0sROofPxloDejTDL0u7WLbUzdd0bjeB+jSN
         oTfyPlrZyq9uO50GbK472SiCDM3EoN7lghNrsmGgmy5MZ0QBWWSW/G3ysfDRPCvjzTil
         jIk0DCPgZI/Khn3fRGwbxbnH3v6fhL+esA/xOgDvjtUUcvHxo0iNIh9aXl4CxUkdcmD8
         fJBSw5TBqO8FHGk7VqWk7U50HciveTvD2sCx9Bd9M88m/E0/TJ8dDqT/2Fi+tjLdynkA
         hc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988848; x=1691593648;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ODlQqQRL7j+ioqTq3MDMk7BwHCUeRlM+arLr48y6tNA=;
        b=KuUvqrPJj0JFxpO8ZScOXBvED6FK/MrEQ7uW9wj+ZkgZeQo3nI+TG1diuUeolmQf75
         D/ldGWUYESEbBtOFnOA9AJ9ibduPMFIWyUPg6H9N4Ja3YFKt8Bn139JRos90ktqDONtB
         MN60HtAYnevSVa9j5oXLHhvhopg096cYDUbpw68gPfY5G5bLufCyuoAgvTn7gzGH5tyG
         W07K6W1wdNmNRzArtvg+6m87sBHe7JXeod07ITp1gJyRCCHjiFs5gnaE9AucmtYv05EX
         8UHu0ojCgFYKTb4HSVxOHPkrskD7t8iShgUoBPsnuj+k+BjOOrVu72YcJzI+m9DJK1fd
         illA==
X-Gm-Message-State: ABy/qLbXflzD6nl/H3qPgsWzIfy64acdgy1hUGNhEYcscEBb7FQUfcEs
        qPfDTJGU74XD2vEEm3H8Ki377OOxWg==
X-Google-Smtp-Source: APBJJlG54cyvOOilnqyHEvE3EGA71yo6JZSxh2bIK8O8x7AqakXp9rNt0p+eKxoE0w7ySnwaeqPwqs6mJg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:5f73:1fc0:c9fd:f203])
 (user=elver job=sendgmr) by 2002:a25:dfc3:0:b0:d15:53b5:509f with SMTP id
 w186-20020a25dfc3000000b00d1553b5509fmr197192ybg.2.1690988848424; Wed, 02 Aug
 2023 08:07:28 -0700 (PDT)
Date:   Wed,  2 Aug 2023 17:06:37 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802150712.3583252-1-elver@google.com>
Subject: [PATCH 1/3] Compiler attributes: Introduce the __preserve_most
 function attribute
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[1]: "On X86-64 and AArch64 targets, this attribute changes the calling
convention of a function. The preserve_most calling convention attempts
to make the code in the caller as unintrusive as possible. This
convention behaves identically to the C calling convention on how
arguments and return values are passed, but it uses a different set of
caller/callee-saved registers. This alleviates the burden of saving and
recovering a large register set before and after the call in the
caller."

[1] https://clang.llvm.org/docs/AttributeReference.html#preserve-most

Use of this attribute results in better code generation for calls to
very rarely called functions, such as error-reporting functions, or
rarely executed slow paths.

Introduce the attribute to compiler_attributes.h.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler_attributes.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 00efa35c350f..615a63ecfcf6 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -321,6 +321,17 @@
 # define __pass_object_size(type)
 #endif
 
+/*
+ * Optional: not supported by gcc.
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#preserve-most
+ */
+#if __has_attribute(__preserve_most__)
+# define __preserve_most __attribute__((__preserve_most__))
+#else
+# define __preserve_most
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-pure-function-attribute
  */
-- 
2.41.0.585.gd2178a4bd4-goog

