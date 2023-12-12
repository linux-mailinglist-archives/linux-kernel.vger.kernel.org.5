Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B505180E4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345940AbjLLHny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjLLHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:43:51 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D4CC2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:43:57 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d9f9fbfd11so2250088a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702367036; x=1702971836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TOXKU7bsGbNdHwHYKjDdosOGqerCEfbXvQrWb4UvRVA=;
        b=LSo5XZFIc/VUGHNlD/o56Rk2QJkMRRxPmj/6S+vhtduOpSWVmESkYQ4SxUJ442BijS
         aSuqHfvmvWekqgxUN1RxOntxyQNV7MHgOUx5AVlyu8VmbtlvtxkGNscRUmymye7DG7lu
         G86q3j5QMnwUbO9MV7I1EnHQS5IHFOn3Iv63bw5Q8NC03KpdUZEZrUKDJkyyZoD6F0K5
         S5Q1q8D93f0tCHC9EJbcwqOuilkiDujcQFsrelaGsfG0QkaA7GvSRpUu1Fp6jjfhIehN
         onRKLZ3gWOEJ2kDEIz+56bTUzkHnziQlx5EI7IXQA4zsdlhw9zjK3eAvexXyjTVme+Wm
         w+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702367036; x=1702971836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOXKU7bsGbNdHwHYKjDdosOGqerCEfbXvQrWb4UvRVA=;
        b=J+gH1me8BjmvAzy7wTEz7ZxRtJfO2JxhvW6VMwr8E1UmJSW07kF7eFpz75frmTZJNi
         Fb5qf5XuyRstXo8YjbHqyhcHN+20FA3Pudbogn7+d10qePPb6bXTUChOPfG40xlPy8bt
         HMXU/ltEGbjg3IfgfSbdL/ag2TB7PLXVPPJ0jUIaPEjsqrhcurB8ciop0RUS0cG9aEZy
         EmYQy2IsGHbauE39CV0IkVZ3ITRr7MDQmTi8rNbTikGbdcjqMXBv1merr+JEimcDKDaL
         kSmSJjXWJpJHQk0ktUDyUptZZq9dqCv/N9mQu/F+J/r3b+B8IV9FuFdse+DR1OczOn4j
         wsaQ==
X-Gm-Message-State: AOJu0YwmA/0UxC7QYke73GZs1VztTe619AAQ72slVyZQzfiRgXq4QsKa
        pfKLUoBsVZpi7A85ru0mqNOBWA==
X-Google-Smtp-Source: AGHT+IGKLGKqgzeNRv7L+xn0zLYdEZOT4libZggr20dVVKc/KDhBqq0Pl8ckyK54H8v3G3sDD1FWkA==
X-Received: by 2002:a05:6830:615:b0:6d9:f334:f886 with SMTP id w21-20020a056830061500b006d9f334f886mr5749871oti.18.1702367036432;
        Mon, 11 Dec 2023 23:43:56 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id d12-20020a056a0010cc00b006ce61c9495fsm7470500pfu.206.2023.12.11.23.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:43:55 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] docs: rust: Clarify that 'rustup override' applies to build directory
Date:   Tue, 12 Dec 2023 13:13:48 +0530
Message-Id: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rustup override is required to be set for the build directory and not
necessarily the kernel source tree (unless the build directory is its
subdir).

Clarify the same in quick-start guide.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Made few changes based on review comments.

 Documentation/rust/quick-start.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index f382914f4191..7ea931f74e09 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -33,14 +33,18 @@ A particular version of the Rust compiler is required. Newer versions may or
 may not work because, for the moment, the kernel depends on some unstable
 Rust features.
 
-If ``rustup`` is being used, enter the checked out source code directory
-and run::
+If ``rustup`` is being used, enter the kernel build directory (or use
+`--path=<build-dir>` argument to the `set` sub-command) and run::
 
 	rustup override set $(scripts/min-tool-version.sh rustc)
 
 This will configure your working directory to use the correct version of
-``rustc`` without affecting your default toolchain. If you are not using
-``rustup``, fetch a standalone installer from:
+``rustc`` without affecting your default toolchain.
+
+Note that the override applies to the current working directory (and its
+sub-directories).
+
+If you are not using ``rustup``, fetch a standalone installer from:
 
 	https://forge.rust-lang.org/infra/other-installation-methods.html#standalone
 
-- 
2.31.1.272.g89b43f80a514

