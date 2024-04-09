Return-Path: <linux-kernel+bounces-136170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606AE89D0C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A9C1C2386F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F371684A30;
	Tue,  9 Apr 2024 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hn3+AGLB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F14754BE2;
	Tue,  9 Apr 2024 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632174; cv=none; b=P2UwQ7Ddjzfs9uHA9RLbD+MCY9FaUMCpFKruvTxj/mFldZ7pLAtSPkDRsMvUAAbYgpjjig0HurfO9wDY2M/pY3mC6HFWmex3HXX5zuy/cGMxntDaEq7ZEOfXwVI05wP2D8O6YqCe1lI71e6L4JHfH5jDLJ8cjv+1Sfm9mGUfxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632174; c=relaxed/simple;
	bh=+d2FuWyDyp09SFgcbLLZEoMRw7nq4tWkjra5cuFOu8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8wH5c+RdtnZkXzOd2OjDY0foPe0H+zEf+fYwZSlC0cEVRm59fyw0tT2iS2+YFkHKc54Xy5aOE/N5wq2+zgFr4mYZZcoVhyFe2Sk300tiu/13wWkINFEcBbgCo0CY+9m/sdvQyLFjGyn87CFPn5DfbOFZ3tiNCthjSCf7HGbdn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hn3+AGLB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LnN46007102;
	Tue, 9 Apr 2024 03:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=sZ1T5BLLnRnaU+VrTMjmxep2SuyqJDIfOmX4eCPgS54=;
 b=Hn3+AGLBGvF2SoKaqvRdXOHZj0RU/dwZmGUc58sKDaVR7FbXLjKXC0cCUG5PvEpBeqQF
 /ECb8yeLhZZ2leAX0qJvZkYXt60mHTGkazDLJwzzCbfiiNyc3pMJsTGeu4DEYxvGcEBf
 wCG8uu5xptkHGHDKuoXyjme757Kx1qdX7lFUfUXwoqXtG6oCS4sw1FLuBXOfcMs1YBlC
 ZDXDFX5b7v7Truhu4ULRKP7UAvuZCQrIs/bEOeVWePtslAGTAStxrU0rOcNHrcYZYnOu
 U/zHehIMyb7FSh2CLQP3L9oNFedgj0tkpNpj4jgCdRfLQVhHTJB+IdlvLvmfn2GAhVhS dA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvc3mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4392jUwN020051;
	Tue, 9 Apr 2024 03:09:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuca6e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:03 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439392F9012913;
	Tue, 9 Apr 2024 03:09:02 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavuca6e1-1;
	Tue, 09 Apr 2024 03:09:02 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Janek Kotas <jank@cadence.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Can Guo <quic_cang@quicinc.com>,
        Anjana Hari <quic_ahari@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v5 00/11] scsi: ufs: Remove overzealous memory barriers
Date: Mon,  8 Apr 2024 23:08:50 -0400
Message-ID: <171260277842.3109929.9923224974042628325.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404090018
X-Proofpoint-ORIG-GUID: mW8gE__06lOifSzNR_qbiKmZGzojZv1-
X-Proofpoint-GUID: mW8gE__06lOifSzNR_qbiKmZGzojZv1-

On Fri, 29 Mar 2024 15:46:42 -0500, Andrew Halaney wrote:

> Please review with care as I'm not all that confident in this subject.
> UFS has a lot of mb() variants used, most with comments saying "ensure this
> takes effect before continuing". mb()'s aren't really the way to
> guarantee that, a read back is the best method.
> 
> Some of these though I think could go a step further and remove the mb()
> variant without a read back. As far as I can tell there's no real reason
> to ensure it takes effect in most cases (there's no delay() or anything
> afterwards, and eventually another readl()/writel() happens which is by
> definition ordered). Some of the patches in this series do that if I was
> confident it was safe (or a reviewer pointed out prior that they thought
> it was safe to do so).
> 
> [...]

Applied to 6.10/scsi-queue, thanks!

[01/11] scsi: ufs: qcom: Perform read back after writing reset bit
        https://git.kernel.org/mkp/scsi/c/c4d28e06b0c9
[02/11] scsi: ufs: qcom: Perform read back after writing REG_UFS_SYS1CLK_1US
        https://git.kernel.org/mkp/scsi/c/a862fafa263a
[03/11] scsi: ufs: qcom: Remove unnecessary mb() after writing testbus config
        https://git.kernel.org/mkp/scsi/c/95d26dda90df
[04/11] scsi: ufs: qcom: Perform read back after writing unipro mode
        https://git.kernel.org/mkp/scsi/c/823150ecf04f
[05/11] scsi: ufs: qcom: Perform read back after writing CGC enable
        https://git.kernel.org/mkp/scsi/c/d9488511b3ac
[06/11] scsi: ufs: cdns-pltfrm: Perform read back after writing HCLKDIV
        https://git.kernel.org/mkp/scsi/c/b715c55daf59
[07/11] scsi: ufs: core: Perform read back after writing UTP_TASK_REQ_LIST_BASE_H
        https://git.kernel.org/mkp/scsi/c/408e28086f1c
[08/11] scsi: ufs: core: Perform read back after disabling interrupts
        https://git.kernel.org/mkp/scsi/c/e4a628877119
[09/11] scsi: ufs: core: Perform read back after disabling UIC_COMMAND_COMPL
        https://git.kernel.org/mkp/scsi/c/4bf3855497b6
[10/11] scsi: ufs: core: Remove unnecessary wmb() after ringing doorbell
        https://git.kernel.org/mkp/scsi/c/d3fb9a24a602
[11/11] scsi: ufs: core: Remove unnecessary wmb() prior to writing run/stop regs
        https://git.kernel.org/mkp/scsi/c/356a8ce7cd50

-- 
Martin K. Petersen	Oracle Linux Engineering

