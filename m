Return-Path: <linux-kernel+bounces-98861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BD3878068
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7119EB2107C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0A43EA64;
	Mon, 11 Mar 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hVMoOPd+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8098E22064;
	Mon, 11 Mar 2024 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163259; cv=none; b=L+qgNpUsdnqKo3QfzFCh+Fv/m4ltvv9jFoB9nONLnmMB9Z+4Nj7gbCuPqMb8ch898APkdVEbGO3C6aBQ6XB8D8hqX4rFRIwUXJtbI5zrn34F03k24Zqsz2lnzZNE72nkhq2eZU1lR89GvEdCyWWX/E2TcMbI7+xz8aBCLWwnYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163259; c=relaxed/simple;
	bh=WzLuQ44dxHHThOYvx0wNWyL9Gwww+wh867usE5iK92o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJJjBDG8v3XXhlao0y5TVjlo4N6oYqxx9wb0o0QbQsuJRWnUgWs3wkAC/f3obBK1gd6HYPBta15OrE0jf2cr2k5Sia7P3VqYSX+Y685eQSLpB6KX970OFwR4N9NII9KuZdqMee5jVq4Q7un/YROVFtpINuHlnOBsNqWzgLI1xOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hVMoOPd+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BCViTB013442;
	Mon, 11 Mar 2024 13:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=D+ymWYhcKlVtuY88TLHRXmdCukNBtEwkGmsa5Q+jAKA=;
 b=hVMoOPd+dM1mfWm6CJbLYudAsIUaZQ6/odCjCWGJm31SGej7E7YbpeGoheyDjlyQwezQ
 rX7tmTxwnZegA2n7Jy3A8JHG16S28K9kzQi71N/Gxx8L77dDHma6nqT0sxVfSSLZpJ1o
 V41mE+CIbOX2ygv/Oe22GxiA3rSw7G506BJNq+w/SpJujivKgqc8qCMfjakZrqxeM+8d
 XhEHTZz+FITnV1ErO/MHXluGdbZKCbUfFipjlyhShYD95X4sy5mG++XTHgfTdWaVQUIY
 7U1HFZXpW+X+sxGRLOmR8gtW/zwk99qaDfu5ooNDtuTPiCo1vMD9CjeA1ql/T/taSDzq zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt1ub18sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 13:20:47 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BCn1LX030314;
	Mon, 11 Mar 2024 13:20:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt1ub18sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 13:20:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42BC3c2e018543;
	Mon, 11 Mar 2024 13:20:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t1r7d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 13:20:46 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BDKgWY32244076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 13:20:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D7A958069;
	Mon, 11 Mar 2024 13:20:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE44758056;
	Mon, 11 Mar 2024 13:20:41 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 13:20:41 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, rnsastry@linux.ibm.com,
        peterhuewe@gmx.de, viparash@in.ibm.com, devicetree@vger.kernel.org,
        jsnitsel@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH v2 1/3] powerpc/prom_init: Replace linux,sml-base/sml-size with linux,sml-log
Date: Mon, 11 Mar 2024 09:20:28 -0400
Message-ID: <20240311132030.1103122-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311132030.1103122-1-stefanb@linux.ibm.com>
References: <20240311132030.1103122-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jZMDAgE8buyi2GjnRjHPY5Rmz2M0p_tg
X-Proofpoint-ORIG-GUID: 7avnkx9d6VRIUGZeJiIcR0uqKwj0IQKZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110100

linux,sml-base holds the address of a buffer with the TPM log. This
buffer may become invalid after a kexec. To avoid accessing an invalid
address or corrupted buffer, embed the whole TPM log in the device tree
property linux,sml-log. This helps to protect the log since it is
properly carried across a kexec soft reboot with both of the kexec
syscalls.

Avoid having the firmware ingest the whole TPM log when calling
prom_setprop but only create the linux,sml-log property as a place holder.
Insert the actual TPM log during the tree flattening phase.

Fixes: 4a727429abec ("PPC64: Add support for instantiating SML from Open Firmware")
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 arch/powerpc/kernel/prom_init.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index e67effdba85c..6f7ca72013c2 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -211,6 +211,8 @@ static cell_t __prombss regbuf[1024];
 
 static bool  __prombss rtas_has_query_cpu_stopped;
 
+static u64 __prombss sml_base;
+static u32 __prombss sml_size;
 
 /*
  * Error results ... some OF calls will return "-1" on error, some
@@ -1954,17 +1956,15 @@ static void __init prom_instantiate_sml(void)
 	}
 	prom_printf(" done\n");
 
-	reserve_mem(base, size);
-
-	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-base",
-		     &base, sizeof(base));
-	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-size",
-		     &size, sizeof(size));
-
-	prom_debug("sml base     = 0x%llx\n", base);
+	/* Add property now, defer adding log to tree flattening phase */
+	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-log",
+		     NULL, 0);
 	prom_debug("sml size     = 0x%x\n", size);
 
 	prom_debug("prom_instantiate_sml: end...\n");
+
+	sml_base = base;
+	sml_size = size;
 }
 
 /*
@@ -2645,6 +2645,17 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 		}
 		prev_name = sstart + soff;
 
+		if (!prom_strcmp("linux,sml-log", pname)) {
+			/* push property head */
+			dt_push_token(OF_DT_PROP, mem_start, mem_end);
+			dt_push_token(sml_size, mem_start, mem_end);
+			dt_push_token(soff, mem_start, mem_end);
+			/* push property content */
+			valp = make_room(mem_start, mem_end, sml_size, 1);
+			memcpy(valp, (void *)sml_base, sml_size);
+			*mem_start = ALIGN(*mem_start, 4);
+			continue;
+		}
 		/* get length */
 		l = call_prom("getproplen", 2, 1, node, pname);
 
-- 
2.43.0


