Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65434792AA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245444AbjIEQks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354244AbjIEKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:19:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B70318D;
        Tue,  5 Sep 2023 03:19:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3853OSiL018296;
        Tue, 5 Sep 2023 10:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=0fMd8Q1gRebvLzMp+AxRQUaLx0+5I6Z7PAbwAWZGOuE=;
 b=NTlouxmugTZqdeGqppOOoLtrE3+PHgsbR5a0tXvEtb9ZB1Mm3EOJ9Op39CdHHLw3Zv9W
 96PrPWlWn2GqwRa77PAxlWPVd1Mn/TPORexu0sUkW5BtJSZ2usZZOn3IuH2HyOwHQpkf
 fvdRjqGlOu/1qjCOhArl+vGUgYanoq0JL/nLFHdLPaG++6GF8vGIpC4Igmn28BPUGh0E
 jVW+4Lm7X77ZL8rxfeEwlUG8G7wJ6uxldq6rZTh7ybvh+5EvXsLx6U5Rig4Zl5SFL/Ar
 8kEq3FUk9PYO+v6ZGsPQK4HBFB/eNdDtlkcj1N4oTXZvwdGK6ITs6WlljfDzneXJX7/0 aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suun1n17j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 10:18:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3859rwST029072;
        Tue, 5 Sep 2023 10:18:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug4j8ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 10:18:52 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385AIlOa032271;
        Tue, 5 Sep 2023 10:18:52 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3suug4j85n-4;
        Tue, 05 Sep 2023 10:18:52 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenchao Hao <haowenchao2@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        louhongxiang@huawei.com
Subject: Re: [PATCH] scsi:libsas: Simplify sas_queue_reset and remove unused code
Date:   Tue,  5 Sep 2023 06:18:27 -0400
Message-Id: <169390541193.1533355.3402161517603895888.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230729102451.2452826-1-haowenchao2@huawei.com>
References: <20230729102451.2452826-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_08,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050092
X-Proofpoint-ORIG-GUID: xwSwlldpRJPrujImmmIUsxviOha8tqMq
X-Proofpoint-GUID: xwSwlldpRJPrujImmmIUsxviOha8tqMq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 18:24:51 +0800, Wenchao Hao wrote:

> sas_queue_reset is always called with param "wait" set to 0, so
> remove it from this function's param list. And remove unused
> function sas_wait_eh.
> 
> 

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi:libsas: Simplify sas_queue_reset and remove unused code
      https://git.kernel.org/mkp/scsi/c/be946e31bcf2

-- 
Martin K. Petersen	Oracle Linux Engineering
