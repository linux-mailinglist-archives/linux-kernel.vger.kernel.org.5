Return-Path: <linux-kernel+bounces-98817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6264877FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39121C215AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A33C484;
	Mon, 11 Mar 2024 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jDJKrIIV"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772013B79F;
	Mon, 11 Mar 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159654; cv=none; b=HvsQ6YtU9WBs2pwEoFN8m76uY1ltO8iMajwqlDb7aeNpnsDZCxd7vn458u8ocJhTvXXb9jg7m2eh1qInniLCcTHEtbeWSesIgedJ31ck9Y92RLmAneS/5dUJyen/yDWDDG1Bhsk0J8gltjyVFCC8V8V1XnnQAfmfVBtbbF4u/+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159654; c=relaxed/simple;
	bh=lT6ed5D2J62Z0WKSMowg1OKClWI1/Su5wTS+SRzONWc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=FtrhXUYojvm6W+2b0Hq+UpOQb3ByK7CRI/vzigF8y8urKOxf+OGvEJhTMUrc5/yZdzioQcnRqYNxC2sK1Cd5vv2pGqP2PqOYrIzh2koNUWYHwFQ62Ej2LgQoJPkPKTXbJo19vAtnGF2i44s0XNggoaYk7JvbcPVClD26VUv2pOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jDJKrIIV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BCCZUw010210;
	Mon, 11 Mar 2024 12:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=lwhdy7sEmrfhsh15zlnWmnETxiy2rvRxB8qfY+77AyA=;
 b=jDJKrIIV954ys97/Gd1GI8allhvbwWUwScaZum+7Cv+H+DbUMP2S2NzLUvUYngR/rjAp
 0oeI/PXvasP6NrZpe60kGv4971jF4k/gfAcpAsrw4G+kkF2X7f54Ef+NBLWU/oUCqfuA
 r3Rqq3FqDaSzSAfFnBJkEk/osYtXGck6PQm1FpZhwZJ5C2Ns4DddoUa3AHfPLAguQy+W
 nKTSrWwfRbwAuiJibbkiGY1HM1gKjclt+Hjj9HZAMWkcLXR7/ADjLOJSOvb0uY/J6ucO
 B+IhEKSLrFO714V07rvnuRtadjprMpVPb8eIZ/emQCQMAicBKk35DEkj58jlfrdUFAgH bw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt1rm853t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:20:02 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BCCajx010239;
	Mon, 11 Mar 2024 12:20:02 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt1rm8539-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:20:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42BBqlTd013459;
	Mon, 11 Mar 2024 12:20:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4ak0228-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:20:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BCJwtC46203286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 12:20:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D8F058043;
	Mon, 11 Mar 2024 12:19:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3E075805D;
	Mon, 11 Mar 2024 12:19:56 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.133.174])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 12:19:56 +0000 (GMT)
Message-ID: <d923917cfd387cbf275eece78406f9ad07e6d0d3.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 8/8] ima: Detect if digest cache changed since last
 measurement/appraisal
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
Date: Mon, 11 Mar 2024 08:19:56 -0400
In-Reply-To: <4bac45ced03f82c2f3775684368e22db5dafea11.camel@huaweicloud.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-9-roberto.sassu@huaweicloud.com>
	 <ddb1c28356fb8a4dcca9bff6dc206802d7981bb8.camel@linux.ibm.com>
	 <4bac45ced03f82c2f3775684368e22db5dafea11.camel@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: OAzy5FfneaTDWaQX9emmkLnO7yIkUJIp
X-Proofpoint-GUID: wjTTtUEvQirIKc1DyaeYRbb8qa3jMuEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110092

On Mon, 2024-03-11 at 10:11 +0100, Roberto Sassu wrote:
> 
> > > @@ -386,8 +402,6 @@ static int process_measurement(struct file *file,
> > > const
> > > struct cred *cred,
> > >  			if (verif_mask_ptr)
> > >  				allow_mask = policy_mask & *verif_mask_ptr;
> > >  		}
> > > -
> > > -		digest_cache_put(digest_cache);
> > 
> > Keeping a reference to the digest_cache list for each file in the iint cache
> > until the file is re-accessed, might take a while to free.
> 
> Yes, that is the drawback...
> 
> > I'm wondering if it necessary to keep a reference to the digest_cache.  Or
> > is it
> > possible to just compare the existing iint->digest_cache pointer with the
> > current digest_cache pointer?
> 
> If the pointer value is the same, it does not guarantee that it is the
> same digest cache used for the previous verification. It might have
> been freed and reallocated.

Agreed.
> 
> Maybe, if the digest_cache LSM is able to notify to IMA that the digest
> cache changed, so that IMA resets its flags in the integrity metadata,
> we would not need to pin it.

Yes, something similar to the "ima_lsm_policy_notifier".

Mimi


