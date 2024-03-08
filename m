Return-Path: <linux-kernel+bounces-96526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5B875D88
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740291C21DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B897C32C89;
	Fri,  8 Mar 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RxQUMAHk"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468F2C1A0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709875427; cv=none; b=OdWfuXi5rJOJpWjA9lA4kYx0TWf+r7DDZmJjgkUel03i0X8xtUdQysEQJFK4Pjqnr6NVvfMeaH8vE3x3mTNyexznT/2Ob7gRZPupVDpG+pVx5zQsgDGjA+7FS4yuxnMwEgSft4rPiSx5zzViN5WRThOg6g36Vz7MD9bXMFhW99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709875427; c=relaxed/simple;
	bh=djHj5MuHX9sgC2IaLOejhm19WGD8rtUIU28yQh0vsm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arx1qJeWuiUEFQqlvUgi5KLMMZVi6LO/GubggjRa1ZfymiRbZJxbl8RRpwCJe+uO+de8473OwhlQsf1sMkJPeOxRYKG/o15Fvi20JmpqI+cQ6Q01BoPCKI9iv/u99OKG461stkBKNirxwVAPLZcDQ7Zg3G4YmXgJU7B8bw+oc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RxQUMAHk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4285COpD011054;
	Fri, 8 Mar 2024 05:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=QhZTVxQHfq/Qhnb3kmam4ih33lBzHOPvgosRKVAinEY=;
 b=RxQUMAHkUfahDGadXPjozF6ujEEDHxMgoZj3k+VNFPDbbCsy7PrSasgZP0B+M4pl55mW
 k9VfUUWnwlQIg4vUNSEbokNy5ZdR7fqllVJ7SWvXYRIU6vroMmEVMXG6kwqqHUsssPbi
 uME+AyxypO3p0Crq/o5/9/dxWUAJLFQGFcMKpXyaFNXduPGmiFRvJ2HYVgH6Cg8Wvwng
 r4CQCP3VZqBLHHTYvpbD02WGIEj6RsKTz4MtEmuSjzpa4qk9FGcc0LMgpBEs0CSEsWcc
 7R6x1m3aGmOETqM84Z9OLuPG6yS8GnsU7Pjsj9tLSPXim9OrWYf5ItL5LqwtgxgoyXYJ 1w== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqvarg4yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 05:23:34 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4283IQOp006045;
	Fri, 8 Mar 2024 05:23:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeetjpn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 05:23:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4285NS1E38338816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 05:23:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3295D2004D;
	Fri,  8 Mar 2024 05:23:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C82120040;
	Fri,  8 Mar 2024 05:23:27 +0000 (GMT)
Received: from li-5024144c-279b-11b2-a85c-93837c9a6aab.in.ibm.com (unknown [9.204.201.194])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 05:23:26 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org, linux-kernel@vger.kernel.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [RFC 0/1] sched: Deprecate DOUBLE_TICK feature
Date: Fri,  8 Mar 2024 10:53:03 +0530
Message-ID: <20240308052304.1835792-1-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m0jjc0U45t03EhqeeBSCcmBUr-NEC51j
X-Proofpoint-GUID: m0jjc0U45t03EhqeeBSCcmBUr-NEC51j
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
 definitions=2024-03-08_03,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=790 impostorscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080040

Upon examining commit 5e963f2bd465, titled "sched/fair: Commit to EEVDF,"
it was noted that the method check_preempt_tick was removed. This change
has rendered the DOUBLE_TICK feature, which previously played a role within
the entity_tick function, inconsequential in the scheduling decisions.
Historically, DOUBLE_TICK enabled periodic ticks to proceed even when a
high-resolution timer (hrtick) was active, with the potential to cancel
the hrtick timer in __schedule if it was active.

With the removal of decision point where DOUBLE_TICK played a role by
commit 5e963f2bd465, questions arise regarding its current utility.

The discussion centers on whether there is a continued need for the hrtick
timer as the system transitions towards EEVDF for calculating preemption
points, based on entity lag, and as the scheduler manages resource allocation
in quanta. Particularly, in scenarios involving multiple processes with
different nice values, where EEVDF governs their preemption according to
their lag, however the behavior depends on the specific values of base_slice_ns 
and config_hz.

Link: https://lore.kernel.org/lkml/0818a331-cea3-4962-88ad-09bccbd3659d@linux.ibm.com/

Vishal Chourasia (1):
  sched: Deprecate DOUBLE_TICK feature

 kernel/sched/fair.c     | 6 ------
 kernel/sched/features.h | 1 -
 2 files changed, 7 deletions(-)

-- 
2.43.0


