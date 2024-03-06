Return-Path: <linux-kernel+bounces-94204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4C873B4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FE21C237B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9471369A9;
	Wed,  6 Mar 2024 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UiFIyMn7"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ADB5B664;
	Wed,  6 Mar 2024 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740537; cv=none; b=sv8HVCzZ1o0TP742ys/ip+mGV8/LekvDZEmN88LyuiYHkEyN/rm9y5NjBmHO3F0SDaKNEWKziI29AFi9k2PJ/rTwbkcyxDeRTZ2l7YEqQcITenRyVqNnQyRVZLVdtil2xnBo2dRq+r0K6NZnszp5wt+Rlep6EChBnbqnwzTE/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740537; c=relaxed/simple;
	bh=Z+200TIFPIJrfmEGNfAITwyHGFuIZSAX44aORegzy3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odDNKltSOQab0bBwmZ07V7RK9/9zl6AnwEkH1IVVgCpRYJgIBhDoIoh7brNj9E4i41E4k6ph1Fc2risneTcDIeu3dZ6oI20O1kh3YE88oJ3JSL1oWvoygONAkhs798AXKuXb2J1MzYhuRqq02PhuBUweSXJzjwBbyrfmE2rLSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UiFIyMn7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426FfEHh012501;
	Wed, 6 Mar 2024 15:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Usr/mQf5MJ3c5dVUkipMXdy38/fgnF+c3+QsiYGiLbY=;
 b=UiFIyMn7L4L4TekxCwjbag6GlbfjwDaWMTM0+8YXxdvtWuQKtkfq8grYd/Jlz/QPKsso
 3qvqeXp6fMSdE18eQ2emfzd8B4lcNs8aofE4BXnrc5cBAHo0sR34dHs9bKz9v302tJPA
 lI9aM63tJlKAfdyZOwpAHfZtwImtOhGwZTzog4ZJbL/91asP3oUYgZ8LmHEaeIJoZcH9
 xzxYv8Q/gm2pFx3I71w89lHAZio1r/EM5smCzwaHJ7+YQQkWOSsXX2phm1QQdWkNFClA
 7ld6mnqr0BjA2HeVgj5RAcptP5jeBCpLTyHXvW6eTRqoJC7CEuMKb8hG+m3x+kp7CQ+s oA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpu0b8ves-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:55:21 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426FpejY013295;
	Wed, 6 Mar 2024 15:55:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpu0b8ve5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:55:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426F6RJA024172;
	Wed, 6 Mar 2024 15:55:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsavk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:55:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426FtG2223003856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 15:55:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 113A45806A;
	Wed,  6 Mar 2024 15:55:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82AEA58063;
	Wed,  6 Mar 2024 15:55:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 15:55:15 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, rnsastry@linux.ibm.com,
        peterhuewe@gmx.de, viparash@in.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/2] tpm: of: If available Use linux,sml-log to get the log and its size
Date: Wed,  6 Mar 2024 10:55:11 -0500
Message-ID: <20240306155511.974517-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306155511.974517-1-stefanb@linux.ibm.com>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v1AkH8xdovcYzxmPLMeXK36wofKzc84i
X-Proofpoint-ORIG-GUID: Y3YmOQTZKs9OZ440swdZFKX77D_9Jsr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060127

If linux,sml-log is available use it to get the TPM log rather than the
pointer found in linux,sml-base. This resolves an issue on PowerVM and KVM
on Power where after a kexec the memory pointed to by linux,sml-base may
have been corrupted. Also, linux,sml-log has replaced linux,sml-base and
linux,sml-size on these two platforms.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/eventlog/of.c | 36 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index 930fe43d5daf..e37196e64ef1 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -54,8 +54,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	const u32 *sizep;
 	const u64 *basep;
 	struct tpm_bios_log *log;
+	const void *logp;
 	u32 size;
-	u64 base;
 
 	log = &chip->log;
 	if (chip->dev.parent && chip->dev.parent->of_node)
@@ -66,37 +66,23 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	if (of_property_read_bool(np, "powered-while-suspended"))
 		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
 
-	sizep = of_get_property(np, "linux,sml-size", NULL);
-	basep = of_get_property(np, "linux,sml-base", NULL);
-	if (sizep == NULL && basep == NULL)
-		return tpm_read_log_memory_region(chip);
-	if (sizep == NULL || basep == NULL)
-		return -EIO;
-
-	/*
-	 * For both vtpm/tpm, firmware has log addr and log size in big
-	 * endian format. But in case of vtpm, there is a method called
-	 * sml-handover which is run during kernel init even before
-	 * device tree is setup. This sml-handover function takes care
-	 * of endianness and writes to sml-base and sml-size in little
-	 * endian format. For this reason, vtpm doesn't need conversion
-	 * but physical tpm needs the conversion.
-	 */
-	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
-	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
+	logp = of_get_property(np, "linux,sml-log", &size);
+	if (logp == NULL) {
+		sizep = of_get_property(np, "linux,sml-size", NULL);
+		basep = of_get_property(np, "linux,sml-base", NULL);
+		if (sizep == NULL && basep == NULL)
+			return tpm_read_log_memory_region(chip);
+		if (sizep == NULL || basep == NULL)
+			return -EIO;
+		logp = __va(be64_to_cpup((__force __be64 *)basep));
 		size = be32_to_cpup((__force __be32 *)sizep);
-		base = be64_to_cpup((__force __be64 *)basep);
-	} else {
-		size = *sizep;
-		base = *basep;
 	}
-
 	if (size == 0) {
 		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
 		return -EIO;
 	}
 
-	log->bios_event_log = devm_kmemdup(&chip->dev, __va(base), size, GFP_KERNEL);
+	log->bios_event_log = devm_kmemdup(&chip->dev, logp, size, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
-- 
2.43.0


