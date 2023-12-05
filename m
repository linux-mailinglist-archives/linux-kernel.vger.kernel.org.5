Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72C9804DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjLEJ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjLEJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:28:14 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BBF135
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:28:18 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce52ff23dfso1385279b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701768498; x=1702373298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ww+t+x4EF+o8Iz1q4xD0rNSq2UgrGpxhIva2EbXP3U=;
        b=WQd4Rz90XOrJAD0wvBSaA0RZETBsG2VzReNSLplzy+/P//EiOtHblYd5upcyeQGq+w
         J3RoD5OHQT8q+3IHewwRRnD5NsFhPnXAiWCYw4Hs5QGNUIgeFZV+YGAt/hbooNuds0mz
         iF8+iJFXWbuAlWLgYTrG7qFTpy17EzpT5j5JHGfoUEhHAn/VIPFUCrjJrBE5jHMh6rX7
         ikfq9/TQ3lXm/euJj2cHnIS8RHs0KssxBX8Cqzl20QRecoURA6MxVhI8K4UrrH+j2eja
         mLN14jt+13Z5S93TIrAEjS8kgKhJBd+V1jI/PaI7odB+Hn0W3ZPU7OF378Y7zldLizw8
         eW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768498; x=1702373298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ww+t+x4EF+o8Iz1q4xD0rNSq2UgrGpxhIva2EbXP3U=;
        b=UhJ/EPgvD0bRQnexxYVzA0gFyhMu0wNXz53o9OutBPMaMAiTOj4LcjMmnYDA49MeEl
         qkxvPAmHF0azBiCSeh5Og4pGmFdzAJAKS5l8pqhM4w2IHx/QN+vWxk16OiKRAMo7xQUH
         rImVtM4/pGep8uJXrD4wxrj+QchbdRgb5BkUx+z8T8IJgqJaDH5nIP2wmaIzNqS6QE4z
         Fkz+2aj2O4wp/7DKAv0s+9WkN5RkALXa6Bs4WH75fQ8JD1eXApMuthVTaxrWgUMz8Atk
         xL37IX/8EAkyk4D7Ki+5QeiM83926yJ1AFVtiN4xfteCLycTWRTffqfWB6oqJL9L24QU
         4Xww==
X-Gm-Message-State: AOJu0YyoDh7nvLAKnnfKiBqZ47Hzh8NW5isiVlTjvWZt+Ts0yd/tV5W/
        zWDVVKK14vPKK87YbsJDyp0VYw==
X-Google-Smtp-Source: AGHT+IFaWRkKbZw7DstMCEBheFGlYTaPcp/3Zi4NlnL96zF+Y1cISDdKfBWTpwQP+FRgk8CWXY1DdQ==
X-Received: by 2002:a05:6a00:893:b0:6ce:2757:7866 with SMTP id q19-20020a056a00089300b006ce27577866mr1216195pfj.33.1701768498058;
        Tue, 05 Dec 2023 01:28:18 -0800 (PST)
Received: from localhost.localdomain ([101.10.93.135])
        by smtp.gmail.com with ESMTPSA id l6-20020a056a00140600b006cdd723bb6fsm8858788pfu.115.2023.12.05.01.28.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 01:28:17 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org, conor@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 02/12] RISC-V: hook new crypto subdir into build-system
Date:   Tue,  5 Dec 2023 17:27:51 +0800
Message-Id: <20231205092801.1335-3-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231205092801.1335-1-jerry.shih@sifive.com>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Create a crypto subdirectory for added accelerated cryptography routines
and hook it into the riscv Kbuild and the main crypto Kconfig.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
 arch/riscv/Kbuild          | 1 +
 arch/riscv/crypto/Kconfig  | 5 +++++
 arch/riscv/crypto/Makefile | 4 ++++
 crypto/Kconfig             | 3 +++
 4 files changed, 13 insertions(+)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile

diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
index d25ad1c19f88..2c585f7a0b6e 100644
--- a/arch/riscv/Kbuild
+++ b/arch/riscv/Kbuild
@@ -2,6 +2,7 @@
 
 obj-y += kernel/ mm/ net/
 obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
+obj-$(CONFIG_CRYPTO) += crypto/
 obj-y += errata/
 obj-$(CONFIG_KVM) += kvm/
 
diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
new file mode 100644
index 000000000000..10d60edc0110
--- /dev/null
+++ b/arch/riscv/crypto/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
+
+endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
new file mode 100644
index 000000000000..b3b6332c9f6d
--- /dev/null
+++ b/arch/riscv/crypto/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# linux/arch/riscv/crypto/Makefile
+#
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 650b1b3620d8..c7b23d2c58e4 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1436,6 +1436,9 @@ endif
 if PPC
 source "arch/powerpc/crypto/Kconfig"
 endif
+if RISCV
+source "arch/riscv/crypto/Kconfig"
+endif
 if S390
 source "arch/s390/crypto/Kconfig"
 endif
-- 
2.28.0

