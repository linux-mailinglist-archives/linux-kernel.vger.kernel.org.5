Return-Path: <linux-kernel+bounces-158567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7998B8B2231
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D85DAB21BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB9A149C47;
	Thu, 25 Apr 2024 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tLduG9PE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE961494DA;
	Thu, 25 Apr 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050373; cv=none; b=EaPq22ryIbXMN79D3MmH6JE6qF0ur18pe1IH0ZoZRK9FnlG3x0uUVUjXz83EuNTQZzuvFmT9Rr0zCyWTD+I5wHMw4Ui7ntoWkt6FH1CG4jlxDM50fSfxLtvn1yYWPADMLtOPGFjzfiHZKDl3cTGMYRvdZWZYWg9PK5zAK8hAEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050373; c=relaxed/simple;
	bh=qEsA4fMSLkxiExCUcAUU2HEHNNs8axftNFScUXDPiew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RGVisPSWWW+IZWHSS3IvlCDCyFPA9hKta7HV5fhaCZjX4T1VLV0CSGeTfbbWLhx+Bz0YQ4WLA5YsY5e6R5aCIv4CXsi0zTHahyfAm8vy0/95BnVNTI7urAg0uYLXjE/yjFWrEM2YuhULFeABL52BRX41ZaoHTNyFpsWgW9Dkewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tLduG9PE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PD26gN005234;
	Thu, 25 Apr 2024 13:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=gsj6tYdabVaphThcZgq+iWqbQLRoqpAoC3FzceEswqw=;
 b=tLduG9PEYYUbvteT6UeisKhiq7fCfPx2v9VBHM5R6Z08Dd0hwdUZgh/glV8FJKqzf2sc
 9jpwDEf2jH5BmQJ3ZmbAhdzZ1r+UrDmlE7a2/Pktc4WDiGmqsgLC0eeQeQtLS6iCa7W7
 ioR9I3ArKMwGB33bbz/3BhIF9JtuUWgUvM7fzvpiGWaAZKIKHi4QctbX2VYdMyIzQMdI
 RKJTvH8uMZ0rGup0PCdXrF+q5PedZbTy1S5iYt+qTPBCjacd9FQUSD6dFXAHuATcke1B
 f7zg1+jWlicbR1DA4h55hLCmPaf0uZaCwQfKJzyruf5ImgjX5Y759+qsL9ijDFWoqMZK KA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqqpwr0c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:06:09 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43PCNv6b023068;
	Thu, 25 Apr 2024 13:06:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1p9u6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:06:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43PD621a35651882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 13:06:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A3C62006A;
	Thu, 25 Apr 2024 13:06:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2758C2004B;
	Thu, 25 Apr 2024 13:06:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.50.16])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Apr 2024 13:06:01 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v1 0/2] s390/pgtable: misc small improvements
Date: Thu, 25 Apr 2024 15:05:53 +0200
Message-ID: <20240425130555.73132-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qKexw6tJUdX7hlIm233UcH7nHME1p4le
X-Proofpoint-GUID: qKexw6tJUdX7hlIm233UcH7nHME1p4le
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=572 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250095

This series has two small improvements for the s390 page tables.

The first aligns the layout of large puds with that of large pmds;
there is no reason for the large pud read and write softbits to be
swapped compared to large pmds.

The second introduces _REGION3_ENTRY_HARDWARE_BITS_LARGE, for
completeness, which is a bitmask of the hardware bits for large puds.

Claudio Imbrenda (2):
  s390/pgtable: switch read and write softbits for puds
  s390/pgtable: introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE

 arch/s390/include/asm/pgtable.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.44.0


