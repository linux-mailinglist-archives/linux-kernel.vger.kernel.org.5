Return-Path: <linux-kernel+bounces-146720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B24EE8A69D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3EC28314A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD8B129E8E;
	Tue, 16 Apr 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OLJ7zm+n"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E395E1292FF;
	Tue, 16 Apr 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267752; cv=none; b=gSDoL9ivzy6sV6E4CXoSWBSkVQIyn2l78TIF7bo7ROm91lljqr/7GIUOtPO/HlItvzT8vrCYWF5UJmCwuPzOyNxa0eQtpVBeYaSLN8s0a8a6tdtoeWchRGz7kH7pY6CLsXcYvA1PhXF/thINzr6k6rFPrIu7w3eTMRwnLYYsd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267752; c=relaxed/simple;
	bh=q3lBDce4HNEiVrdQdtt3WuGh2tYMUeZ5GnShOn2kylE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQ4zqnspNU3r7354QUB8XQxlwPY/zkQx2sPWxljlt27WOgunR39ciC4wo9PoQMK6388+2H0O3KxeRpGaYZlsbcMgUI9IwIhroiJdUV4Aopw7xoupd1t53Ye1vmKizmrzaMubjZbHdeav0bJTHoM6XOTJP+i0nHirZEEApXo6IE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OLJ7zm+n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GAwBD5031627;
	Tue, 16 Apr 2024 11:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hKbWqZiR5So+vb841wV12n/dE9jFQYX/o5+nphH3lqo=;
 b=OLJ7zm+nwKOZLAYYq/jdxi6JiK5GxMZVOekDu8cWu0J6oabHHObU5OxNZ/qk5z0B2kvz
 PC7aqWfE7+M88OWAfH2QQQhrzpmwLOc0kUGL7iWu+FLm8kHyeIYBt2cKgDwj36k7RWTx
 Uiio4eO4RR3tie9k1O8Oz9eZ8mJMC21tAw/A0qyVLf9Q2sURHTwMu6xpLyHeDC4LtwRo
 8T0UVu0dLD93OJ6dZ39gCWSl2yfQWo5SPvrxQSuvehZ9PNLGli1z/oF7LGutZFDHtVUI
 Ee6uCPwwziyJMv1K8lGz4oorIx+xwDWA930T4uGQ3sX3OmfT3P5t82h+HPvYnFdLoQDN Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhr1fg2h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 11:42:27 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GBgRtV004291;
	Tue, 16 Apr 2024 11:42:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhr1fg2gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 11:42:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43G8k53e023576;
	Tue, 16 Apr 2024 11:42:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnwtbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 11:42:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43GBgKeL53739838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 11:42:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 538FF20043;
	Tue, 16 Apr 2024 11:42:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25BE820040;
	Tue, 16 Apr 2024 11:42:20 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Apr 2024 11:42:20 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, frankja@linux.ibm.com, nrb@linux.ibm.com,
        nsg@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, david@redhat.com
Subject: [PATCH v1 0/2] s390/mm: fix improper use of __storage_key_init_range
Date: Tue, 16 Apr 2024 13:42:18 +0200
Message-ID: <20240416114220.28489-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fCnGpB0yf90yxINshwSZgIHV9VblGN2I
X-Proofpoint-GUID: BjZCMELtseTwRyJlXnaWfp15y66KVAJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=873 adultscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160072

The function __storage_key_init_range() expects the end address to be
the first byte outside the range to be initialized. I.e. end - start
should be the size of the area to be initialized.

This small series fixes two cases in which the last address in the
range was passed as end address. This was still functionally correct,
since __storage_key_init_range() will still loop over single pages and
correctly clear the given range, but it will be slower than clearing
the storage keys for the whole 1M block with a single instruction.

Claudio Imbrenda (2):
  s390/mm: fix storage key clearing for guest huge pages
  s390/mm: fix clearing storage keys for huge pages

 arch/s390/mm/gmap.c        | 2 +-
 arch/s390/mm/hugetlbpage.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.44.0


