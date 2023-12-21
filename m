Return-Path: <linux-kernel+bounces-8387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CF981B67C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB701C25283
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AB67AE82;
	Thu, 21 Dec 2023 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ipm4M4ZU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9C7995A;
	Thu, 21 Dec 2023 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLCi6uQ007058;
	Thu, 21 Dec 2023 12:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=HvPSu01XvhdYDYSnMEu4+snsYnVxSHyR0wBlHc0igYw=;
 b=ipm4M4ZUajsQPvX2bEayuSnh96CV66MzlD7fL8QHtdRW37yAAAKIsiVqT+BwpQOGEm3a
 r4IrzmHLI6ZruZYzrNOYcId7c4cTQricVKaBlDneuyyHyxjS6v4MoirP9N9iLV/TBk2s
 nb4B52bPOwxs9Phl0V/G2cmJuIhITjakeogSevrrVCdz74rCKBkq6/39nsYYvBlzldhz
 ei7gnHMJ3EzezZe6WxzmlVSitsZShrGSRXsaZlV4aZzNHou6rPUZiMQAc7msbZ7LT6yo
 KO/kiwCX+F7cSkJxF3zDDj+cgZa53NCKdmuMnG2bUYaGpkY0kCS4ZF4E019PGjwZAYEZ XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13gujsuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 12:48:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLC8HpF035489;
	Thu, 21 Dec 2023 12:48:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bb308d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 12:48:32 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BLCmSsS039413;
	Thu, 21 Dec 2023 12:48:32 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-32-150.vpn.oracle.com [10.175.32.150])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12bb304w-2;
	Thu, 21 Dec 2023 12:48:32 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>, Jaroslav Kysela <perex@perex.cz>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] Documentation: move driver-api/isapnp to userspace-api/
Date: Thu, 21 Dec 2023 13:48:15 +0100
Message-Id: <20231221124816.2978000-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221124816.2978000-1-vegard.nossum@oracle.com>
References: <20231221124816.2978000-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_06,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210096
X-Proofpoint-ORIG-GUID: EUPvnK1tAM4yaYa7i36uzvDeAON75DC3
X-Proofpoint-GUID: EUPvnK1tAM4yaYa7i36uzvDeAON75DC3

driver-api/isapnp documents /proc interfaces for interfacing directly
with ISA Plug & Play devices, not any kind of API for kernel developers,
and should thus also live under userspace-api/.

Also fix a few issues while we're at it.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/driver-api/index.rst                     | 1 -
 Documentation/userspace-api/index.rst                  | 1 +
 Documentation/{driver-api => userspace-api}/isapnp.rst | 8 ++++----
 MAINTAINERS                                            | 2 +-
 drivers/pnp/isapnp/Kconfig                             | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename Documentation/{driver-api => userspace-api}/isapnp.rst (51%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 9511db303446..b1b82ac1063b 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -81,7 +81,6 @@ available subsections can be seen below.
    dcdbas
    eisa
    isa
-   isapnp
    io-mapping
    io_ordering
    generic-counter
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 93174ffc7350..277b7a40ca91 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -31,6 +31,7 @@ place where this information is gathered.
    vduse
    futex2
    tee
+   isapnp
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/isapnp.rst b/Documentation/userspace-api/isapnp.rst
similarity index 51%
rename from Documentation/driver-api/isapnp.rst
rename to Documentation/userspace-api/isapnp.rst
index 8d0840ac847b..d6fceb19b8ae 100644
--- a/Documentation/driver-api/isapnp.rst
+++ b/Documentation/userspace-api/isapnp.rst
@@ -1,11 +1,11 @@
-==========================================================
-ISA Plug & Play support by Jaroslav Kysela <perex@suse.cz>
-==========================================================
+=======================
+ISA Plug & Play support
+=======================
 
 Interface /proc/isapnp
 ======================
 
-The interface has been removed. See pnp.txt for more details.
+The interface was removed in kernel 2.5.53. See pnp.rst for more details.
 
 Interface /proc/bus/isapnp
 ==========================
diff --git a/MAINTAINERS b/MAINTAINERS
index 0506d14340f7..7b6d2dbe4f1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11252,7 +11252,7 @@ F:	drivers/media/radio/radio-isa*
 ISAPNP
 M:	Jaroslav Kysela <perex@perex.cz>
 S:	Maintained
-F:	Documentation/driver-api/isapnp.rst
+F:	Documentation/userspace-api/isapnp.rst
 F:	drivers/pnp/isapnp/
 F:	include/linux/isapnp.h
 
diff --git a/drivers/pnp/isapnp/Kconfig b/drivers/pnp/isapnp/Kconfig
index d0479a563123..8b5f2e461a80 100644
--- a/drivers/pnp/isapnp/Kconfig
+++ b/drivers/pnp/isapnp/Kconfig
@@ -7,6 +7,6 @@ config ISAPNP
 	depends on ISA || COMPILE_TEST
 	help
 	  Say Y here if you would like support for ISA Plug and Play devices.
-	  Some information is in <file:Documentation/driver-api/isapnp.rst>.
+	  Some information is in <file:Documentation/userspace-api/isapnp.rst>.
 
 	  If unsure, say Y.
-- 
2.34.1


