Return-Path: <linux-kernel+bounces-97322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D78768C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07817287DDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAF618C3D;
	Fri,  8 Mar 2024 16:46:25 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111236D;
	Fri,  8 Mar 2024 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916385; cv=none; b=EY9WJppOM4McWhbFbOeMRjGLbsswRa3QlwSTStxCI8+Fm6aetpEe8OfiUC/p0tXMc7h1YW3pLg7e5jvglQbQBcMhpQZPtqXrFvRj7fXqafKy7M8/99p+eUx/SK7ZV/cMPa0kMRjCOqWKVYodSfpf84FNqiddiw/39u8yNECAdd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916385; c=relaxed/simple;
	bh=Q9JbJgy4s95+FVzuI2yxuPSyR9uhk2IBqK8U1Ci2sa0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UG7JV29LabZK0eJGDGDjnuISBlF2+hMuzw8yZespSIm8ek95jnvyrAtIm/u9DEYHsnxtWyceLXC13qRN/lTlCGdAitAgSMYb+e8pUpUUmxt4jBlKRiQWY6ZCDDVAbOIjBGgBNGJ13Y7hTDIblmsb/dIebSNniRCdYMPfMxZ8OCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Trrm457q1z9yjbF;
	Sat,  9 Mar 2024 00:12:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6A32E140590;
	Sat,  9 Mar 2024 00:27:52 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXyxR3POtl6xr2Aw--.9011S2;
	Fri, 08 Mar 2024 17:27:51 +0100 (CET)
Message-ID: <523a37b29820fe98151b1d608f77b88cc026a91d.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH 6/8] ima: Use digest cache for measurement
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, corbet@lwn.net,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
 hch@lst.de,  mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
 dhowells@redhat.com,  jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com,
 petr.vorel@gmail.com,  petrtesarik@huaweicloud.com, mzerqung@0pointer.de,
 kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 08 Mar 2024 17:27:31 +0100
In-Reply-To: <acfb4159b16b84d8fa1517d6870edaaaadf901c8.camel@linux.ibm.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-7-roberto.sassu@huaweicloud.com>
	 <acfb4159b16b84d8fa1517d6870edaaaadf901c8.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDXyxR3POtl6xr2Aw--.9011S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1kXF48KFy7CFykuF48JFb_yoW7Gr18pa
	97uF12kFs5Wr1fGF13Aa12vF4xtrWktF47Jws8WF1Yyan8Xrn29w1rtw15ZryfAr48Za17
	tF4UKrsxZF1qvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUoj
	jgUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj5ckyQAEsZ

On Fri, 2024-03-08 at 11:08 -0500, Mimi Zohar wrote:
> Hi Roberto,
>=20
> > diff --git a/security/integrity/ima/ima_main.c
> > b/security/integrity/ima/ima_main.c
> > index 3fc48214850a..48a09747ae7a 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -222,7 +222,9 @@ static int process_measurement(struct file *file, c=
onst
> > struct cred *cred,
> >  	bool violation_check;
> >  	enum hash_algo hash_algo;
> >  	unsigned int allowed_algos =3D 0;
> > -	u64 verif_mask =3D 0;
> > +	u64 verif_mask =3D 0, *verif_mask_ptr, policy_mask =3D 0, allow_mask =
=3D 0;
> > +	struct digest_cache *digest_cache =3D NULL, *found_cache;
> > +	digest_cache_found_t found;
> > =20
> >  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> >  		return 0;
> > @@ -233,7 +235,7 @@ static int process_measurement(struct file *file, c=
onst
> > struct cred *cred,
> >  	 */
> >  	action =3D ima_get_action(file_mnt_idmap(file), inode, cred, secid,
> >  				mask, func, &pcr, &template_desc, NULL,
> > -				&allowed_algos, NULL);
> > +				&allowed_algos, &policy_mask);
> >  	violation_check =3D ((func =3D=3D FILE_CHECK || func =3D=3D MMAP_CHEC=
K ||
> >  			    func =3D=3D MMAP_CHECK_REQPROT) &&
> >  			   (ima_policy_flag & IMA_MEASURE));
> > @@ -364,10 +366,34 @@ static int process_measurement(struct file *file,=
 const
> > struct cred *cred,
> >  	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
> >  		pathname =3D ima_d_path(&file->f_path, &pathbuf, filename);
> > =20
> > +	/*
> > +	 * For now we don't support nested verification with digest caches.
>=20
> I haven't reviewed the digest_cache LSM patch set yet.  What does 'nested=
' mean
> in this context?  Why mention it here?

This is the reason for the check func !=3D DIGEST_LIST_CHECK. Before I
had this check in validate_rule(), but then realized that I would have
to reject rules without 'func=3D'.

Not doing this check means that we could use digest caches also for
verifying digest lists (this is the meaning of nested verification).
This possibility is actually not remote, we would need this
functionality to verify Debian-based distributions.

Now, leaving aside the fact that Debian packages still use MD5 for
checksums (I heard that they would like to switch to SHA256 but didn't
verify if it happened), this would be the chain of verification:

/bin/cat -> md5sums -> coreutils (DEB pkg) -> Packages.gz -> Release

Release is the only file signed with PGP.

I already tried to verify a chain, it works, but I didn't want to
include too many functionality at the beginning. DEB format is not yet
supported, for RPMs chained verification it is not needed.

It would be fantastic if md5sums (or sha256sums) is directly signed
tough.

> > +	 * Since we allow IMA policy rules without func=3D, we have to enforc=
e
> > +	 * this restriction here.
> > +	 */
> > +	if (rc =3D=3D 0 && policy_mask && func !=3D DIGEST_LIST_CHECK)
> > +		digest_cache =3D digest_cache_get(file_dentry(file));
>=20
> So whether or not a DIGEST_LIST_CHECK policy rule even exists,
> digest_cache_get() will be called.  Similarly, even if a digest_cache lis=
t
> hasn't been measured or appraised, digest_cache_get() will be called.
>=20
> Basically every file in policy will check the digest_cache.

Only if there is 'digest_cache=3Dcontent' in the matching rule.

> > +
> > +	if (digest_cache) {
> > +		found =3D digest_cache_lookup(file_dentry(file), digest_cache,
> > +					    iint->ima_hash->digest,
> > +					    iint->ima_hash->algo);
> > +		/* AND what is allowed by the policy, and what IMA verified. */
> > +		if (found) {
> > +			found_cache =3D digest_cache_from_found_t(found);
> > +			verif_mask_ptr =3D digest_cache_verif_get(found_cache,
> > +								"ima");
>=20
> Instead of using "verif_{set,get}' consider using '{set,get}_usage', wher=
e usage
> here means measure or appraise.

Usage might make sense for IMA, not sure for any other user.

> > +			if (verif_mask_ptr)
> > +				allow_mask =3D policy_mask & *verif_mask_ptr;
> > +		}
> > +
> > +		digest_cache_put(digest_cache);
> > +	}
> > +
>=20
> I'm wondering if it makes sense to create IMA wrappers for each of the
> digest_cache functions - checking the digest_cache for the hash, setting =
the
> digest_cache permitted usage, etc - and put all of them in a separate
> ima_digest_cache.c file.  The file would only be included in the Makefile=
 if
> digest_cache is configured.

It would be fine for me.

> In this file you could define a static local global variable to detect wh=
ether
> the digest_cache is ready to be used.  Only after successfully measuring =
and
> appraising a digest_cache list, based on policy, set the variable.

Ok, something similar to ima_policy_flag.

> >  	if (action & IMA_MEASURE)
> >  		ima_store_measurement(iint, file, pathname,
> >  				      xattr_value, xattr_len, modsig, pcr,
> > -				      template_desc);
> > +				      template_desc, allow_mask);
>=20
> 'allowed_usage'?

Sure, I started renaming them.

Thanks

Roberto

> >  	if (rc =3D=3D 0 && (action & IMA_APPRAISE_SUBMASK)) {
> >  		rc =3D ima_check_blacklist(iint, modsig, pcr);
> >  		if (rc !=3D -EPERM) {
>=20
> thanks,
>=20
> Mimi


