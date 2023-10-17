Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBEE7CB7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbjJQBMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjJQBMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:12:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE58F9;
        Mon, 16 Oct 2023 18:12:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKONsP014525;
        Tue, 17 Oct 2023 01:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=QFA8Q5JfrFLxXyI/2NbtgGFd2MRBy1aq57sU7Ghi5bA=;
 b=mH6vtagRnFu1e2z/fwoGXdsCQOVpsUAPWDoE+WuWgxkOADyVoWDkI/Zb4RVlnnW0nW3k
 WX0Rw8sn103ApliBK7ssxt4m4y/zpyBZHSwNHGSwOViY3Y2beHXLULh1ISngriWPxgkj
 OsPKrSkL4uIh7dOrXwtTZOnh/5BjpR6Ry4SAIYAB/DxMJy95gBKmqKbjxfOt47jLxZfc
 NPwUQm+CXm4l7Ow9wwPgnxJmcZarTgp82JxUDg0PRewOt57i3v35dKsUNo4dIg9l4NJj
 /fXxilGAK6eSeGNzCnbwx4xjRLF3fV4YWB4M2vIvMOBixDwQcECEO/NRM3GNxj0WiE9G 1w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu41s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 01:12:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GMqLq7027089;
        Tue, 17 Oct 2023 01:12:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg5366nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 01:12:04 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39H1C3si039761;
        Tue, 17 Oct 2023 01:12:04 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3trg5366mf-2;
        Tue, 17 Oct 2023 01:12:04 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-scsi@vger.kernel.org, Wenchao Hao <haowenchao2@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        louhongxiang@huawei.com
Subject: Re: [PATCH] scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup
Date:   Mon, 16 Oct 2023 21:11:49 -0400
Message-Id: <169750286910.2183937.11241575331092205293.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231011130350.819571-1-haowenchao2@huawei.com>
References: <20231011130350.819571-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=830 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170008
X-Proofpoint-GUID: Rg81BBs0gnOhaz41M4c31Cop8GfTm6Ce
X-Proofpoint-ORIG-GUID: Rg81BBs0gnOhaz41M4c31Cop8GfTm6Ce
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 21:03:50 +0800, Wenchao Hao wrote:

> fc_lport_ptp_setup() did not check the return value of fc_rport_create()
> which is possible to return NULL which would cause a NULL pointer
> dereference. Address this issue by checking return value of
> fc_rport_create() and log error message on fc_rport_create() failed.
> 
> 

Applied to 6.7/scsi-queue, thanks!

[1/1] scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup
      https://git.kernel.org/mkp/scsi/c/4df105f0ce9f

-- 
Martin K. Petersen	Oracle Linux Engineering
