Return-Path: <linux-kernel+bounces-98860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D32878065
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE9E1F222B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2893E489;
	Mon, 11 Mar 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aB0Qh6IM"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D43C47D;
	Mon, 11 Mar 2024 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163259; cv=none; b=VD5RM5yb4rtA1z6COX3owDZV45F9M02EV1OxIG6WZyYmJRhVJgoabYgRDEuSQRAw53zroc7sg4Fl9sTUD/Vucj/PWXXaWzGI5hcYbItFSKwzdXUulYRlXGqq4dkBQH47zuGcGiEEKAMN0Va4qZu978glLjeynOUKuYWBHHvTstA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163259; c=relaxed/simple;
	bh=L8tgnmjJu0pZA9NyfyfkDIi6Ml7LyUf1NDZqAO2rndM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNTbvZEkNBpEBZFCBQDVSJsBLzCP4kfqocSTNypu1cFAppsYx68pW2SiGX3KQn47b5fLcNhJwmU57Psl3rHXXxdGhnnnEitvXe6uhVO73447KlxIL10Xx/4+hVXLTPj/WeUr4E4QPw1j7Uq8bo01d1kYcmqwDP4hS3Nsw7KYPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aB0Qh6IM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BCI8Jw005870;
	Mon, 11 Mar 2024 13:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Bi0JfFIbxmrcO+JuI0s9tGF/rGitvqCliyhjBRUI4WQ=;
 b=aB0Qh6IMn9z1nanQJpB/CND3ub4ikrLKpxlETU57Cnau4ghjmEUdxP5m73op+JTLZIfN
 ywT338ZmIyPLt1JbGrxyGyyUZYjjTuhKraxGsjGMnnu1yMd5g+S7aA1k+743nEBO783r
 /XU1DrDoUzoIl0I1Rr/s9wlgFvAl0d5UOPdbFYsXm8uN8U60S1uUSTouNJqJ9YHQBNFh
 ikc/xwpUEsIHZWeVPrdpp6uxiR0TGcuEnxt44NCByexrxJZLz2ZikSzEKKRzjOvxyc8A
 egQma2RZg5N4GkbKp5jaYJvsO62CLngjT7TtclDKwtOjgPEQtKCre418X34QppPZFkIm LA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt1ub18s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 13:20:46 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BCdvp5002135;
	Mon, 11 Mar 2024 13:20:46 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt1ub18rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 13:20:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42BCWaqc018575;
	Mon, 11 Mar 2024 13:20:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t1r7d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 13:20:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BDKfLL49873394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 13:20:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A692F58052;
	Mon, 11 Mar 2024 13:20:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0944F5806B;
	Mon, 11 Mar 2024 13:20:41 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 13:20:40 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, rnsastry@linux.ibm.com,
        peterhuewe@gmx.de, viparash@in.ibm.com, devicetree@vger.kernel.org,
        jsnitsel@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH v2 0/3] Preserve TPM log across kexec
Date: Mon, 11 Mar 2024 09:20:27 -0400
Message-ID: <20240311132030.1103122-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xr-xHkLmF9h3KYaSDuSM45usL_Xs_Pz6
X-Proofpoint-ORIG-GUID: jSeJUwI5ej7dkFGgywgbufOlky76KrWw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1011
 bulkscore=0 mlxlogscore=736 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110100

This series resolves an issue on PowerVM and KVM on Power where the memory
the TPM log was held in may become inaccessible or corrupted after a kexec
soft reboot. The solution on these two platforms is to store the whole log
in the device tree because the device tree is preserved across a kexec with
either of the two kexec syscalls.

Regards,
   Stefan

v2:
 - Added DT bindings patch (2/3)
 - Reformulated commit messages and addded Fixes tags
 - Follow Michael's suggestion on prom_init patch (1/3)

Stefan Berger (3):
  powerpc/prom_init: Replace linux,sml-base/sml-size with linux,sml-log
  dt-bindings: tpm: Add linux,sml-log to ibm,vtpm.yaml
  tpm: of: If available use linux,sml-log to get the log and its size

 .../devicetree/bindings/tpm/ibm,vtpm.yaml     | 20 +++++++++--
 .../devicetree/bindings/tpm/tpm-common.yaml   | 14 +++++++-
 arch/powerpc/kernel/prom_init.c               | 27 +++++++++-----
 drivers/char/tpm/eventlog/of.c                | 36 ++++++-------------
 4 files changed, 61 insertions(+), 36 deletions(-)

-- 
2.43.0


