Return-Path: <linux-kernel+bounces-97102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB39E876591
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6581C2159F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49693BBF5;
	Fri,  8 Mar 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OR2v33ul"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5563B8;
	Fri,  8 Mar 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905593; cv=none; b=H/DXXi6W1kTopeo/OxGe0chgLuNk9dqgvLrlQfG2MXdwL1ztygN+Q0POr9Lrcgxz9oaygGcLnXS285T8dZ0geL05m1D7l4H59oSe7/vpoGwdP7zVPnMsvNidBg9HjVptjDYphgxBF367qWt8hnEM+6eakRnrIURlk/DQbj3mGNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905593; c=relaxed/simple;
	bh=GBFwFYZ4ubg0U+FlRZQiIvGDvUpfu7Sbide83u/wP3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=SaTM7Q802kzg1NtMzxOCoorY81LJoRLVvT5GrBwM3tEjOwJke1BB4KENO/xAOIPL8pDreil89LfNoqd4Efv8ilqW50XU1wbPkUh6nFRg8M7RE2ZE44Jgk7mB4lvm0dWPD4RYkPcl7znVrJ4vOjCJ6Q80FE51uWLcTEa2EdDjQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OR2v33ul; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DCY5s003316;
	Fri, 8 Mar 2024 13:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Z9B5en3b/B8IE/ICyxvk/gv4UnKx7MFoXBu5looV+Ug=;
 b=OR2v33ulhloADO1SAtdMFTTD7q/vlaVe6+dY/hXR/u0sBdpvl9ADuzQs8NjKs5nvvZdR
 pIcsQlL+JCY6Z14zdlhX/SLzuTIXT6S+6NJBtkb5/F+OrA1R6RTM+MjYZyq8KZ06uw9l
 3dxC98FtZQuXsTTFE2k0nctELQZX0Da1WZb04YB+tAYmirWXjuy59twSPDckkASt2uKV
 xvzMEo/HZzoSrenq+tVEKYHTVM51l5Y2dVGJe0YZQSV35FGJ1zZPf/KWiEf8dhEPsMWL
 Ajiv1dAcnI1qzDQqwa4rcIYI+kBpa4Ze5b+YDUk5DOJeqC3GGteqkA+xiHBy98+AiL5j 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr3brgjt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 13:45:48 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428Djkgk001146;
	Fri, 8 Mar 2024 13:45:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr3brgjhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 13:45:46 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428D1emU024185;
	Fri, 8 Mar 2024 13:41:32 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsqxrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 13:41:32 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428DfUma29819268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 13:41:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 112E45804B;
	Fri,  8 Mar 2024 13:41:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D33EF58055;
	Fri,  8 Mar 2024 13:41:27 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.150.204])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 13:41:27 +0000 (GMT)
Message-ID: <3e855b6c0892a00743758fc04bfb183cae2a42ef.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 3/8] ima: Add digest_cache policy keyword
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
Date: Fri, 08 Mar 2024 08:41:27 -0500
In-Reply-To: <71c77bbef487ae3279f0c3f85785bd0c03a4ee8c.camel@huaweicloud.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-4-roberto.sassu@huaweicloud.com>
	 <031d4ff2bf0c04df5f4094989b94f7ce3e3e73f6.camel@linux.ibm.com>
	 <71c77bbef487ae3279f0c3f85785bd0c03a4ee8c.camel@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: 9w5FCygre4tzblgPXK5_lhRgyHoU6pXT
X-Proofpoint-GUID: RvHVb4juFytOgR1T2UgdrpVSMY45jGJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080110

On Fri, 2024-03-08 at 10:05 +0100, Roberto Sassu wrote:
> On Thu, 2024-03-07 at 14:43 -0500, Mimi Zohar wrote:
> > On Wed, 2024-02-14 at 15:35 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Add the 'digest_cache=' policy keyword, to enable the usage of digest
> > > caches for specific IMA actions and purposes.
> > > 
> > > At the moment, it accepts only 'content' as value, as digest caches can be
> > > only used only for measurement and appraisal of file content. In the
> > > future, it might be possible to use them for file metadata too.
> > 
> > At least from this patch, it is unclear why 'digest_cache' requires an
> > option.  
> > The usage - measure, appraise - is based on 'action'.  From an IMA
> > perspective,
> > does the file content make a difference?  And if it did, then file 'data'
> > would
> > parallel file 'metadata'.
> 
> I wanted to express the fact that digest caches, if available, can only
> be used to appraise file data, if there is no metadata (similarly to
> module-style appended signatures).
> 
> That would prevent for example the scenario where appraisal of file
> data is successful without having verified current metadata, and EVM
> attaches to the file a valid HMAC on file close, based on the current
> xattr value (trust at first use).

Correct. There's no requirement for 'security.ima' to exist to calculate the EVM
HMAC.  Before using EVM HMAC, the filesystem needs to be properly labeled by
walking the filesystem.  The HMAC is calculated based on the existing file
metadata.  The first use is during a setup stage and subsequently for new files.

> 
> An IMA rule with 'digest_cache=metadata' would take a different code
> path. It would make IMA send to evm_verifyxattr() the calculated file
> digest (since there is no security.ima), and let EVM calculate and
> search the digest of file metadata in the digest cache.

Ok.  So no 'security.evm' either, but a metadata digest cache.

I understand the need to provide EVM with the file hash in this case, but as
much as possible, IMA and EVM should be independent of each other.

> 
> I didn't go that far yet, but this is more or less what I would like to
> do, also based on my old implementation of the IMA Digest Lists
> extension (which supports file metadata lookup).
> 
> > Without having to pass around "digest_cache_mask" would simplify this patch.
> 
> We need to pass it anyway, to let process_measurement() know that it
> can use digest caches. Or we can make 'flags' in ima_iint_cache a u64,
> and introduce new flags.

It's bad enough that the function parameters change when there's actual data. 
Yes, please increase the size of 'flags' and introduce new flags.

thanks,

Mimi

> > > The 'digest_cache=' keyword can be specified for the subset of IMA hooks
> > > listed in ima_digest_cache_func_allowed().
> > > 
> > > POLICY_CHECK has been excluded for measurement, because policy changes
> > > must
> > > be visible in the IMA measurement list. For appraisal, instead, it might
> > > be
> > > useful to load custom policies in the initial ram disk (no security.ima
> > > xattr).
> > > 
> > > Add the digest_cache_mask member to the ima_rule_entry structure, and set
> > > the flag IMA_DIGEST_CACHE_MEASURE_CONTENT if 'digest_cache=content' was
> > > specified for a measure rule, IMA_DIGEST_CACHE_APPRAISE_CONTENT for an
> > > appraise rule.
> > > 
> > > Propagate the mask down to ima_match_policy() and ima_get_action(), so
> > > that
> > > process_measurement() can make the final decision on whether or not digest
> > > caches should be used to measure/appraise the file being evaluated.
> > > 
> > > Since using digest caches changes the meaning of the IMA measurement list,
> > > which will include only digest lists and unknown files, enforce specifying
> > > 'pcr=' with a non-standard value, when 'digest_cache=content' is specified
> > > in a measure rule.
> > > 
> > > This removes the ambiguity on the meaning of the IMA measurement list.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > 


