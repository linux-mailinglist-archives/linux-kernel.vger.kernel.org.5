Return-Path: <linux-kernel+bounces-130989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B89B89819F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CAC28A856
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B394548FA;
	Thu,  4 Apr 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TEEMyRfM"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052756471;
	Thu,  4 Apr 2024 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213311; cv=none; b=c10CJH9JeuYN1llBuJIaTHf66GZaoCjMsFeMLtWuP+cX7Bt31UFiZ61m+brxk7IesrvnVDWiop5l1e/n15dnWhElslNEtogWvI0fYX2ofO2LtKGvqs9DkUqyxY8bj2peBMpV+sCff6i1kf2Qdl9bw0pXXkSwd78iByWmqrhj3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213311; c=relaxed/simple;
	bh=0BHKcHIZtORzL2QSY9kHdJR44umnViVVEXDbS+LBEoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ewK3yz2L8nY7rG370O/Gb0P0hxZE8Er2snGuRnCS9y4Txebu5LYfvHxdHA2GwSXZhCvTKs/UTwP8BCNSGeVf3Uf+Br4WJbMTrkAFq4smc+6ytzW3JgkxmCJDhOag69TN+vmHV8XfFnB54vZqV4z0mWSkKjXKBgccxbWXQCz15IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TEEMyRfM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4346dS9n025311;
	Thu, 4 Apr 2024 06:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=V7evhjpTFK9lm74+v57J7Xg0uT3wJ4ThHPEeFTWCAko=;
 b=TEEMyRfMulrC+cP/oyQRzmKMny70gyFYWpPGaPhmAbMhNVb+orpUJogx1JsoFW0UjVxK
 6cMNbCg2kNcUvTC8GZunwJ0bS7lgS2M/IPlj3W5ZGasbAEeFJI5jd+E+rV2UOHO3aQMI
 SZfL/44LRIFdurze/wAfJGtPIOTw8MkQb0ztEI1cE1mywj5jEP2wQJP7sK3RPnscCPQQ
 JShcUSdsqzTItIx22DwyzA190o2K5kUSbHzAHV78bi27IMc3MHK9C1aRElR+qfmNoXsV
 x4qVMmbJ8py4WakB3tY4oVIaJoDAbBbYckSvNr5jW9tzEfQCThrZUroNPKPtTHMCT4fs 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9pj4r2wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 06:48:24 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4346mO2S008206;
	Thu, 4 Apr 2024 06:48:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9pj4r2wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 06:48:24 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43442PpJ031079;
	Thu, 4 Apr 2024 06:48:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epxjj1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 06:48:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4346mHtq44368380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 06:48:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7BCB20043;
	Thu,  4 Apr 2024 06:48:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EAFF20040;
	Thu,  4 Apr 2024 06:48:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 06:48:17 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [Ping PATCH 1/2 v2] perf report: Fix PAI counter names for s390 virtual machines
Date: Thu,  4 Apr 2024 08:48:05 +0200
Message-Id: <20240404064806.1362876-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wMPdyqtEhokfUQu_u3fm-w5kXlzap0wM
X-Proofpoint-GUID: RaCYlNc5oY8ikhRFXIrfForHg67OUq82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_02,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040042

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
Reviewed-by: Ian Rogers <irogers@google.com>
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


