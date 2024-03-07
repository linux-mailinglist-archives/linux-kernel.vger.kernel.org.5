Return-Path: <linux-kernel+bounces-96177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53BF875822
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91D41C21892
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14A1386C3;
	Thu,  7 Mar 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q5E6ACEX"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9F7137C5A;
	Thu,  7 Mar 2024 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842680; cv=none; b=heFPavcxxNYeoi2CCILAuWJIDF5RQHu5Iz6VCFriKzOKVW7T4ppVzljJhUR1o1AsdNehAEUjIR3Lav/vsFkou45TphVejBSMHWJM6rONhvBKZHc8X5SJsG0IUb5P1ZpT32O3aIZyIJRzZ874KnKWBklP1KYJletDChZdEPFEYMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842680; c=relaxed/simple;
	bh=r/8blkKqYPsCBkHFNYcQBtfslcTcKITOwPP4iW8Ofpk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=Znf96/L66RbkpV0JN6fC1k15+xADtZJeb2uExLYsT7aCvkVg0kfYsScfT3YYkBCiW7vQKONtQgsM4T0HX+XvI6HeDX7MJYmfRl0tOa3dbP/QwPHw8MRO80YpZ/shQfu+5m0mz4cp6MLNfCCEeoz5B7RyQn/K5p/eEHqofCqo4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q5E6ACEX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427K2M8n024240;
	Thu, 7 Mar 2024 20:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ATyzSmY6hc2fJ6cvh377et3WJ2a2h5UtxL9G4l1VoRQ=;
 b=q5E6ACEXgJ9n/+bofQ45jHmMpHLtkGhtLV0cst3vT5nIgTpSfYbZC6VKXl298Mkhw4oH
 2q6TLgx+QRApD6Md604BGN2ERxMxdWhdRQJATZUGA0hhIUQJk+phHBkWaoltLBtyGiLm
 svcEdbXzyznlzg5MSUTW+7vIL0681EnCyKVSBn4gGaymIc1V5DMHgjEEKG+Sm0aDNo7B
 92IUOKvdI/GUzIEuTOrPB1OSxewib6zFEUmffkwDd2aHlImnQPOy3BzmUdgpwrsGRitw
 PDips5I7zZgVWZWjs+yK+5vvJTu1Y7JauDFritrsEkgoQvkelKJEmaSE4xyumE9tLgDO FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqm8ur7j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 20:17:11 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 427KEjdu026733;
	Thu, 7 Mar 2024 20:17:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqm8ur7gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 20:17:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 427IDGK8006063;
	Thu, 7 Mar 2024 20:17:09 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeetg72m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 20:17:09 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 427KH69H31523288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 20:17:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C44258064;
	Thu,  7 Mar 2024 20:17:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D725258062;
	Thu,  7 Mar 2024 20:17:03 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.133.222])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 20:17:03 +0000 (GMT)
Message-ID: <ed5df367582f0c5e212638a12204fd20fd8e46e5.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 4/8] ima: Add digest_cache_measure and
 digest_cache_appraise boot-time policies
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
        hch@lst.de, mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
        dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
        ppavlu@suse.com, petr.vorel@gmail.com, petrtesarik@huaweicloud.com,
        mzerqung@0pointer.de, kgold@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 07 Mar 2024 15:17:03 -0500
In-Reply-To: <20240214143525.2205481-5-roberto.sassu@huaweicloud.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TfqGrkqKNzvW7VbgqMWaMNGsy172yF4L
X-Proofpoint-ORIG-GUID: w_l64ZQrM3m9TfhqJDI21trE_EDpnMAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_15,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403070142

On Wed, 2024-02-14 at 15:35 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Specify the 'digest_cache_measure' boot-time policy with 'ima_policy=' in
> the kernel command line

The 'built-in' policies may be specified on the boot command line.  Please
update Subject line, to user the term "built-in" as well as here.

>  to add the following rule at the beginning of the
> IMA policy, before other rules:

Comments below...

> 
> measure func=DIGEST_LIST_CHECK pcr=12
> 
> which will measure digest lists into PCR 12 (or the value in
> CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX).
> 
> 'digest_cache_measure' also adds 'digest_cache=content pcr=12' to the other
> measure rules, if they have a compatible IMA hook. The PCR value still
> comes from CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX.
> 
> Specify 'digest_cache_appraise' to add the following rule at the beginning,
> before other rules:
> 
> appraise func=DIGEST_LIST_CHECK appraise_type=imasig|modsig
> 
> which will appraise digest lists with IMA signatures or module-style
> appended signatures.
> 
> 'digest_cache_appraise' also adds 'digest_cache=content' to the other
> appraise rules, if they have a compatible IMA hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 15 ++++++-
>  security/integrity/ima/Kconfig                | 10 +++++
>  security/integrity/ima/ima_policy.c           | 45 +++++++++++++++++++
>  3 files changed, 69 insertions(+), 1 deletion(-)

[...]
 
> @@ -971,6 +1006,16 @@ void __init ima_init_policy(void)
>  {
>  	int build_appraise_entries, arch_entries;
>  
> +	/*
> +	 * We need to load digest cache rules at the beginning, to avoid dont_
> +	 * rules causing ours to not be reached.
> +	 */

"lockdown" trusts IMA to measure and appraise kernel modules, if the rule
exists.  Placing the digest_cache first breaks this trust.

From a trusted and secure boot perspective, the architecture specific policy
rules should not be ignored. Putting the digest_cache before any other rules
will limit others from being able to use digest_cache.

Instead of putting the digest_cache_{measure,appraise} built-in policies first,
skip loading the dont_measure_rules.


Mimi

> +	if (ima_digest_cache_measure)
> +		add_rules(&measure_digest_cache_rule, 1, IMA_DEFAULT_POLICY);
> +
> +	if (ima_digest_cache_appraise)
> +		add_rules(&appraise_digest_cache_rule, 1, IMA_DEFAULT_POLICY);
> +
>  	/* if !ima_policy, we load NO default rules */
>  	if (ima_policy)
>  		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),


