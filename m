Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68C8812682
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjLNE34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443157AbjLNE3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:29:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC54136;
        Wed, 13 Dec 2023 20:29:43 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0UK5n016583;
        Thu, 14 Dec 2023 04:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=yKEqQl9gsil6mOmOfS3MH81l1GTX93NGG+JkhqNdLqU=;
 b=hfh68A8zN29s7DnRVpJ+i2xO58X7x489Fg/2gk8WjTTIQWdreVQBvwX9KbOcvVd+hosc
 2Cv3Ma8TFUWwp0wV1IcshYLgGLhzLNInFTt4LqW0LieAY8+dlCWj9YuW4ZZCuuVHrJ3i
 3exSG+XwEx04nz4nw4WFEP4Nhpk+AlE62RoAd6adqS7uEh/djqXqCjzm+TPAVmA3O6My
 fe0Gt9g+h6M6Xh8NjRtMUhdxv4JvZe45PwVdXagRelxCt18kkv4I0Yw6naHx90SVdZ8P
 i02icy/7P/6947Lqu9HrQLVwc1T3vlLYHhO2GX3v5P/Y59WiqYo2Y43q9SNWW5b6ielt tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrr80n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 04:29:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE4DNaT010136;
        Thu, 14 Dec 2023 04:29:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9ev34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 04:29:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE4TQMG035965;
        Thu, 14 Dec 2023 04:29:28 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uvep9ev0g-7;
        Thu, 14 Dec 2023 04:29:28 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: ibmvfc: replace deprecated strncpy with strscpy
Date:   Wed, 13 Dec 2023 23:29:12 -0500
Message-ID: <170205513098.1790765.790754719475852189.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231030-strncpy-drivers-scsi-ibmvscsi-ibmvfc-c-v1-1-5a4909688435@google.com>
References: <20231030-strncpy-drivers-scsi-ibmvscsi-ibmvfc-c-v1-1-5a4909688435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_01,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=764 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140024
X-Proofpoint-GUID: ZAmarbD8rNyIDwQf6ako5Cczn0fu8kVF
X-Proofpoint-ORIG-GUID: ZAmarbD8rNyIDwQf6ako5Cczn0fu8kVF
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

On Mon, 30 Oct 2023 19:04:33 +0000, Justin Stitt wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect these fields to be NUL-terminated as the property names from
> which they are derived are also NUL-terminated.
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: ibmvfc: replace deprecated strncpy with strscpy
      https://git.kernel.org/mkp/scsi/c/a9baa16b4fc1

-- 
Martin K. Petersen	Oracle Linux Engineering
