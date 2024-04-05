Return-Path: <linux-kernel+bounces-133247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE50289A134
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84948288720
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE91A172768;
	Fri,  5 Apr 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="trnWmx4l"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4516FF47;
	Fri,  5 Apr 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330979; cv=none; b=OpwaL2hCfJOc/aqNneKbN7YGr0TQYTSAsRJNellJd7puep7kJHLzMpMUKZFBjKOOayc5mWYqKuWrDMbaKUBHBv29zn6KN6s9JuoVGuVwUlcfTdwlMyCUSOWbbo3d4UWfnEHl/yQLTHr2sTCOMCbMws0ltaRKP/MByYmBdObLOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330979; c=relaxed/simple;
	bh=5VRbHJIvszzptc9rXnIqoakhk4Y/8V4MlYQ1nZayw50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SZhoW69VXmuTs5kkfqDWBm9GxLJ49bUhf1HAn75nWaKmonVfNxSFldJbY1Lptkg2MwBsPk0qKFH/krOlVtCgHy0SH9emlLGP8128OP4eJuseqY37IFp+ZZlRTMmhO5ZHKjB6O3lqZU7a4AeV7fNyBTSu8zQuDmszksSuGTL+E2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=trnWmx4l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435EvwLl009043;
	Fri, 5 Apr 2024 15:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=oFe/WebQcvfKeDqTd4X6IDbnNxnThHpUT2URrKMxakI=;
 b=trnWmx4lNVm+sHVEP43gMwrbWVqntQ+B7ygvG42mU4Z9hQWv/R0rLa58hvSIiP3JEiAs
 JaBmwpgU/C3RaZ3NKq4YSui5y5DbuoPBR84MmhJFXMMkN4ieCdnJAg1ovUGaeHdVUzyo
 L0ES/Xcu5VfxjjynFnpLqSwIWXQz8XPjS75clLdBkCGeSfUg9Yr2LhcHt/LswnZZSUpj
 2OyaQSXkCK1PoO3rrmg6S1MJZM1O8Qp0V5qixcSWAnnexe70U08YTeldypuQjtJ53Dqj
 kD4LAsSorctRM6tHJVgkJYSv+vSAF5WRfUG5RH/xirkCuugwouvm1YJoCcgx52coUyWa yA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xakgu83py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:29:30 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 435D7GTE007708;
	Fri, 5 Apr 2024 15:29:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epwu90g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:29:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435FTOos14745964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 15:29:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 936B12006C;
	Fri,  5 Apr 2024 15:29:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72C6B20040;
	Fri,  5 Apr 2024 15:29:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2024 15:29:24 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/1] tty: Handle HAS_IOPORT dependencies
Date: Fri,  5 Apr 2024 17:29:23 +0200
Message-Id: <20240405152924.252598-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PmB-YRW4Zn-ztXJCbnXD0pRA-O1SuGOs
X-Proofpoint-ORIG-GUID: PmB-YRW4Zn-ztXJCbnXD0pRA-O1SuGOs
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
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050111

Hi Greg, Jiri, Ilpo,

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

The patch was previously acked[3] by Greg but given this was almost
a year ago and didn't apply then I didn't carry the Ack over. That said
I don't think there were non trivial changes.

Thanks,
Niklas

[0] https://lore.kernel.org/all/20230522105049.1467313-1-schnelle@linux.ibm.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=has_ioport
[2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
[3] https://lore.kernel.org/all/2023053050-prodigal-shine-4d1c@gregkh/

Niklas Schnelle (1):
  tty: serial: handle HAS_IOPORT dependencies

 drivers/tty/Kconfig                  |  4 +--
 drivers/tty/serial/8250/8250_early.c |  4 +++
 drivers/tty/serial/8250/8250_pci.c   | 14 ++++++++++
 drivers/tty/serial/8250/8250_port.c  | 42 +++++++++++++++++++++++-----
 drivers/tty/serial/8250/Kconfig      |  7 ++---
 drivers/tty/serial/Kconfig           |  2 +-
 6 files changed, 59 insertions(+), 14 deletions(-)

-- 
2.40.1


