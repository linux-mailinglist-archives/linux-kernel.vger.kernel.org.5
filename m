Return-Path: <linux-kernel+bounces-131334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D32A898668
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F52D28BA47
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594AE84FD0;
	Thu,  4 Apr 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lnvgy36I"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB3745C3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231369; cv=none; b=BaGFTgG1Kf2IsuQn+yiTGNOrwgkq7kagojSDmklPGCH61fUfju7AxvKxb4IMc2up/4aVukl1EkohAECUH5Ej6+o6BfXrhvLqd4xJUlT9q902wc59zqE3WjQawUnri+WIbsk3uI1wAVqnTpBF9Xj5kQk8iZw+it3+YB6PlqI2SpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231369; c=relaxed/simple;
	bh=LCWAW+VOm6FrXEOYBB2mg7d0P/d+F63lRzQcYlEJDFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCpL+BBCKXnkylyNgc+Dw2jGeqddkob5WsYhvuZNtUipquh2AqSGrJcmkaHxStnZ8HDV8B3LHeQu5daS4zid1c5ITguXCo/waxxulfo+fdOjurjh6ESya2CRBl/r7O6Qf8W5zi0B67cUeTvPZZEzDFZTgyrLIWTtZx83j50PEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lnvgy36I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434BRG5q020074;
	Thu, 4 Apr 2024 11:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ZJhMoA4/8PPu9Nyl7nddIUmvaUIpt0j8YsJpTQeATsg=;
 b=lnvgy36I3YYqHtfk9KO8u2+tIZxYDzkZvYwC0BrlIH8j3s+LrGIrrjgwCb7h4QDI13G5
 Fyjth7NVmras+gFojA/7UlBmwmCin2FrfRoO8aQYRSUHN1K2c9KaU00FPaCVuuCWf88q
 IQ4wPjvWf8URrfK5w417lTqjnCerYrsZ7GhpI52kgkg1uFwekhjEMmowPLMVostxMgap
 dbYLxsr2u6/dA95Mn/U1huUeb1XTNOoy74KY1LID1cI+rLz9z43kmgj+TiEZNI+dGhnk
 1yiLSpyn5LZ7XRU55e+8MUb/pacVgYaGNp9f/MjOPdkdsMFLAu2rDOc28VR+zx9Xxpcc fw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9ubc01qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 11:49:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434ANbZp007759;
	Thu, 4 Apr 2024 11:49:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epwkvnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 11:49:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434BnHCQ45875496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 11:49:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCC7A2004B;
	Thu,  4 Apr 2024 11:49:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2FAB20040;
	Thu,  4 Apr 2024 11:49:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 11:49:17 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/1] /dev/port: Handle HAS_IOPORT dependencies
Date: Thu,  4 Apr 2024 13:49:16 +0200
Message-Id: <20240404114917.3627747-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lj2ScmAtP-imcuHAXZkXcG5WMtgurrRi
X-Proofpoint-ORIG-GUID: Lj2ScmAtP-imcuHAXZkXcG5WMtgurrRi
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
 definitions=2024-04-04_08,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404040081

Hi Greg, Hi Arnd,

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
  /dev/port: don't compile file operations without CONFIG_DEVPORT

 drivers/char/mem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.40.1


