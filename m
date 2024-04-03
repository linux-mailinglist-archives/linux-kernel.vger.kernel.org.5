Return-Path: <linux-kernel+bounces-129876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B637897182
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5741F21A63
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E36148831;
	Wed,  3 Apr 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PGQMJalj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BA94DA0C;
	Wed,  3 Apr 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152112; cv=none; b=RD2RHTQOXS/al3D+rW7kc68v7Yx0+3fXE6YohGCY5TrAB0j8TDgqAXSKuRewaiYRShR9ewCL4jYt4wRDrSmICjFrenTWEB46ZyAFlvOqo2dK87bLpmY/lipgrsMRKAg8XkIL5p0b7ET6aEasDup4B5kzWUsOInGwQ0yrwqrnNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152112; c=relaxed/simple;
	bh=XQw90a7JGR/+AP6daIo3qRQb2zXpuUyjd+M+ZOxSCgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b3Hid8M3K44LgPGpZT/bdazOsGPgoNrNcPSLoFchrMXUeEN9Vmniv4lnnuH2tIzxQAD6o35tTHQWK/x0P3TxHDqRWPu03CiXdzJDE4byTCSfnv+VQxy2q9gbo2ndW8HgCwZF8wSlA+GD2AoUhfpxGqupDDbjIS4VS+5Kxc88L/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PGQMJalj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433DRLUj028566;
	Wed, 3 Apr 2024 13:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=UUgVx7rrXbDM5JrKl3tHqzknPYhLx6bxoiT307vyvcI=;
 b=PGQMJaljV5o/luqUMASlYbo4ei5x9FM2qboq9XZjNu6pJTYcHRikGSQk8lK7fSGaD5ej
 GywvxgtkcNALIZPCDDATDIyw4kWT8u7rzuuNAMJc8qT7rDrr1+mpJRCDpEoYtGbubue3
 I+jpg5ZLOjjwljVeAGOV6xlYullpEn3cp0aQRuReLweTE+DqMCRy1cGmZsB7l69ROeHp
 92/HL3x3jf07BB2rhFWSAfRnz5h4kEasK7IAqAbOv3qFi/4+2dcWWSqeFFSNhWgGnd6c
 etikZpJmAkZFdm6C+y1vUHJ4xFBHTRjfZ4RAvdR9mm9GAL/6rkkyywqcKmghChIbTBfp aA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x980tg1yt-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:48:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433D2TbS015241;
	Wed, 3 Apr 2024 13:24:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6y9m546a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:24:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433DOlmT47448476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 13:24:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C76022004D;
	Wed,  3 Apr 2024 13:24:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A54B420043;
	Wed,  3 Apr 2024 13:24:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 13:24:47 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/1] hexagon: Handle HAS_IOPORT dependencies
Date: Wed,  3 Apr 2024 15:24:46 +0200
Message-Id: <20240403132447.719833-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aj4ESgDpjfjWFRHjLfjg75USY95AjFIl
X-Proofpoint-GUID: aj4ESgDpjfjWFRHjLfjg75USY95AjFIl
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
 definitions=2024-04-03_13,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=997
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404030095

Hi Brian,

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
  hexagon: Don't select GENERIC_IOMAP without HAS_IOPORT support

 arch/hexagon/Kconfig | 1 -
 1 file changed, 1 deletion(-)

-- 
2.40.1


