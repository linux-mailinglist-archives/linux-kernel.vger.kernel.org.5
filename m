Return-Path: <linux-kernel+bounces-60406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4463B850475
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C913D2835D5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7D6481DD;
	Sat, 10 Feb 2024 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sqvwW7T3"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED54CB51;
	Sat, 10 Feb 2024 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707569822; cv=none; b=FJnzhqG3R9jmqGnxcFvH/p8Uv3bim3JXabJpqGpgTxJL1Ct1kT/ltFhbMRwPzOiO0p8JiYSBCWjnQomFJHyPQwkFqZZa9TDUBJ8E8KkgIxD4zgj+hAajstjM0BcZDIglTKXD3vmITgFgrUZRfhoAOGa0zX46RQhPpjy23q2Ig2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707569822; c=relaxed/simple;
	bh=XveJv1CTfFqEzUlKqPUXlyQYCkmqFnf5OOVS23W/ro8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hfrQIKTrANup0EV0XS+Mc3P6HXiqdbkaJRJ4nnqUlQFJ6QByPNahe0kqAkVZCdl3PIIZLOm6uiwd2xFaXm3LxJvh7LlJpyGRCZDGvJBzJLb3vQB0JWQukoA8SBi50n5onwevHobBdyOI2/o2qc9hqhqrRz6AdS/q3Zg4NyE1ZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sqvwW7T3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41AALlVT021376;
	Sat, 10 Feb 2024 12:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=kcHxy6hR8JksGEBmB7+lME5RD90ChjNcUanlnTwLfK8=;
 b=sqvwW7T3m0oBxIbzTPKoXbPeEabRRXN4EbGdWdKTX0vGaP88z9aytVPQCMFAaR83X6Od
 h5NKx4DaXSMVNiC6GcvJgLqv95zQhzQaS92x5ntkjdVfxTY5FEGe1elnYg2jdAkRB3lF
 s6UNRZBOg33TdjPTnq2Ccpw9KRAqtZQ84A2Ept/S/8cIOfkNwdJ93qCWv58xSdWeoE5u
 xQUHHfzrRtzTP1ymwrDhdt/Mwqhn+u2ALCPmVIp/vXWUK8sI6749Ob12pAlQDDmOvP/O
 L8v96i7d2bauUoGGbnrJ75c5LZThMi73GXVfyu6fqF0mkpGJGZPRrItUjGo7mxOre3v9 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w67aw1u0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 12:56:46 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41ACuj6s016974;
	Sat, 10 Feb 2024 12:56:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w67aw1u01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 12:56:45 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41A9lkLC014765;
	Sat, 10 Feb 2024 12:56:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tph9fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 12:56:44 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41ACufT453018904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Feb 2024 12:56:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BA3158058;
	Sat, 10 Feb 2024 12:56:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66FD058057;
	Sat, 10 Feb 2024 12:56:39 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.183.218])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 10 Feb 2024 12:56:39 +0000 (GMT)
Message-ID: <98bdd564c6bf1894717d060f3187c779e969fc5f.camel@linux.ibm.com>
Subject: Re: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer
 scnprintf() variant
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: Lee Jones <lee@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Finn
 Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>, drew@colorado.edu,
        Tnx
 to <Thomas_Roesch@m2.maus.de>, linux-scsi@vger.kernel.org
Date: Sat, 10 Feb 2024 07:56:38 -0500
In-Reply-To: <20240208102939.GF689448@google.com>
References: <20240208084512.3803250-1-lee@kernel.org>
	 <20240208084512.3803250-4-lee@kernel.org>
	 <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com>
	 <20240208102939.GF689448@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0_0N3qv_PRysYJ0vGkw1IBX5PPhbpYFk
X-Proofpoint-ORIG-GUID: r7E3Cnz4lFaJqGafNEcctfudfxufykah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-10_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=501 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402100110

On Thu, 2024-02-08 at 10:29 +0000, Lee Jones wrote:
> On Thu, 08 Feb 2024, Geert Uytterhoeven wrote:
> 
> > Hi Lee,
> > 
> > Thanks for your patch!
> > 
> > On Thu, Feb 8, 2024 at 9:48 AM Lee Jones <lee@kernel.org> wrote:
> > > There is a general misunderstanding amongst engineers that
> > > {v}snprintf()
> > > returns the length of the data *actually* encoded into the
> > > destination
> > > array.  However, as per the C99 standard {v}snprintf() really
> > > returns
> > > the length of the data that *would have been* written if there
> > > were
> > > enough space for it.  This misunderstanding has led to buffer-
> > > overruns
> > > in the past.  It's generally considered safer to use the
> > > {v}scnprintf()
> > > variants in their place (or even sprintf() in simple cases).  So
> > > let's
> > > do that.
> > 
> > Confused... The return value is not used at all?
> 
> Future proofing.  The idea of the effort is to rid the use entirely.
> 
>  - Usage is inside a sysfs handler passing PAGE_SIZE as the size
>    - s/snprintf/sysfs_emit/
>  - Usage is inside a sysfs handler passing a bespoke value as the
> size
>    - s/snprintf/scnprintf/
>  - Return value used, but does *not* care about overflow
>    - s/snprintf/scnprintf/
>  - Return value used, caller *does* care about overflow
>    - s/snprintf/seq_buf/
>  - Return value not used
>    - s/snprintf/scnprintf/
> 
> This is the final case.

To re-ask Geert's question: the last case can't ever lead to a bug or
problem, what value does churning the kernel to change it provide?  As
Finn said, if we want to deprecate it as a future pattern, put it in
checkpatch.

James


