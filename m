Return-Path: <linux-kernel+bounces-3121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2C18167A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5DB1C2242B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4799FBF4;
	Mon, 18 Dec 2023 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qnbU9We8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE1E55E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI7MqMJ003639;
	Mon, 18 Dec 2023 07:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=g8jCvGvl4swyr2RjaobjzQiBxqTOe7z3ifMluGI4T24=;
 b=qnbU9We8Tn9xyh/1HpEQofhyzEJAoCcl9R+BqChPLz7xSAibnzDRshgjGqHNl1Sj1Cx1
 i3M1JEcbpFp8wXWJednDy4B9Xw6uE1dAuEf4Z4sX+tndk/DJANagDhnBqm4DSO4D54b0
 PISepuTc0/Fl3/NOKvd486bokOvGyd2nWBHsvx9jqDKQ5ChiSLX/TZrxr+E70LB285PB
 YbIC95baNhrGPM1EmZ/P8LgcdQlv4ajiYVnl2dhBBZImup+fVWmdMZPBxdAkEDl8oz9v
 EPdznzxukk5ysgx2o1zlQPq5vdyyxPiTFzFYY6VXC8m2p3Qwn1ypVb/jg8/Oj62HOtKS gQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2grf9xrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:45:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI7Bi3s027074;
	Mon, 18 Dec 2023 07:45:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rejq3ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:45:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BI7jORn18416314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 07:45:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 513D720043;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4135620040;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 0FC38E03E5; Mon, 18 Dec 2023 08:45:24 +0100 (CET)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v2 0/3] entry: inline syscall enter/exit functions
Date: Mon, 18 Dec 2023 08:45:17 +0100
Message-Id: <20231218074520.1998026-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a3nYW5KOmwB-hoR-5UizNSzH3mnAnght
X-Proofpoint-ORIG-GUID: a3nYW5KOmwB-hoR-5UizNSzH3mnAnght
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_04,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxlogscore=498 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312180054

Hi List,

looking into the performance of syscall entry/exit after s390 switched
to generic entry showed that there's quite some overhead calling some
of the entry/exit work functions even when there's nothing to do.
This patchset moves the entry and exit function to entry-common.h, so
non inlined code gets only called when there is some work pending.

I wrote a small program that just issues invalid syscalls in a loop.
On an s390 machine, this results in the following numbers:

without this series:

$ ./syscall 1000000000
runtime: 94.886581s / per-syscall 9.488658e-08s

with this series:

$ ./syscall 1000000000
runtime: 84.732391s / per-syscall 8.473239e-08s

so the time required for one syscall dropped from 94.8ns to
84.7ns, which is a drop of about 11%.

Sven Schnelle (3):
  entry: move exit to usermode functions to header file
  entry: move enter_from_user_mode() to header file
  entry: move syscall_enter_from_user_mode() to header file

 include/linux/entry-common.h |  94 +++++++++++++++++++++++++++++--
 kernel/entry/common.c        | 106 ++++-------------------------------
 2 files changed, 100 insertions(+), 100 deletions(-)

Changes in v2:
- don't move of exit_to_user_mode_loop() to header file
-- 
2.40.1


