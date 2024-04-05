Return-Path: <linux-kernel+bounces-132897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18375899BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0AB1C2237B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7516D16C6A4;
	Fri,  5 Apr 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dh7qfcB/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FC16132B;
	Fri,  5 Apr 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315933; cv=none; b=R9rwZsrmZ21Sw9aaByF2mLaoFEnL/iJxUqiEPhxXZ+VKPVg3yOyLzKvYwahMLEwArmkLy5G2n8BN+VPycNlF+9uTLrgN0IStcWP7auDLIPF4u7Inz5V4d9avxHFFeMkMlSicqtKh3zw2MtroyNFWHccjL1QrQR7+0eGDzikiuoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315933; c=relaxed/simple;
	bh=V4qI1rNN3XUit9jxdu8kEl95AIVtXhBHWOFJK5RuWBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BMcmG3jSU6yKW3dsqZR6zr74V0MIcF3QwYeH78xB4ac79o5d72qmZVu9u86HGTzWoHsrgitm+DD2JPprYvgPLmQIdWzm5V3UbEsFlsgnSVNZNi8S4Fs4dXZAH7Khtj9CAs+Km4UI46LGvmFiWgqWFczqLcLGQpIZijCEYXnlUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dh7qfcB/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435BI1xN016084;
	Fri, 5 Apr 2024 11:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=cHucxGpcDq5gHMAeVAbAeGgnEwEQpWc2GRkTuDwX2MA=;
 b=Dh7qfcB/r9vlpYsgsKtoZxn56tWesqCOITExSN68uNmvnTDXIMuvV/z1WJPY9izDHIAt
 CrE4KLoS29v8g64aiwhRfjc06TkP7AdepTkQwTT2FU9nX4GJpeh8XTNSLon+AimCxyuA
 RsYomx9ptwlzg/jDTODT5ORg9fwGKLEjQSr91+YednMA3atRXEdvb8pjpnZcgYcZykek
 NXe0hWqsuomSUnn850txwlnWTD4QWnSSLWDYYpfNATYjbst/vOIfULzsi078fVrgWrcP
 VQ2QM2kYEi2FaLJsTWYNpGLHTlFMzaa7hXEbBuIDKID2QTO1sArT/66evEIVVR26TIX0 ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xag9yg01t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:18:39 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 435BIdbU016470;
	Fri, 5 Apr 2024 11:18:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xag9yg01p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:18:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4359wUl2022293;
	Fri, 5 Apr 2024 11:18:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9eq0j332-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:18:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435BIW7T51380592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 11:18:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D41C20040;
	Fri,  5 Apr 2024 11:18:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE80D20043;
	Fri,  5 Apr 2024 11:18:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2024 11:18:31 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-hams@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH net-next 0/1] XYZ: Handle HAS_IOPORT dependencies
Date: Fri,  5 Apr 2024 13:18:30 +0200
Message-Id: <20240405111831.3881080-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U-EXTpSWl69qGr55-QgSSaHTocWLqoFZ
X-Proofpoint-ORIG-GUID: XfocbBsB7bs3G4uNIVWawrONzM5V2USL
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
 definitions=2024-04-05_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050081

Hi networking maintainers,

This is a follow up in my ongoing effort of making inb()/outb() and
similar I/O port accessors compile-time optional. Previously I sent this
as a treewide series titled "treewide: Remove I/O port accessors for
HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
subset of patches merged I've changed over to per-subsystem series. These
series are stand alone and should be merged via the relevant tree such
that with all subsystems complete we can follow this up with the final
patch that will make the I/O port accessors compile-time optional.

The current state of the full series with changes to the remaining subsystems
and the aforementioned final patch can be found for your convenience on my
git.kernel.org tree in the has_ioport branch[1]. As for compile-time vs runtime
see Linus' reply to my first attempt[2].

Thanks,
Niklas

[0] https://lore.kernel.org/all/20230522105049.1467313-1-schnelle@linux.ibm.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=has_ioport
[2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/

Niklas Schnelle (1):
  net: handle HAS_IOPORT dependencies

 drivers/net/Kconfig                  | 2 +-
 drivers/net/arcnet/Kconfig           | 2 +-
 drivers/net/can/cc770/Kconfig        | 1 +
 drivers/net/can/sja1000/Kconfig      | 1 +
 drivers/net/ethernet/3com/Kconfig    | 4 ++--
 drivers/net/ethernet/8390/Kconfig    | 6 +++---
 drivers/net/ethernet/amd/Kconfig     | 4 ++--
 drivers/net/ethernet/fujitsu/Kconfig | 2 +-
 drivers/net/ethernet/intel/Kconfig   | 2 +-
 drivers/net/ethernet/sis/Kconfig     | 4 ++--
 drivers/net/ethernet/smsc/Kconfig    | 2 +-
 drivers/net/ethernet/ti/Kconfig      | 2 +-
 drivers/net/ethernet/via/Kconfig     | 1 +
 drivers/net/ethernet/xircom/Kconfig  | 2 +-
 drivers/net/fddi/defxx.c             | 2 +-
 drivers/net/hamradio/Kconfig         | 6 +++---
 drivers/net/wan/Kconfig              | 2 +-
 net/ax25/Kconfig                     | 2 +-
 18 files changed, 25 insertions(+), 22 deletions(-)

-- 
2.40.1


