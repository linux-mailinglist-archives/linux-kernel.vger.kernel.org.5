Return-Path: <linux-kernel+bounces-4587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC77817FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB0C1F2490F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D89FAD4F;
	Tue, 19 Dec 2023 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S25VWntF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528A17F7;
	Tue, 19 Dec 2023 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0J0Hq017111;
	Tue, 19 Dec 2023 02:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=Jh0ViTVYp6UFQesVXkY41TyQl2OU8MR9EOAY47CdiIk=;
 b=S25VWntFp2LXuw5RSuq+N2SZknIPiRxHbyLbVsDIDEKBShdFk25wqP8MwyrOMC3mVOik
 Wrb/c6XYjN1Od4VOLSHXl6KQUgTHHA6Qh4jAuIOhf2tcrJb0ytMjDbfZ4IB2SbFV9ZeL
 6J2Ffq2VQ3QLwU14wNMMqP4wKDrFxl7bVpJ/9Zee9GSdW59f3OPLKi2e46bngll3uH+H
 uMwcg5NEhPAS3HUFDxP+ucI6umDHOic6RNVWBAcEZzi3OoAJIWBV+utNAuN5hSGyxSZS
 ZknbCtcGHUB8fai8rZ9PkZhhBFw3QVSL95K+PP9oOMZ0O8gDXrvVF9ppgvQNbVaF417l NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13guctec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0aVhW020992;
	Tue, 19 Dec 2023 02:19:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b69t5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:09 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJ2J7Z5012682;
	Tue, 19 Dec 2023 02:19:09 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b69t3t-2;
	Tue, 19 Dec 2023 02:19:08 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, beanhuo@micron.com, thomas@t-8ch.de,
        Bean Huo <beanhuo@iokpp.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: Re: [PATCH v5 0/3] Add UFS RTC support
Date: Mon, 18 Dec 2023 21:18:46 -0500
Message-ID: <170294822183.2675590.1544104102539771357.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212220825.85255-1-beanhuo@iokpp.de>
References: <20231212220825.85255-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_15,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=653 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190017
X-Proofpoint-ORIG-GUID: Et7fJmjzmUn1AzofuPW0C0_y7fitZcgb
X-Proofpoint-GUID: Et7fJmjzmUn1AzofuPW0C0_y7fitZcgb

On Tue, 12 Dec 2023 23:08:22 +0100, Bean Huo wrote:

> Adding RTC support for embedded storage device UFS in its driver, it is
> important for a few key reasons:
> 
> 1. Helps with Regular Maintenance:
> The RTC provides a basic way to keep track of time, making it useful for
> scheduling routine maintenance tasks in the storage device. This includes
> things like making sure data is spread
> evenly across the storage to extend its life.
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/3] scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
      https://git.kernel.org/mkp/scsi/c/9fa268875ca4
[2/3] scsi: ufs: core: Add UFS RTC support
      https://git.kernel.org/mkp/scsi/c/6bf999e0eb41
[3/3] scsi: ufs: core: Add sysfs node for UFS RTC update
      https://git.kernel.org/mkp/scsi/c/838f595a5672

-- 
Martin K. Petersen	Oracle Linux Engineering

