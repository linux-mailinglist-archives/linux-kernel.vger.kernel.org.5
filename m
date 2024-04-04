Return-Path: <linux-kernel+bounces-131272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B1189858F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B11D28C1F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9182C7E;
	Thu,  4 Apr 2024 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LXu1O22b"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72D8004D;
	Thu,  4 Apr 2024 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228333; cv=none; b=AGo7bHLY3cHhh4MFT71LYNsCcKXH1UjEzs5P6A9tuMhfQaGLaagVjUdiMioEmZMYkVO0XuaBOO+QKZZV8KvGXnnbQRZr6qt2UxgBAV3JHdn7SsX0yuWFVGr0GYc2IAPR8WiU8BuUuTVDF3jziYvU9tBfhfmwE6RjUEfk2a7nUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228333; c=relaxed/simple;
	bh=Rc3R2b6o6+XSpkXaC+GKakPvjIA7w7nIQw4D0hiTupI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S5Plzj7z1XQXgJX4VthfdCmoeImFC3IFdlX7o3IR94kEMx/x2F1aF2LoW/LihCrNfda85wfQE9t0tGjXXTsMnnQUx+OcwMzP/sb2hl/R4Lh7JLfih8dG1AavSzAr024oqCUnGq/7pix/5hpUn0c9KXzImFEajtdlmGxa0hxhXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LXu1O22b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434AuCal005146;
	Thu, 4 Apr 2024 10:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Q1KT3XwIxwc3eWYDOHmzuEX/o01qlD903VMt0m1mc04=;
 b=LXu1O22bnMKcKxmDTjaAYCpV7w+czbf7dp/OBRw5wqysqQoPEHmLbPHdMlJkDrw2chgZ
 3qwyeOWUhwLqSNq17npaS7E7xNnqgECWOBIh5oqFW79XJEQW8LuWqKadPfqNv8c/BYfU
 7yn9GavNCom6B69W5Rx2VC0AQ0prA/kzV7TTL+VHQMWVhCGZPheoVRUeSsuWPO10Sw2p
 d/TQkWDRMt4C/tWhD4m71QMYhkMOwZEECaO3i3GjvzxsLEhY2zK/AAsFRIONCNSO/ySG
 Pzknz8qhdsZNQV6kiODKAVApHm4roT36jpz94hIAlw28W7d4G2c80LEO3m+9+rA0rvzC HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9tvh80dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 10:58:47 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 434AwlJo008464;
	Thu, 4 Apr 2024 10:58:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9tvh80de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 10:58:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434ALcZ8008629;
	Thu, 4 Apr 2024 10:58:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epw3p65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 10:58:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434Awe2g43712956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 10:58:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAAB72004D;
	Thu,  4 Apr 2024 10:58:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8EE72004E;
	Thu,  4 Apr 2024 10:58:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 10:58:40 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] char: tpm: handle HAS_IOPORT dependencies
Date: Thu,  4 Apr 2024 12:58:40 +0200
Message-Id: <20240404105840.3396821-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240404105840.3396821-1-schnelle@linux.ibm.com>
References: <20240404105840.3396821-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lqniLcAq6qDv7lYPEmKKVJ4QnPtQRQ3e
X-Proofpoint-ORIG-GUID: SI1L4iVm5GCUywQsPcSnBwYzaWV7oztI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040075

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. We thus need to add this dependency and ifdef sections of
code using inb()/outb() as alternative access methods.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
and may be merged via subsystem specific trees at your earliest
convenience.

 drivers/char/tpm/Kconfig        |  1 +
 drivers/char/tpm/tpm_infineon.c | 16 ++++++++++++----
 drivers/char/tpm/tpm_tis_core.c | 19 ++++++++-----------
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 927088b2c3d3..418c9ed59ffd 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -149,6 +149,7 @@ config TCG_NSC
 config TCG_ATMEL
 	tristate "Atmel TPM Interface"
 	depends on PPC64 || HAS_IOPORT_MAP
+	depends on HAS_IOPORT
 	help
 	  If you have a TPM security chip from Atmel say Yes and it 
 	  will be accessible from within Linux.  To compile this driver 
diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 9c924a1440a9..99c6e565ec8d 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -26,7 +26,9 @@
 #define	TPM_MAX_TRIES		5000
 #define	TPM_INFINEON_DEV_VEN_VALUE	0x15D1
 
+#ifdef CONFIG_HAS_IOPORT
 #define TPM_INF_IO_PORT		0x0
+#endif
 #define TPM_INF_IO_MEM		0x1
 
 #define TPM_INF_ADDR		0x0
@@ -51,34 +53,40 @@ static struct tpm_inf_dev tpm_dev;
 
 static inline void tpm_data_out(unsigned char data, unsigned char offset)
 {
+#ifdef CONFIG_HAS_IOPORT
 	if (tpm_dev.iotype == TPM_INF_IO_PORT)
 		outb(data, tpm_dev.data_regs + offset);
 	else
+#endif
 		writeb(data, tpm_dev.mem_base + tpm_dev.data_regs + offset);
 }
 
 static inline unsigned char tpm_data_in(unsigned char offset)
 {
+#ifdef CONFIG_HAS_IOPORT
 	if (tpm_dev.iotype == TPM_INF_IO_PORT)
 		return inb(tpm_dev.data_regs + offset);
-	else
-		return readb(tpm_dev.mem_base + tpm_dev.data_regs + offset);
+#endif
+	return readb(tpm_dev.mem_base + tpm_dev.data_regs + offset);
 }
 
 static inline void tpm_config_out(unsigned char data, unsigned char offset)
 {
+#ifdef CONFIG_HAS_IOPORT
 	if (tpm_dev.iotype == TPM_INF_IO_PORT)
 		outb(data, tpm_dev.config_port + offset);
 	else
+#endif
 		writeb(data, tpm_dev.mem_base + tpm_dev.index_off + offset);
 }
 
 static inline unsigned char tpm_config_in(unsigned char offset)
 {
+#ifdef CONFIG_HAS_IOPORT
 	if (tpm_dev.iotype == TPM_INF_IO_PORT)
 		return inb(tpm_dev.config_port + offset);
-	else
-		return readb(tpm_dev.mem_base + tpm_dev.index_off + offset);
+#endif
+	return readb(tpm_dev.mem_base + tpm_dev.index_off + offset);
 }
 
 /* TPM header definitions */
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 714070ebb6e7..176cd8dbf1db 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1057,11 +1057,6 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
 		clkrun_val &= ~LPC_CLKRUN_EN;
 		iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
 
-		/*
-		 * Write any random value on port 0x80 which is on LPC, to make
-		 * sure LPC clock is running before sending any TPM command.
-		 */
-		outb(0xCC, 0x80);
 	} else {
 		data->clkrun_enabled--;
 		if (data->clkrun_enabled)
@@ -1072,13 +1067,15 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
 		/* Enable LPC CLKRUN# */
 		clkrun_val |= LPC_CLKRUN_EN;
 		iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
-
-		/*
-		 * Write any random value on port 0x80 which is on LPC, to make
-		 * sure LPC clock is running before sending any TPM command.
-		 */
-		outb(0xCC, 0x80);
 	}
+
+#ifdef CONFIG_HAS_IOPORT
+	/*
+	 * Write any random value on port 0x80 which is on LPC, to make
+	 * sure LPC clock is running before sending any TPM command.
+	 */
+	outb(0xCC, 0x80);
+#endif
 }
 
 static const struct tpm_class_ops tpm_tis = {
-- 
2.40.1


