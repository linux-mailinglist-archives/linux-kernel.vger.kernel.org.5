Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8CE762885
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGZCGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGZCGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:06:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFE2121;
        Tue, 25 Jul 2023 19:06:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJISc9025724;
        Wed, 26 Jul 2023 02:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=GczAHi1nw468rSxodTKpEIcFvWhoCEa0bsGuATtQoO8=;
 b=fAohI5291MSEt6rNTbvAdhjb4xxuFZa+xlraVDK/MeF7mCsK47fNjrt2xyTqNLv/XExG
 CZjS8n9/GgQrIwWMf4IgMoyMlqzsACjT8oSTZIMgEQ2K6y5iQq3+6oIxtogP04jwiJ1i
 y7Jq3EG3l0HjM2QcEC7OE37uWy16+Aj7PZO/RaDPQ2mF6xj8MliIdBeSyOnESaZMUYQd
 oHMR8NK2HbqsubgirauQDJWV2la+NzHkuq1/lH76BEEwQa4D/iA4FZTqelmY3mHgPWR4
 Jd0jn4qYhPYzIIXffZesWP1rx5g0CiibeQhx9HMVe2+fHTgePOhf9L9xyAepbfEyMQhy tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d6fvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 02:05:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q0G7po023017;
        Wed, 26 Jul 2023 02:05:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j5jd4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 02:05:17 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36Q253Nh038905;
        Wed, 26 Jul 2023 02:05:16 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3s05j5jcwf-9;
        Wed, 26 Jul 2023 02:05:16 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, quic_nitirawa@quicinc.com,
        Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scsi: ufs: qcom: Get queue ID from MSI index in ESI handler
Date:   Tue, 25 Jul 2023 22:04:54 -0400
Message-Id: <169033702306.2256288.1829460658983198898.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1689062349-77385-1-git-send-email-quic_ziqichen@quicinc.com>
References: <1689062349-77385-1-git-send-email-quic_ziqichen@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260016
X-Proofpoint-ORIG-GUID: 9X7kyfQvS3VUWg5GfJE9Z7HOjoUNTQpM
X-Proofpoint-GUID: 9X7kyfQvS3VUWg5GfJE9Z7HOjoUNTQpM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 15:59:08 +0800, Ziqi Chen wrote:

> platform_msi_domain_alloc_irqs() does not always get consecutive
> IRQ numbers, hence queue IDs calculated out from IRQ numbers may
> be incorrect if we assume IRQ numbers are consecutive. Fix it by
> passing msi_desc to ESI handler to use msi_desc->msi_index as
> queue ID.
> 
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: ufs: qcom: Get queue ID from MSI index in ESI handler
      https://git.kernel.org/mkp/scsi/c/8f2b78652d05

-- 
Martin K. Petersen	Oracle Linux Engineering
