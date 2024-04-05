Return-Path: <linux-kernel+bounces-133278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919189A19F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7131C22FBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F2016FF3F;
	Fri,  5 Apr 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qb93qjIV"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672016F917;
	Fri,  5 Apr 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331825; cv=none; b=Jq9k1sQ1POgcUI4GfyguIflZExuM5K8cWyKKdkP+RkZOg39hIp11pCmyvvfI5RQXqlL9ziakM16uUtdtK3lluN+97/0FvCQkEvUDCqZnOWZrZBOYCEL02mas7wF9m1PwmRq4llwnTPxWXc75Q9+DJ7AVmdjun9Xo/PM8QFPihnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331825; c=relaxed/simple;
	bh=GLYjitsvkl7e7DDPD5ICwfMOzIGkz/pBD2SvMceBBKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvr11bvElZNlVzl9bZxOKTd3ZyXFM3Vl5QX+DDzxNubaOCpkuaWdz9zXH3UH8hT160J/KTgsUC+HCzb6ZAjtrnOBq8HIuwTI5P+qjVVZMw1TBHJqhd5bMXp1I5Q6wEGba3R/6WmPu1YzXUxHFIpl53g/cdwxEKfn1SnFd8Gq3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qb93qjIV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435ERLCp007273;
	Fri, 5 Apr 2024 15:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Ud3E4K/jMbq9dT0lA4HOVwcj6RCy+VLBGogAjeFdCZg=;
 b=qb93qjIVL0Y+3bQbSiOSj5+AVMnePnzdV3rTBfYuWD0nGMTf/ZQCaCOr1JjOla3+4+xR
 iJXkCjaZqnXc1DLMkrkHMGjlIvMfHyaH90PosRmc7m7+bJPzgJMJRGIU2GiVdcmHi3Or
 JQI6DDjH8CtBdQC5k+/0wuAdb44XNayhryJ6f3ZmNIJ/YKIZtBgyob2/+4/jRtThoRXc
 jHOqAVUjlJ635CFWP95irqZqHvGqJ8rPDivMs9K4f5eMLTs0SNdOF7BD3+4Y2nqsOY4a
 dXdd99/RJHvNWxMrrFNX4wdY/n+Xe0YtgFaZj5c3irCWNplMhjmZvV4/yBOs/e/wTiFb yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xak2rr8v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:43:39 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 435Fhdkk015292;
	Fri, 5 Apr 2024 15:43:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xak2rr8v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:43:39 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 435CxA5w008681;
	Fri, 5 Apr 2024 15:43:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epwb997-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:43:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435FhW3a31130302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 15:43:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4113020043;
	Fri,  5 Apr 2024 15:43:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1092D20040;
	Fri,  5 Apr 2024 15:43:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2024 15:43:32 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/1] vgacon: Handle HAS_IOPORT dependencies
Date: Fri,  5 Apr 2024 17:43:30 +0200
Message-Id: <20240405154331.292421-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M_PwfAPfdO4op4D1Ug7JiyYPfxxX23BG
X-Proofpoint-ORIG-GUID: 3H4jt0DmnB4aMS1B2rnZS9r3XQpwDgm-
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050112

Hi Greg, Helge,

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
  vgacon: add HAS_IOPORT dependencies

 drivers/video/console/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.40.1


