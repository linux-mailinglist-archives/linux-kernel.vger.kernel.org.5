Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6324979F672
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjINBlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjINBlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:41:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1761BE7;
        Wed, 13 Sep 2023 18:40:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E1Jp9W013575;
        Thu, 14 Sep 2023 01:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=ZExZKpHQC04IrjkW6/EZ6aFwHm7m6mhplNslB/QBZww=;
 b=TQIIkPeDVyRKsFZ7I0bdWF9vuviL+xnFzCU5n/Ov241SE0vo3w6I/GTuEzyGlcDoweUG
 mWlwQXDLI0gxCX04HcE2Ql8ek89krpDWkoC0nawofStGHXln3eO667YIyBdRRbcgnd4Q
 oeBDI80qlzFtHVRzoheymdi/mxWf9Um/+q2RSXhnvRpIPMyaJuWH6R3nFDbg0BxX+itT
 5iQrRqXZtiqgMMI/L2uTJ5UdBjzXVCCTm3DE3SBa5nsssuVQCuIKxuHy0CID5Pl0ofnH
 52R7TZdNhNbBB41mM0f1VoYL/24F9aEXde9k3EsPt4p0GUfuXCNJHSfWigVKcYoESs15 fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kkkqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:40:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38E0a4I5007592;
        Thu, 14 Sep 2023 01:40:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f581r2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:40:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38E1efpX038417;
        Thu, 14 Sep 2023 01:40:47 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3t0f581qyy-6;
        Thu, 14 Sep 2023 01:40:46 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Michal Grzedzicki <mge@meta.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jinpu.wang@cloud.ionos.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Wang <jinpu.wang@ionos.com>
Subject: Re: [PATCH v2 1/2] pm80xx: Use phy specific sas address when sending PHY_START command
Date:   Wed, 13 Sep 2023 21:40:29 -0400
Message-Id: <169465549436.730690.3321701168124397748.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913155611.3183612-1-mge@meta.com>
References: <CAMGffE=kWc1rsNfn6n8d1qkYw2U8sz+n5E-GEkWB7=835j=66g@mail.gmail.com> <20230913155611.3183612-1-mge@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=566 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140013
X-Proofpoint-GUID: Dvn9UAPcXAbvL50PnTEt7pSr8ohPeW1b
X-Proofpoint-ORIG-GUID: Dvn9UAPcXAbvL50PnTEt7pSr8ohPeW1b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 08:56:10 -0700, Michal Grzedzicki wrote:

> Some cards have more than one sas addresses. Using incorrect
> address causes communication issues with some devices like expanders.
> 
> 

Applied to 6.6/scsi-fixes, thanks!

[1/2] pm80xx: Use phy specific sas address when sending PHY_START command
      https://git.kernel.org/mkp/scsi/c/71996bb835ae
[2/2] pm80xx: Avoid leaking tags when processing OPC_INB_SET_CONTROLLER_CONFIG command
      https://git.kernel.org/mkp/scsi/c/c13e73317458

-- 
Martin K. Petersen	Oracle Linux Engineering
