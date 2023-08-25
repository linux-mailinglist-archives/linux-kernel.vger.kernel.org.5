Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F8A787CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbjHYBOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbjHYBNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:13:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6932F19BB;
        Thu, 24 Aug 2023 18:13:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEICK009944;
        Fri, 25 Aug 2023 01:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=5Rykf3Um9Dg/wmB3aw2HkzZRg3rDzaC8xK6lS1ydVcY=;
 b=VErVouJ8f2+cUCo7iYPdMc6lP/TuVLmTbExFYkiUT7T2/pc4P7mm34AC/6+zquBReQ2r
 +0ZFubvBXs4mLRpcn6UR/rjEtcwyTF34U44qpNAYsXD71nnlremkGtp7YESWN+a5j6sp
 z63sDlFo9I9E7Z0CH5dPYj2wEtMCc0XJw1Gp1R54gBbguUO1D27jwwfIsl9gRfCMhRGH
 1xvkrqlSJJZUCyS/vB7iUI5u7TXSZf5LtRVlWThyddkMtXYsKdfM/RXHFjqjMyaGIJ9b
 CHcRA+lfnxF/ZpZ/hA+RanSHCy/0S6Qgfvyt88iUm40zV793td1iYXg7MRHEOI/y0SWj /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yv5ftf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ONB1dS036189;
        Fri, 25 Aug 2023 01:13:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywqfmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:40 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P1DVEG019787;
        Fri, 25 Aug 2023 01:13:40 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywqf8n-12;
        Fri, 25 Aug 2023 01:13:40 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Tony Battersby <tonyb@cybernetics.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: core: Use 32-bit hostnum in scsi_host_lookup()
Date:   Thu, 24 Aug 2023 21:12:58 -0400
Message-Id: <169292577155.789945.5462933435489756281.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a02497e7-c12b-ef15-47fc-3f0a0b00ffce@cybernetics.com>
References: <a02497e7-c12b-ef15-47fc-3f0a0b00ffce@cybernetics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=895 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250009
X-Proofpoint-GUID: ihQnOeSaQEy-Si0kkPI_0oQFzeNZH1fy
X-Proofpoint-ORIG-GUID: ihQnOeSaQEy-Si0kkPI_0oQFzeNZH1fy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 10:03:25 -0400, Tony Battersby wrote:

> Change scsi_host_lookup() hostnum argument type from unsigned
> short to unsigned int to match the type used everywhere else.
> 
> 

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: core: Use 32-bit hostnum in scsi_host_lookup()
      https://git.kernel.org/mkp/scsi/c/62ec2092095b

-- 
Martin K. Petersen	Oracle Linux Engineering
