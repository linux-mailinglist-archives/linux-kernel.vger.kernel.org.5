Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E7B7C8EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjJMVEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjJMVEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:04:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ABCB7;
        Fri, 13 Oct 2023 14:04:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DKx09I024381;
        Fri, 13 Oct 2023 21:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=RxRDBzSxGCukCgoDhscDHJ6Yu9/o7tSPkEMqvtjUFM8=;
 b=mtKEuwHbZlWJTenuyTBI/1U0u1fPykIcmM2bNmF6VUOEBschYSfQ/Wq+lyo9I1megrzP
 9zMAszV+g86Q33frKmnnfYloveJpTOHeJfCBzzHHzwcw02Ld/MEMeBM0gl2Fqr9AxcPx
 hCbGWRfmUFDe+d7aa9fut06xuaL4RQ1+z+E8v+DkLOvYwlGtpPI4Qs6T6fqjKft8p1BX
 /erINaawzx/CSMRLzRXisdbzDft8VBuvDWUR0uDabChAUX9kvz/4QR79O2u/ehCZD0cl
 Lv/XD3KMgpEc42uyKBB4sCNoOoh1Yd8O7g4jjmu5P1g6946kmAYIC4FQC+hPvrlwAHWi gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh8a36xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 21:04:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DKeDZp036834;
        Fri, 13 Oct 2023 21:03:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0uxn84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 21:03:58 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DL1kdl003704;
        Fri, 13 Oct 2023 21:03:57 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tpt0uxn63-4;
        Fri, 13 Oct 2023 21:03:57 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] scsi: message: fusion: replace deprecated strncpy with strscpy
Date:   Fri, 13 Oct 2023 17:03:52 -0400
Message-Id: <169721547124.1657123.14284756622462613195.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231003-strncpy-drivers-message-fusion-mptsas-c-v2-1-5ce07e60bd21@google.com>
References: <20231003-strncpy-drivers-message-fusion-mptsas-c-v2-1-5ce07e60bd21@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=909 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130183
X-Proofpoint-GUID: hhZ38WIVNpulHJ4-lz3ZncdfAfDlp0n_
X-Proofpoint-ORIG-GUID: hhZ38WIVNpulHJ4-lz3ZncdfAfDlp0n_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 22:15:45 +0000, Justin Stitt wrote:

> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> The only caller of mptsas_exp_repmanufacture_info() is
> mptsas_probe_one_phy() which can allocate rphy in either
> sas_end_device_alloc() or sas_expander_alloc(). Both of which
> zero-allocate:
> |       rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> ... this is supplied to mptsas_exp_repmanufacture_info() as edev meaning
> that no future NUL-padding of edev members is needed.
> 
> [...]

Applied to 6.7/scsi-queue, thanks!

[1/1] scsi: message: fusion: replace deprecated strncpy with strscpy
      https://git.kernel.org/mkp/scsi/c/45e833f0e5bb

-- 
Martin K. Petersen	Oracle Linux Engineering
