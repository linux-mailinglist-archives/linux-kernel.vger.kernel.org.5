Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6567C8EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjJMVEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjJMVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:04:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA471BE;
        Fri, 13 Oct 2023 14:04:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DKwmBh012305;
        Fri, 13 Oct 2023 21:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=5TU3/wiclntYZX2QdgK2x67sWd17Bs8cXaMOgZNuRHs=;
 b=nt+3/Imk8aQNA7A20jmLhw+c2gOjB/PKutPvidOR4XdAJ2Kdh8n1RupiTA/w5l0sxLR4
 jws2BT0B9YQi2MG+412i5jW4R1ZykNrev3yN9sBfaG5j5pNfnAhca72wIMUTYdsGTtoE
 6QZFHvZHBFzstF7OA8Hx0zxiTMz1AQTAnHOP8q3BvdENGSiPg4TOzyIjNClk2XQa7cA7
 cRNMrmsRMmYsIRG43uBUDRtP+wEfVcUoWh3SqOTf2anJh+s2YZ8Iv9UqQm4y3sqRA1Wy
 GjL2fH24tU3J/Vk0C7rpNoMpNpEjvW9uhxsnE1CuIkdGiDkOEnrgaNJjAV8GPmB7UfVT 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43wx42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 21:03:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DKht8c037226;
        Fri, 13 Oct 2023 21:03:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0uxn6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 21:03:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DL1kdf003704;
        Fri, 13 Oct 2023 21:03:56 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tpt0uxn63-1;
        Fri, 13 Oct 2023 21:03:56 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] scsi: ufs: ufs-pci: Switch to use acpi_evaluate_dsm_typed()
Date:   Fri, 13 Oct 2023 17:03:49 -0400
Message-Id: <169721547126.1657123.12376613270044102409.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231002135125.2602895-1-andriy.shevchenko@linux.intel.com>
References: <20231002135125.2602895-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=697 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130183
X-Proofpoint-ORIG-GUID: hDH8orBkE_DwBYQuN5ILecKwg9x-CyYG
X-Proofpoint-GUID: hDH8orBkE_DwBYQuN5ILecKwg9x-CyYG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2023 16:51:25 +0300, Andy Shevchenko wrote:

> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
> 
> 

Applied to 6.7/scsi-queue, thanks!

[1/1] scsi: ufs: ufs-pci: Switch to use acpi_evaluate_dsm_typed()
      https://git.kernel.org/mkp/scsi/c/fcf3fb7bd50c

-- 
Martin K. Petersen	Oracle Linux Engineering
