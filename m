Return-Path: <linux-kernel+bounces-39722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951383D55A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E8E1F252DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E681B807;
	Fri, 26 Jan 2024 07:53:56 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7991911702;
	Fri, 26 Jan 2024 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255635; cv=none; b=bT2HHyM4Cqx7QomrBXJYrD1Wv4yryuufRzTW4Bv8k1FbmebgWxMrY0bUMX3+lBnyQZYm45aFLZFn9HSqel3WcJFkqDDvO72O1+/h61hBT7E1ufAFgYsWiWoFw0EafhvdB3W+raXwG3zrsnvbpsMRu48hZeE9yAlOxJPLMnZjtvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255635; c=relaxed/simple;
	bh=HwCuA5QJ87i2SeLnr2LrU9plUlNo/os+AAfWy2cvjUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AZkeHjPGFI/aJ9ZLfEQYnM3n7jqdYOPQQCK/X4UwDuBoh67o8wW9+XpJBfQJSdMWjxGrzJsm5ani9woeNZcuyOGzyyQxgfIZSlkByoUgtS7+cy41P0xG8znjfFrP5oT6+mqM0PC3dGC5F4X7Q27eaChgbhW3JnaQzb7gR+ESLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TLqLz39jGz9yJjM;
	Fri, 26 Jan 2024 15:38:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 0BC9D14066A;
	Fri, 26 Jan 2024 15:53:38 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCXjhf6ZLNl_+hHAQ--.46242S2;
	Fri, 26 Jan 2024 08:53:37 +0100 (CET)
Message-ID: <3e1ebbbeea1db01183bac0a7d0fa9063cb862f81.camel@huaweicloud.com>
Subject: Re: [PATCH v3 5/5] ramfs: Initialize security of in-memory inodes
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org, 
 serge@hallyn.com, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>,  Hugh Dickins <hughd@google.com>
Date: Fri, 26 Jan 2024 08:53:27 +0100
In-Reply-To: <20240125170858.1ce723a57c7fd2b9bfb5d28d@linux-foundation.org>
References: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
	 <20231116090125.187209-6-roberto.sassu@huaweicloud.com>
	 <20240125170858.1ce723a57c7fd2b9bfb5d28d@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCXjhf6ZLNl_+hHAQ--.46242S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4xZr1kAF4rZw18KF1UAwb_yoW5WFy8pr
	W0q3WDG3ZYqFy7Wr10qF4Duw1SqayfKr4DCw4kX3WxA3Z7Cr1ktF1rKr13CF1rCrW8Cw4F
	qw4j9r13uw1UJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5T2HAAAsH

On Thu, 2024-01-25 at 17:08 -0800, Andrew Morton wrote:
> On Thu, 16 Nov 2023 10:01:25 +0100 Roberto Sassu <roberto.sassu@huaweiclo=
ud.com> wrote:
>=20
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
> >=20
>=20
> fwiw,
>=20
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>=20
> Please include this in the relevant security tree.

Thanks a lot!

Roberto

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
> > --=20
> > 2.34.1


