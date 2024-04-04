Return-Path: <linux-kernel+bounces-131362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0368986BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEEC1F21664
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101686244;
	Thu,  4 Apr 2024 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bb6aU/e9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE385276
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232186; cv=none; b=ntJMxw8hPpcJwV6jJTvsE0PYbZWiYRuk0cwPyQ1RWnechtrWx5xuMQv6Ku+a8uhDEr7sJo5kj8lP0NLAroYDVzqBeLAhVbDO23K0aG7/L8xIWOVF96moZdCFRB6hvKz10vQFymdElEk9nFwXHiPFYhSixN39fZx4lA+pZCgRhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232186; c=relaxed/simple;
	bh=gIUGMsN82kZZvzxn93KRMaSbbp3rtwo4SndPT7pELOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=umYhLVS/EkJqAhg0o6IoecmXGdjvPN6cj64M+ystmo0k2smAGWG57CTYxjnIo/Q7YOCVU5YvxxrEr5POdbpdJllOwp5ViRkNncKLaDpeLVZKq21rlh04a8G9WOD3O5SftqRAPI8vVXWjEw9B7p4U0t904c095CxZIhfzsG6w/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bb6aU/e9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434AtqTa020217;
	Thu, 4 Apr 2024 12:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=irlzy7YdtlnJBBSs+xzxK76SkCyWGCLINWBCevcbiR8=;
 b=bb6aU/e9HSqz9zmQCyBKIfuFoRdD4yFwLtYyC8NQDH9DDUMBxnU+nrk02Z4UWyFQjrPk
 Cd+vqAzE9g1ypHuHn4TSuBg+SzWBc8t1/3ACdZwSKmJ5vGxRD2G9N2bWnJ+FUwqJ4j2C
 9ZPeGcSeF58HVChVIyFEdrj7vZHVny2q797qT5h57CmXTIC1pTNsr/fQUeW3JgMzIM/1
 C+MAVy54RVItORefR5u89XSlpjf+pG5DtkofWxg99wpTfl32Bg6rpcgqUbcDlSYSEYGR
 oRCPL74ElejflJNwVHqWy6dLiOFGMOeDJBqaNUjl+lg+BAA9vO0fpZNAvqTJGzIFHK9H pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9tvn054y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 12:02:51 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 434C2pDg031538;
	Thu, 4 Apr 2024 12:02:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9tvn054w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 12:02:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434AU8Ak007708;
	Thu, 4 Apr 2024 12:02:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epwkxp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 12:02:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434C2jBH45220106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 12:02:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDED22004B;
	Thu,  4 Apr 2024 12:02:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C11DA20043;
	Thu,  4 Apr 2024 12:02:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 12:02:44 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>
Cc: Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/1] drm: Handle HAS_IOPORT dependencies
Date: Thu,  4 Apr 2024 14:02:43 +0200
Message-Id: <20240404120244.3659560-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -OAA6bYc8hgLut5N10IPmlz1fAHnHZsn
X-Proofpoint-ORIG-GUID: 2a1he7Yybvp0ifWzwHLSQ3mdB7ZnKDwv
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040082

Hi DRM Maintainers,

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
  drm: handle HAS_IOPORT dependencies

 drivers/gpu/drm/qxl/Kconfig   |  1 +
 drivers/gpu/drm/tiny/bochs.c  | 17 +++++++++++++++++
 drivers/gpu/drm/tiny/cirrus.c |  2 ++
 drivers/gpu/drm/xe/Kconfig    |  2 +-
 4 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.40.1


