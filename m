Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC076A173
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGaTp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGaTpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:45:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58AD199E;
        Mon, 31 Jul 2023 12:45:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDToBa004888;
        Mon, 31 Jul 2023 19:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=ChVz0ZX1KvR23ysnfIHDEWyzXcxl9hWiSY/2ND276C0=;
 b=L1+mbUlayB4NhxCShBWal1RIo+qx9ywT2UvHTzbtI1W92PCOpTly0P0D06Tjd8malvo+
 JSNpcLCiC+R1zPw6hlmKsQsl9pl0I+VSAZa7PuDOyGCW/+rKg/q5LDgGeOuxYr3dBdd+
 WgeOWPbB01yDAsrNOj6eJAfOfFlaftO6mzd7MhX5NF9dby1dSRxiAZm0MCox9rwPfJcl
 Fi6bBazSvVZf6Yf2tpaC0nsIqvHK2PoFGd1y4bPs/r1bdlP91tH+13MMC1rf9zK97GoD
 H9LMymLQ84fzpJ7wfGiQIUzEZSIBJP+gx+r39oijDT2helBcfI+oVdActDOkxtGp14c3 Zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uauucxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:45:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VHsZ0x013715;
        Mon, 31 Jul 2023 19:45:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s75cmpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:45:18 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36VJjEff025102;
        Mon, 31 Jul 2023 19:45:17 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3s4s75cmf1-4;
        Mon, 31 Jul 2023 19:45:17 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lin Ma <linma@zju.edu.cn>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v1] scsi: qla4xxx: Add length check when paring nlattrs
Date:   Mon, 31 Jul 2023 15:45:05 -0400
Message-Id: <169083266403.2873709.2950258839122967870.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230723080053.3714534-1-linma@zju.edu.cn>
References: <20230723080053.3714534-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_13,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=840 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310179
X-Proofpoint-ORIG-GUID: qo7PuxsscNeIuBNSREr7DiyUw0il4VeG
X-Proofpoint-GUID: qo7PuxsscNeIuBNSREr7DiyUw0il4VeG
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2023 16:00:53 +0800, Lin Ma wrote:

> There are three places that qla4xxx looply parses nlattrs
> * qla4xxx_set_chap_entry(...)
> * qla4xxx_iface_set_param(...)
> * qla4xxx_sysfs_ddb_set_param(...)
> and each of them directly converts the nlattr to specific pointer of
> structure without length checking. This could be dangerous as those
> attributes are not validated before and a malformed nlattr (e.g., length
> 0) could result in an OOB read that leaks heap dirty data.
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: qla4xxx: Add length check when paring nlattrs
      https://git.kernel.org/mkp/scsi/c/47cd3770e31d

-- 
Martin K. Petersen	Oracle Linux Engineering
