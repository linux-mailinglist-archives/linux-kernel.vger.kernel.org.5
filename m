Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201B17F87F0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjKYCy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKYCy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:54:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FBA170B;
        Fri, 24 Nov 2023 18:54:33 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1Yuj3013455;
        Sat, 25 Nov 2023 02:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=hMGK+1vHotDFsNXZFPqP/3Sbw2I6KrBmnVv/+URrfCA=;
 b=IIWStlXs0CmMtHJquScY2YsS3Lokwag3VU1jvDNyr7+Cn2Zg37ISrLPyXUQG6IuuCE6r
 GedFxcCEFpKbqr4vxa8Wj8TLsE1X4frnXrrYivbK6FJLx6m5HOnhiS8yJRr9rcX72QAY
 vzIJR3UkMUNbPl7I81kMsw7uJ1zUhMu8kl8k0KijQ1MVieuakVgIVk53i9BS44SzOosQ
 vSBiH2Qe2dUZsa6fqX9qspDeIbhqzjxIG+2JMGI3aKlszk6Zdk6lMpY4xcc8rZn+Q4kt
 YZxn2YCJTr+ZJyzM7SCgTeU3ieLMWALSWN2bjtrCb58m5/7IJIDG1QoHmsgAD8/edTDQ Wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uentvm17b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Nov 2023 02:54:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1XuM2027071;
        Sat, 25 Nov 2023 02:54:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c99f5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Nov 2023 02:54:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AP2sRSp011828;
        Sat, 25 Nov 2023 02:54:28 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uk7c99f5h-2;
        Sat, 25 Nov 2023 02:54:28 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-sas: replace deprecated strncpy with strscpy
Date:   Fri, 24 Nov 2023 21:54:14 -0500
Message-ID: <170087016623.1036733.12314891671424643121.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231023-strncpy-drivers-scsi-3w-sas-c-v1-1-4c40a1e99dfc@google.com>
References: <20231023-strncpy-drivers-scsi-3w-sas-c-v1-1-4c40a1e99dfc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_01,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=899 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311250020
X-Proofpoint-ORIG-GUID: kmusJXCYZ1AH8InRz8lQ5STuG3-dMD6m
X-Proofpoint-GUID: kmusJXCYZ1AH8InRz8lQ5STuG3-dMD6m
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

On Mon, 23 Oct 2023 19:50:57 +0000, Justin Stitt wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This pattern of strncpy(dest, src, strlen(src)) is extremely bug-prone.
> This pattern basically never results in NUL-terminated destination
> strings unless `dest` was zero-initialized. The current implementation
> may be accidentally correct as tw_dev is zero-allocated via:
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: 3w-sas: replace deprecated strncpy with strscpy
      https://git.kernel.org/mkp/scsi/c/7936a19e944b

-- 
Martin K. Petersen	Oracle Linux Engineering
