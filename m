Return-Path: <linux-kernel+bounces-48623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39290845EFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84031F2E99E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CC56FBAE;
	Thu,  1 Feb 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ti1A9VTp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B207C6D9;
	Thu,  1 Feb 2024 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810042; cv=none; b=aVgVsCUeVpMdjFnhCbwH/Mb+tmqbOh31eSZrNd09i7B+/75uupIblf+mpBk4f6h2Yt/fJ9twgSql6fiByCEcAZ2+j+h68vHXt3fq8eqYuQCRIOqcH9DpxHQcR5rQPuV8AbGpTLSL8Av2Xk+omPkXrjYHaNMl1cULMH0SlxhNUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810042; c=relaxed/simple;
	bh=dpOUcu7IbHDeCEh2JaReFBEDT7bkJ64tQ36kol86cPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=c6UGCYamwFN/W6+ouevUlcPPYdrq9BDIfV5rFloLpiEG6mQCTALVaBv+FLO+fYn6nMVQTIfC4iqGV7O6c31nLUTn8ZgM/8Pmrlwyj5P8zJrIuXIckvz9VTKp/GoyINDBQrSSWS879289RMloIohXEqZdg3hE8CLbyFBgbE8Li4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ti1A9VTp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411HavJa025720;
	Thu, 1 Feb 2024 17:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=spgR5xcN8f3RR5bhl5lyotJJgbnhsAwYmCkAPk2siAY=;
 b=Ti1A9VTpPoQ3LwgPNEfTvfWk13fTiG3ogOG77yTG6Bvdn528GaVpKlO9j26nJXfDyncK
 5nNgAdPtYUh3FzMoRrObIB5LmddCt/eUkcLWiJHjUxJXsvGUOaPoezkFHnoP7cA7kOPj
 iUu7fWCp2fmKzF0wWCccHwLaa2mIG/AnXW3P4sSq7SQXQXYCRhFIsYsuXHDzNy6H9kop
 2t7FAuSjwygSuBITGNIGpI6x1xEOV1KY6/NMl7cq/bIoasc/AGS1xn6VwQyZPlroFT15
 8hrnJOP8f/AECrxQjla+Ww2VuCXz1O2eg1l40b8M617ku/KAGg/Lfy/2wllPPot96Ncr JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0e093xg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:53:44 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 411HbEUN028573;
	Thu, 1 Feb 2024 17:53:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0e093xfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:53:44 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 411Ft7vj010833;
	Thu, 1 Feb 2024 17:53:43 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5p5ytn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:53:43 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 411HrgJw23462472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 17:53:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D779B58056;
	Thu,  1 Feb 2024 17:53:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22BD558052;
	Thu,  1 Feb 2024 17:53:42 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Feb 2024 17:53:42 +0000 (GMT)
Message-ID: <42a1c6674ed61fe3cd77cab1709d253be4862778.camel@linux.ibm.com>
Subject: Re: [PATCH 5/5] evm: Enforce signatures on unsupported filesystem
 for EVM_INIT_X509
From: Mimi Zohar <zohar@linux.ibm.com>
To: Amir Goldstein <amir73il@gmail.com>,
        Stefan Berger
 <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, miklos@szeredi.hu,
        Christian Brauner
 <brauner@kernel.org>
Date: Thu, 01 Feb 2024 12:53:31 -0500
In-Reply-To: <CAOQ4uxikngPf5t9zmJqV3SKkdmMm6ZwF095uoa6HLN-yAkdnSQ@mail.gmail.com>
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
	 <20240130214620.3155380-6-stefanb@linux.ibm.com>
	 <CAOQ4uxikngPf5t9zmJqV3SKkdmMm6ZwF095uoa6HLN-yAkdnSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J7feQ9CQco5ZnsnnPkG5WW_NEmb2vFcV
X-Proofpoint-ORIG-GUID: HjSDWdz8hgUqKiEydvFJWr1dmCEdwfff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010138

On Wed, 2024-01-31 at 16:06 +0200, Amir Goldstein wrote:
> On Tue, Jan 30, 2024 at 11:46 PM Stefan Berger <stefanb@linux.ibm.com
> > wrote:
> > Unsupported filesystems currently do not enforce any signatures.
> > Add
> > support for signature enforcement of the "original" and "portable &
> > immutable" signatures when EVM_INIT_X509 is enabled.
> > 
> > The "original" signature type contains filesystem specific
> > metadata.
> > Thus it cannot be copied up and verified. However with
> > EVM_INIT_X509
> > and EVM_ALLOW_METADATA_WRITES enabled, the "original" file
> > signature
> > may be written.
> > 
> > When EVM_ALLOW_METADATA_WRITES is not set or once it is removed
> > from
> > /sys/kernel/security/evm by setting EVM_INIT_HMAC for example, it
> > is not
> > possible to write or remove xattrs on the overlay filesystem.
> > 
> > This change still prevents EVM from writing HMAC signatures on
> > unsupported filesystem when EVM_INIT_HMAC is enabled.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  security/integrity/evm/evm_main.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/security/integrity/evm/evm_main.c
> > b/security/integrity/evm/evm_main.c
> > index e96d127b48a2..f49609dfcbc7 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -192,7 +192,11 @@ static enum integrity_status
> > evm_verify_hmac(struct dentry *dentry,
> >                      iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
> >                 return iint->evm_status;
> > 
> > -       if (is_unsupported_fs(dentry))
> > +       /*
> > +        * On unsupported filesystems with EVM_INIT_X509 not
> > enabled, skip
> > +        * signature verification.
> > +        */
> > +       if (!(evm_initialized & EVM_INIT_X509) &&
> > is_unsupported_fs(dentry))
> >                 return INTEGRITY_UNKNOWN;
> > 
> 
> Are the names is_unsupported_fs() and SB_I_EVM_UNSUPPORTED still
> a good description of what overlayfs is after this change?
> Is EVM really not supported on overlayfs after this change?
> 
> Would you consider a better descriptive name, for the helper and
> flag,
> at least as descriptive as SB_I_IMA_UNVERIFIABLE_SIGNATURE?

The EVM "portable & immutable" signature can be copied up, because it
does not contain filesystem specific metadata.  Support for the
"original" EVM signature is limited, since it contains filesystem
specific metadata, but it could be used to sign the overlay filesystem
during a "setup" stage.

Like the "original" EVM signatues, the EVM HMAC contains filesystem
specific metadata.  For this reason, they too cannot be copied up.  

In addition, without first verifying the file's EVM HMAC on the lower
filesystem, calculating and writing the EVM HMAC on the overlay could
result in making the lower level file with an invalid HMAC, valid. 

SB_I_EVM_UNSUPPORTED could be renamed SB_I_EVM_HMAC_UNSUPPORTED.


Mimi


