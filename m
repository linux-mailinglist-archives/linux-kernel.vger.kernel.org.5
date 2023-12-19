Return-Path: <linux-kernel+bounces-4588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE9817FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4267EB24850
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367AC120;
	Tue, 19 Dec 2023 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ls8p68p9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888211FDE;
	Tue, 19 Dec 2023 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0ItNs024921;
	Tue, 19 Dec 2023 02:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=k5vEHErutD0gy4pCpI9WFNK0fAqydSWVzvIEwzBuSLg=;
 b=Ls8p68p9ihAFoS3W7hEmqP8rtLKiRW4c3julSycqlPCX1wiebJvDMaqAmfXbBY2JSEif
 ub2iOCZPpTv3lRye7KZQ1q4XJ0LRQr/6XM+MJCmDhsXpsobZbswvIQYk3gWT/WZc8zir
 sBMCOWtjC6fFTHNoAh1yAgtnC82lEb5cCml4Hbwq1lCzj787iOoXwfIzjvgo/llHLDSl
 kCmjHZ3B77y7nsHi9btHwBMAVNg8zGAfa3mmTmGUiJx71USa4mIj4KBHtgTNW5iCdJr0
 E0dxU3nLFP9xm2sQqUp2OWRVVhNkZMHHIBfbRJA/5xxVJ8xAS39la6puwXKjdigEfl8/ iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p44ung-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0nYPj020993;
	Tue, 19 Dec 2023 02:19:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b69taj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:18 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJ2J7ZH012682;
	Tue, 19 Dec 2023 02:19:17 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b69t3t-8;
	Tue, 19 Dec 2023 02:19:17 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: jejb@linux.ibm.com, Manivannan Sadhasivam <mani@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, ahalaney@redhat.com, quic_nitirawa@quicinc.com
Subject: Re: [PATCH v2 00/17] scsi: ufs: qcom: Code cleanups
Date: Mon, 18 Dec 2023 21:18:52 -0500
Message-ID: <170294822180.2675590.5345670755175208640.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
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
 mlxlogscore=967 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190017
X-Proofpoint-GUID: V8zZqrkJPe_YcHhkC9yiH4vSd067Nl3p
X-Proofpoint-ORIG-GUID: V8zZqrkJPe_YcHhkC9yiH4vSd067Nl3p

On Fri, 08 Dec 2023 12:28:45 +0530, Manivannan Sadhasivam wrote:

> This series has code some cleanups to the Qcom UFS driver. No functional
> change. In this version, I've removed code supporting legacy controllers
> ver < 2.0, as the respective platforms were never supported in upstream.
> 
> Tested on: RB5 development board based on Qcom SM8250 SoC.
> 
> - Mani
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[01/17] scsi: ufs: qcom: Use clk_bulk APIs for managing lane clocks
        https://git.kernel.org/mkp/scsi/c/9caef8568831
[02/17] scsi: ufs: qcom: Fix the return value of ufs_qcom_ice_program_key()
        https://git.kernel.org/mkp/scsi/c/3bf7ab4ac30c
[03/17] scsi: ufs: qcom: Fix the return value when platform_get_resource_byname() fails
        https://git.kernel.org/mkp/scsi/c/3a747c5cf9b6
[04/17] scsi: ufs: qcom: Remove superfluous variable assignments
        https://git.kernel.org/mkp/scsi/c/1f165c87ec3e
[05/17] scsi: ufs: qcom: Remove the warning message when core_reset is not available
        https://git.kernel.org/mkp/scsi/c/d42d368647da
[06/17] scsi: ufs: qcom: Export ufshcd_{enable/disable}_irq helpers and make use of them
        https://git.kernel.org/mkp/scsi/c/0ae7a02726bc
[07/17] scsi: ufs: qcom: Fail ufs_qcom_power_up_sequence() when core_reset fails
        https://git.kernel.org/mkp/scsi/c/d11954711499
[08/17] scsi: ufs: qcom: Check the return value of ufs_qcom_power_up_sequence()
        https://git.kernel.org/mkp/scsi/c/e430c0e08957
[09/17] scsi: ufs: qcom: Remove redundant error print for devm_kzalloc() failure
        https://git.kernel.org/mkp/scsi/c/8291652ed8a2
[10/17] scsi: ufs: qcom: Use dev_err_probe() to simplify error handling of devm_gpiod_get_optional()
        https://git.kernel.org/mkp/scsi/c/c7afadacc180
[11/17] scsi: ufs: qcom: Remove unused ufs_qcom_hosts struct array
        https://git.kernel.org/mkp/scsi/c/e7458beab809
[12/17] scsi: ufs: qcom: Sort includes alphabetically
        https://git.kernel.org/mkp/scsi/c/be2e06c81a31
[13/17] scsi: ufs: qcom: Initialize cycles_in_1us variable in ufs_qcom_set_core_clk_ctrl()
        https://git.kernel.org/mkp/scsi/c/3b60f4564ff5
[14/17] scsi: ufs: qcom: Simplify ufs_qcom_{assert/deassert}_reset
        https://git.kernel.org/mkp/scsi/c/6b481af25ec0
[15/17] scsi: ufs: qcom: Remove support for host controllers older than v2.0
        https://git.kernel.org/mkp/scsi/c/104cd58d9af8
[16/17] scsi: ufs: qcom: Use ufshcd_rmwl() where applicable
        https://git.kernel.org/mkp/scsi/c/0e9f4375db1c
[17/17] scsi: ufs: qcom: Remove unused definitions
        https://git.kernel.org/mkp/scsi/c/cac50d04fffe

-- 
Martin K. Petersen	Oracle Linux Engineering

