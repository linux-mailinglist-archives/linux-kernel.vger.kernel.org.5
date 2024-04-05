Return-Path: <linux-kernel+bounces-133148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F61899F87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC4F2840B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D4816EBFA;
	Fri,  5 Apr 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d5YN2Qr4"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD156CDB7;
	Fri,  5 Apr 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327203; cv=none; b=auLvxKabwoayVjcLoZkAgfa/3qBt6UGYP4w5/fMlK7G0bKUZ6uwQY4lWKoC2Uzba2wxVncK+4GsU49N+v5XL75j3mxWyLwSgQsIoyzEVDI8F5s5NcSVgPrmI2UwIO3fIWnoe83GjKIbs+F3ThNOxIkZl2SKxFc3DiTdaDXXWsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327203; c=relaxed/simple;
	bh=UhRnsU78ZDrRf3B0lZc2belagC3V0J+pq4SCdT+OcZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tR9q9DU/o5mFdkiZIHJQLHX8BT2scvUme2yNU36+pPAHOFQXnYyXNAminUkBUe93R30lS+Y6Jdd/FlROfBCxGdxWR3r9T90FdUEIT5jottZFqIT9oZZq4GHD0ARBw66syLMMIUyFSWeZlbwgeuaFAFZx0xkglQ5CcAK7+CltBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d5YN2Qr4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435CvN8T010444;
	Fri, 5 Apr 2024 14:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=HrrIFi5xYR4eKRJXOyyWxavd4B03u9QlRyXjpM6kF/4=;
 b=d5YN2Qr4Z6yAZSSNEKN/dvA86cqeUeHmrZUJ93NnkH4MO/dD5hucXS2Iz+B1gTJdOARd
 MX9yYXjAQ3IM0TSvRSRNoldeOV4xE03s66zmSNgxXperFiD6eTB5GpSw8FsvXfWL4Qm+
 ZUqz6xQ1cmqlIY4R7a1VUPiluW6A0SqkyQ+n+LSFSHlRfdDrIEuoMGb76ON7o1nIkEOS
 zF8yx1gYyZjpt7YP/+aD4YmSwJBIRLg8k5MmtPYgxW3CX8wmgwxy3bSwwHehe3dOaa3k
 cj7fzG3WjGd5G6+kT96I4cGFygDXHnWiupaQ1zcol5M/9TiLhSUS+jNx8/YORZWvR7Yx Yw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xahrur7gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 14:26:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 435DE85H009100;
	Fri, 5 Apr 2024 14:22:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epy2v2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 14:22:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435EMR7Q49086950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 14:22:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 326C720040;
	Fri,  5 Apr 2024 14:22:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 042262004D;
	Fri,  5 Apr 2024 14:22:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2024 14:22:26 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] pnp: add HAS_IOPORT dependencies
Date: Fri,  5 Apr 2024 16:22:26 +0200
Message-Id: <20240405142226.144216-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240405142226.144216-1-schnelle@linux.ibm.com>
References: <20240405142226.144216-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z3qwB7mRlZYk1VBcsgnUx9rM-9hj76fm
X-Proofpoint-ORIG-GUID: z3qwB7mRlZYk1VBcsgnUx9rM-9hj76fm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_14,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050103

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. We thus need to depend on HAS_IOPORT even when compile
testing only.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
and may be merged via subsystem specific trees at your earliest
convenience.

 drivers/pnp/isapnp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pnp/isapnp/Kconfig b/drivers/pnp/isapnp/Kconfig
index 8b5f2e461a80..8e5dec59e342 100644
--- a/drivers/pnp/isapnp/Kconfig
+++ b/drivers/pnp/isapnp/Kconfig
@@ -4,7 +4,7 @@
 #
 config ISAPNP
 	bool "ISA Plug and Play support"
-	depends on ISA || COMPILE_TEST
+	depends on ISA || (HAS_IOPORT && COMPILE_TEST)
 	help
 	  Say Y here if you would like support for ISA Plug and Play devices.
 	  Some information is in <file:Documentation/userspace-api/isapnp.rst>.
-- 
2.40.1


