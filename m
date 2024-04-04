Return-Path: <linux-kernel+bounces-131271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C8A89858D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A842C1C214A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02F580BF7;
	Thu,  4 Apr 2024 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PEfiU9X4"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3DA7580B;
	Thu,  4 Apr 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228332; cv=none; b=syiWMpYPQo62QO/89UofjJUIVh52+RSLSSlBE7uIHNoty1eGPXZ7+wfKlJz0IGVPPUwEgfCxxMhHXQEWoZ2VPWOrg3TgHuJ/KR4vmynl7i7YA3XXDfNrdvszdtV9WbJL1QgxnTTdgw4aew0Rm9JZKRTLpb8AMOtzqDWoWqKxSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228332; c=relaxed/simple;
	bh=74izii2I5bjSHt9CeEUwIxSyGfbdoLXigvccbRalNbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NmsNBVlArZfKg3GIwcFOwlGbh4ekCSgIyAtJuN3fDBJNybwvFx3dnnTOf2TYPxgSpeX0rUMh0Rfc2P0n05qeCV7dgoY/0JD02go7LLbszt+9p21AG+yGUSsS9xUrOvU5kF0OOuHvEfB486Rtb+7a5y4H7G6BYzApzWjJmaHQTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PEfiU9X4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434AvG9j013992;
	Thu, 4 Apr 2024 10:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=VKSRHzOGlluEMqS70eCRqda5wOVXaiy817kbRpjF9R4=;
 b=PEfiU9X4JxyJM1C0vhIyR7xwYz7Qo3mFU3dQpCkbZi+e1QnhBHMiLROM7/GijKAIJlQf
 gUN2QPFpjNrtqF9ksNjAzXhLUSS5Qt8i2OzFvzC0wjtEa5ol426C3Rvujs/Mo3DBHd2r
 uZQy6PAxgVCTtKhcbVozsc3VzRK0S7k69QQIDyG+Ru7NOTkhnjzxJ0t61KXRogMFhrF3
 zMn7G1WcyYtPsJ8ieMQPGyPvwaJz8MHxTfjbPc2co0Fn6MtQXZ0nbtIkcYXDBG+LTU5t
 pYex5pROCmZdOIK+kWfkT09fP9FPrs4hCFMjb6Vs7njF310H39daU1oNl5bOV8Uu9Oh3 +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9twb8083-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 10:58:47 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 434AwlfK016270;
	Thu, 4 Apr 2024 10:58:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9twb8081-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 10:58:47 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434AVM8W003711;
	Thu, 4 Apr 2024 10:58:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epybnwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 10:58:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434AweFF48562586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 10:58:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A014C20040;
	Thu,  4 Apr 2024 10:58:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DBAC2004D;
	Thu,  4 Apr 2024 10:58:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 10:58:40 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/1] char: tpm: Handle HAS_IOPORT dependencies
Date: Thu,  4 Apr 2024 12:58:39 +0200
Message-Id: <20240404105840.3396821-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x9_UfW0g6S7OFRCdasK6_-xJC9L_HMF9
X-Proofpoint-ORIG-GUID: oLpX2ILrewyABTx7H1D8TZUEWPMQ9Wgu
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040075

Hi Peter, Jarkko,

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
  char: tpm: handle HAS_IOPORT dependencies

 drivers/char/tpm/Kconfig        |  1 +
 drivers/char/tpm/tpm_infineon.c | 16 ++++++++++++----
 drivers/char/tpm/tpm_tis_core.c | 19 ++++++++-----------
 3 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.40.1


