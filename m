Return-Path: <linux-kernel+bounces-131853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B56898C97
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261C31C269BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD0C6D1B5;
	Thu,  4 Apr 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="accTUUmn"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A814A8B;
	Thu,  4 Apr 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249423; cv=none; b=bqZ0dhjM0hPEPczmpp307C0gFgYPRbtPe8CNcxQi2bsdWNPTyjTd4Z9lf4RHAxmAiFREEXsG3muQWVEGox7G5z7UJ4nzcNPPJGxEjGVqSDWjmfVxyd7wFFtj/U7S6yEva0O5SntmtJeL2OaGC/s+ge4a6FK5TiNnwhwd7f38pic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249423; c=relaxed/simple;
	bh=duuvXRyazU2+2lIzUlGDb5oo8et3T5/0CRetwEqiMgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iWMA8EKNc27r8cKnQkUHwXZJgWk4FInzWb6ClJoLhoPlAIZrvRWbUdWZEE9YPlHSxopRk4PNkxMvgz1bBcPIAQhdyjVFCbo9H1JCeZNdTioJJQPnNF7jAn8gBno98GfHjIiEHixh/Bbldx5Y/Et/TcdTDGLaAroJx0JSx3dYmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=accTUUmn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434FuB8Z020276;
	Thu, 4 Apr 2024 16:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bdVj70TgvvAB/XwbPfr6Rf7uON1edbSCq/OzQHOOv9s=;
 b=accTUUmntu4DgR7NUZDo4p+mCy7P0fKn7263a5qWZ8SBAIv+klBDYwQcrK6YwrnBYA9b
 NtRZPxDfteZjSuGXx3+KKpZlMUhtcW+LAz7XHD8sDMdXVMgPhseT6qY4RdOQwJ2ummun
 LU1JCWhUDk964VwwyuG21s/uioRtZE+qYUmYhHiZ9/BhbSTF58Jqrbf3Sp7DWYvA3l96
 djkHlxBbsXQh08yM9bn3rm0IPyE79M8/A8PSq+AH9ILnQvgoaDrM9+KNLQDnMGaQhXht
 nj+YzrHFuSBv+hx+4P1IYMHIuQsKYoROWTWQ1CYLtAr6Pahah2tCLqAlffid4NVOO87Q vA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9xuw86vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 16:49:59 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 434GnwOS023179;
	Thu, 4 Apr 2024 16:49:58 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9xuw86vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 16:49:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434GVMYq003608;
	Thu, 4 Apr 2024 16:49:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epydaqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 16:49:57 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434Gnskc11469416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 16:49:57 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97D3E58056;
	Thu,  4 Apr 2024 16:49:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0394A5805A;
	Thu,  4 Apr 2024 16:49:54 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.110.28])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 16:49:53 +0000 (GMT)
Message-ID: <27d36ec8e0539c5d6bc760de7305299a2142f9f1.camel@linux.ibm.com>
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
Date: Thu, 04 Apr 2024 12:49:53 -0400
In-Reply-To: <Zg7AoOh7CL5ZD/fe@neat>
References: <Zg7AoOh7CL5ZD/fe@neat>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7G1mvBz-_JYfcWI_EuIHlwQhBX0aA1n1
X-Proofpoint-ORIG-GUID: rGa29e18cm8TrLTRwfsfd7u0yycR1-yR
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
 definitions=2024-04-04_13,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040117

Hi Gustavo,

On Thu, 2024-04-04 at 09:00 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There is currently an object (`hdr)` in `struct ima_max_digest_data`
> that contains a flexible structure (`struct ima_digest_data`):
> 
>  struct ima_max_digest_data {
>         struct ima_digest_data hdr;
>         u8 digest[HASH_MAX_DIGESTSIZE];
>  } __packed;
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of a struct, we use the `__struct_group()` helper to separate
> the flexible array from the rest of the members in the flexible
> structure:
> 
> struct ima_digest_data {
>         __struct_group(ima_digest_data_hdr, hdr, __packed,
> 
>         ... the rest of the members
> 
>         );
>         u8 digest[];
> } __packed;
> 
> And similarly for `struct evm_ima_xattr_data`.
> 
> With the change described above, we can now declare an object of the
> type of the tagged `struct ima_digest_data_hdr`, without embedding the
> flexible array in the middle of another struct:
> 
>  struct ima_max_digest_data {
>         struct ima_digest_data_hdr hdr;
>         u8 digest[HASH_MAX_DIGESTSIZE];
>  } __packed;
> 
> And similarly for `struct evm_digest` and `struct evm_xattr`.
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure.
> 
> So, with these changes, fix the following warnings:
> 
> security/integrity/evm/evm.h:64:32: warning: structure containing a flexible
> array member is not at the end of another structure [-Wflex-array-member-not-
> at-end]
> security/integrity/evm/../integrity.h:40:35: warning: structure containing a
> flexible array member is not at the end of another structure [-Wflex-array-
> member-not-at-end]
> security/integrity/evm/../integrity.h:68:32: warning: structure containing a
> flexible array member is not at the end of another structure [-Wflex-array-
> member-not-at-end]
> security/integrity/ima/../integrity.h:40:35: warning: structure containing a
> flexible array member is not at the end of another structure [-Wflex-array-
> member-not-at-end]
> security/integrity/ima/../integrity.h:68:32: warning: structure containing a
> flexible array member is not at the end of another structure [-Wflex-array-
> member-not-at-end]
> security/integrity/integrity.h:40:35: warning: structure containing a flexible
> array member is not at the end of another structure [-Wflex-array-member-not-
> at-end]
> security/integrity/integrity.h:68:32: warning: structure containing a flexible
> array member is not at the end of another structure [-Wflex-array-member-not-
> at-end]
> security/integrity/platform_certs/../integrity.h:40:35: warning: structure
> containing a flexible array member is not at the end of another structure [-
> Wflex-array-member-not-at-end]
> security/integrity/platform_certs/../integrity.h:68:32: warning: structure
> containing a flexible array member is not at the end of another structure [-
> Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks, Gustavo.  I already applied and tested v4, but was trying to actually
see the errors with before pushing it out.

Mimi 



