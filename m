Return-Path: <linux-kernel+bounces-33860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD5F836FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B86A1C28F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAF1495E9;
	Mon, 22 Jan 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HQU/xgY+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F138495DF;
	Mon, 22 Jan 2024 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945785; cv=none; b=Da0qI6nGe/Y5XJDrov64+YIuQ3Mml8wf8TlZ/4Aiib4ZdgSzgcx4vvnMuMhWBm2xYzwgBrgLLki4F2QIx3atKkBanCP7hCCJYdgjojvzIz4Ao54GsipkPb0csfjU+Iqvz31S7M1EyJw8ycCqV+H6SNOI2Af2F2ccg6hRXPEWCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945785; c=relaxed/simple;
	bh=SxxSWiKlLkIIdaR2lFRfvvLtPrAjR7knkdq3ntGAKIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=knQAMbI1f0eNV2HX5NitHCJG9VHtWqfTl7FtAolDgNLIzlLamxbfmluMx3ocyx/WgifOoUHZEHkiD9hAPY4KzDIaU5BTFPd2s5OV6DN+GNBQ39SDpXfPDspOMJw0wCDktpXE9jcO1lJk8bu5o+5sHGlkdCUTEWdNgGsEmUH1mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HQU/xgY+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MHOOss032448;
	Mon, 22 Jan 2024 17:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=EtTVATMRo8Tg2MeiKpn3dDX6z3G14KJlXax/0NCnrsE=;
 b=HQU/xgY+X5uQi/buZnYEV1O9TtTA+b3KKSxgkQE9MO3xmVLsXpHLn/qs4ndFkbkki9rZ
 pK6cvKIBHcmAxJ9QXKZzAkvoTrk8hu0rb0VsHsFhtwnvNeGwMY8LcuWQclk1IeGCHM7F
 Z7lpBuosa2RrgvVn9CS5Qke3DnNXFL0KRlv5E5+u3sQ2hDTX5fiVvePB2mWe+wy82t+y
 /SFNl6YQV+U57nBbmtSYT+rV9QyOGeoe9L97M3FMM+3sOChqVW5F5wUDNvigwl5mTr7t
 eFFDYXERm6WknFOC+XaEUXtVnGBWbJWHIKzcLu+uMncgwpd9KWqbaul0ESvKooaCUULk Pw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsuxaa5nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:49:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40MFkQrU026475;
	Mon, 22 Jan 2024 17:49:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgt2eet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:49:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40MHnARB27591306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 17:49:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 390B220043;
	Mon, 22 Jan 2024 17:49:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0C2620040;
	Mon, 22 Jan 2024 17:49:07 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.53.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jan 2024 17:49:07 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, mingo@kernel.org,
        peterz@infradead.org, chandan.babu@oracle.com, anton@tuxera.com,
        djwong@kernel.org
Subject: [RFC PATCH v2 0/4] remove duplicate ifdefs
Date: Mon, 22 Jan 2024 23:19:00 +0530
Message-Id: <20240122174904.178594-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -rzBX_0dIV7n-gkdJoFKiqnOb4QTrDRU
X-Proofpoint-GUID: -rzBX_0dIV7n-gkdJoFKiqnOb4QTrDRU
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
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=824 priorityscore=1501 clxscore=1011
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220124

When going through the code observed a case in scheduler,
where #ifdef CONFIG_SMP was used to inside an #ifdef CONFIG_SMP.
That didn't make sense since first one is good enough and second
one is a duplicate.

This could improve code readability. No functional change is intended.

Since this might be present in other code areas wrote a very basic
python script which helps in finding these cases. It doesn't handle any
complicated #defines or space separated "# if". At some places the
log collected had to be manually corrected due to space separated ifdefs.
Thats why its not a treewide change.
There might be an opportunity for other files as well.

Logic is very simple. If there is #ifdef or #if or #ifndef add that
variable to list. Upon every subsequent #ifdef or #if or #ifndef
check if the same variable is in the list. If yes flag
an error. Verification was done manually later checking for any #undef
or any error due to script. These were the ones that flagged out and
made sense after going through code.

More details about how the logs were collected and the script used for
processing the logs are mentioned in v1 cover letter.

v2->v1:
split the fs change into two patches as suggested by Chandan Babu R.
v1: https://lore.kernel.org/all/20240118080326.13137-1-sshegde@linux.ibm.com/

Shrikanth Hegde (4):
  sched: remove duplicate ifdefs
  xfs: remove duplicate ifdefs
  ntfs: remove duplicate ifdefs
  arch/powerpc: remove duplicate ifdefs

 arch/powerpc/include/asm/paca.h           | 4 ----
 arch/powerpc/kernel/asm-offsets.c         | 2 --
 arch/powerpc/platforms/powermac/feature.c | 2 --
 arch/powerpc/xmon/xmon.c                  | 2 --
 fs/ntfs/inode.c                           | 2 --
 fs/xfs/xfs_sysfs.c                        | 4 ----
 kernel/sched/core.c                       | 4 +---
 kernel/sched/fair.c                       | 2 --
 8 files changed, 1 insertion(+), 21 deletions(-)

--
2.39.3


