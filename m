Return-Path: <linux-kernel+bounces-159962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66FE8B36D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C23D284202
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF72145B0D;
	Fri, 26 Apr 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tbp17R2G"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F78145349;
	Fri, 26 Apr 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133097; cv=none; b=fW7GJ/W126SP7fM0v7fb++JAcdpk4PXH32WJhey2upSMcH6WMq4XDeRRa0czKVkC5yJkFoFFaGW7kCMQT7ihcV2GJKoFkYPcdbfplBGTlFsHx1pKNLl5FwZlo5oXpaZohJFwjOBLJ4otW4h05lCklrDpT4oOIasMSQHTMyThnME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133097; c=relaxed/simple;
	bh=71B9hvR0TAidNKjRr/Yas85knyIIwykweYM+UROeySk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKzMiM5q+PJdEqwNcM18ryHMmYraO8rWX6LYZY3GjnB8Khcv5JfW1TykmlG4cuNOEwbs6N5lDysktE0xCXZgsRPYKAT1E3YZkNNIXmlAFAlPQsBtpcZQpxp7tM0bPNhuUxCEy2l1KWtvyflhxNJTek8nfkNGNsc020dVSYAUovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tbp17R2G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QBwZ4X031410;
	Fri, 26 Apr 2024 12:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=r2lm4RYky6s5HJ/OLtCbC1IWchuqoburllwXBAy+vSs=;
 b=tbp17R2G2UXgRf34ITrfeRaOpRIHol2KIdjyuCPsAwvElbeesofu87+nkQbZdaaw7W76
 +QQ9BNBB3OdtQUSKJiNFjOkZCcW/y7zBK6Ry4hnoFrF+d4RLf8bdcN9XxM57nQOsyQUm
 IgRz0y6XZtW6BXh984Kws0STHNn/+oc/ogNPSUOgs2I4zJy2bD9y8wOPa06DhALFQmQS
 9dwpmmFDnTasNszsKImWUFzJirslWzBmMCOmA16dreB4LBjuJYak0lKJVShfFJBHYDvt
 hhgCWugppTD2lKWD2abR97x+l9ssdImE9kC7P1UQvjdJUhrohR3cK8m8Ko0br+U9bD1h aA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrbus00j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 12:04:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q9MEeV023068;
	Fri, 26 Apr 2024 12:04:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1pfk0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 12:04:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43QC4lA051446132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 12:04:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9A562004D;
	Fri, 26 Apr 2024 12:04:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EA1620040;
	Fri, 26 Apr 2024 12:04:47 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 12:04:47 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v3 0/2] s390/pgtable: misc small improvements
Date: Fri, 26 Apr 2024 14:04:45 +0200
Message-ID: <20240426120447.34318-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ofleeTSIDlZbQuIuKo4GQs4EYsOIgIzr
X-Proofpoint-ORIG-GUID: ofleeTSIDlZbQuIuKo4GQs4EYsOIgIzr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=680
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260080

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


