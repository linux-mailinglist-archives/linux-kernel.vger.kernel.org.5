Return-Path: <linux-kernel+bounces-162450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94068B5B72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D748B24B02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782567E0F6;
	Mon, 29 Apr 2024 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kmdvju6N"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF157C09E;
	Mon, 29 Apr 2024 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401296; cv=none; b=KgSKpOaXmBs3CWnKoutFMeNe9gHFVMxAD9/ayYMETyXuzQT8oTfIUGYDyKYfvXhL4yYtIKNJuBQ47TLIMhaRgIjjMwnGIQaLfFdqsBsQ0FyI66RftykS0WUVmTScfNqssZy9KHmIMh3RyBxENsWDrF7+olcVvD2QKe1qE4bHztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401296; c=relaxed/simple;
	bh=zUpyn1o89qFVs68bNIOAc5MbuA2BtS5raoqVCeAk+Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itHcmXSpiRs+OapfPQBVgpbOt6vbNizBj6LTudQOKfJjDh+PNdIErpED2IeohqnM0zW9euG2poi8uVG11TBPQBNieUM3NdjkDXziKNtxrEExdxh2xMqK9juy2sp00lZ6Pqa6grS6VnNEH5ThFUE4BMAXOLls0rUcb/eSYEZJDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kmdvju6N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TEYrH9013595;
	Mon, 29 Apr 2024 14:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zbWERgzpSe4fhT45WlE6zBKjb8DNyAlKjuxmxcI0OVw=;
 b=Kmdvju6N5Bz5mpnu28gtqavPYQiSwgp02cltY/RwousJwPZ7qaC3SI6r9dsetNthXF9W
 FFGY7rC5BGMswRvStGJvu90+qZEqEVQhd+ole8B1NtTZnoZoi0jdmp6tRafzslvtwlZf
 gJMdCbdyPu1Vjjv6ydl7Cbaxf3utTa8PVEjSYvNso7SX28hMWI/j7OL7a07OtV5GJOCd
 zfre50A9Wx3EzRecWHHPxipj6e4Z5yJvP/S/lZHo8k88WlbOZBUuqWCPxEu8ccvmGFpY
 pNor+09VXO4AfZ8V5/3bTx0JSsvoURH7TQkR5VDSKMR7bGPiHy0Cd2dpJwqf34/4v/U+ Tw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtdcfg0jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 14:34:52 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43TE5oP0001440;
	Mon, 29 Apr 2024 14:34:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsbptr0wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 14:34:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43TEY9HG36569440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 14:34:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80AE520049;
	Mon, 29 Apr 2024 14:34:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FAA920040;
	Mon, 29 Apr 2024 14:34:09 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2024 14:34:09 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v4 0/2] s390/pgtable: misc small improvements
Date: Mon, 29 Apr 2024 16:34:07 +0200
Message-ID: <20240429143409.49892-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QM_UG90wo0vEQyuKclGFtMwKYrE34PzH
X-Proofpoint-ORIG-GUID: QM_UG90wo0vEQyuKclGFtMwKYrE34PzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=664 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290092

This series has two small improvements for the s390 page tables. they
fix some small inconsistencies and missing things.

The first aligns the layout of large puds with that of large pmds;
there is no reason for the large pud read and write softbits to be
swapped compared to large pmds.

The second adds a few bits to _SEGMENT_ENTRY_BITS,
_SEGMENT_ENTRY_HARDWARE_BITS and _SEGMENT_ENTRY_HARDWARE_BITS_LARGE;
those bits are supposed to always be zero, the current code was working
correctly since those bits were being ignored and always left set to
zero. The patch also introduces _REGION3_ENTRY_HARDWARE_BITS and
_REGION3_ENTRY_HARDWARE_BITS_LARGE, for completeness, which are the
bitmasks of the hardware bits for normal puds and large puds.

v3->v4
* fix order of _REGION3_ENTRY_HARDWARE_BITS* macros to be the same as
  the _SEGMENT_ENTRY_HARDWARE_BITS* macros
v3->v2
* update patch description for the second patch
v2->v1
* add the missing pmd bits and _REGION3_ENTRY_HARDWARE_BITS

Claudio Imbrenda (2):
  s390/pgtable: switch read and write softbits for puds
  s390/pgtable: add missing hardware bits for puds, pmds

 arch/s390/include/asm/pgtable.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.44.0


