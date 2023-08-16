Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CD777E61D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjHPQOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbjHPQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:13:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0537C114;
        Wed, 16 Aug 2023 09:13:32 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GG8uBL001767;
        Wed, 16 Aug 2023 16:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=e/XIqBPQAX7LPDVtIPmKHP8dCZhB0WFNu7PUiJVkDCE=;
 b=q0/VFjCwQ4CBBIfB0rMgbQ4o9lXiPstzTMnbys0ylIv8QDa4yrwGbSgZoLQAdNfSnyev
 GzZiAJHR5PDty0XGu4RmeJQ5aTNL7tQx+ZyXUNPeFvAVtJyQK1bT2qjrXT4K2C9hQQsM
 Wygv5KnFutqIP/Y6y5Ltgk/VpKLaUhfo4/VIspWb+vLM3h8OCTQICkB2msWScF/PAfcB
 dReTXQCK0eiWOJrUljzJUSx/qLPo2Akz/L1CpNiD0M8CeKy8ct6X0DoamLcd7EvQ6KLS
 l5cXD6GNXp8stuMZKE/sq6/VpuDwAr/Tdtqs1wySE31tORIMzdpb1BruPuMoHxpQTPT6 Og== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh1eq0ghs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 16:13:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFBow9002418;
        Wed, 16 Aug 2023 16:13:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendne8t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 16:13:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GGDPDM6816370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 16:13:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6223958065;
        Wed, 16 Aug 2023 16:13:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5D1558055;
        Wed, 16 Aug 2023 16:13:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.190.160])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 16 Aug 2023 16:13:24 +0000 (GMT)
Message-ID: <f7df1bfc9a2ef4900dccb01ab81aa1fa9aaa6eb9.camel@linux.ibm.com>
Subject: Re: [PATCH v2] s390/ipl: fix virtual vs physical address confusion
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-integrity@vger.kernel.org
Date:   Wed, 16 Aug 2023 12:13:24 -0400
In-Reply-To: <20230816132942.2540411-1-agordeev@linux.ibm.com>
References: <20230816132942.2540411-1-agordeev@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3j84uwq5RE8h16KqQZwa0cEzBsZ6o6P_
X-Proofpoint-GUID: 3j84uwq5RE8h16KqQZwa0cEzBsZ6o6P_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-16 at 15:29 +0200, Alexander Gordeev wrote:
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
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 2df94d32140c..8d207b82d9fe 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -188,7 +188,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
>  	data->memsz = ALIGN(data->memsz, PAGE_SIZE);
>  	buf.mem = data->memsz;
>  
> -	ptr = (void *)ipl_cert_list_addr;
> +	ptr = __va(ipl_cert_list_addr);
>  	end = ptr + ipl_cert_list_size;
>  	ncerts = 0;
>  	while (ptr < end) {
> @@ -200,7 +200,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
>  
>  	addr = data->memsz + data->report->size;
>  	addr += ncerts * sizeof(struct ipl_rb_certificate_entry);
> -	ptr = (void *)ipl_cert_list_addr;
> +	ptr = __va(ipl_cert_list_addr);
>  	while (ptr < end) {
>  		len = *(unsigned int *)ptr;
>  		ptr += sizeof(len);
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 393dd8385506..c744104e4a9c 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -875,7 +875,7 @@ static void __init log_component_list(void)
>  		pr_info("Linux is running with Secure-IPL enabled\n");
>  	else
>  		pr_info("Linux is running with Secure-IPL disabled\n");
> -	ptr = (void *) early_ipl_comp_list_addr;
> +	ptr = __va(early_ipl_comp_list_addr);
>  	end = (void *) ptr + early_ipl_comp_list_size;
>  	pr_info("The IPL report contains the following components:\n");
>  	while (ptr < end) {
> diff --git a/security/integrity/platform_certs/load_ipl_s390.c b/security/integrity/platform_certs/load_ipl_s390.c
> index e769dcb7ea94..c7c381a9ddaa 100644
> --- a/security/integrity/platform_certs/load_ipl_s390.c
> +++ b/security/integrity/platform_certs/load_ipl_s390.c
> @@ -22,8 +22,8 @@ static int __init load_ipl_certs(void)
>  
>  	if (!ipl_cert_list_addr)
>  		return 0;
> -	/* Copy the certificates to the system keyring */
> -	ptr = (void *) ipl_cert_list_addr;
> +	/* Copy the certificates to the platform keyring */
> +	ptr = __va(ipl_cert_list_addr);
>  	end = ptr + ipl_cert_list_size;
>  	while ((void *) ptr < end) {
>  		len = *(unsigned int *) ptr;

ipl_cert_list_addr is defined as an unsigned long.  At this point, the
changes are simple cleanup of removing "(void *)" and replacing it with
__va().

From arch/s390/include/asm/page.h:
#define __pa(x)                 ((unsigned long)(x))
#define __va(x)                 ((void *)(unsigned long)(x))

So, Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

I'm trying to understand if there is a difference between the other
archs and s390; and whether a similar change is needed for the other
archs.  Loading certificates on the other archs call kmalloc to
allocate memory for the certs. Is the memory being allocated on x390
using kmalloc?

-- 
thanks,

Mimi

