Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5304D787CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbjHYBOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbjHYBNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:13:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182FA1BF1;
        Thu, 24 Aug 2023 18:13:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEWXE007619;
        Fri, 25 Aug 2023 01:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=4ae/6jqZ7JL16wWDezb7y/sEVdIJSyLkrzQau7TBcyE=;
 b=nhXhXsLzxResYSTaIoZEaSBTmRPeAFw+gtm932xRcm2BGHbobVFZaOMI3+1gR/SYlVkb
 uadAV/453vfg58BDoPqxU7VWktusg8Qq2+ueQDRQGjt/1T8UA2Q0ljC2bVBFfJCg2Ycf
 NJmI2ORATmz+eGZiDjOfa3cbJfw7GuhwmTizoAMC0IcWLGhG0IXcQZknzihuQc+fHIM4
 wjBSYRdSjsH5gHUlpo3IBLBlgesialjz0MuMtVCgch0QUg2Kisbg+4PS7wkp2FhfVNOF
 eXL6RU6oK53Swb5w8XaknIV9NSxQkJeBUXJQT3GZ6keQIdHusimkGOcOa0RI6B9JduIR Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvwcp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37P0O6at036234;
        Fri, 25 Aug 2023 01:13:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywqfk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:39 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P1DVE6019787;
        Fri, 25 Aug 2023 01:13:38 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywqf8n-7;
        Fri, 25 Aug 2023 01:13:38 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     hare@suse.de, jejb@linux.ibm.com, bigeasy@linutronix.de,
        dave@stgolabs.net, satishkh@cisco.com, sebaddel@cisco.com,
        kartilak@cisco.com, Chengfeng Ye <dg573847474@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock
Date:   Thu, 24 Aug 2023 21:12:53 -0400
Message-Id: <169292577171.789945.18412382770051459269.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230817074708.7509-1-dg573847474@gmail.com>
References: <20230817074708.7509-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=554 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250009
X-Proofpoint-ORIG-GUID: XmGQQVrB5vdEyPBJ2KUPeWKpRQ0LllcW
X-Proofpoint-GUID: XmGQQVrB5vdEyPBJ2KUPeWKpRQ0LllcW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 07:47:08 +0000, Chengfeng Ye wrote:

> There is a long call chain that &fip->ctlr_lock is acquired by isr
> fnic_isr_msix_wq_copy() under hard irq context. Thus other process
> context code acquiring the lock should disable irq, otherwise
> deadlock could happen if the irq preempt the execution while the
> lock is held in process context on the same CPU.
> 
> [ISR]
> fnic_isr_msix_wq_copy()
>  -> fnic_wq_copy_cmpl_handler()
>  -> fnic_fcpio_cmpl_handler()
>  -> fnic_fcpio_flogi_reg_cmpl_handler()
>  -> fnic_flush_tx()
>  -> fnic_send_frame()
>  -> fcoe_ctlr_els_send()
>  -> spin_lock_bh(&fip->ctlr_lock)
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock
      https://git.kernel.org/mkp/scsi/c/1a1975551943

-- 
Martin K. Petersen	Oracle Linux Engineering
