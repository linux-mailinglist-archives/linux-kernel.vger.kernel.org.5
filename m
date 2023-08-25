Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8387890C5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjHYVvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjHYVv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:51:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291BE26AD;
        Fri, 25 Aug 2023 14:51:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEI04025180;
        Fri, 25 Aug 2023 21:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=D3Hs24eJaHAVwjPmIkUV9nktWGw2cWeejk3LHcVj4RY=;
 b=WjeR0e039OCT2BFtFsobG9WyYaLlBWQGVs2vjkoNRACenoYqiMXb4dcCz5yn120zcCdG
 R4li3/O63PztreZm2FYOt8CTQ++43VNboeabhzOEv9nDAMkIfJg2A3fLbwyd0GU28t2A
 zrPH/j06Z3d6CbjoVUyfQKjGCyGEb6PuHTD0joGz2nu4thgVdunD6txnsB2MrPA1bIZM
 PDZmsb9ImYYose2E0VL02gGgB+TX48vOr3fTIz0mC2WKYpEmNMt6a6jAyPTMqEgLPI5K
 +CVQUyB+gHfNW9qGqKvUvDsh6rD5W1F+zvpJx24iDynv1VTsOsgfQWhYZmgLFsZsyDII +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvyc9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 21:51:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PKXNFq005823;
        Fri, 25 Aug 2023 21:51:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yv4emh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 21:51:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37PLpDvV019636;
        Fri, 25 Aug 2023 21:51:13 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sn1yv4eg7-1;
        Fri, 25 Aug 2023 21:51:13 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.ibm.com,
        nmusini@cisco.com, bvanassche@acm.org, dan.carpenter@linaro.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhu Wang <wangzhu9@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH -next] scsi: snic: fix double free in snic_tgt_create()
Date:   Fri, 25 Aug 2023 17:50:59 -0400
Message-Id: <169300023878.1212091.11390138946813564658.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230819083941.164365-1-wangzhu9@huawei.com>
References: <20230819083941.164365-1-wangzhu9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=616 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250195
X-Proofpoint-GUID: meLRMKHYGsOT5CoetQQY-2WbvanquTy6
X-Proofpoint-ORIG-GUID: meLRMKHYGsOT5CoetQQY-2WbvanquTy6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2023 08:39:41 +0000, Zhu Wang wrote:

> The commit 41320b18a0e0 ("scsi: snic: Fix possible memory leak if
> device_add() fails") fix the memory leak caused by dev_set_name() when
> device_add() failed. While it did not consider that 'tgt' has already been
> released when put_device(&tgt->dev) is called. We removed kfree(tgt) in
> the error path to avoid double free 'tgt'. And we moved
> put_device(&tgt->dev) after the removed kfree(tgt) to avoid UAF
> (Use-After-Free).
> 
> [...]

Applied to 6.5/scsi-fixes, thanks!

[1/1] scsi: snic: fix double free in snic_tgt_create()
      https://git.kernel.org/mkp/scsi/c/1bd3a76880b2

-- 
Martin K. Petersen	Oracle Linux Engineering
