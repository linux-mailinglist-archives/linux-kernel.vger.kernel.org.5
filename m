Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F1378C3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjH2L6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjH2L5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:57:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFB919F;
        Tue, 29 Aug 2023 04:57:36 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TBu5iB027092;
        Tue, 29 Aug 2023 11:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=XKNzpjIMizmE1yoCpdDi1AcUjsxJu19awOuBKIPruYc=;
 b=DPFf14kI5HZyyAxgkVibrdK40zXqZPa5r0bucfwQCtkgspNWeRP05mV2YLR2m5NDwN+J
 8vR7KNysubtJHJ+1djjfjBM4NqYXbHA/4OIb4Op2/ECw95Y8obqbXknUdE/RGIA97GWU
 HPOw8wPKgqzO06UHlInriAsgAF5g7h2gBpmSMVRTNT9XOOSfiuU43wE0H92KMa1ucI3E
 ij+cFFO+QtDC2dfhE0TIxaAH0YKffdcjhyiQ7pctgcrncYbDf0FbAmFbbNwVkzR2owZx
 u2OSv6OvQq9siIuiyrYDzkVQua02LmxpdPh1ALDZU3+BuDC5vJ2JqPfSkMiUnJSCn7yh rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssg84g0qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 11:57:05 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TBuZpx029169;
        Tue, 29 Aug 2023 11:57:05 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssg84g0q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 11:57:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TB1NSh014168;
        Tue, 29 Aug 2023 11:57:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxjtp3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 11:57:04 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37TBv3HN066282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 11:57:03 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 576FA58068;
        Tue, 29 Aug 2023 11:57:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 416785805A;
        Tue, 29 Aug 2023 11:57:03 +0000 (GMT)
Received: from localhost (unknown [9.61.165.118])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Aug 2023 11:57:03 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Daniel =?utf-8?Q?D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        mpe@ellerman.id.au
Subject: Re: [PATCH 4.14 00/57] 4.14.324-rc1 review
In-Reply-To: <868cd8e3-2e7e-7b98-0a6e-e5586cb6ab0d@linaro.org>
References: <20230828101144.231099710@linuxfoundation.org>
 <868cd8e3-2e7e-7b98-0a6e-e5586cb6ab0d@linaro.org>
Date:   Tue, 29 Aug 2023 06:57:03 -0500
Message-ID: <87bkeqysc0.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tNG9XWO3BqGFluEAbrfS9r4YfGSsVbxi
X-Proofpoint-GUID: PIGYm00qPEIDUO_bj_Cg9gsarDUM-aIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_08,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=719
 malwarescore=0 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel D=C3=ADaz <daniel.diaz@linaro.org> writes:
>
> We see this build regression on PowerPC with GCC-8 and GCC-12:
> -----8<-----
>    /builds/linux/arch/powerpc/kernel/rtas_flash.c: In function 'rtas_flas=
h_init':
>    /builds/linux/arch/powerpc/kernel/rtas_flash.c:717:22: error: implicit=
 declaration of function 'kmem_cache_create_usercopy'; did you mean 'kmem_c=
ache_create'? [-Werror=3Dimplicit-function-declaration]
>      flash_block_cache =3D kmem_cache_create_usercopy("rtas_flash_cache",
>                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>                          kmem_cache_create
>    /builds/linux/arch/powerpc/kernel/rtas_flash.c:717:20: error: assignme=
nt to 'struct kmem_cache *' from 'int' makes pointer from integer without a=
 cast [-Werror=3Dint-conversion]
>      flash_block_cache =3D kmem_cache_create_usercopy("rtas_flash_cache",
>                        ^
> ----->8-----
>
> That's on defconfig and cell_defconfig.
>
> Bisection points to "powerpc/rtas_flash: allow user copy to flash
> block cache objects" (5190538c66e5). Reverting that patch makes the
> build pass again.

That change should not be applied to 4.14.x. The problem it fixes is not
present in that version.
