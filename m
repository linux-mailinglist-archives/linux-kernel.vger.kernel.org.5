Return-Path: <linux-kernel+bounces-43824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9E84193B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5861C25025
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8604F3771C;
	Tue, 30 Jan 2024 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WB1Y19pC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646EB364D2;
	Tue, 30 Jan 2024 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581654; cv=none; b=jFNVZeZps+35nsxr4RJYfUb7kbYSaNrW0umDrZYFmtS1nZWhS5jbjKTfYOwfBUodQwaA6DneCFFdm7aLoOc2Va8ChVepQ9+GHpJ/kiMdeyXyWIEWweiHr55nmGrxeDGPkfPUynirruHNaGkiypManfSPUoyq+2smYwN4QlFz8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581654; c=relaxed/simple;
	bh=W1lbuevOg4lz80k4e+i9bIkNJZ2002FG6iFJ013m188=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4PoZE6dLUSPtPKkvAEuZuLwYwciUYgcHaqyZ1v3nrsn4LyrLLtc1whtg3EKtBb0Ybrif8Iv3vJxxUep9WB0pA98xrlVecD90MrLTFHIXeEe+4DGKjIIngsjw2a4vf9q54rWhKTL2LJa74JtC685DMjXaVNRusdLdxDqgKt339E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WB1Y19pC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJiSsY007793;
	Tue, 30 Jan 2024 02:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=M6ttjQYwKrto5D2RHLbTN3mnyU+mC7uKIL6Z00W0Jkg=;
 b=WB1Y19pCDjUKaGVaSzXEqmRNkO6oEzmKCxqCOYXOg1+bPbc3w5b9aoseJjI6XAzVPFmF
 SBATm2+5E1jdWdyPHHkaRFiBw6GYb/+T34iBtsuA1XwBgjZL81cC+42RWE3QW0NQVMZ5
 fGtO84MkTdFDhaT+AUCGpoEXUkyQslva4q+sDCV/+yvQALgo7MWNN8YDwetiA4UkIweK
 Pv1NNBAFnv4jmjy2d4Gz9UxncessXW/LbldICopirZQNgNYN7XX9g37CB93qaGlLYcVp
 fVkVWor0uHSKjt6A6vH51Jd8s/iMcseIm1yGRJyOalnGMdZO0HYI43JloWudc0/TNEiN ZA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuwft1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U1au6Y014634;
	Tue, 30 Jan 2024 02:27:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96g504-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40U2RPxi040916;
	Tue, 30 Jan 2024 02:27:27 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr96g4y7-3;
	Tue, 30 Jan 2024 02:27:27 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Chandrakanth patil <chandrakanth.patil@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: megaraid: remove redundant assignment to variable retval
Date: Mon, 29 Jan 2024 21:26:59 -0500
Message-ID: <170657812674.784857.7579326201557441300.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240118121441.2533620-1-colin.i.king@gmail.com>
References: <20240118121441.2533620-1-colin.i.king@gmail.com>
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
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=879 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300015
X-Proofpoint-ORIG-GUID: W7Nd81WSNvuI_R4H-0335ZCahUDBeS7e
X-Proofpoint-GUID: W7Nd81WSNvuI_R4H-0335ZCahUDBeS7e

On Thu, 18 Jan 2024 12:14:41 +0000, Colin Ian King wrote:

> The variable retval is being assigned a value that is not being
> read afterwards. The assignment is redundant and can be removed.
> 
> Cleans up clang scan warning:
> Although the value stored to 'retval' is used in the enclosing
> expression, the value is never actually read from 'retval'
> [deadcode.DeadStores]
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: megaraid: remove redundant assignment to variable retval
      https://git.kernel.org/mkp/scsi/c/9759cdc1bcb8

-- 
Martin K. Petersen	Oracle Linux Engineering

