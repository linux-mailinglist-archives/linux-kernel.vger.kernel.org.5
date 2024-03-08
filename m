Return-Path: <linux-kernel+bounces-96855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE21587623F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AECD1F214A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC7A55E7C;
	Fri,  8 Mar 2024 10:37:25 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B855E62;
	Fri,  8 Mar 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894245; cv=none; b=lfOHHMa6kOsSkersil1tIiQT7NdzlnRh1SiNk+OJV8wwTGR0szrfzK6x/OPZTOdMUQzjUccSrkbpHN8QRjNMpqH2c9xgcfkPGnQkj/g7a05VTVTb+aFM2VaYYnkFULgvvaCmuv+4uylOwax+zH8vKXUiJ9fKhTU/Z354q3eM7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894245; c=relaxed/simple;
	bh=MDdQ3beQ1q4madF/M56EEmJ1IyDRizOjzaekKCVL1RY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BAWEHkyH6NN6O3IJr1jDPPoFZePJFKO37JbFYPggA0kksroZHxGzTT3uSRkRdw/U3jCnMeEkjIj3ECKVLe6P4DlnGFcvfZi9C0Ml3O981dEG2cpEbJxNOduB3u/HsUvYopE67hv11JFVtygNEZV8URQZNtM7up/ZW2rTqdYel8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Trhth3TbGz9xrN2;
	Fri,  8 Mar 2024 18:17:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 59304140558;
	Fri,  8 Mar 2024 18:37:09 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXTBVE6uplNCHyAw--.7639S2;
	Fri, 08 Mar 2024 11:37:08 +0100 (CET)
Message-ID: <e10207bd82ee13fb088f9efc12e10a5478b6926d.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH 4/8] ima: Add digest_cache_measure and
 digest_cache_appraise boot-time policies
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
Date: Fri, 08 Mar 2024 11:36:48 +0100
In-Reply-To: <ed5df367582f0c5e212638a12204fd20fd8e46e5.camel@linux.ibm.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-5-roberto.sassu@huaweicloud.com>
	 <ed5df367582f0c5e212638a12204fd20fd8e46e5.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBXTBVE6uplNCHyAw--.7639S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw43Ww45WFy3Gr4xKF45ZFb_yoWrCF43pa
	yDCF1YkFWDur1fAw1ava18ur4Fy39agF43XayUJ345Ars5XFn2k3W8Aa45urWUZw48X3Z2
	yF4UKr47W34DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBF1jj5shHQABsC

On Thu, 2024-03-07 at 15:17 -0500, Mimi Zohar wrote:
> On Wed, 2024-02-14 at 15:35 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Specify the 'digest_cache_measure' boot-time policy with 'ima_policy=3D=
' in
> > the kernel command line
>=20
> The 'built-in' policies may be specified on the boot command line.  Pleas=
e
> update Subject line, to user the term "built-in" as well as here.

Ok, will do.

> >  to add the following rule at the beginning of the
> > IMA policy, before other rules:
>=20
> Comments below...
>=20
> >=20
> > measure func=3DDIGEST_LIST_CHECK pcr=3D12
> >=20
> > which will measure digest lists into PCR 12 (or the value in
> > CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX).
> >=20
> > 'digest_cache_measure' also adds 'digest_cache=3Dcontent pcr=3D12' to t=
he other
> > measure rules, if they have a compatible IMA hook. The PCR value still
> > comes from CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX.
> >=20
> > Specify 'digest_cache_appraise' to add the following rule at the beginn=
ing,
> > before other rules:
> >=20
> > appraise func=3DDIGEST_LIST_CHECK appraise_type=3Dimasig|modsig
> >=20
> > which will appraise digest lists with IMA signatures or module-style
> > appended signatures.
> >=20
> > 'digest_cache_appraise' also adds 'digest_cache=3Dcontent' to the other
> > appraise rules, if they have a compatible IMA hook.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 15 ++++++-
> >  security/integrity/ima/Kconfig                | 10 +++++
> >  security/integrity/ima/ima_policy.c           | 45 +++++++++++++++++++
> >  3 files changed, 69 insertions(+), 1 deletion(-)
>=20
> [...]
> =20
> > @@ -971,6 +1006,16 @@ void __init ima_init_policy(void)
> >  {
> >  	int build_appraise_entries, arch_entries;
> > =20
> > +	/*
> > +	 * We need to load digest cache rules at the beginning, to avoid dont=
_
> > +	 * rules causing ours to not be reached.
> > +	 */
>=20
> "lockdown" trusts IMA to measure and appraise kernel modules, if the rule
> exists.  Placing the digest_cache first breaks this trust.

The new rules don't prevent other rules to be reached, since they are
'do' and not 'don_t' rules.

If the kernel reads a file with file ID READING_MODULE, that would
still be matched by rules with 'func=3DMODULE_CHECK', even if there are
rules with 'func=3DDIGEST_LIST_CHECK', which will be instead matched when
there is a kernel read with file ID READING_DIGEST_LIST.

We can talk about the rule modification. Speaking of appraising kernel
modules, setting 'ima_policy=3Ddigest_cache_appraise' in the kernel
command line would have the effect of changing:

appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig

to:

appraise func=3DDIGEST_LIST_CHECK appraise_type=3Dimasig|modsig
appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig digest_cache=3Dc=
ontent

The effect of this would be that, if the kernel does not have
security.ima or an appended signature, appraisal will be still
successful by verifying the signature (in the xattr or appended) of the
digest list, and looking up the digest of the kernel module in that
digest list.

> From a trusted and secure boot perspective, the architecture specific pol=
icy
> rules should not be ignored.

I'm still missing how the architecture-specific policy would be
ignored.

> Putting the digest_cache before any other rules
> will limit others from being able to use digest_cache.

Sorry, didn't understand.

Let me just remark that measuring/appraising a digest list is a
necessary condition for using the digest cache built from that digest
list.

Not doing that has the same effect of a negative digest lookup, even if
that digest was in the digest list.

> Instead of putting the digest_cache_{measure,appraise} built-in policies =
first,
> skip loading the dont_measure_rules.

It does not seem a good idea. We still want to avoid
measurements/appraisal in the pseudo filesystems.

Roberto

> Mimi
>=20
> > +	if (ima_digest_cache_measure)
> > +		add_rules(&measure_digest_cache_rule, 1, IMA_DEFAULT_POLICY);
> > +
> > +	if (ima_digest_cache_appraise)
> > +		add_rules(&appraise_digest_cache_rule, 1, IMA_DEFAULT_POLICY);
> > +
> >  	/* if !ima_policy, we load NO default rules */
> >  	if (ima_policy)
> >  		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),


