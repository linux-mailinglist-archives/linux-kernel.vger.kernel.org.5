Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9561177E578
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbjHPPov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344331AbjHPPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:44:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5D2711;
        Wed, 16 Aug 2023 08:44:28 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFeiDr002766;
        Wed, 16 Aug 2023 15:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Wq4rVGv7mURGeMjWpmI1pyPB5doRfFVO1W+MtKrYPyA=;
 b=nWdGPzhZ4S238knTsIjTRJv0zTVcrGI3eGSorY8ooQejDQp7AJRQwn7JuBmboxUVtBf7
 lyRaSitw8eKauGIQlTHCEKULlXb7saSB/3Jb5q2wZKAIbKv/eF4q/6NzbnXybpr6Ovbu
 DRQlPJf8bshlU531LRlhicFTCsJF50TdSPXgQIP30IVd5JvDuBxt8yzbah+m/8NMUlRz
 o0vbtI/OWu51LY3Xjlba8J7MHDVPvfN+EUh+qvKWnnekGH6XYgxq6XjEhrYwZZ+rwQzt
 s0rI+awVoQFyuGrSk63gGv0/dOUvH6fFnMqTOM2s/nZ7vdN8MhQwMJ+R7+kVzzeZpKDf pQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh0ymgmbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 15:44:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GEgOZL001078;
        Wed, 16 Aug 2023 15:44:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsyebq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 15:44:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GFiLS620447850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 15:44:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E451C20043;
        Wed, 16 Aug 2023 15:44:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F73720040;
        Wed, 16 Aug 2023 15:44:21 +0000 (GMT)
Received: from osiris (unknown [9.171.77.81])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 15:44:21 +0000 (GMT)
Date:   Wed, 16 Aug 2023 17:44:19 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] s390/ipl: fix virtual vs physical address confusion
Message-ID: <20230816154419.29011-A-hca@linux.ibm.com>
References: <20230816132942.2540411-1-agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816132942.2540411-1-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h-S-ZZLIQBO4a5punWEJTqAf-ESnngyj
X-Proofpoint-GUID: h-S-ZZLIQBO4a5punWEJTqAf-ESnngyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_15,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 mlxlogscore=689 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308160135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 03:29:42PM +0200, Alexander Gordeev wrote:
> The value of ipl_cert_list_addr boot variable contains
> a physical address, which is used directly. That works
> because virtual and physical address spaces are currently
> the same, but otherwise it is wrong.
> 
> While at it, fix also a comment for the platform keyring.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/kernel/machine_kexec_file.c             | 4 ++--
>  arch/s390/kernel/setup.c                          | 2 +-
>  security/integrity/platform_certs/load_ipl_s390.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Mimi, Jarkko, any objections from your side?
I would take this via the s390 tree.
