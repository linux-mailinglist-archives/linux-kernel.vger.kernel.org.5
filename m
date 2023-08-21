Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D28D7835B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjHUW26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjHUW25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:28:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9226C127;
        Mon, 21 Aug 2023 15:28:29 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxJOZ031473;
        Mon, 21 Aug 2023 22:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=8Eb54utV3xTuLY6gBZBYXR36sF5WOla9WSuw5Z8Zw1g=;
 b=HbOyz66JDT+PR9rvqpC/YubLpxcRukmMW5woeGubLebebjb1YN+VXmqnyJjpv1+ewXtv
 6bGyiAchBJzFVCriewiH3uQj+nZ0Uw8nG8dyHtv9IWnnodZfC9WcgmudmqRhWcuEBSXQ
 rmFc7Cs8Il1uWq99ybMSsmRThb/NqUUXEh02gBb99dneQtQKci9Vb89t5cRM/KlyDjGQ
 ZW1jrYIZPJontpIvH9UjTpxNd4pyt3HAu/d0VVDHzUohQl/gmp9lYjWiDAN+G2l872Ut
 9zdYBUntGT0QIwZwIAbbk/nwmm5eC8DkotB8eZ6cWad50MPksZQrg1HdVofgFk1/WR2H Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnscc1w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:27:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LM5ULd029855;
        Mon, 21 Aug 2023 22:27:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm6ajb6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:27:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LMRiS3021660;
        Mon, 21 Aug 2023 22:27:45 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sjm6ajb5m-3;
        Mon, 21 Aug 2023 22:27:45 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     powen.kao@mediatek.com, bvanassche@acm.org,
        alim.akhtar@samsung.com, adrian.hunter@intel.com,
        jejb@linux.ibm.com, stanley.chu@mediatek.com,
        asutoshd@codeaurora.org, quic_cang@quicinc.com, mani@kernel.org,
        beanhuo@micron.com, ebiggers@google.com, agross@kernel.org,
        Arthur.Simchaev@wdc.com, konrad.dybcio@linaro.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        quic_ziqichen@quicinc.com, quic_nguyenb@quicinc.com,
        quic_narepall@quicinc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 0/2] Fix hibern8 enter failure during host reset
Date:   Mon, 21 Aug 2023 18:27:38 -0400
Message-Id: <169265683480.715970.14573327240844184320.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726134140.7180-1-quic_nitirawa@quicinc.com>
References: <20230726134140.7180-1-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=852
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210206
X-Proofpoint-GUID: iGpYBKveDISno3lA3OV41w2OhRly0HVz
X-Proofpoint-ORIG-GUID: iGpYBKveDISno3lA3OV41w2OhRly0HVz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 19:11:38 +0530, Nitin Rawat wrote:

> Changes from V1:
> - Updated commit description to explain the patch.
> - Added Co-developed-by tag.
> 
> Nitin Rawat (2):
>   scsi: ufs: core: Export ufshcd_is_hba_active
>   scsi: ufs: ufs-qcom: check host controller state
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/2] scsi: ufs: core: Export ufshcd_is_hba_active
      https://git.kernel.org/mkp/scsi/c/548fdf771b8e
[2/2] scsi: ufs: ufs-qcom: check host controller state
      https://git.kernel.org/mkp/scsi/c/21f04fb4e8ca

-- 
Martin K. Petersen	Oracle Linux Engineering
