Return-Path: <linux-kernel+bounces-131252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2EE898550
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3991C25D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900397F7E4;
	Thu,  4 Apr 2024 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lL+P8F+9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F48F7D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227529; cv=none; b=cmZ1HmToyMOBInTOkNJXPBBKfDVaDJ0KwiNflx30wieJxVhxj641XtTKh6E8bR10lKSXyZH1Bft8o93HtNx1gz6R80pjSU83UgoFksjePahSSfjeu1d0PVIGSMfdEPbUufgrY+Ajj+v2kL5f3t0DLLmEcyL8eDdhbIBXJdZpjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227529; c=relaxed/simple;
	bh=SeBdGV1HrtUEroD4qusHwI5kDkq+YHBV14rOoo6DxoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SMue+XAsfEgKs2r5CRK/QHYydHNs6qVcaAzNSAtH2fX/sBz3VvK6dzFNtREUYoHW6OJxSUQKYUX9NeMIdjrbXXr7UJOVwZYZBwJ3vgaVZPGPND4c94KWqGCU+XSmffEgw51YTqKJWCkE43betOScE2ws98LWvOSYknQi4CzSv1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lL+P8F+9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434AgEV7018925;
	Thu, 4 Apr 2024 10:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=q+sqSTsDlBfp7Iyh5uWNZH97tMcJDE9eD7jxd8HKrIE=;
 b=lL+P8F+9ESZh/BlZFSq4+kY49sqDNzfaxlJM7xg5n7btHUbCoiOlSyqWkYXqIl/rF89V
 wiipkuZ/ig1jpI5tR91O/63ZFliRVybrMZb9QKyTXQ1JS+K3ZWYp8yqyhIC3UnRJcN5z
 RZS0e7AaZW+79k0eAaNCDC2Z4hwBCXq3V6yj/cc7w9dEG3U+MBZbsIlS0cRKQbPM0JWV
 r0q/JC6yc58PQ0p4nTam0SdBFXXZlCYheh2kBu37NhjfizbbIqtEH3OD/4kMc1CpV+qk
 nYXnHQgj6jw3X/zkP4S48dgjBr252E/EDJD7F34O2MFGUHkqPpiK7aqV8jMaMfn7I2Fr XQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9tpbg059-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 10:45:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434AAUWc009103;
	Thu, 4 Apr 2024 10:45:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epxum83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 10:45:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434Aj7Sd50921898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 10:45:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 308162004D;
	Thu,  4 Apr 2024 10:45:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0220E2004F;
	Thu,  4 Apr 2024 10:45:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 10:45:06 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/1] char: ipmi: Handle HAS_IOPORT dependencies
Date: Thu,  4 Apr 2024 12:45:05 +0200
Message-Id: <20240404104506.3352637-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XzpofZFzyJ9yLadgYnIAYyNINa_Y1r7R
X-Proofpoint-ORIG-GUID: XzpofZFzyJ9yLadgYnIAYyNINa_Y1r7R
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
 definitions=2024-04-04_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040073

Hi Corey,

This is a follow up in my ongoing effort of making inb()/outb() and
similar I/O port accessors compile-time optional. Previously I sent this
as a treewide series titled "treewide: Remove I/O port accessors for
HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
subset of patches merged I've changed over to per-subsystem series. These
series are stand alone and should be merged via the relevant tree such
that with all subsystems complete we can follow this up with the final
patch that will make the I/O port accessors compile-time optional.

The current state of the full series with changes to the remaining
subsystems and the aforementioned final patch can be found for your
convenience on my git.kernel.org tree in the has_ioport_v6 branch[1] with
signed tags. As for compile-time vs runtime see Linus' reply to my first
attempt[2].

Thanks,
Niklas

[0] https://lore.kernel.org/all/20230522105049.1467313-1-schnelle@linux.ibm.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=has_ioport_v6
[2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/

Niklas Schnelle (1):
  char: ipmi: handle HAS_IOPORT dependencies

 drivers/char/ipmi/Makefile       | 11 ++++-------
 drivers/char/ipmi/ipmi_si_intf.c |  3 ++-
 drivers/char/ipmi/ipmi_si_pci.c  |  3 +++
 3 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.40.1


