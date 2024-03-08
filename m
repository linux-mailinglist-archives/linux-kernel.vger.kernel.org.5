Return-Path: <linux-kernel+bounces-96617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C08875EFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327141F21D4D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF34F8A2;
	Fri,  8 Mar 2024 08:01:16 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBE442C0B;
	Fri,  8 Mar 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884876; cv=none; b=Wxx+PmAjqZFFzyiXWi2Ayl9MNVFz3MGlNQTWrJr5aGVDxLC5gnU3Nus7idyeph6z791+PwcF0OBSIPngBZIEELpJt2tn1XhXYf2Ybw4zPAyhjXigFKVqKlSxGEKPgGwVcKBhVDQ/GDWxasHyN5sqoFeA6Ed9RciM04Izh041Uok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884876; c=relaxed/simple;
	bh=lH06gu41KGGdl2j7eC+BOEF+bIAi2G+B4a6FYWs1A1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DWz33jrOkiNyo0VpT9/EO90IPCmw+X8//3y9q7CpRA8+rccUNT3vRdz9TDMXte5KdJmcczwBH9s5lB1NrKTuCt515HMWijezeqr9ukaBfZLS4GExhOCDWfLVF6rWPEVTNrT3+ly9N50RGIOVE9I4Dz7gxRZZ8gNb8gpJT0/HebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TrdWB2Hb5z9xrp4;
	Fri,  8 Mar 2024 15:45:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 4B26B140636;
	Fri,  8 Mar 2024 16:01:09 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAn0Rm0xeplYFzwAw--.20905S2;
	Fri, 08 Mar 2024 09:01:08 +0100 (CET)
Message-ID: <33b20e63a191672b8f974b929c79e30b2e38ae3f.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH 2/8] ima: Nest iint mutex for DIGEST_LIST_CHECK hook
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
Date: Fri, 08 Mar 2024 09:00:48 +0100
In-Reply-To: <2f2d07c33170b6ed06f72e927a0d31989bca7c85.camel@linux.ibm.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-3-roberto.sassu@huaweicloud.com>
	 <2f2d07c33170b6ed06f72e927a0d31989bca7c85.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAn0Rm0xeplYFzwAw--.20905S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyUJFy3KFW8KryfWr4kJFb_yoWxJF1rpF
	Z7ta4UG398XFZrur4rtFZrZFyfKayqgFW8Gw45C3WvyF98Jr1rtFy8tr129Fy5CrW0k3WS
	vr4jgws8u3WjyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73D
	UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj5ceLgAAsA

On Thu, 2024-03-07 at 14:42 -0500, Mimi Zohar wrote:
> On Wed, 2024-02-14 at 15:35 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Invoking digest_cache_get() inside the iint->mutex critical region can
> > cause deadlocks due to the fact that IMA can be recursively invoked for
> > reading the digest list. The deadlock would occur if the digest_cache L=
SM
> > attempts to read the same inode that is already locked by IMA.
> >=20
> > However, since the digest_cache LSM makes sure that the above situation
> > never happens, as it checks the inodes, it is safe to call
> > digest_cache_get() inside the critical region and nest the iint->mutex
> > when the DIGEST_LIST_CHECK hook is executed.
> >=20
> > Add a lockdep subclass to the iint->mutex, that is 0 if the IMA hook
> > executed is not DIGEST_LIST_CHECK, and 1 when it is. Since lockdep allo=
ws
> > nesting with higher classes and subclasses, that effectively eliminates=
 the
> > warning about the unsafe lock.
> >=20
> > Pass the new lockdep subclass (nested variable) from ima_inode_get() to
> > ima_iint_init_always() and ima_iint_lockdep_annotate().
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/ima/ima.h      |  2 +-
> >  security/integrity/ima/ima_iint.c | 11 ++++++-----
> >  security/integrity/ima/ima_main.c |  6 +++---
> >  3 files changed, 10 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.=
h
> > index cea4517e73ab..c9140a57b591 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -216,7 +216,7 @@ static inline void ima_inode_set_iint(const struct =
inode
> > *inode,
> >  }
> > =20
> >  struct ima_iint_cache *ima_iint_find(struct inode *inode);
> > -struct ima_iint_cache *ima_inode_get(struct inode *inode);
> > +struct ima_iint_cache *ima_inode_get(struct inode *inode, bool nested)=
;
> >  void ima_inode_free(struct inode *inode);
> >  void __init ima_iintcache_init(void);
> > =20
> > diff --git a/security/integrity/ima/ima_iint.c
> > b/security/integrity/ima/ima_iint.c
> > index e7c9c216c1c6..b4f476fae437 100644
> > --- a/security/integrity/ima/ima_iint.c
> > +++ b/security/integrity/ima/ima_iint.c
> > @@ -41,7 +41,7 @@ struct ima_iint_cache *ima_iint_find(struct inode *in=
ode)
> >   * See ovl_lockdep_annotate_inode_mutex_key() for more details.
> >   */
> >  static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *ii=
nt,
> > -					     struct inode *inode)
> > +					     struct inode *inode, bool nested)
> >  {
> >  #ifdef CONFIG_LOCKDEP
> >  	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];
>=20
>=20
> "nested" is being pushed all the way down to here, perhaps I'm missing
> something, but I don't see it being used in any of the patches.

Must have gone away during a conflict resolution...

That should have been:

@@ -85,12 +85,13 @@ static inline void iint_lockdep_annotate(struct integri=
ty_iint_cache *iint,
        if (WARN_ON_ONCE(depth < 0 || depth >=3D IMA_MAX_NESTING))
                depth =3D 0;
=20
-       lockdep_set_class(&iint->mutex, &iint_mutex_key[depth]);
+       lockdep_set_class_and_subclass(&iint->mutex, &iint_mutex_key[depth]=
,
+                                      nested);
 #endif
 }
=20
 static void iint_init_always(struct integrity_iint_cache *iint,
-                            struct inode *inode)
+                            struct inode *inode, bool nested)
 {
        iint->ima_hash =3D NULL;
        iint->version =3D 0;

Thanks

Roberto

> Mimi
>=20
> > @@ -56,7 +56,7 @@ static inline void ima_iint_lockdep_annotate(struct
> > ima_iint_cache *iint,
> >  }
> > =20
> >  static void ima_iint_init_always(struct ima_iint_cache *iint,
> > -				 struct inode *inode)
> > +				 struct inode *inode, bool nested)
> >  {
> >  	iint->ima_hash =3D NULL;
> >  	iint->version =3D 0;
> > @@ -69,7 +69,7 @@ static void ima_iint_init_always(struct ima_iint_cach=
e
> > *iint,
> >  	iint->ima_creds_status =3D INTEGRITY_UNKNOWN;
> >  	iint->measured_pcrs =3D 0;
> >  	mutex_init(&iint->mutex);
> > -	ima_iint_lockdep_annotate(iint, inode);
> > +	ima_iint_lockdep_annotate(iint, inode, nested);
> >  }
> > =20
> >  static void ima_iint_free(struct ima_iint_cache *iint)
> > @@ -82,13 +82,14 @@ static void ima_iint_free(struct ima_iint_cache *ii=
nt)
> >  /**
> >   * ima_inode_get - Find or allocate an iint associated with an inode
> >   * @inode: Pointer to the inode
> > + * @nested: Whether or not the iint->mutex lock can be nested
> >   *
> >   * Find an iint associated with an inode, and allocate a new one if no=
t
> > found.
> >   * Caller must lock i_mutex.
> >   *
> >   * Return: An iint on success, NULL on error.
> >   */
> > -struct ima_iint_cache *ima_inode_get(struct inode *inode)
> > +struct ima_iint_cache *ima_inode_get(struct inode *inode, bool nested)
> >  {
> >  	struct ima_iint_cache *iint;
> > =20
> > @@ -100,7 +101,7 @@ struct ima_iint_cache *ima_inode_get(struct inode *=
inode)
> >  	if (!iint)
> >  		return NULL;
> > =20
> > -	ima_iint_init_always(iint, inode);
> > +	ima_iint_init_always(iint, inode, nested);
> > =20
> >  	inode->i_flags |=3D S_IMA;
> >  	ima_inode_set_iint(inode, iint);
> > diff --git a/security/integrity/ima/ima_main.c
> > b/security/integrity/ima/ima_main.c
> > index 780627b0cde7..18285fc8ac07 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -248,7 +248,7 @@ static int process_measurement(struct file *file, c=
onst
> > struct cred *cred,
> >  	inode_lock(inode);
> > =20
> >  	if (action) {
> > -		iint =3D ima_inode_get(inode);
> > +		iint =3D ima_inode_get(inode, func =3D=3D DIGEST_LIST_CHECK);
> >  		if (!iint)
> >  			rc =3D -ENOMEM;
> >  	}
> > @@ -699,7 +699,7 @@ static void ima_post_create_tmpfile(struct mnt_idma=
p
> > *idmap,
> >  		return;
> > =20
> >  	/* Nothing to do if we can't allocate memory */
> > -	iint =3D ima_inode_get(inode);
> > +	iint =3D ima_inode_get(inode, false);
> >  	if (!iint)
> >  		return;
> > =20
> > @@ -731,7 +731,7 @@ static void ima_post_path_mknod(struct mnt_idmap *i=
dmap,
> > struct dentry *dentry)
> >  		return;
> > =20
> >  	/* Nothing to do if we can't allocate memory */
> > -	iint =3D ima_inode_get(inode);
> > +	iint =3D ima_inode_get(inode, false);
> >  	if (!iint)
> >  		return;
> > =20


