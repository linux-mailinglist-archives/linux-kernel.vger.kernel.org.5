Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F08E787CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbjHYBOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbjHYBNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:13:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D211BFE;
        Thu, 24 Aug 2023 18:13:50 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEYkA027002;
        Fri, 25 Aug 2023 01:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=FXNAfQ1sSnPTtxWjoAgyebo/Q9fbzPL7FS3hI1W4YqY=;
 b=gxXKo75TnW8daUIr4ghPvkVfrY/6oENAZ741P9ZMN14yuLqdNamaxw0wzIjR25iEltcM
 ouWQ9KNWouHU5VvnrGwQ0GOSoDZg4gaiputcyb95jEAp4WsrwJ2vPE2cCvUL2OgZG4/5
 9bEEzrz3IhvRDnK6H3Q799fY52WdJbuaGyECY5cFsnpUm40WoDsnIauNv9g3oKHkcLFw
 SHzZBlzLI/TQoulPjy7ttsAwSe6TMPLELa8jNcjnV8DgcQJq5s2NZ9g2XBb0QNkjdTP+
 9np9J9Jpni/X/AG8FkFW5SMwpLCaq6IM2QBIRvsYZP1tPh29axmbeYgGIIIdlsUbQRSL bA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20ddcts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37P0LhLn036104;
        Fri, 25 Aug 2023 01:13:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywqfjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P1DVE2019787;
        Fri, 25 Aug 2023 01:13:37 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywqf8n-5;
        Fri, 25 Aug 2023 01:13:37 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, Brian Masney <bmasney@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com, quic_nguyenb@quicinc.com
Subject: Re: [PATCH v3 0/2] scsi: ufs: convert probe to use dev_err_probe()
Date:   Thu, 24 Aug 2023 21:12:51 -0400
Message-Id: <169292577158.789945.10019219783707017391.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814184352.200531-1-bmasney@redhat.com>
References: <20230814184352.200531-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=899 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250009
X-Proofpoint-GUID: t2mhmuA9VlgmG_HMiO-uZMyzYmB6_Pcg
X-Proofpoint-ORIG-GUID: t2mhmuA9VlgmG_HMiO-uZMyzYmB6_Pcg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 14:43:50 -0400, Brian Masney wrote:

> The following two log messages are shown on bootup due to an
> -EPROBE_DEFER when booting on a Qualcomm sa8775p development board:
> 
>     ufshcd-qcom 1d84000.ufs: ufshcd_variant_hba_init: variant qcom init
>         failed err -517
>     ufshcd-qcom 1d84000.ufs: Initialization failed
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/2] scsi: ufs: core: convert to dev_err_probe() in hba_init
      https://git.kernel.org/mkp/scsi/c/137523237172
[2/2] scsi: ufs: host: convert to dev_err_probe() in pltfrm_init
      https://git.kernel.org/mkp/scsi/c/517f8eb3fa64

-- 
Martin K. Petersen	Oracle Linux Engineering
