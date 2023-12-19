Return-Path: <linux-kernel+bounces-4591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB14817FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6399E2854AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ACA11710;
	Tue, 19 Dec 2023 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cdT+XJu+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8685386;
	Tue, 19 Dec 2023 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0JSer018729;
	Tue, 19 Dec 2023 02:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=8hgMui5IfrlicjH5IV7rxovhTxySQYdDHIh8ZaptdKw=;
 b=cdT+XJu+r5HVYSB3qHXEU1Nrn9ldS8VeMKo65n7klSOW6PQ5OULrNbpg7HDnHF+1dNIl
 A05nu3YndZCElC8Gzaf7EmxeSyLqRTkae20vs+i4UYXoI8DNZgA/ZJATgGh1UZFQdmUl
 GD4817CYdBvN+n2FZHtLoLmPIIHPGV7Qmdoo6csDvOEsGx507R09S+UYFxMNLN23w91f
 ujiqXNTncGLThDifM2hSLvD6TTOD2iEp/hGlnwfYcauuah21HV/5ApEJlg/k4W8nv9EI
 C797aNtQzA6Q9XLYknLnl912YVX+/UbKH8IORZX2mEpqP3cxlNyEM9j/x2M97HmJ1LkF 1w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13guctfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ1Mf62028151;
	Tue, 19 Dec 2023 02:19:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bc5j4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:46 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJ2EbhV009328;
	Tue, 19 Dec 2023 02:19:46 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3v12bc5j3x-2;
	Tue, 19 Dec 2023 02:19:45 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, jejb@linux.ibm.com, quic_asutoshd@quicinc.com,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chanwoo Lee <cw9316.lee@samsung.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, grant.jung@samsung.com,
        jt77.jang@samsung.com, dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: Re: [PATCH v3] scsi: ufs: qcom: Return ufs_qcom_clk_scale_*() errors in ufs_qcom_clk_scale_notify()
Date: Mon, 18 Dec 2023 21:19:36 -0500
Message-ID: <170295223232.2870516.2257248057089025297.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231215003812.29650-1-cw9316.lee@samsung.com>
References: <CGME20231215003817epcas1p21127357982772ebe0e84b86f20115186@epcas1p2.samsung.com> <20231215003812.29650-1-cw9316.lee@samsung.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=931 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190017
X-Proofpoint-ORIG-GUID: Z8tp9hmbYYjBv9iaE6IqJ6jcI_MvoyEG
X-Proofpoint-GUID: Z8tp9hmbYYjBv9iaE6IqJ6jcI_MvoyEG

On Fri, 15 Dec 2023 09:38:12 +0900, Chanwoo Lee wrote:

> In commit 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")
> the error handling was accidentally changed, resulting in the error of
> ufs_qcom_clk_scale_*() calls not being returned.
> 
> This is the case I checked.
> * ufs_qcom_clk_scale_notify -> 'ufs_qcom_clk_scale_up_/down_pre_change' error -> return 0;
> 
> [...]

Applied to 6.7/scsi-fixes, thanks!

[1/1] scsi: ufs: qcom: Return ufs_qcom_clk_scale_*() errors in ufs_qcom_clk_scale_notify()
      https://git.kernel.org/mkp/scsi/c/9264fd61e628

-- 
Martin K. Petersen	Oracle Linux Engineering

