Return-Path: <linux-kernel+bounces-98584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB10877C50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5582822E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1161642F;
	Mon, 11 Mar 2024 09:12:37 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337214271;
	Mon, 11 Mar 2024 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148357; cv=none; b=LqK2bGfPxqqJX+xmAFF2zhb1j/Q2CqwPAkiJlZbbJUtpZ9GClZEylLrzKGhjOauqV5MvzQadVPWgrWCN3MGqt4/4GPBk8hPZuJ78NOmI5Ney5buHw9mJLT5iaO2AxmZ1/tOcLq0OBM15YeRrKFZMKkL4PUEazQEAZMGSML7ydFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148357; c=relaxed/simple;
	bh=mwhr+GeZD2Fwv7OWp5evIy1WT7xupje/d5vp5keqrbc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MQ+TKucdRx86OLfFAqu3D2IKhm/CJ8Lh/AaD39If6WvSanNQA6Q9luK+47VC9ikyLBZW9KvsjdT7qmY85BN+0B85tUZyn5nT7BY2iT3WB/kB1SOGZazQDTwvBxp3Z/VCG9cr8dzvqBzetaCjzXDueKZWwj+6C/kbRyRwv2e8VnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TtVy01X1Vz9y0kN;
	Mon, 11 Mar 2024 16:56:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 1EEF5140ED8;
	Mon, 11 Mar 2024 17:12:15 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCHcibeyu5l0rgXBA--.16486S2;
	Mon, 11 Mar 2024 10:12:14 +0100 (CET)
Message-ID: <4bac45ced03f82c2f3775684368e22db5dafea11.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH 8/8] ima: Detect if digest cache changed since last
 measurement/appraisal
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
Date: Mon, 11 Mar 2024 10:11:54 +0100
In-Reply-To: <ddb1c28356fb8a4dcca9bff6dc206802d7981bb8.camel@linux.ibm.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-9-roberto.sassu@huaweicloud.com>
	 <ddb1c28356fb8a4dcca9bff6dc206802d7981bb8.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCHcibeyu5l0rgXBA--.16486S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15ury7ArW3WF1rGw43GFg_yoW5XFW7pa
	93CF1UKF4rZrW3G3W7Aa12vF18trZaqF4xua1Ygw1fArs5Xr9Yyw4rAw1UWry8Cr4UZanF
	qw4Ygrs8Z3WDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73D
	UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBF1jj5szTAABsC

On Fri, 2024-03-08 at 12:35 -0500, Mimi Zohar wrote:
> Hi Roberto,
>=20
> > b/security/integrity/ima/ima_main.c
> > index a66522a22cbc..e1b2f5737753 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -301,6 +301,15 @@ static int process_measurement(struct file *file, =
const
> > struct cred *cred,
> >  		}
> >  	}
> > =20
> > +	/* Check if digest cache changed since last measurement/appraisal. */
> > +	if (iint->digest_cache &&
> > +	    digest_cache_changed(inode, iint->digest_cache)) {
> > +		iint->flags &=3D ~IMA_DONE_MASK;
> > +		iint->measured_pcrs =3D 0;
> > +		digest_cache_put(iint->digest_cache);
> > +		iint->digest_cache =3D NULL;
> > +	}
> > +
> >  	/* Determine if already appraised/measured based on bitmask
> >  	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
> >  	 *  IMA_AUDIT, IMA_AUDITED)
> > @@ -371,8 +380,15 @@ static int process_measurement(struct file *file, =
const
> > struct cred *cred,
> >  	 * Since we allow IMA policy rules without func=3D, we have to enforc=
e
> >  	 * this restriction here.
> >  	 */
> > -	if (rc =3D=3D 0 && policy_mask && func !=3D DIGEST_LIST_CHECK)
> > -		digest_cache =3D digest_cache_get(file_dentry(file));
> > +	if (rc =3D=3D 0 && policy_mask && func !=3D DIGEST_LIST_CHECK) {
> > +		if (!iint->digest_cache) {
> > +			/* Released by ima_iint_free(). */
> > +			digest_cache =3D digest_cache_get(file_dentry(file));
> > +			iint->digest_cache =3D digest_cache;
> > +		} else {
> > +			digest_cache =3D iint->digest_cache;
> > +		}
>=20
> Simple cleanup:
> 		if (!iint->digest_cache)
> 			iint->digest_cache =3Ddigest_cache_get(file_dentry(file));
>=20
> 		digest_cache =3D iint->digest_cache;

Thanks.

> > +	}
> > =20
> >  	if (digest_cache) {
> >  		found =3D digest_cache_lookup(file_dentry(file), digest_cache,
> > @@ -386,8 +402,6 @@ static int process_measurement(struct file *file, c=
onst
> > struct cred *cred,
> >  			if (verif_mask_ptr)
> >  				allow_mask =3D policy_mask & *verif_mask_ptr;
> >  		}
> > -
> > -		digest_cache_put(digest_cache);
>=20
> Keeping a reference to the digest_cache list for each file in the iint ca=
che
> until the file is re-accessed, might take a while to free.

Yes, that is the drawback...

> I'm wondering if it necessary to keep a reference to the digest_cache.  O=
r is it
> possible to just compare the existing iint->digest_cache pointer with the
> current digest_cache pointer?

If the pointer value is the same, it does not guarantee that it is the
same digest cache used for the previous verification. It might have
been freed and reallocated.

Maybe, if the digest_cache LSM is able to notify to IMA that the digest
cache changed, so that IMA resets its flags in the integrity metadata,
we would not need to pin it.

Roberto

> thanks,
>=20
> Mimi
>=20
> >  	}
> > =20
> >  	if (action & IMA_MEASURE)
>=20


