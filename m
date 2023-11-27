Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E577F9AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjK0HHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjK0HHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:07:13 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC5412D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:07:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfa8f7c356so13681925ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701068839; x=1701673639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMA+62ieF0dHRmbCC9GfwETOr1r4110ste5ly+nBz6U=;
        b=HmNx+yUnvgnQUx0mmcJDl6+/jcRjbWZTVcZkbiTQihU3fwI9ZVC+RNwaJxXO6r85XR
         9cfSYPzXj9ZIk9kOZ93aTwXGEK84mjROA5r+oSUWqtGGOM9zFRKqoc1mK02zW6q1wwrF
         x2iQRCavZJKOsP66zjln2HFTjRqKS8ZSNGxaQm52t38Pswhb74W6J3HV3lYcuRNgvhS1
         DYBvZpyKboPF4S9kPSZEqyi+/rn1Ji7KjBAzmghLYY19iPttqGkq1RAPvVBeRBPVRtH6
         NesvgqyiyeqfwhPmfH/y2+jUX/FIcD1/40PwW3YcDRPDCqdF1QfLb8HuEsA1vLCqxlJ1
         zAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068839; x=1701673639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMA+62ieF0dHRmbCC9GfwETOr1r4110ste5ly+nBz6U=;
        b=C15dAFsQNruWElV2ajM1lIhuGTQsTJm9MjZhPU3uBTCVjv8tz1UnGBEJq/G8Pj2B2v
         PuJrexLzeT96WcyjpkQHjNvCO17fBbbDmGPGYDZzfPQFohRtrZvjhf8/+Jol5IuJPYoO
         UyGZbQtXbcAm6Q2huuIJQe6KjmF3CEHyjJjSrj/Exl5nbtaNkumYGM3jxX6uyOWxO3Ol
         nttAplJtSjkiICYkh+lh/nRfjr/Rgh1dX87TrSbvNnEvbgp2PrK4Siq7e5GpKlaH36fG
         rkttXl45LZQkMzKNUL1LkG5ZRazagfsUfrB09cm42fq1RT7BmqnrQpxr0ZIfFi4onZbV
         58Vg==
X-Gm-Message-State: AOJu0YwRYbd1lYldSQAkWccZ7OOo3Gr1jcOrIBvLzE/IFKDKp+FwpZE1
        K3l+N+li8KmjmnJXGrVvir9W7w==
X-Google-Smtp-Source: AGHT+IGuXY7hovfUUFK918N8FOS5pzp5Ne429WLs/7kFsDgC+8/3HusV0OnDurXW0gspNvwdh6EGhA==
X-Received: by 2002:a17:903:1205:b0:1cc:5589:7dba with SMTP id l5-20020a170903120500b001cc55897dbamr10929394plh.43.1701068839357;
        Sun, 26 Nov 2023 23:07:19 -0800 (PST)
Received: from localhost.localdomain ([101.10.45.230])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001cfcd3a764esm1340134plb.77.2023.11.26.23.07.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2023 23:07:19 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 02/13] RISC-V: hook new crypto subdir into build-system
Date:   Mon, 27 Nov 2023 15:06:52 +0800
Message-Id: <20231127070703.1697-3-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231127070703.1697-1-jerry.shih@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

