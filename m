Return-Path: <linux-kernel+bounces-27133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60082EAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDEF0B2300C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C47B11CBF;
	Tue, 16 Jan 2024 08:39:38 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB412B82;
	Tue, 16 Jan 2024 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TDhrd4R7nz9xyNh;
	Tue, 16 Jan 2024 16:24:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 0C1231409EB;
	Tue, 16 Jan 2024 16:39:28 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3cCS4QKZlq8CkAA--.3812S2;
	Tue, 16 Jan 2024 09:39:27 +0100 (CET)
Message-ID: <909a681238012328b0ab5499a5b66bef95247a89.camel@huaweicloud.com>
Subject: Re: [PATCH v3 5/5] ramfs: Initialize security of in-memory inodes
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Roberto Sassu <roberto.sassu@huawei.com>, casey@schaufler-ca.com,
 paul@paul-moore.com, jmorris@namei.org,  serge@hallyn.com
Date: Tue, 16 Jan 2024 09:39:16 +0100
In-Reply-To: <c1ab0a9160d9220fac6e9c8c2bfa9ea493a08699.camel@huaweicloud.com>
References: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
	 <20231116090125.187209-6-roberto.sassu@huaweicloud.com>
	 <c1ab0a9160d9220fac6e9c8c2bfa9ea493a08699.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwA3cCS4QKZlq8CkAA--.3812S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4fKFW8tr1DCFW7Wr4UArb_yoW5ZFWDpr
	Z2q3Z8G3ZYqFyxGr1SqF4Duw1SqayrKr4DC3yxXw17A3Z7Cr1DtF1fKr13uF1rCrW8Cw1F
	qF4j9r15uw1UArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj5iWVQAAsr

On Fri, 2024-01-12 at 09:17 +0100, Roberto Sassu wrote:
> On Thu, 2023-11-16 at 10:01 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Add a call security_inode_init_security() after ramfs_get_inode(), to l=
et
> > LSMs initialize the inode security field. Skip ramfs_fill_super(), as t=
he
> > initialization is done through the sb_set_mnt_opts hook.
> >=20
> > Calling security_inode_init_security() call inside ramfs_get_inode() is
> > not possible since, for CONFIG_SHMEM=3Dn, tmpfs also calls the former a=
fter
> > the latter.
> >=20
> > Pass NULL as initxattrs() callback to security_inode_init_security(), s=
ince
> > the purpose of the call is only to initialize the in-memory inodes.
>=20
> Hugh, Andrew, is the patch fine for you? Casey would make a PR for the
> patch set.

(I guess putting the people of interest in To instead of CC could
help...)

Friendly ping... it would be awesome if you could Ack this patch so
that Casey can still ask Linus to pull.

Thanks

Roberto

> Thanks
>=20
> Roberto
>=20
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  fs/ramfs/inode.c | 32 +++++++++++++++++++++++++++++++-
> >  1 file changed, 31 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> > index 4ac05a9e25bc..8006faaaf0ec 100644
> > --- a/fs/ramfs/inode.c
> > +++ b/fs/ramfs/inode.c
> > @@ -102,11 +102,20 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode=
 *dir,
> >  	int error =3D -ENOSPC;
> > =20
> >  	if (inode) {
> > +		error =3D security_inode_init_security(inode, dir,
> > +						     &dentry->d_name, NULL,
> > +						     NULL);
> > +		if (error) {
> > +			iput(inode);
> > +			goto out;
> > +		}
> > +
> >  		d_instantiate(dentry, inode);
> >  		dget(dentry);	/* Extra count - pin the dentry in core */
> >  		error =3D 0;
> >  		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
> >  	}
> > +out:
> >  	return error;
> >  }
> > =20
> > @@ -134,6 +143,15 @@ static int ramfs_symlink(struct mnt_idmap *idmap, =
struct inode *dir,
> >  	inode =3D ramfs_get_inode(dir->i_sb, dir, S_IFLNK|S_IRWXUGO, 0);
> >  	if (inode) {
> >  		int l =3D strlen(symname)+1;
> > +
> > +		error =3D security_inode_init_security(inode, dir,
> > +						     &dentry->d_name, NULL,
> > +						     NULL);
> > +		if (error) {
> > +			iput(inode);
> > +			goto out;
> > +		}
> > +
> >  		error =3D page_symlink(inode, symname, l);
> >  		if (!error) {
> >  			d_instantiate(dentry, inode);
> > @@ -143,6 +161,7 @@ static int ramfs_symlink(struct mnt_idmap *idmap, s=
truct inode *dir,
> >  		} else
> >  			iput(inode);
> >  	}
> > +out:
> >  	return error;
> >  }
> > =20
> > @@ -150,12 +169,23 @@ static int ramfs_tmpfile(struct mnt_idmap *idmap,
> >  			 struct inode *dir, struct file *file, umode_t mode)
> >  {
> >  	struct inode *inode;
> > +	int error;
> > =20
> >  	inode =3D ramfs_get_inode(dir->i_sb, dir, mode, 0);
> >  	if (!inode)
> >  		return -ENOSPC;
> > +
> > +	error =3D security_inode_init_security(inode, dir,
> > +					     &file_dentry(file)->d_name, NULL,
> > +					     NULL);
> > +	if (error) {
> > +		iput(inode);
> > +		goto out;
> > +	}
> > +
> >  	d_tmpfile(file, inode);
> > -	return finish_open_simple(file, 0);
> > +out:
> > +	return finish_open_simple(file, error);
> >  }
> > =20
> >  static const struct inode_operations ramfs_dir_inode_operations =3D {
>=20


