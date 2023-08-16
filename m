Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0977E868
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345418AbjHPSMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbjHPSMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:12:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4F6E4C;
        Wed, 16 Aug 2023 11:12:44 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GICKHM029166;
        Wed, 16 Aug 2023 18:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=YZbFboQnqkz5D4FKGOLnOGo1d5f+ZI68YqiO2f+UcHI=;
 b=mPvscO3jxP3NFF/xJw6mSHF1v3J5Q1AWyEJKVX4PaAz58tpp6yA0TTMTSvLMrr2sNnL4
 LSmSMd09hnVonDh8tK4YsquvI6DMcky+b9arKFMEydeni+e231+BqX6+j8UA5xuVZyJL
 8d4NRbRyWQ9TL6T1Lb9YDeurNjxUg6bxxhD67YDdWiQinkcjz6x67TjU3KUFhpcRE4Yj
 hu2jZsArRB+Ys0a0M/aIL3LBrcjwtD/I3Z8YfsGuie8Sh7L3kwbC07A/wB0AgN723/Gk
 bfBUIV82/Tq1pv8lFVknBXaGHEQzk9KEWIcTLshrn219tIpXkvNPvpL9mbMv29a8/RoB xw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh3h7802w-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 18:12:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GGoAgB002408;
        Wed, 16 Aug 2023 17:34:57 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendnev48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:34:57 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GHYuCn21037762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 17:34:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73D5C58058;
        Wed, 16 Aug 2023 17:34:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B744D5805B;
        Wed, 16 Aug 2023 17:34:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.190.160])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 16 Aug 2023 17:34:55 +0000 (GMT)
Message-ID: <47dd1902aa6c2328680223beb1235b28a36f6193.camel@linux.ibm.com>
Subject: Re: [PATCH v2] s390/ipl: fix virtual vs physical address confusion
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-integrity@vger.kernel.org
Date:   Wed, 16 Aug 2023 13:34:55 -0400
In-Reply-To: <20230816154419.29011-A-hca@linux.ibm.com>
References: <20230816132942.2540411-1-agordeev@linux.ibm.com>
         <20230816154419.29011-A-hca@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _aPcZM2A9bpN9gnvYu4fx0UPGgAMfwJI
X-Proofpoint-ORIG-GUID: _aPcZM2A9bpN9gnvYu4fx0UPGgAMfwJI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=832
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160159
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-16 at 17:44 +0200, Heiko Carstens wrote:
> On Wed, Aug 16, 2023 at 03:29:42PM +0200, Alexander Gordeev wrote:
> > The value of ipl_cert_list_addr boot variable contains
> > a physical address, which is used directly. That works
> > because virtual and physical address spaces are currently
> > the same, but otherwise it is wrong.
> > 
> > While at it, fix also a comment for the platform keyring.
> > 
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> >  arch/s390/kernel/machine_kexec_file.c             | 4 ++--
> >  arch/s390/kernel/setup.c                          | 2 +-
> >  security/integrity/platform_certs/load_ipl_s390.c | 4 ++--
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> Mimi, Jarkko, any objections from your side?
> I would take this via the s390 tree.

No objections from my side.

-- 
thanks,

Mimi

