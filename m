Return-Path: <linux-kernel+bounces-4590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1456817FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F48E2854AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4CC11728;
	Tue, 19 Dec 2023 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QomB89D6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5681171C;
	Tue, 19 Dec 2023 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0J5gE025044;
	Tue, 19 Dec 2023 02:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=yskQ78r92q5mG7d7jw1QYsnF+XyPla4428Cx+87LW3E=;
 b=QomB89D6f5LlqFMVBaOPi0AdjjWHJkQoESPWq74yjiQVyIdrOwYQirB+JW35XOmn+1+X
 n+/02fRbTfEutLi+oJGTwhlAWCALGstf20wIT6bGSmJo1Z6PzN0p+f7+fpL4Cm+QlCyk
 DC9Ij52InR8T/+qxKQ1U1F+sBK1su6wISLvQCFwrl7k61XUNy5LBwZpbs7qjsuRzNcWP
 1H+yxdrjwpguqYWCwg+gJ6nca1SUQxYpV5usTp8XICAWLc/0e9Yl43/qpQ5QOLtrIgMR
 aBpF76hWbaiXHjE7zqJFUfkhhtxDMxWXVxyrtNaW9SPwbsedcfpGyH3Z1ct6kQUnQv7t Fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p44unn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0soGd020909;
	Tue, 19 Dec 2023 02:19:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b69tb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:20 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJ2J7ZJ012682;
	Tue, 19 Dec 2023 02:19:19 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b69t3t-9;
	Tue, 19 Dec 2023 02:19:19 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com,
        vkoul@kernel.org, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, Can Guo <quic_cang@quicinc.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 00/10] Enable HS-G5 support on SM8550
Date: Mon, 18 Dec 2023 21:18:53 -0500
Message-ID: <170294822172.2675590.9852477289938557441.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
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
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190017
X-Proofpoint-GUID: hFRgHiHplc8Oh0bXvqh80-vFWM6K9nTY
X-Proofpoint-ORIG-GUID: hFRgHiHplc8Oh0bXvqh80-vFWM6K9nTY

On Sat, 02 Dec 2023 04:36:06 -0800, Can Guo wrote:

> This series enables HS-G5 support on SM8550.
> 
> This series is rebased on below changes from Mani -
> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-1-manivannan.sadhasivam@linaro.org/
> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-2-manivannan.sadhasivam@linaro.org/
> 
> This series is tested on below HW combinations -
> SM8550 MTP + UFS4.0
> SM8550 QRD + UFS3.1
> SM8450 MTP + UFS3.1 (for regression test)
> SM8350 MTP + UFS3.1 (for regression test)
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[01/10] scsi: ufs: host: Rename structure ufs_dev_params to ufs_host_params
        https://git.kernel.org/mkp/scsi/c/fa3dca8251c4
[02/10] scsi: ufs: ufs-qcom: No need to set hs_rate after ufshcd_init_host_param()
        https://git.kernel.org/mkp/scsi/c/dc604b4c9d60
[03/10] scsi: ufs: ufs-qcom: Setup host power mode during init
        https://git.kernel.org/mkp/scsi/c/55820a7f2cb9
[04/10] scsi: ufs: ufs-qcom: Allow the first init start with the maximum supported gear
        https://git.kernel.org/mkp/scsi/c/743e1f596ccc
[05/10] scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts with HW version 5
        https://git.kernel.org/mkp/scsi/c/9d8528a833fc
[06/10] scsi: ufs: ufs-qcom: Set initial PHY gear to max HS gear for HW ver 4 and newer
        https://git.kernel.org/mkp/scsi/c/0bd3cb895d19
[07/10] scsi: ufs: ufs-qcom: Check return value of phy_set_mode_ext()
        https://git.kernel.org/mkp/scsi/c/a68abdadfe13
[08/10] scsi: ufs: ufs-qcom: Add support for UFS device version detection
        https://git.kernel.org/mkp/scsi/c/dc7c948d74e1

-- 
Martin K. Petersen	Oracle Linux Engineering

