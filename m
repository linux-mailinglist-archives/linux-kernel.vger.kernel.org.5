Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25418812675
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443140AbjLNE3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443130AbjLNE3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:29:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626F9B9;
        Wed, 13 Dec 2023 20:29:36 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0S5Bn004524;
        Thu, 14 Dec 2023 04:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=0X3+fdRFzvEhD957wPV3grzj5bB7Y6RcxFvRN/wYaRQ=;
 b=bfVV1zXrAZKMKizAxVCWzMh8k4ruUmpQovhN8b7OQVLO67SbVNvPWqyeGyFjsy21AnbJ
 jEwamSjFyPqYi4oegjmUM+WdV2OUHetLTulVjzbvs2/dI8AdHuY45fhTw7cwVNQnEDvJ
 LzK6v3JGkwTFBoPnxJ6p/bnqAV6Bvw/iZ/oil2LHR6ZzSuXdWOoFnN0fWOGrnC4kstNo
 pZmz95TUrvI1Qm2e+6kscVroDhZE9DxY7lJsXQYkrNyT+qrKWusb7a6uAQaKxREkiqWo
 yelG0vBB1goJD9hserSYIZNvpp8koegpPN5Q9DieiaF3G6h/fzpPR6SjPr1H4xpn8sgG gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d9x66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 04:29:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE38M5m009842;
        Thu, 14 Dec 2023 04:29:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9ev0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 04:29:26 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE4TQM4035965;
        Thu, 14 Dec 2023 04:29:26 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uvep9ev0g-1;
        Thu, 14 Dec 2023 04:29:26 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] scsi: fnic: return error if vmalloc failed
Date:   Wed, 13 Dec 2023 23:29:06 -0500
Message-ID: <170205513086.1790765.12387126447114972285.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231128111008.2280507-1-artem.chernyshev@red-soft.ru>
References: <20231128111008.2280507-1-artem.chernyshev@red-soft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_01,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=688 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140024
X-Proofpoint-GUID: wXUn-rRvv0VGWEDUitwVoxsxs_3NAc99
X-Proofpoint-ORIG-GUID: wXUn-rRvv0VGWEDUitwVoxsxs_3NAc99
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 14:10:08 +0300, Artem Chernyshev wrote:

> In fnic_init_module() exists redundant check for return value
> from fnic_debugfs_init(), because at moment it only can
> return zero. It make sense to process theoretical vmalloc failure.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: fnic: return error if vmalloc failed
      https://git.kernel.org/mkp/scsi/c/f5f27a332a14

-- 
Martin K. Petersen	Oracle Linux Engineering
