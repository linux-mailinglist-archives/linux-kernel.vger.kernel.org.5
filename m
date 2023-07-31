Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC67F76A170
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjGaTpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGaTpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:45:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB91B2;
        Mon, 31 Jul 2023 12:45:20 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTJ9d029568;
        Mon, 31 Jul 2023 19:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=/Kd2V0k/lLv+56J3a2P0teQNuzHpQLFn1rCvoLa66pA=;
 b=wZ2Ul/PqfCjHcGbXtQKfkg7LvjO1Uz7FuCJ/X+V3HDx73aBNb7ABDg2jARpYeHXraJUf
 QDhQe9lmW539EgQBovyTdFKXXnY2SB05LgvorL0JedTJvaK/Z14js2Ug3DGR0avtjl6l
 taYv/m7qb7IsPtxI4b7C/DAK+1jCRLDO0wTdQQj/61aFx1lpqO91MTwbzA7TzKh9hg5g
 MDr9Xmvt0z/Wcv7I0Pl8VMfcXqHzJMHhyo+XqcaHp2BOKrzCgiazLDuqFpNBgc7POgeJ
 fm++UZt4+kCLUaqPrrlnydbjp0DUqiTd1m/Wr3L2VrSqm9nan5Oat266Qa+mt5R8wNCH JA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd3f7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:45:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VICZNl013711;
        Mon, 31 Jul 2023 19:45:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s75cmke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:45:17 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36VJjEfd025102;
        Mon, 31 Jul 2023 19:45:16 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3s4s75cmf1-3;
        Mon, 31 Jul 2023 19:45:16 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     ketan.mukadam@broadcom.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lin Ma <linma@zju.edu.cn>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v1] scsi: be2iscsi: Add length check when parsing nlattrs
Date:   Mon, 31 Jul 2023 15:45:04 -0400
Message-Id: <169083266402.2873709.5582459662630461146.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230723075938.3713864-1-linma@zju.edu.cn>
References: <20230723075938.3713864-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_13,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310179
X-Proofpoint-GUID: Kjo8zRpKKIxmtaS3UR17VIGDwZPs8kkz
X-Proofpoint-ORIG-GUID: Kjo8zRpKKIxmtaS3UR17VIGDwZPs8kkz
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

On Sun, 23 Jul 2023 15:59:38 +0800, Lin Ma wrote:

> beiscsi_iface_set_param parses nlattr with nla_for_each_attr and assumes
> every attributes can be viewed as struct iscsi_iface_param_info.
> 
> This is not true because there is no any nla_policy to validate the
> attributes passed from the upper function iscsi_set_iface_params.
> 
> This patch adds the nla_len check before accessing the nlattr data and
> error return EINVAL if the length check fails.
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: be2iscsi: Add length check when parsing nlattrs
      https://git.kernel.org/mkp/scsi/c/ee0268f230f6

-- 
Martin K. Petersen	Oracle Linux Engineering
