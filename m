Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABC67B0C98
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjI0Te1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjI0TeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:34:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A491AE;
        Wed, 27 Sep 2023 12:34:15 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RIxXco031579;
        Wed, 27 Sep 2023 19:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=yXpFmhlR9AlFWS+Br0UIwWK6r35K7t/9c1QioZsWI6o=;
 b=V3G6ftH4Nqfo4cewFgRjIm2L6TZyLCaZaMBS7agVBsQRrK67JuitGJECAbJV5Um7ilYv
 6VY6hwjK5HnCA6BX1p5S/YXBYNBq42i60fDymzXUEc91Kcm81QmNoiqjKFuoL0TDi2mQ
 SIHt3AK1wUmff5oy1KXxeLK6p0HYS/Vb9zrjXZbZaqkGiFH1r3SIbXY3XA1oFXX/NNOL
 FWY9Y1/IcsjRqMsGw4yGWdbFfY0zfyxsvZmkVKoSFfnU+/LrnsRpUgxhVBepxS3GRR7P
 drdEKova3l4hG64BLR1/OPjoZ5J9/iPjngeqm/xM409gdQKv8FhjyddYxnpVPCgkDHSw lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc2jfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 19:34:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RHuFM0030660;
        Wed, 27 Sep 2023 19:34:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8cuj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 19:34:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RJY90p008431;
        Wed, 27 Sep 2023 19:34:11 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3t9pf8cub4-3;
        Wed, 27 Sep 2023 19:34:11 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     sebaddel@cisco.com, Karan Tilak Kumar <kartilak@cisco.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: Fix sg_reset success path
Date:   Wed, 27 Sep 2023 15:34:02 -0400
Message-Id: <169584315406.1272983.2132589534497114740.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919182436.6895-1-kartilak@cisco.com>
References: <20230919182436.6895-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=757 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270166
X-Proofpoint-GUID: V0nVRsYQ4A-IWmVTFTEDkT5-6DMSMRdq
X-Proofpoint-ORIG-GUID: V0nVRsYQ4A-IWmVTFTEDkT5-6DMSMRdq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 11:24:36 -0700, Karan Tilak Kumar wrote:

> sg_reset performs a device reset/lun reset on a lun.
> Since it is issued by the user, it does not come into the
> driver with a tag or a queue id.
> Fix the fnic driver to create an io_req and use a scsi command tag.
> Fix the ITMF path to special case the sg_reset response.
> 
> 
> [...]

Applied to 6.6/scsi-fixes, thanks!

[1/1] scsi: fnic: Fix sg_reset success path
      https://git.kernel.org/mkp/scsi/c/514f0c400bde

-- 
Martin K. Petersen	Oracle Linux Engineering
