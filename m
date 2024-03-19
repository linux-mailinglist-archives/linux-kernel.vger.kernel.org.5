Return-Path: <linux-kernel+bounces-107326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7887FB19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9D81C21BED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1467D41D;
	Tue, 19 Mar 2024 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QmBDf7cd"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077E7D098;
	Tue, 19 Mar 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841869; cv=none; b=lsdrqsHcnW6faZeWpdQIjy9bjd97ksC53WX6kJ5wBRyD1652WveF4+eHG2yP05LEEReK/f7dNTgZ+K3R6a01FJIBFT08YXqbFUuZsM6KIRLKZcXwLcaRmnk8ZoXbNf0R3zF4ElR3XjW5XeDFF5r1Dzd57JwyXQGZAAGAKZ+jX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841869; c=relaxed/simple;
	bh=0spjMsQPlJTDmjGtorWPzWT87tD+gg4/0qmis1bJQ3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+SJ4wcehIu/+DPoqA3EU/xapFOMadXlhnYGyfT6gZDuFL1WOeG/5rK9WcyCFl5CCt66BxBJNdmDMcFqrfXOz15YP0aZnLhXQKbCK/8oOvqK2JH3iBNYqBqJpaFdf7mxxr9ow/j/SikWJzZBkqTM1jNs5iFdOfijhIi4rAdQUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QmBDf7cd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42J9B0G6003146;
	Tue, 19 Mar 2024 09:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kfFT1P/IgpeSJp39XAmKjKLqlIuz1wFwnZS2Gt96AvU=;
 b=QmBDf7cdoRrNMAKh67Jqt6V2KPs8+RXh2dJGBZKMJJ401R58aj10Di44yX8/0FGcqkfd
 WUoAglFmUV+mM1RkSPS6mwajLkMDC8KsaVcLYqvwzVe8O3+YrtGkSd937GXu83vqTsa/
 SjHVokQfXHGy8a8wZVQ1S+vFp/URc8L4wW1PCHkFShDwCFjVZedKVmCRDHz0Kr/XK+Qj
 ObYCkPVroS4sFDszPLZM2UbEGeaBMgDZLrPDjZqQ/3WphQ/Jrn4MvHZxgywtTPKWj/zy
 uXSk7dJt5gqzD/zqZnJEHdDUvgQjjDF0hHBKZG29VA1N+JVnS/QNkwE6rHQXrkvsCY7i eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy74u8jtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:51:02 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42J9p15R024490;
	Tue, 19 Mar 2024 09:51:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy74u8jtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:51:01 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42J73Fcg017190;
	Tue, 19 Mar 2024 09:51:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrt6u1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:51:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42J9otlJ48955860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 09:50:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A4BC20040;
	Tue, 19 Mar 2024 09:50:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 523F620043;
	Tue, 19 Mar 2024 09:50:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 09:50:55 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/2] perf report: Fix PAI counter names for s390 virtual machines
Date: Tue, 19 Mar 2024 10:50:42 +0100
Message-Id: <20240319095043.857594-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WGk10ZOD1v8jBIM4hO6cgv0zJwkMzaUB
X-Proofpoint-GUID: YhFx5wsQgtIVvoJ6XEY-ZCitFLebkiVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190075

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


