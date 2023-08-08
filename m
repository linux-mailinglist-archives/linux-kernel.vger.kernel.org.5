Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4446A7736E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjHHCns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjHHCno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:43:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD310C8;
        Mon,  7 Aug 2023 19:43:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3781idl9023919;
        Tue, 8 Aug 2023 02:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=hNo6dKLcDkN2kqgj5ENz6eYAJp6Oc9pqa/4Cw5IpVFA=;
 b=QHGIdPon7nA7G/C4q2FwasAHokkTV+8S4siRtvz+nlSBcVO8uP/SYwDxmtTU8Y9TWzMp
 V9OKnO9qxxZddAcuPYX+Uru467WgwSmMbSjb/qCfM8VOKiVRe5BXCnGfE2866P1wwlRV
 950wZrC5nSiJ/HbAKV556ev13MNzE/UxRlmFL09why9PHfToU5waiMr+iYnMY2IYNVtO
 EUHXA9ELNC8SdWlwSsd7f4ZZadADMlazcH7d9wFkkU1LYc6uHOP7Bu0EfOtgVFmQvEvL
 ORl3+UcNnRLWPUcmn0TFEx1B8CTaRFCMEUiMMv7A9CXfziH+76/Hmb1+OZiMJ/r5J2oi 3A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eaam3yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:43:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 377NW0bc027353;
        Tue, 8 Aug 2023 02:43:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv55wg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:43:35 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3782hYGj038171;
        Tue, 8 Aug 2023 02:43:34 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s9cv55wfu-1;
        Tue, 08 Aug 2023 02:43:34 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        Chengfeng Ye <dg573847474@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
Date:   Mon,  7 Aug 2023 22:43:22 -0400
Message-Id: <169146257041.4040705.14041298485588180339.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726125655.4197-1-dg573847474@gmail.com>
References: <20230726125655.4197-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_28,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=805 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080022
X-Proofpoint-ORIG-GUID: 4BXzPavUdcgYGaoWy0pz6lbH5pazCWGx
X-Proofpoint-GUID: 4BXzPavUdcgYGaoWy0pz6lbH5pazCWGx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 12:56:55 +0000, Chengfeng Ye wrote:

> As &qedi_percpu->p_work_lock is acquired by hard irq qedi_msix_handler(),
> other acquisition of the same lock under process context should disable
> irq, otherwise deadlock could happen if the irq preempt the execution
> while the lock is held in process context on the same CPU.
> 
> qedi_cpu_offline() is one such function acquires the lock on process
> context.
> 
> [...]

Applied to 6.5/scsi-fixes, thanks!

[1/1] scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
      https://git.kernel.org/mkp/scsi/c/dd64f8058719

-- 
Martin K. Petersen	Oracle Linux Engineering
