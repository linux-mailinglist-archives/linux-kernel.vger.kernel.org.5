Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA078E491
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345643AbjHaBtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345651AbjHaBtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:49:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA5D9C;
        Wed, 30 Aug 2023 18:49:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0EjDN012132;
        Thu, 31 Aug 2023 01:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=IoJ55lmsCSiFbRgBXJ6sb7E1RfD5nkFY93UY3DR6jeo=;
 b=yUF/LTaCmn5a7K3jdw3honoUNKeo2AOzsEC/iBY2dkkrxAbHf1Yw8Rl/6M8nYgYK39Mx
 OYQCbJ4PKxo/NgJEnmMFR2z7WW9x8L81fQUhUMzDBpoOed5eZpdaMqASwqtUXJHLx3YR
 rav8TyINmOiemyBmMNPyjFT2AEIfCyu3shbuCEmWlbjr9QXgngrKZajFzqlTU/kR+HIT
 yp0qjH7ZANeDH5VPn8xjdrhifPjU15s49MQKJc/l5tjfqHC7O41KqbkcLD5+9W2gW9Yi
 L2f14wa7Gmrd8EgFbmUfj1rV95SEQBLJBVZDUEahIbHPHTeK1AT5Q93KGWTwY3TYMPEB lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9xt8sma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:48:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0VnKT032764;
        Thu, 31 Aug 2023 01:48:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dqtxmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:48:58 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37V1mnKr000352;
        Thu, 31 Aug 2023 01:48:57 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sr6dqtxfw-5;
        Thu, 31 Aug 2023 01:48:57 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Juergen Gross <jgross@suse.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        xen-devel@lists.xenproject.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] xen/scsifront: shost_priv() can never return NULL
Date:   Wed, 30 Aug 2023 21:48:32 -0400
Message-Id: <169344360100.1293881.8692912884292085962.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822064817.27257-1-jgross@suse.com>
References: <20230822064817.27257-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_01,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=882 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310014
X-Proofpoint-ORIG-GUID: zwa0klpZnT3pvexSHJKeq2TYYWeJVYWz
X-Proofpoint-GUID: zwa0klpZnT3pvexSHJKeq2TYYWeJVYWz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 08:48:17 +0200, Juergen Gross wrote:

> There is no need to check whether shost_priv() returns a non-NULL
> value, as the pointer returned is just an offset to the passed in
> parameter.
> 
> While at it replace an open coded shost_priv() instance.
> 
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/1] xen/scsifront: shost_priv() can never return NULL
      https://git.kernel.org/mkp/scsi/c/73c7881b5066

-- 
Martin K. Petersen	Oracle Linux Engineering
