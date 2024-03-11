Return-Path: <linux-kernel+bounces-98849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A187803D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C044D284C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9CA3D3A5;
	Mon, 11 Mar 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DeEgByOJ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E022F07;
	Mon, 11 Mar 2024 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162159; cv=none; b=DDhUWQjqO0QwqvssBRRaet2TWF7hTbub/EUFEQidCeCLPIFWLWFahze4aVuyjLfbd0eAkWQmSJJjyBJ1VtyG1TadZHLAFr7/8c5C0MyqvO9lPOTyY21aOqDG9Mp4C6F+VdblCQLsSaCbxj/EK4cZMUsFUI7mp5B7scO5sgZFee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162159; c=relaxed/simple;
	bh=b2m6reMxwKCNgla1SqFeghA07C0xRGg0cSYvjVVdNuY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=ju1XMa8b0uC0eWp7+AuRRkBGx9wFIVq2gZoHvvXEM4tZt8wqJZ2pGyPVFSSsADT1zAUAC95l4Id4B7ZjnYWHWaoARDWMprSygPFV6F4E7KYPiNAmpQbwmHPQLczikVagqc79C4+6zN+Pd9RMQFaZwF141X6tUZ6stfHqZWhwYSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DeEgByOJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BCu8vr002031;
	Mon, 11 Mar 2024 13:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WzlWfdHMjTYsdI0QpojR5FBtLlPJTOzFYIM7zvBRPGw=;
 b=DeEgByOJThF3FrX2pYJicKA6T+K0OxkScpwFL2g+lyYfE30RkbVVvm2UYdAmOch8cwLN
 FCvkC2pkHQRMpBOZ+Bs1kbGS3XiF1OQLriE8ACtrglS6sbOPYmZA+0b0VYBMvbXkKA4n
 viYkf8Zn3frs3xnahlUkc9ThpU1HZOplj6KNWP8mEm9wZjne2NPVBeIeYlDMW8aDaP+W
 LS6blA51Q8Yv0D3lhJkbQ9qa0CHNc+VwTwbvvwfqgzVjREaVOfvzFhFr6Z1rfh9D966f
 G8ufpikofzR4VhMwKR8vCULXZ61cCH9ggDZv45D58AxUY1PRTYRyAHKreHhiF/POCSC8 hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt1yk8gwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 13:01:16 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BCwi7C009716;
	Mon, 11 Mar 2024 13:01:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt1yk8gs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 13:01:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42BCx5wO015485;
	Mon, 11 Mar 2024 13:01:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fygrh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 13:01:08 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BD16MZ34144698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 13:01:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78BAF5805E;
	Mon, 11 Mar 2024 13:01:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C7EA5805B;
	Mon, 11 Mar 2024 13:01:04 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.133.174])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 13:01:04 +0000 (GMT)
Message-ID: <3d937327f3c91351c3c3cd4877c121b9b1405868.camel@linux.ibm.com>
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
Date: Mon, 11 Mar 2024 09:01:03 -0400
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
X-Proofpoint-ORIG-GUID: 99p9g0zYnCT7adUFJCgNmr0A3rZT0qII
X-Proofpoint-GUID: xUGCBjq3AdhUXUp0olxrxUrIm-1VapzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110098

On Wed, 2024-02-14 at 15:35 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Specify the 'digest_cache_measure' boot-time policy with 'ima_policy=' in
> the kernel command line to add the following rule at the beginning of the
> IMA policy, before other rules:
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

Defining two new built-in policies - digest_cache_measure, digest_cache_appraise
- in a single patch would be acceptable, if there wasn't anything else going on.

Changing other policy rules should not be made in this patch.  A clear
explanation as to why other policy rules need to be modified is needed.  It
shouldn't be hidden here.

thanks,

Mimi

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 


