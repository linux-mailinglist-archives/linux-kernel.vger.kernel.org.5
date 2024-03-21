Return-Path: <linux-kernel+bounces-110710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C38862C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64F7B22710
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72F13665C;
	Thu, 21 Mar 2024 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A1trTufF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E54133998
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058206; cv=none; b=oju9tZY9NKt9qzscjR6WuyXw9viGG3XgShQ5gDfKUV8QQNInO/B1brFi41ngzgPfZF3eBeMWBz4m8ThENg5ela35/xk976pBNOcZQ0/jnV3NOVyL6hH9gXuzO+hqnWxvHXND589Md/pFQmz9R33BVmRqkDTVeChfKWFs5obJzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058206; c=relaxed/simple;
	bh=QEfb7ArDPAw7BurUWKSTGbJOzHTHhuPzZv+fEE6mFOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qomwaTI336CBBxFFMNXT7lh2kDlXzYC/+GjR0Wt6fO0sjf8moQJS4REbebWMio+snJ48MK5S0d2jvO9uAjiOtlbc2AAYXiIfjM8mCbg71dc7f5V8yD2nenebzVEpfgjm8cdksumTqK/dNVL7V1qchzu8PpjcU1dK2PZzQ+6mcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A1trTufF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LKYfIX015481;
	Thu, 21 Mar 2024 21:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=coS0Q7iuOrYlbqS2f118vlt6+24Qu8egpx6DRQZs+XA=;
 b=A1trTufFluwhS4HxyGaG3FNnmmVfA7jXBUmobYaSX2WOu6F/FIledp1xnzl5ON5mVB0m
 6Tv0AmlpIIdOdzbADpU0kHVcUdUM77SCItmw0+aHQTa8g0S/MOxsB6De7goG4HqsCNc5
 ETr/Pf6rFAWKVaMD3HGJ+hkCiC8dzA3iVS5kU2rTKJvZN49latUPOhC1D5wnhHe/k7Va
 GMeH4IYwFj4GJBj0KDWKcCGJVrRq8f5hy3GLnScWywkFX0Rwfzki5TRLqZNGGojf6Pf3
 pXACe1GnFXYzzWFskg02/RoWuqCPkGegSAKXnuNh8UpACOXt54q8Ywplccni1gbbYdWI rw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aakeeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 21:56:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42LKUxHe007481;
	Thu, 21 Mar 2024 21:56:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1vahejh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 21:56:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LLt1fi038093;
	Thu, 21 Mar 2024 21:56:24 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ww1vahej4-1;
	Thu, 21 Mar 2024 21:56:24 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        matthias.neugschwandtner@oracle.com, andrew.brownsword@oracle.com
Subject: [RFC PATCH v2 0/1] x86/pkeys: update PKRU to enable pkey 0
Date: Thu, 21 Mar 2024 21:56:21 +0000
Message-Id: <20240321215622.3396410-1-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=591 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210165
X-Proofpoint-ORIG-GUID: 2V_V9hk42Vh5LmbRFqzZwTkyeKxIvokC
X-Proofpoint-GUID: 2V_V9hk42Vh5LmbRFqzZwTkyeKxIvokC

v2 updates:
- PKRU is passed as a parameter from handle_signal() all the way to
copy_fpregs_to_sigframe(), where it actually updates PKRU in the
sigframe

I'm working on adding a test case in
tools/testing/selftests/mm/protection_keys.c.

Aruna Ramakrishna (1):
  x86/pkeys: update PKRU to enable pkey 0 before XSAVE

 arch/x86/include/asm/fpu/signal.h  |  3 +-
 arch/x86/include/asm/sighandling.h | 10 +++----
 arch/x86/kernel/fpu/signal.c       | 44 ++++++++++++++++++++++++++----
 arch/x86/kernel/fpu/xstate.c       | 13 +++++++++
 arch/x86/kernel/fpu/xstate.h       |  1 +
 arch/x86/kernel/signal.c           | 40 +++++++++++++++++++++------
 arch/x86/kernel/signal_32.c        |  8 +++---
 arch/x86/kernel/signal_64.c        |  9 +++---
 8 files changed, 101 insertions(+), 27 deletions(-)

-- 
2.39.3


