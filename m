Return-Path: <linux-kernel+bounces-132082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0CB898F76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910771C27D73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325AD1350DA;
	Thu,  4 Apr 2024 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q/N0Qg7e"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540FA1339BA;
	Thu,  4 Apr 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261548; cv=none; b=ttC0l64VBer80WWnltrHHnrom7P+KH6PN90XTcXoGfgYqIA8QHDmC3HuOsSFooQraLEwCvUUeI0Ur1b9dOifZiG9tMWvHY/7cdCW/3iYHyHoHPb+811HVgzhvovLKuJScEaqm73kdIfe0HO7fVidtB0mJ2DMwGkh2xicIN/VkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261548; c=relaxed/simple;
	bh=EVMGvafgBfGII3RlR8B+OnNiFJ1HBdwxUaoCS0beDwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jANx073DIKO08NdBjpp3qSAH3AVqO/tO6RmIoDX08tpzyf2B9iyuMZDxBQQSHv4+Wc86gaKO16guD2Q4/dtb6BeoDEIgEZdSsHhQq+NyAIR+hgg2AOCD9dZSS+habhNOKQgcKqjCHaZPBAwG+ncoB4WXECXuQpP7Mep7Sbs1zsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q/N0Qg7e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434K4Lif024701;
	Thu, 4 Apr 2024 20:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Vq+lptyiRA9JJ5e/aNhf5SqSn6V7P4PE1G4+0cOGBO8=;
 b=q/N0Qg7eXYklXJJKy7OU7HMJI+I5t5nGr+wqlqvFENVTwHk6aLuKF/p02dFOCb1R2m5z
 v6CgCDNdVMraTxA3E2tViCfDi9EsvUqEUfKqdHjy35dgykdZJK+VIOoIgW1ocMRdrIST
 T4AufXqc+yx6SQT3R6eo2TvvYD656ngycn2PTmYpZ763Ph0JhRG8aKJgcLv5ZhOUots7
 +g5DGSvIMMuo6fLdgSOylNbU+qAXkRLtIe2s3tFAb76j/9Ci6pl4CW63hT+cF4Ddlejm
 flFQqvbfZd9GVz1Y1KkH5rMWrmZHq45z92A+fDnholzzgwBEeV8MiBAJ7OtZqaE87czX kg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xa2w900kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 20:12:00 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 434KBxQS003418;
	Thu, 4 Apr 2024 20:11:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xa2w900k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 20:11:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434JLP0d007723;
	Thu, 4 Apr 2024 20:11:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epwpcx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 20:11:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434KBu806750888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 20:11:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43B6358055;
	Thu,  4 Apr 2024 20:11:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 334045804B;
	Thu,  4 Apr 2024 20:11:55 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.110.28])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 20:11:55 +0000 (GMT)
Message-ID: <b3956fd36307d33ebbf0e4633e0d2389860cf720.camel@linux.ibm.com>
Subject: Re: [PATCH v5][next] integrity: Avoid
 -Wflex-array-member-not-at-end warnings
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Thu, 04 Apr 2024 16:11:54 -0400
In-Reply-To: <27d36ec8e0539c5d6bc760de7305299a2142f9f1.camel@linux.ibm.com>
References: <Zg7AoOh7CL5ZD/fe@neat>
	 <27d36ec8e0539c5d6bc760de7305299a2142f9f1.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cKQ50c5FNWZMYVHwbzG33Sdc9xNugIbj
X-Proofpoint-GUID: 6QGzaMYvKNPwzhV7Q8RfDJC5OcsCCgGz
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_16,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404040144

On Thu, 2024-04-04 at 12:49 -0400, Mimi Zohar wrote:
> Hi Gustavo,
> 
> On Thu, 2024-04-04 at 09:00 -0600, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> > ready to enable it globally.
> > 
> > There is currently an object (`hdr)` in `struct ima_max_digest_data`
> > that contains a flexible structure (`struct ima_digest_data`):
> > 
> >  struct ima_max_digest_data {
> >         struct ima_digest_data hdr;
> >         u8 digest[HASH_MAX_DIGESTSIZE];
> >  } __packed;
> > 
> > So, in order to avoid ending up with a flexible-array member in the
> > middle of a struct, we use the `__struct_group()` helper to separate
> > the flexible array from the rest of the members in the flexible
> > structure:
> > 
> > struct ima_digest_data {
> >         __struct_group(ima_digest_data_hdr, hdr, __packed,
> > 
> >         ... the rest of the members
> > 
> >         );
> >         u8 digest[];
> > } __packed;
> > 
> > And similarly for `struct evm_ima_xattr_data`.
> > 
> > With the change described above, we can now declare an object of the
> > type of the tagged `struct ima_digest_data_hdr`, without embedding the
> > flexible array in the middle of another struct:
> > 
> >  struct ima_max_digest_data {
> >         struct ima_digest_data_hdr hdr;
> >         u8 digest[HASH_MAX_DIGESTSIZE];
> >  } __packed;
> > 
> > And similarly for `struct evm_digest` and `struct evm_xattr`.
> > 
> > We also use `container_of()` whenever we need to retrieve a pointer to
> > the flexible structure.
> > 
> > So, with these changes, fix the following warnings:
> > 
> > security/integrity/evm/evm.h:64:32: warning: structure containing a flexible
> > array member is not at the end of another structure [-Wflex-array-member-
> > not-
> > at-end]
> > security/integrity/evm/../integrity.h:40:35: warning: structure containing a
> > flexible array member is not at the end of another structure [-Wflex-array-
> > member-not-at-end]
> > security/integrity/evm/../integrity.h:68:32: warning: structure containing a
> > flexible array member is not at the end of another structure [-Wflex-array-
> > member-not-at-end]
> > security/integrity/ima/../integrity.h:40:35: warning: structure containing a
> > flexible array member is not at the end of another structure [-Wflex-array-
> > member-not-at-end]
> > security/integrity/ima/../integrity.h:68:32: warning: structure containing a
> > flexible array member is not at the end of another structure [-Wflex-array-
> > member-not-at-end]
> > security/integrity/integrity.h:40:35: warning: structure containing a
> > flexible
> > array member is not at the end of another structure [-Wflex-array-member-
> > not-
> > at-end]
> > security/integrity/integrity.h:68:32: warning: structure containing a
> > flexible
> > array member is not at the end of another structure [-Wflex-array-member-
> > not-
> > at-end]
> > security/integrity/platform_certs/../integrity.h:40:35: warning: structure
> > containing a flexible array member is not at the end of another structure [-
> > Wflex-array-member-not-at-end]
> > security/integrity/platform_certs/../integrity.h:68:32: warning: structure
> > containing a flexible array member is not at the end of another structure [-
> > Wflex-array-member-not-at-end]
> > 
> > Link: https://github.com/KSPP/linux/issues/202
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> Thanks, Gustavo.  I already applied and tested v4, but was trying to actually
> see the errors with before pushing it out.

With GCC-14, I'm seeing the "warning: structure containing a flexible array
member is not at the end of another structure [-Wflex-array-member-not-at-end]"
messages.  As expected, with the patch no warnings.

"checkpatch.pl --strict" complains "CHECK: Alignment should match open
parenthesis".  I'll queue the patch, but how about teaching checkpatch.pl to
ignore __struct_group()?

thanks,

Mimi


