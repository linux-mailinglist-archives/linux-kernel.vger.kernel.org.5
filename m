Return-Path: <linux-kernel+bounces-152452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9BA8ABEAD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 08:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2371F21024
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 06:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B0D27E;
	Sun, 21 Apr 2024 06:34:31 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7887A610B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713681270; cv=none; b=Ifp+bvUsTO5qwC8NVtUtxx7bahnWdcfs4yYz5zjtxWpEmKplJaR+D8YiNhUxCt3Uitl/yGSVrtGZQd9LlM3SjJ5Ik0y0NH9cBfGIj7pRUzthNL6YRY84M1I9J3k33eyPqllRnbrVXb3cQAo5AuArvXh4ctiZRAMphNWSptWNjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713681270; c=relaxed/simple;
	bh=VD/0Pgea1LB9bTtunmnVPCOT/7QCqILhW2dLTcV6YOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gZcYzfl/PC7XjBDXKtBywSg4XKRJf+qbYX8twItERes3D7Q+yDc5JhVJmASaZ0q2W6KCZW84yxtvX65Z/RySm+MHd7+NWzGbXA6aaJ3JrHIOfQAZLmdb8+SbVEFzSptb1YRgSvQqft+puOA6gPGvQVS1YpEr5p31tjFAUw78ihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrAB3Xew5syRmL9D8AA--.15695S2;
	Sun, 21 Apr 2024 14:33:29 +0800 (CST)
Received: from ubuntu.. (unknown [10.12.190.182])
	by gateway (Coremail) with SMTP id _____wCHf9o4syRmUdi+AQ--.34043S2;
	Sun, 21 Apr 2024 14:33:29 +0800 (CST)
From: Shiqi Liu <shiqiliu@hust.edu.cn>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: broonie@kernel.org,
	anshuman.khandual@arm.com,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	miguel.luis@oracle.com,
	joey.gouly@arm.com,
	shiqiliu@hust.edu.cn,
	oliver.upton@linux.dev,
	jingzhangos@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/sysreg: Update PIE permission encodings
Date: Sun, 21 Apr 2024 14:33:28 +0800
Message-Id: <20240421063328.29710-1-shiqiliu@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAB3Xew5syRmL9D8AA--.15695S2
Authentication-Results: app2; spf=neutral smtp.mail=shiqiliu@hust.edu.
	cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1rWF1DKFWfGw48uF4kWFg_yoW5GF4DpF
	1kCas0qr12gF47u34fKFnxCrW3Ja1rtr13Xa17urZrJF15uw18Wr1aqF43trW7ZFWktFW5
	Xr1DKw1Yvr9rZrJanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm0b7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUAV
	WUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr1j6F4UJwAv7VCjz48v1sIEY2
	0_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcV
	Cjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	AVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x07j2uWLUUUUU=
X-CM-SenderInfo: bpsqjjaxryjlo6kx23oohg3hdfq/

Fix left shift overflow issue when the parameter idx is greater than or
equal to 8 in the calculation of perm in PIRx_ELx_PERM macro.

Fix this by modifying the encoding to use a long integer type.

Signed-off-by: Shiqi Liu <shiqiliu@hust.edu.cn>
---
 arch/arm64/include/asm/sysreg.h       | 24 ++++++++++++------------
 tools/arch/arm64/include/asm/sysreg.h | 24 ++++++++++++------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9e8999592f3a..af3b206fa423 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1036,18 +1036,18 @@
  * Permission Indirection Extension (PIE) permission encodings.
  * Encodings with the _O suffix, have overlays applied (Permission Overlay Extension).
  */
-#define PIE_NONE_O	0x0
-#define PIE_R_O		0x1
-#define PIE_X_O		0x2
-#define PIE_RX_O	0x3
-#define PIE_RW_O	0x5
-#define PIE_RWnX_O	0x6
-#define PIE_RWX_O	0x7
-#define PIE_R		0x8
-#define PIE_GCS		0x9
-#define PIE_RX		0xa
-#define PIE_RW		0xc
-#define PIE_RWX		0xe
+#define PIE_NONE_O	UL(0x0)
+#define PIE_R_O		UL(0x1)
+#define PIE_X_O		UL(0x2)
+#define PIE_RX_O	UL(0x3)
+#define PIE_RW_O	UL(0x5)
+#define PIE_RWnX_O	UL(0x6)
+#define PIE_RWX_O	UL(0x7)
+#define PIE_R		UL(0x8)
+#define PIE_GCS		UL(0x9)
+#define PIE_RX		UL(0xa)
+#define PIE_RW		UL(0xc)
+#define PIE_RWX		UL(0xe)
 
 #define PIRx_ELx_PERM(idx, perm)	((perm) << ((idx) * 4))
 
diff --git a/tools/arch/arm64/include/asm/sysreg.h b/tools/arch/arm64/include/asm/sysreg.h
index ccc13e991376..cd8420e8c3ad 100644
--- a/tools/arch/arm64/include/asm/sysreg.h
+++ b/tools/arch/arm64/include/asm/sysreg.h
@@ -701,18 +701,18 @@
  * Permission Indirection Extension (PIE) permission encodings.
  * Encodings with the _O suffix, have overlays applied (Permission Overlay Extension).
  */
-#define PIE_NONE_O	0x0
-#define PIE_R_O		0x1
-#define PIE_X_O		0x2
-#define PIE_RX_O	0x3
-#define PIE_RW_O	0x5
-#define PIE_RWnX_O	0x6
-#define PIE_RWX_O	0x7
-#define PIE_R		0x8
-#define PIE_GCS		0x9
-#define PIE_RX		0xa
-#define PIE_RW		0xc
-#define PIE_RWX		0xe
+#define PIE_NONE_O	UL(0x0)
+#define PIE_R_O		UL(0x1)
+#define PIE_X_O		UL(0x2)
+#define PIE_RX_O	UL(0x3)
+#define PIE_RW_O	UL(0x5)
+#define PIE_RWnX_O	UL(0x6)
+#define PIE_RWX_O	UL(0x7)
+#define PIE_R		UL(0x8)
+#define PIE_GCS		UL(0x9)
+#define PIE_RX		UL(0xa)
+#define PIE_RW		UL(0xc)
+#define PIE_RWX		UL(0xe)
 
 #define PIRx_ELx_PERM(idx, perm)	((perm) << ((idx) * 4))
 
-- 
2.34.1


