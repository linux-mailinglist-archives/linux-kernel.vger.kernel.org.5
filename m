Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB58179EA71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbjIMOHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjIMOHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:07:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D7619B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:07:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401ce65dfc4so20492685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694614045; x=1695218845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eUcO5LOOz7EzwAPKcG26jxLJeh1V8AQ265+bz+A8SoI=;
        b=ghWp2P7FzMPfXxx92sRRLIgspF6ywoLPI0exB8rmYw6q8Zt7orULGR5cdhjmcfkk0U
         CGb0H/ATVoRbVugygxPv5L8tjzBRbAF0Dc30fPMfzJvhvS97QWFQv2hgc6fba9aBJnQ7
         5wwedTvp7Rkm4MgxthcG92MgyXT3liwxeH76nIX20pDHAX5gEZjzEeCUAUpKqBgQHqvt
         VQSyknI+PQ8XX4SsjhwALP63aNhxwvyaTfo+gGd+9w8gbcb7FRl9jSmVR7Tjb4XN9JWo
         MdIS5LScIr9h/Kv4n8MX49KAcBNpXmExcux+w9xx2XBJYz4oXHDkDg4ORpHE7nj3uaHQ
         scHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694614045; x=1695218845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUcO5LOOz7EzwAPKcG26jxLJeh1V8AQ265+bz+A8SoI=;
        b=HTSdsBS54nW3riVqpJVAMpRZ9XBeC9p1x4uFkaehsugv7xZ5NPz/yBMS2BnwBuHk0g
         8UW/7sAEj/2kmXje8+7D1pnSdgVbEh62f8xAJ4YlRmz+qj6GmNjcag0jNuQw+KGXfd+Q
         A+lqs52uVer1bOAKgPuXYFUkJo3/exDZlNVO3161X6yVATA4FokQXBhAPkAUb7TEy8lc
         4G45qvbDrXFWuYRN4h1VIVZqxOdmZTHlrUmDfIIGGwj1zyDqSFxHpH7f30e3pTe84zls
         f3mmbODn7C5iYx/U3OSXvrMEm6rRRPHoUSiC1oTNYR/1HIXk1Xg3qMxP95rKehXY7FT5
         ADWA==
X-Gm-Message-State: AOJu0YxvLZnTCSyvrVz+vceabGdoB4gEZnGkH2dRCctTB81+9QL2PXvK
        X6AncYNgm0JDrGBFfiZGfWybVAiCHxl6o1kzIjRVrA==
X-Google-Smtp-Source: AGHT+IGCH9EQFNujQ2CA3x2E+UgIyr58wi0F+nWTVuTCbTQOTY+VR6HOeI5WcUFS+BmJOSuQbmxsDA==
X-Received: by 2002:a05:600c:1da2:b0:401:7d3b:cc84 with SMTP id p34-20020a05600c1da200b004017d3bcc84mr2256337wms.0.1694614044700;
        Wed, 13 Sep 2023 07:07:24 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:8fed:c1bc:8957:f1f0])
        by smtp.gmail.com with ESMTPSA id q5-20020a7bce85000000b004013797efb6sm2166222wmj.9.2023.09.13.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 07:07:23 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Shuah Khan <shuah@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PATCH] selftests: sud_test: return correct emulated syscall value on RISC-V
Date:   Wed, 13 Sep 2023 16:07:11 +0200
Message-Id: <20230913140711.266975-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the sud_test expects the emulated syscall to return the
emulated syscall number. This assumption only works on architectures
were the syscall calling convention use the same register for syscall
number/syscall return value. This is not the case for RISC-V and thus
the return value must be also emulated using the provided ucontext.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 tools/testing/selftests/syscall_user_dispatch/sud_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index b5d592d4099e..1b5553c19700 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -158,6 +158,14 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 
 	/* In preparation for sigreturn. */
 	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	/*
+	 * Modify interrupted context returned value according to syscall
+	 * calling convention
+	 */
+#if defined(__riscv)
+	((ucontext_t*)ucontext)->uc_mcontext.__gregs[REG_A0] = MAGIC_SYSCALL_1;
+#endif
 }
 
 TEST(dispatch_and_return)
-- 
2.40.1

