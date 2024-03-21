Return-Path: <linux-kernel+bounces-109722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C1881CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4501D1F22055
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4516F51C44;
	Thu, 21 Mar 2024 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dz0X1PAk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8C3A1DE;
	Thu, 21 Mar 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005334; cv=none; b=GijuOg6KmQdULkIdTgKzI6cWh0hTUczCjHXNaXDJfqAOwW6uOocrexPhOGC0XAH9HrLNmAHsQmdvGcF3Hy4Q1zh5wZiZxLMBgDhVBuQrMXN6MNhQqIeyKVS18zpkn/X/+9Q8r0UDgSQRytYXPjjHCfOV1ZHaDbmf3mgDKgsXyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005334; c=relaxed/simple;
	bh=0spjMsQPlJTDmjGtorWPzWT87tD+gg4/0qmis1bJQ3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MtOSLPf5oaP+ycBg3pP/uKnnrIvJqpKvj9Wz4qcjjX+gOfH6eZkJYF8xBfpAcieWVJurkb/aSy0uwBfN4VwWLkJNeWuxn9Pwan5fGq0JbFL/9M/zTWOFd1LmXRMZO416Ev1EU/4MX3xe+oW/g3GcCSnP/hDfJJg6JUAhb/nZJrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dz0X1PAk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L5UEQa026735;
	Thu, 21 Mar 2024 07:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kfFT1P/IgpeSJp39XAmKjKLqlIuz1wFwnZS2Gt96AvU=;
 b=dz0X1PAkp1/378CIf/EpE+QKopG4ccnN/nAO5jOSCrJ2fC/QYtzy8JNFVBq2uQZVovju
 Oqor8nUDy4W82U7ZPJI5Rjb7URH7XJWP/qgwj5Cy4+e7YJPXV6OyflZvF93ZNAlN07/V
 yzDwFK5mKaQrv4dnY+TQ0xkWCGyaLtURW09tmRvo9rQiupD5KYIW6kIx5qZw/HeX4Taf
 cN53v52SYs7V3dxBxA2YqrWWcr4zdYt854FMTNVHAxEJx1EkWFsK76Z3CVSqfowxuXov
 MqnjQGUwc1TekW7Ny0fY2ciq2DLTJxTF3os22aZ6K1Bq57T1Gl6qHw9AtPiidWndMPqJ Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0e5ug8n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 07:15:29 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42L7FSta025377;
	Thu, 21 Mar 2024 07:15:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0e5ug8n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 07:15:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42L4GrBo019898;
	Thu, 21 Mar 2024 07:15:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqyku6rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 07:15:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42L7FMCW47120734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 07:15:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D9FC2005A;
	Thu, 21 Mar 2024 07:15:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD26B20049;
	Thu, 21 Mar 2024 07:15:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 07:15:21 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/2 v2] perf report: Fix PAI counter names for s390 virtual machines
Date: Thu, 21 Mar 2024 08:15:11 +0100
Message-Id: <20240321071512.2916952-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RsZ2xrJwmwhQ1aSqIR3hHqJ3PykXC9NO
X-Proofpoint-GUID: aSmhyR8FiF_PDp2lVxYikV1irO6ZRUtp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210047

s390 introduced Processor Activity Instrumentation (PAI) counter
facility on LPAR and virtual machines z/VM for models 3931 and 3932.
These counters are stored as raw data in the perf.data file and are
displayed with command

 # ./perf report -i /tmp//perfout-635468 -D | grep Counter
	Counter:007 <unknown> Value:0x00000000000186a0
	Counter:032 <unknown> Value:0x0000000000000001
	Counter:032 <unknown> Value:0x0000000000000001
	Counter:032 <unknown> Value:0x0000000000000001
 #

However on z/VM virtual machines, the counter names are not retrieved
from the PMU and are shown as '<unknown>'.
This is caused by the CPU string saved in the mapfile.csv for this
machine:

   ^IBM.393[12].*3\.7.[[:xdigit:]]+$,3,cf_z16,core

This string contains the CPU Measurement facility first and second
version number and authorization level (3\.7.[[:xdigit:]]+).
These numbers do not apply to the PAI counter facility.
In fact they can be omitted.
Shorten the CPU identification string for this machine to manufacturer
and model. This is sufficient for all PMU devices.

Output after:
 # ./perf report -i /tmp//perfout-635468 -D | grep Counter
	Counter:007 km_aes_128 Value:0x00000000000186a0
	Counter:032 kma_gcm_aes_256 Value:0x0000000000000001
	Counter:032 kma_gcm_aes_256 Value:0x0000000000000001
	Counter:032 kma_gcm_aes_256 Value:0x0000000000000001
 #

Fixes: b539deafbadb ("perf report: Add s390 raw data interpretation for PAI counters")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/pmu-events/arch/s390/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index a918e1af77a5..b22648d12751 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -5,4 +5,4 @@ Family-model,Version,Filename,EventType
 ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
 ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
 ^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15,core
-^IBM.393[12].*3\.7.[[:xdigit:]]+$,3,cf_z16,core
+^IBM.393[12].*$,3,cf_z16,core
-- 
2.44.0


