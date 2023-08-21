Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B119F783595
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjHUWZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjHUWZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:25:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC1E4;
        Mon, 21 Aug 2023 15:25:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxYfx028078;
        Mon, 21 Aug 2023 22:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=x+6ga/auxri6KFaLH62hrqAjdnfX5pv1RCcw3nGBDVs=;
 b=dLSBb7S9E/l+7TL0Df6sMB5XjROiE0M/GVKcRaLLWt1NzFLu7urw+1IM7/y+DoAxZbXW
 DsNI+SuscGo3p2OZxh21LxAXDFlyeEMF+JWQ8uiAMzzCj4uaUjIpjbC/c1iZYI1V5TeL
 LpzV2UgRKfeQrloLaKjFogzj5xwOSYVaflpOTQWCgz2BtzNOaVs/8LJj0F03mMtExUTJ
 xWV7wZPTnHgGZIBZ2J2AQSbw7tuT7Ij7/PC3VyZUuQ7NhzHiH1YW1l0hEXrRmEzIuFH5
 glyMN8weOHHiG5ztLOvRxV9bYaPVVqsax//BEDXjXLNsPrrZkLoCxfGWOvm8MqNRTNgv CQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjp9ubxbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:25:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LM2Gh1017778;
        Mon, 21 Aug 2023 22:25:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm6aj7wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:25:16 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LMPFMH026555;
        Mon, 21 Aug 2023 22:25:15 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sjm6aj7vw-1;
        Mon, 21 Aug 2023 22:25:15 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: Re: [PATCH v2] scsi: ufs: ufs-qcom: clear qunipro_g4_sel for HW major version > 5
Date:   Mon, 21 Aug 2023 18:25:10 -0400
Message-Id: <169265669017.715819.6777943804485890015.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821-topic-sm8x50-upstream-ufs-major-5-plus-v2-1-f42a4b712e58@linaro.org>
References: <20230821-topic-sm8x50-upstream-ufs-major-5-plus-v2-1-f42a4b712e58@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=548 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210206
X-Proofpoint-ORIG-GUID: HOMIamXOJBJehfSpmucNIgN7M5P4r6mj
X-Proofpoint-GUID: HOMIamXOJBJehfSpmucNIgN7M5P4r6mj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 14:11:21 +0200, Neil Armstrong wrote:

> The qunipro_g4_sel clear is also needed for new platforms with
> major version > 5, fix the version check to take this in account.
> 
> 

Applied to 6.5/scsi-fixes, thanks!

[1/1] scsi: ufs: ufs-qcom: clear qunipro_g4_sel for HW major version > 5
      https://git.kernel.org/mkp/scsi/c/c422fbd5cb58

-- 
Martin K. Petersen	Oracle Linux Engineering
