Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E80178FE64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349778AbjIANjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjIANjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:39:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF7E4C;
        Fri,  1 Sep 2023 06:39:02 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381DccGm019319;
        Fri, 1 Sep 2023 13:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=lKatZ2/Cc1BaS6JWQPOwLl2JiazNzu2oTp+AqekD1Gw=;
 b=nPUPDwzE1o8ECB4vda46e+WkrWpPMPGrr/Xbre62W97Xd1lGa2Tfngy4h9d3vDKqeOgy
 VRPeWGrOiACpydUEp6DQzP1hLERvzvs1iTtZwQq5vCV4kyJzlNBMRUKdp0TOL9zFdKUu
 nDjLub+j4hat6JrOL1lKE01LwcBWSavpupo/ZB8s3D91gL5/P4vu0cJRTZsRDv1RM8pS
 vnbqKQPY78EWgDk5Wxqy4FluSc4zf/qz1vBAS6EDOiVK9hM0S+YTRgJqRjzkXFBmJyA9
 3oMR8wPFuCAeCtNM3WZsirIClJPe27Vj+BlO5iB0O+rlE/F880PyFdpHuXwkC1aET93O Fw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sugcbhfrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 13:38:58 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 381CED7v004928;
        Fri, 1 Sep 2023 13:38:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3squqtddf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 13:38:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 381DcsXY46203326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Sep 2023 13:38:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FA392004B;
        Fri,  1 Sep 2023 13:38:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEE4E20043;
        Fri,  1 Sep 2023 13:38:53 +0000 (GMT)
Received: from osiris (unknown [9.171.88.193])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Sep 2023 13:38:53 +0000 (GMT)
Date:   Fri, 1 Sep 2023 15:38:52 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] s390/dasd: fix string length handling
Message-ID: <20230901133852.5990-A-hca@linux.ibm.com>
References: <20230828153142.2843753-1-hca@linux.ibm.com>
 <20230828153142.2843753-2-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828153142.2843753-2-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aao6eX7HV6tUxRH2llbjf0RVoPlzK54R
X-Proofpoint-ORIG-GUID: aao6eX7HV6tUxRH2llbjf0RVoPlzK54R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_11,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=956 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309010127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Mon, Aug 28, 2023 at 05:31:42PM +0200, Heiko Carstens wrote:
> Building dasd_eckd.o with latest clang reveals this bug:
> 
>     CC      drivers/s390/block/dasd_eckd.o
>       drivers/s390/block/dasd_eckd.c:1082:3: warning: 'snprintf' will always be truncated;
>       specified size is 1, but format string expands to at least 11 [-Wfortify-source]
>        1082 |                 snprintf(print_uid, sizeof(*print_uid),
>             |                 ^
>       drivers/s390/block/dasd_eckd.c:1087:3: warning: 'snprintf' will always be truncated;
>       specified size is 1, but format string expands to at least 10 [-Wfortify-source]
>        1087 |                 snprintf(print_uid, sizeof(*print_uid),
>             |                 ^
> 
> Fix this by moving and using the existing UID_STRLEN for the arrays
> that are being written to. Also rename UID_STRLEN to DASD_UID_STRLEN
> to clarify its scope.
> 
> Fixes: 23596961b437 ("s390/dasd: split up dasd_eckd_read_conf")
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_devmap.c |  6 +-----
>  drivers/s390/block/dasd_eckd.c   | 10 +++++-----
>  drivers/s390/block/dasd_int.h    |  4 ++++
>  3 files changed, 10 insertions(+), 10 deletions(-)

Just wondering, will you pick this one up, or should I route this via
the s390 tree?
