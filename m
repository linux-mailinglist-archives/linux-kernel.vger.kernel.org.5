Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640F27F87F3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjKYCyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjKYCy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:54:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D615819A3;
        Fri, 24 Nov 2023 18:54:34 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP27C70001998;
        Sat, 25 Nov 2023 02:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=kQn8x6bLmDO7gCoPY5/hW3tUTK9kDp5O45WlyduHfHY=;
 b=MTgZIX7Vr3jZCg0Ji7/pOD5rlBY7MoSNRoZ3YOtcmgfmGSn9bi4PypeUwdB5Hgc9WBX7
 n4ChkvEtM2jDgPIDaSFr2xel8h2dLYPKQEJ6w6upox0zFQ4oA7G2LZx373gBCtONWNMN
 Yz5+WVpWT/TfE0i8qcE0b9ujdtCNtwBQtiKCAZPH8E0ytsrKyCnXHUSBJwCbIJ+XUpUo
 cJ2QxRfsTV/fviR4p9mn9kQmWFhQMwrKH8zXlm/q8TAMCQv7bVLYx5DnsvLH6WTRhlia
 r2Q0iE7U9k8tcvCJpD+wWbizyWd7l02BaSsD1XF5dpGufisfJ+16ZRs2ziYIobKMFBWv LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7ucg12c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Nov 2023 02:54:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1XuVx027070;
        Sat, 25 Nov 2023 02:54:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c99f6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Nov 2023 02:54:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AP2sRSx011828;
        Sat, 25 Nov 2023 02:54:29 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uk7c99f5h-6;
        Sat, 25 Nov 2023 02:54:29 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: elx: libefc: replace deprecated strncpy with strscpy_pad/memcpy
Date:   Fri, 24 Nov 2023 21:54:18 -0500
Message-ID: <170087016627.1036733.4443783771400286080.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231026-strncpy-drivers-scsi-elx-libefc-efc_node-h-v2-1-5c083d0c13f4@google.com>
References: <20231026-strncpy-drivers-scsi-elx-libefc-efc_node-h-v2-1-5c083d0c13f4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_01,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=770 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311250020
X-Proofpoint-GUID: -PHVGXN59J63RBStTidkzNOaeNlhKRXV
X-Proofpoint-ORIG-GUID: -PHVGXN59J63RBStTidkzNOaeNlhKRXV
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

On Thu, 26 Oct 2023 01:53:13 +0000, Justin Stitt wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> To keep node->current_state_name and node->prev_state_name NUL-padded
> and NUL-terminated let's use strscpy_pad() as this implicitly provides
> both.
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: elx: libefc: replace deprecated strncpy with strscpy_pad/memcpy
      https://git.kernel.org/mkp/scsi/c/1057f44137c5

-- 
Martin K. Petersen	Oracle Linux Engineering
