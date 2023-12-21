Return-Path: <linux-kernel+bounces-8381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1801381B66C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15AF1F25BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFD578E74;
	Thu, 21 Dec 2023 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iDiR1UQC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC173179;
	Thu, 21 Dec 2023 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLCi3iA025857;
	Thu, 21 Dec 2023 12:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=DlnPkRUIIC85SgqzTPQ8nEZWUI5vi+Pe+7zbBO34tD0=;
 b=iDiR1UQCY0tpVlN97Rlh77VDvvnTXvbQKU8gxotxzi+tP/yS8Z/8y2OadYtad9KHcVsH
 LDtPPuTkllj+lUP1fjwVXKnIZTLZ2IFXvSadQbh8o5qNIWeuoGkh4zazeqf3oIKRMk7e
 xpMmrHuUw97yUP6sPDrkSW75AJyT7IwRujxOZCIR5VEd4QlpcsP7ZGTruoHRrjfOgs8a
 VwnrSnD9HjuXExIR86Xh/mmPstZ7okkzsWbYFZhxOb/kQDTRXoFroBtbfofmsCj5GdmP
 6O8ml5yRHm7X+HxrzlienadHirJH8AfjqxmFOQdEoQ/F0okCU4P9IO9hHLOcJ3zKbhxM 1A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v4b4891bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 12:48:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLBUJOH035519;
	Thu, 21 Dec 2023 12:48:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bb306t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 12:48:29 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BLCmSsQ039413;
	Thu, 21 Dec 2023 12:48:28 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-32-150.vpn.oracle.com [10.175.32.150])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12bb304w-1;
	Thu, 21 Dec 2023 12:48:28 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>, Jaroslav Kysela <perex@perex.cz>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 0/2] Move driver-api/{dcdbas,isapnp} to userspace-api/
Date: Thu, 21 Dec 2023 13:48:14 +0100
Message-Id: <20231221124816.2978000-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
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
 mlxlogscore=824 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210096
X-Proofpoint-GUID: MQROLr94N0JP5FhWCbTDUQ5tKKCiw2Jo
X-Proofpoint-ORIG-GUID: MQROLr94N0JP5FhWCbTDUQ5tKKCiw2Jo

Hi,

Neither isapnp.rst nor dcdbas.rst document driver APIs; rather, they
document /proc and /sys interfaces, respectively, which are userspace
APIs.

I'm submitting this to the documentation tree -- Jaroslav and Stuart,
is that OK with you? I suggest doing it that way since there is a tiny
dependency between the patches (for the driver-api/index.rst and
userspace-api/index.rst changes).

Testing: ran htmldocs, didn't see any warnings related to these.

Thanks,


Vegard

--

Vegard Nossum (2):
  Documentation: move driver-api/isapnp to userspace-api/
  Documentation: move driver-api/dcdbas to userspace-api/

 Documentation/driver-api/index.rst                     | 2 --
 Documentation/{driver-api => userspace-api}/dcdbas.rst | 0
 Documentation/userspace-api/index.rst                  | 2 ++
 Documentation/{driver-api => userspace-api}/isapnp.rst | 8 ++++----
 MAINTAINERS                                            | 4 ++--
 drivers/platform/x86/dell/Kconfig                      | 2 +-
 drivers/platform/x86/dell/dcdbas.c                     | 2 +-
 drivers/pnp/isapnp/Kconfig                             | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)
 rename Documentation/{driver-api => userspace-api}/dcdbas.rst (100%)
 rename Documentation/{driver-api => userspace-api}/isapnp.rst (51%)

-- 
2.34.1


