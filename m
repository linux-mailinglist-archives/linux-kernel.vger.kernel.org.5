Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AFD7FC12E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjK1QxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344772AbjK1Qw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:52:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8393410D8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:53:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DD3C433C8;
        Tue, 28 Nov 2023 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701190384;
        bh=3qurBRQ+YYPOV/RKYMrmvhtcPz7PtaDGGqvhTMc0mA0=;
        h=From:Date:Subject:To:Cc:From;
        b=ATXuq9a1kuRQI+tUyQf1iziGaB7B4aDpmGQS2N9tEcFvJZj5aiTOTwX2OT9xpIxcg
         fzciCjeJroMPD6cqwjYwHngs2wF6WR2nYGPmsQUVxuDR61Q+FPoGREmCQMRsGDxMcj
         hXfNc1TlS5dNs+lSrdVPHLS52uqdJlNQ6LRcZQwUGg5ZIb7YzJWfRrWJiEs6Imx4ko
         t19+nUjhDgDb5Ez9AamWTI5wI2yDPz/URNJJS87llNisCUp7nCP/+F4TtEP1qTb6CX
         7WwSqwqarbfVhS+Ou/AlWYiVwNuYCx9IKHek/gcKMiQ6Fd5Cegf2Gt1i+2pp9Hgzed
         p1Xwfc9uah7bQ==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 28 Nov 2023 09:52:48 -0700
Subject: [PATCH] arm64: vdso32: Define BUILD_VDSO32_64 to correct
 prototypes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-arm64-vdso32-missing-prototypes-error-v1-1-0fdd403cea07@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN8aZmUC/x3NwQrCMAyA4VcZORtoUxXxVcRDWbOZw5qSjDEZe
 3eLx+/y/wc4m7DDczjAeBMXrR3xMsD4yXVmlNINFCjFSA/MttyvuBXXRLiIu9QZm+mq67exI5u
 pIYeSQo4j32iC3mrGk+z/z+t9nj/APoitdwAAAA==
To:     arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org
Cc:     vincenzo.frascino@arm.com, nathan@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2927; i=nathan@kernel.org;
 h=from:subject:message-id; bh=3qurBRQ+YYPOV/RKYMrmvhtcPz7PtaDGGqvhTMc0mA0=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlpUu83Tt2XejStwHnRKj+HDXckRB6y+QjrnHN1Cnz1o
 +xB1ZOajlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRpUoM/9PuCLDdfrTRir03
 h+ecI8up+4FPdN0zNc/wPXmRkXpi30dGhqt7a9ZFd+oEiYuc4zTYd7oke9oiwZhjJx9Oknl/TDR
 0HzsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 42874e4eb35b ("arch: vdso: consolidate gettime
prototypes"), there are a couple of errors when building the 32-bit
compat vDSO for arm64:

  arch/arm64/kernel/vdso32/vgettimeofday.c:10:5: error: conflicting types for '__vdso_clock_gettime'; have 'int(clockid_t,  struct old_timespec32 *)' {aka 'int(int,  struct old_timespec32 *)'}
     10 | int __vdso_clock_gettime(clockid_t clock,
        |     ^~~~~~~~~~~~~~~~~~~~
  In file included from arch/arm64/kernel/vdso32/vgettimeofday.c:8:
  include/vdso/gettime.h:16:5: note: previous declaration of '__vdso_clock_gettime' with type 'int(clockid_t,  struct __kernel_timespec *)' {aka 'int(int,  struct __kernel_timespec *)'}
     16 | int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
        |     ^~~~~~~~~~~~~~~~~~~~
  arch/arm64/kernel/vdso32/vgettimeofday.c:28:5: error: conflicting types for '__vdso_clock_getres'; have 'int(clockid_t,  struct old_timespec32 *)' {aka 'int(int,  struct old_timespec32 *)'}
     28 | int __vdso_clock_getres(clockid_t clock_id,
        |     ^~~~~~~~~~~~~~~~~~~
  include/vdso/gettime.h:15:5: note: previous declaration of '__vdso_clock_getres' with type 'int(clockid_t,  struct __kernel_timespec *)' {aka 'int(int,  struct __kernel_timespec *)'}
     15 | int __vdso_clock_getres(clockid_t clock, struct __kernel_timespec *res);
        |     ^~~~~~~~~~~~~~~~~~~

The type of the second parameter in __vdso_clock_getres() and
__vdso_clock_gettime() changes based on whether compiling for 32-bit vs.
64-bit, which is controlled by CONFIG_64BIT or the preprocessor macro
BUILD_VDSO32_64, which denotes a 32-bit vDSO is being built for a 64-bit
architecture. Since this situation is the latter case, define
BUILD_VDSO32_64 before the inclusion of include/vdso/gettime.h to clear
up the warning

Fixes: 42874e4eb35b ("arch: vdso: consolidate gettime prototypes")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/CA+G9fYtV6X=c3JVTTAX89_=wc+uqLpzggnsbGSx-98m_5yd5yw@mail.gmail.com/
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/ZWCRWArzbTYUjvon@finisterre.sirena.org.uk/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/kernel/vdso32/vgettimeofday.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
index e23c7f4ef26b..29b4d8f61e39 100644
--- a/arch/arm64/kernel/vdso32/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018 ARM Limited
  *
  */
+#define BUILD_VDSO32_64
 #include <vdso/gettime.h>
 
 int __vdso_clock_gettime(clockid_t clock,

---
base-commit: ca8e45c8048a2c9503c74751d25414601f730580
change-id: 20231128-arm64-vdso32-missing-prototypes-error-e0d30a1ce52f

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

