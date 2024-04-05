Return-Path: <linux-kernel+bounces-133140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C9E899F65
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B34F282330
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5BC16F0F8;
	Fri,  5 Apr 2024 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mB9nqNnv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49AA16EC10;
	Fri,  5 Apr 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326666; cv=none; b=iQO3O+vS1QW16FiWgLlQOA5b+uVjV4VNVHgm0PQrVes7yTri39Z23C+isirfZKdsfhpsPod6tFYTdacF6OJNygPOy9xHC1a7NA1pP/maUM2Vtk9UwsW5uHEN96TXIzVvZv9EzbbIJtPpbLgGbkX1ivRwKsDc/VzaJivDCIS4r7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326666; c=relaxed/simple;
	bh=U17liQpywJZqzvfF2s5U5/znHXqwcP4t0v/zYuO1Dyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=O2C3Fdd4JuRKDfDVYUVLuJUA6NtHPtmiEn0zSyykIMCz3UoJEEtd1OxNBM6wJ1yY/0qtjohabFe4wqgkS/8fWmUczy5LB2Ic4Z7wO+5B0YJCEZIhcSkBC4AYAOhWs7PgSzV7HVPXK7IdS9D4oqZ0ZOCv8sXclXVGHt2pXf93Qds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mB9nqNnv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435DQXQ1019047;
	Fri, 5 Apr 2024 14:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=TUmKMDwUoLogS/+j4Uv+vxtiIwsSDaKPFGJe3NunF6E=;
 b=mB9nqNnvL5wZrOOSOLtYiCq2FgQzVdHBd2HbB6sEW5V1GfXegQsb8l85qMIbgrL6lUyz
 Kc6GbnG44BOeh5W8I8EPs8pKkyuz5Zbo/XjL8iFaUcSuGpUnayWXomr8MToyiHAug6yw
 qASbPwRjdS843AhgGkLtP4pg2D3Xzmzl+dR+If6OPt1BqsYCxnxfwjMQjqapkdItYFbf
 PYqdKx9Lx2YpUHNcxIoUQE2xh01EK9Adw5RdZUMyLStWMoY4m3dsvjWtA8D3jONu4L6d
 6ggJsGBgKnbJSG6C2IIr1A5FCI1gFx06+7/sj5+KlVBryAqGYkw2CPkr6cTLPWNO0MnU Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xahrur73v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 14:17:14 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 435EHEHT030388;
	Fri, 5 Apr 2024 14:17:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xahrur73s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 14:17:14 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 435CcRkS003612;
	Fri, 5 Apr 2024 14:17:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epyjxgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 14:17:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435EHBgI20251212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 14:17:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 251125806A;
	Fri,  5 Apr 2024 14:17:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ABD358052;
	Fri,  5 Apr 2024 14:17:10 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.142.172])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2024 14:17:10 +0000 (GMT)
Message-ID: <cb683a87f9d6942df057567fbf2de57f83bd6546.camel@linux.ibm.com>
Subject: Re: [PATCH v5][next] integrity: Avoid
 -Wflex-array-member-not-at-end warnings
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva"
 <gustavoars@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Fri, 05 Apr 2024 10:17:09 -0400
In-Reply-To: <d6c9a04e-66e3-4010-9a35-fb5efc3f1af0@embeddedor.com>
References: <Zg7AoOh7CL5ZD/fe@neat>
	 <27d36ec8e0539c5d6bc760de7305299a2142f9f1.camel@linux.ibm.com>
	 <b3956fd36307d33ebbf0e4633e0d2389860cf720.camel@linux.ibm.com>
	 <d6c9a04e-66e3-4010-9a35-fb5efc3f1af0@embeddedor.com>
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
X-Proofpoint-GUID: nTgj8x-mMrz1hQjnt_3Wx53SLRRm0Nm1
X-Proofpoint-ORIG-GUID: ovnVxbgugPSecIjL19HnDdyRy1Wun-bz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_14,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=980 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050102

On Thu, 2024-04-04 at 18:56 -0600, Gustavo A. R. Silva wrote:
> > "checkpatch.pl --strict" complains "CHECK: Alignment should match open
> > parenthesis".  I'll queue the patch, but how about teaching checkpatch.pl to
> > ignore __struct_group()?
> 
> I think this would do it:
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..e229b97f17f6 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3958,7 +3958,7 @@ sub process {
>                          my $rest = $2;
> 
>                          my $pos = pos_last_openparen($rest);
> -                       if ($pos >= 0) {
> +                       if ($pos >= 0 && $rest !~
> /(__)?struct_group(_(tagged|attr))?(\()/) {
>                                  $line =~ /^(\+| )([ \t]*)/;
>                                  my $newindent = $2;
> 
> I'll send a proper patch. Thanks for the suggestion, Mimi.

Thanks, it works.

Mimi


