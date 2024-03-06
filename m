Return-Path: <linux-kernel+bounces-94202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B4873B49
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6A32813EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FB7135A5B;
	Wed,  6 Mar 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ixt6DFbe"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40781350EF;
	Wed,  6 Mar 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740535; cv=none; b=EyIO1HM7QvMVgv705cx9et2C+XJl1idOw6vd/lBrXE+WedOrujo6gihg3B38Bv7bq2prvokUKVAesLohxeLTV0wWTacPV0MO+cZJC5jLCnVghPzqn3Co+NnWl/nOgDNb3S6ERhe9z63EcoCkUFuPBVrwb31mfm8wPv9WQZLFIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740535; c=relaxed/simple;
	bh=P9DqqasGLsdiUxmaOVJCigiPRlH82rvT3TggqTmjOS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDaM7WTCkoB+FQHA/GsCQa7wXMo7iXsoIbnt2y/zUNKsOgtbMVyj3VqNhBfjGVTeVTKANJjniWyJCjDnYo2XEp3+XJU60IvwH0zJQM8Xp0vlIvsLNpPBoppEm0e3nhiygtDQtct9nvzNZLPhpvCfLfDB3ShTD5n1ebuGkAZW2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ixt6DFbe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426FoaB7028094;
	Wed, 6 Mar 2024 15:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=dqXDU606IX7tPW6Aj3a3JGsIYTkiO0MyBca1qoCZcCw=;
 b=ixt6DFbeH98kWxhcMq/MF3KKTsQ7aShD0yrXy6Vcr2OSd8mRVy+d446vXRxaBmW/Q+7E
 d5TkXusNvytNvOqVP0AZlI8LAAWqz1ufOfFPce6l/7/mxEErFbvc9hYObB2OSbl3qswA
 q7F/tDUDC90uSRH+L+jEtaFNPLa3I24eA2Y7jspH70pyxKxL+Mdp2xVaFmQf+R/ytaSO
 ukvRWn0TmN63vzK5AICg5dQzeROW1us3HnDT1myYr60Cy5O2zE9GJURskT/Pcw+JefmI
 +NaWfHxGuN6LLl/AOV6qwWSiGf5k/0vque9BItqEuFxoRrwQpK4yi2yht8Au3IA+9Qsd tw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wptj8t6rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:55:20 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426FoqH2029694;
	Wed, 6 Mar 2024 15:55:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wptj8t6r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:55:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426ExWth024185;
	Wed, 6 Mar 2024 15:55:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsavju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:55:18 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426FtEQx31326484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 15:55:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB32A58065;
	Wed,  6 Mar 2024 15:55:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E32E58063;
	Wed,  6 Mar 2024 15:55:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 15:55:14 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, rnsastry@linux.ibm.com,
        peterhuewe@gmx.de, viparash@in.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/2] Preserve TPM log across kexec
Date: Wed,  6 Mar 2024 10:55:09 -0500
Message-ID: <20240306155511.974517-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o_181VeA48Inz-Y-9-q8JknX23pZW9qR
X-Proofpoint-ORIG-GUID: w52wozKT8c3wrcTE3WBlFdhPjZH18sFk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=861 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060127

This series resolves an issue on PowerVM and KVM on Power where the memory
the TPM log was held in may become inaccessible or corrupted after a kexec
soft reboot. The solution on these two platforms is to store the whole log
in the device tree because the device tree is preserved across a kexec with
either of the two kexec syscalls.

Regards,
   Stefan

Stefan Berger (2):
  powerpc/prom_init: Replace linux,sml-base/sml-size with linux,sml-log
  tpm: of: If available Use linux,sml-log to get the log and its size

 arch/powerpc/kernel/prom_init.c |  8 ++------
 drivers/char/tpm/eventlog/of.c  | 36 ++++++++++-----------------------
 2 files changed, 13 insertions(+), 31 deletions(-)

-- 
2.43.0


