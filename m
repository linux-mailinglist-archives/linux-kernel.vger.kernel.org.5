Return-Path: <linux-kernel+bounces-52944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A2A849EB7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E04282E2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6772FE2D;
	Mon,  5 Feb 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pyll0emW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844432D627;
	Mon,  5 Feb 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148135; cv=none; b=iQdyx3UqsLPu5WOxbuN16Mm5wNQrKNHoJlZU06anY77NwUe4ZbjS6WdV6j29527wm4e+3lzie0Ms9VgDQzztaESPkWIZCP3dgNvMMB1/Sck+7yCoh45OMKf+SrIdcB1Z/NpiC+Wj3lE1dc2CXtBFP/LnWpND+HRtVMzTMlHA+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148135; c=relaxed/simple;
	bh=gF4abiAE7o1Jb+ADKtH3pnc506NKrhtdoAIh8FRnIM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VWsRbZfi5dtrNYFRzXdUs/fjJ0yS7lUimR1lGdMlO2n/AaIGCILKq4pY7CdhYpnu32+orudCgGK/ECdR3BKLo7RVCruPhTauBW0oVG5h2iS3qUk8K0y5CYCLi412CwcBHxXNlE+0XDOyQXb9a7As2hkdYZK59lQteR4kQTbMN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pyll0emW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415FUIhR031309;
	Mon, 5 Feb 2024 15:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Qr4e+7PBAi+DGQotRFim47e5nCGPxD99dZJ2eUwkKqs=;
 b=pyll0emWELqiVHAvPi4a2xgJMSsCqaBhTEC056U51F07oGT728LboXsglRBQaXDtb6ZG
 FGbhv3Ppo6InBAsIyRK+d8aDC71URpIC/xzra+7mubRL+KSu7/EZhn3wOcAxv2pDk6wo
 pzLuLzHpXMHb1335VTDkFMTCje87pet0L9VGrKsHCJcg+zy0HZwN11V4tsiuzvoyfNAS
 +N1s35OtQ7g6ubCbHeYKFVIwLXjS7wRJ/Y3CiP7bNln704PZWO9AXXP0x5fVvgX1YzQT
 rolatB+uiUZ3n07Bg+FNejWI46+vdvWgpfFQ6LUF/D7faVatQULf6lc8nhzlFSqA7T3q BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3272rxnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:48:49 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415FmVHY008463;
	Mon, 5 Feb 2024 15:48:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3272rxnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:48:48 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415F9BWq008515;
	Mon, 5 Feb 2024 15:48:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221js0jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:48:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415FmjP519661160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 15:48:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D0C020043;
	Mon,  5 Feb 2024 15:48:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B3020040;
	Mon,  5 Feb 2024 15:48:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 15:48:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 0/2] Compiler Attributes, s390: Provide and use __uninitialized macro
Date: Mon,  5 Feb 2024 16:48:42 +0100
Message-Id: <20240205154844.3757121-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CP-Uhy6NsaYgZdsK3xKr5xJS0lLcxHOV
X-Proofpoint-ORIG-GUID: DGeq5jnvLZmP3kAOwDZnSiE8VHJ_MCx9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=825 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050119

With INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO enabled the kernel will
be compiled with -ftrivial-auto-var-init=<...> which causes initialization
of stack variables at function entry time.

In order to avoid the performance impact that comes with this users can use
the "uninitialized" attribute to prevent such initialization.

In particular code sections in s390 specific kernel code which use floating
point or vector registers all come with a 520 byte stack variable to save
already in use registers, if required.

If the above named config options are enabled this stack variable will
always be initialized on function entry in addition to saving register
contents, which contradicts the intend (performance improvement) of such
code sections.

Therefore provide a generic __uninitialized macro and an s390 specific
DECLARE_KERNEL_FPU_ONSTACK() macro which provides a kernel fpu variable
with an __uninitialized attribute, and convert all existing code to use
this.

If people are ok which this approach, I'd like to carry this via the s390
tree to avoid potential merge conflicts, since there is a larger fpu code
rework pending

Thanks,
Heiko

Heiko Carstens (2):
  Compiler Attributes: Add __uninitialized macro
  s390/fpu: make use of __uninitialized macro

 arch/s390/crypto/chacha-glue.c      |  2 +-
 arch/s390/crypto/crc32-vx.c         |  2 +-
 arch/s390/include/asm/fpu/types.h   |  3 +++
 arch/s390/kernel/sysinfo.c          |  2 +-
 include/linux/compiler_attributes.h | 12 ++++++++++++
 lib/raid6/s390vx.uc                 |  4 ++--
 6 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.40.1


