Return-Path: <linux-kernel+bounces-153685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591228AD1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A2F1F23B72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5960A15358D;
	Mon, 22 Apr 2024 16:16:08 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAC153839;
	Mon, 22 Apr 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802566; cv=none; b=V4a/63UVAG8jIp08YLhXi2j8mftwGPzSY8SjBZeTkdew5y5VqUiWBqbMDBAY4+Uih+ZsYsrp0rW7TKKGF6VPRJg/EyY74K3AdrlUQnuxZnha+oFqJ2nmc6dQbV8i0iH7yExURk+pvz5qLBIjHztbY9vfjp05XJemf480v0zPWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802566; c=relaxed/simple;
	bh=mWsvm93fW0w0fv42lI/98E0osUgiOpWtgizrRxa8two=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jlw/I6GD9zE7Y3bfuYPrc92W0WEle5EAOcPo14JSLVmew6jFXgC9C2+qoRuv4UxE1nl/GPVxtNNtPLsam6oF7P0oWtj5MFtnJ6SLT/z9MNBYG1+sc4cScBF9sfvtv5Ia5g0jh+A6pXW5TOH7R0iJsLDBBMVXtO62fPje7/+VqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNVL16MDnz9xHw0;
	Mon, 22 Apr 2024 23:59:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 55E641404A6;
	Tue, 23 Apr 2024 00:15:34 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwC3qhMdjSZmSmHCBg--.36545S2;
	Mon, 22 Apr 2024 17:15:33 +0100 (CET)
Message-ID: <9781bed037fa7ba6610e65220054b8f93a6e5966.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v2 2/2] ima: Fix detection of read/write violations
 on stacked filesystems
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
 roberto.sassu@huawei.com,  amir73il@gmail.com, miklos@szeredi.hu,
 brauner@kernel.org
Date: Mon, 22 Apr 2024 18:15:21 +0200
In-Reply-To: <20240422150651.2908169-3-stefanb@linux.ibm.com>
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
	 <20240422150651.2908169-3-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwC3qhMdjSZmSmHCBg--.36545S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur1fWr1fZry7ArW7ZFy5Arb_yoW5tF43pF
	Z8ta4UG395tF1I9F1vya4UZa1F93y8KF4UZa4Yq348JFnagrn09rWaya4YyryfJr93ur40
	qa1jvr98Ca15trDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj5iucgACsw

On Mon, 2024-04-22 at 11:06 -0400, Stefan Berger wrote:
> On a stacked filesystem, when one process opens the file holding a file's
> data (e.g., on upper or lower layer on overlayfs) then issue a violation
> when another process opens the file for reading on the top layer (overlay
> layer on overlayfs). This then provides similar behavior to the existing
> case where a violation is generated when one process opens a file for
> writing and another one opens the same file for reading.
>=20
> Convert the current code so that it can handle the normal case as well
> as the stacked filesystem case. Therefore, use d_real with parameter
> D_REAL_FILEDATA to get the next dentry holding the file data. On a normal
> filesystem this would be the dentry of the file and on a stacked filesyst=
em
> this could be an upper or lower dentry. Check the dentry's inode for
> writes and if it has any issue the violation. Otherwise continue onto the
> next dentry given the current dentry by again calling d_real. On a normal
> filesystem this would return the same dentry as before and on a stacked
> filesystem it would return the next-level dentry, so either the upper
> or lower dentry of the next lower layer.

I have a question. What happens for the opposite, when you open an
overlayfs file for write, and it was already opened and measured in the
lower layers?

If IMA was invoked for the lower layers, the ToMToU detection would be
detected. But it does not seem the case:

struct file *backing_file_open(const struct path *user_path, int flags,
			       const struct path *real_path,
			       const struct cred *cred)
{

[...]

	error =3D vfs_open(real_path, f);
	if (error) {
		fput(f);
		f =3D ERR_PTR(error);
	}

	return f;

security_file_post_open(), which invokes IMA, is called after
vfs_open() and only in do_open().

Also, consider that ima_iint_get() and ima_rdwr_violation_check() are
called with the inode lock held. If you access different inodes, the
locking scheme changes.

Thanks

Roberto

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/integrity/ima/ima_main.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index f04f43af651c..7d727c448dc7 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -122,7 +122,9 @@ static void ima_rdwr_violation_check(struct file *fil=
e,
>  				     char *filename)
>  {
>  	struct inode *inode =3D file_inode(file);
> +	struct dentry *fd_dentry, *d;
>  	fmode_t mode =3D file->f_mode;
> +	struct inode *fd_inode;
>  	bool send_tomtou =3D false, send_writers =3D false;
> =20
>  	if (mode & FMODE_WRITE) {
> @@ -134,11 +136,20 @@ static void ima_rdwr_violation_check(struct file *f=
ile,
>  						&iint->atomic_flags))
>  				send_tomtou =3D true;
>  		}
> -	} else {
> -		if (must_measure)
> -			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
> -		if (inode_is_open_for_write(inode) && must_measure)
> -			send_writers =3D true;
> +	} else if (must_measure) {
> +		set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
> +
> +		d =3D d_real(file_dentry(file), D_REAL_FILEDATA);
> +		do {
> +			fd_dentry =3D d;
> +			fd_inode =3D d_inode(fd_dentry);
> +			if (inode_is_open_for_write(fd_inode)) {
> +				send_writers =3D true;
> +				break;
> +			}
> +			/* next layer of stacked fs */
> +			d =3D d_real(fd_dentry, D_REAL_FILEDATA);
> +		} while (d !=3D fd_dentry);
>  	}
> =20
>  	if (!send_tomtou && !send_writers)


