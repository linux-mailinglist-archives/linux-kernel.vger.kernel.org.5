Return-Path: <linux-kernel+bounces-40938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A82783E87F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8731F25816
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A92A55;
	Sat, 27 Jan 2024 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+nuApS6"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0839E;
	Sat, 27 Jan 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315662; cv=none; b=qOd1eOU/w5MjlfEzVQ+4OAstiC43ueGfB/lfDvWdWuPEcDD2aITX0QpGLsBcbQvIuPFkN2TWTmgzPCXY/J2QCCzhjQLLyIRXwPWt70lB6uW2g2/Pq5h0LGY1FwvdcEHf5oZrszaFlrtms47U6NrlcCJH2FkOV3YvnyIlLAr7lsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315662; c=relaxed/simple;
	bh=4XPEyzaSBvNLI1Qg82UwrUlD/qPJSCHU+bNF6HfO6qg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JzihnCypBI6Cm3RYIr7gGOUQOcP21f0PZsAf/ttMRR9DDsWW1FMJI8MSzZI5bzWUrUPKzb3DXIGQxxaljqcOTacLKC9t2Ivryzh1v6MjUW+rMdj95ouUhc5GF45g4aAY+ySuMpS4T+fPT0LBSpEZ1crD3NTMe5x5/IrQMjLVmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+nuApS6; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706315660; x=1737851660;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=4XPEyzaSBvNLI1Qg82UwrUlD/qPJSCHU+bNF6HfO6qg=;
  b=Y+nuApS6vla2kq86aXsBEv+o47ImfhyrlRe6P+C9dSkxTr0YDLTWNLpL
   5J/HTgpbrW9qmuJxN2M7RQ1YYeclvDj9cGAJ+ak4TnB1FrNNYyZlU6Lsh
   4280+g0CNL4lMO9u6TseFMbR3v+5cZrgFpUxd+qYhbbY8SF9asASyQRcm
   TRDzPFXQCjdmz0ThPK4Vq8v0E0tgzbOZmtY++LLc8dDNPQL7vszuR2fNm
   8asfG1pYaL7zlNULsGHl1SfXaqg1+MbdOuThSOMLpTamH2/4uguh6fP9i
   D/WWqZV5bl57yOtUhjHj/A6NeSqUOk/UxM4olrqqh7aHjFyS7LNhJ8S23
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401483846"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="401483846"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 16:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="906471871"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="906471871"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.67])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 16:34:18 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 3/4] overlayfs: Optimize credentials usage
In-Reply-To: <CAOQ4uxh15X9pMY7Ck=iigaaKX11_77x5sZE9jxakTG9VpkuG6g@mail.gmail.com>
References: <20240125235723.39507-1-vinicius.gomes@intel.com>
 <20240125235723.39507-4-vinicius.gomes@intel.com>
 <CAOQ4uxh15X9pMY7Ck=iigaaKX11_77x5sZE9jxakTG9VpkuG6g@mail.gmail.com>
Date: Fri, 26 Jan 2024 16:34:17 -0800
Message-ID: <87il3f4nsm.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amir Goldstein <amir73il@gmail.com> writes:

> On Fri, Jan 26, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> File operations in overlayfs also check against the credentials of the
>> mounter task, stored in the superblock, this credentials will outlive
>> most of the operations. For these cases, use the recently introduced
>> guard statements to guarantee that override/revert_creds() are paired.
>>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>>  fs/overlayfs/copy_up.c |  4 +--
>>  fs/overlayfs/dir.c     | 22 +++++++------
>>  fs/overlayfs/file.c    | 70 ++++++++++++++++++++++--------------------
>>  fs/overlayfs/inode.c   | 60 +++++++++++++++++++-----------------
>>  fs/overlayfs/namei.c   | 21 ++++++-------
>>  fs/overlayfs/readdir.c | 18 +++++------
>>  fs/overlayfs/util.c    | 23 +++++++-------
>>  fs/overlayfs/xattrs.c  | 34 ++++++++++----------
>>  8 files changed, 130 insertions(+), 122 deletions(-)
>>
>> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
>> index b8e25ca51016..55d1f2b60775 100644
>> --- a/fs/overlayfs/copy_up.c
>> +++ b/fs/overlayfs/copy_up.c
>> @@ -1202,7 +1202,8 @@ static int ovl_copy_up_flags(struct dentry *dentry=
, int flags)
>>         if (err)
>>                 return err;
>>
>> -       old_cred =3D ovl_override_creds(dentry->d_sb);
>> +       old_cred =3D ovl_creds(dentry->d_sb);
>> +       guard(cred)(old_cred);
>>         while (!err) {
>>                 struct dentry *next;
>>                 struct dentry *parent =3D NULL;
>> @@ -1227,7 +1228,6 @@ static int ovl_copy_up_flags(struct dentry *dentry=
, int flags)
>>                 dput(parent);
>>                 dput(next);
>>         }
>> -       revert_creds(old_cred);
>>
>>         return err;
>>  }
>> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
>> index 0f8b4a719237..5aa43a3a7b3e 100644
>> --- a/fs/overlayfs/dir.c
>> +++ b/fs/overlayfs/dir.c
>> @@ -687,9 +687,9 @@ static int ovl_set_link_redirect(struct dentry *dent=
ry)
>>         const struct cred *old_cred;
>>         int err;
>>
>> -       old_cred =3D ovl_override_creds(dentry->d_sb);
>> +       old_cred =3D ovl_creds(dentry->d_sb);
>> +       guard(cred)(old_cred);
>>         err =3D ovl_set_redirect(dentry, false);
>> -       revert_creds(old_cred);
>>
>>         return err;
>>  }
>> @@ -894,12 +894,13 @@ static int ovl_do_remove(struct dentry *dentry, bo=
ol is_dir)
>>         if (err)
>>                 goto out;
>>
>> -       old_cred =3D ovl_override_creds(dentry->d_sb);
>> -       if (!lower_positive)
>> -               err =3D ovl_remove_upper(dentry, is_dir, &list);
>> -       else
>> -               err =3D ovl_remove_and_whiteout(dentry, &list);
>> -       revert_creds(old_cred);
>> +       old_cred =3D ovl_creds(dentry->d_sb);
>> +       scoped_guard(cred, old_cred) {
>> +               if (!lower_positive)
>> +                       err =3D ovl_remove_upper(dentry, is_dir, &list);
>> +               else
>> +                       err =3D ovl_remove_and_whiteout(dentry, &list);
>> +       }
>>         if (!err) {
>>                 if (is_dir)
>>                         clear_nlink(dentry->d_inode);
>> @@ -1146,7 +1147,8 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>>                         goto out;
>>         }
>>
>> -       old_cred =3D ovl_override_creds(old->d_sb);
>> +       old_cred =3D ovl_creds(old->d_sb);
>> +       old_cred =3D override_creds_light(old_cred);
>>
>>         if (!list_empty(&list)) {
>>                 opaquedir =3D ovl_clear_empty(new, &list);
>> @@ -1279,7 +1281,7 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>>  out_unlock:
>>         unlock_rename(new_upperdir, old_upperdir);
>>  out_revert_creds:
>> -       revert_creds(old_cred);
>> +       revert_creds_light(old_cred);
>>         if (update_nlink)
>>                 ovl_nlink_end(new);
>>         else
>
> Most of my comments on this patch are identical to the ones I have made on
> backing file, so rather complete that review before moving on to this big=
ger
> patch.
>
> I even wonder if we need a specialized macro for overlayfs
> guard(ovl_creds, ofs); or if
> guard(cred, ovl_override_creds(dentry->d_sb));
> is good enough.
>

I think that if the DEFINE_LOCK_GUARD_1() idea works, that might be
unecessary. Let's see.

> One thing that stands out in functions like ovl_rename() is that,
> understandably, you tried to preserve logic, but in fact, the scope of
> override_creds/revert_creds() in some of the overlayfs functions ir rather
> arbitrary.
>

That's very good to learn.=20

> The simplest solution for functions like the above is to use guard(cred, =
.
> and extend the scope till the end of the function.
> This needs more careful review, but the end result will be much cleaner.
>

Yeah, increasing the indentation level of whole blocks cause the whole
patch to be much harder to review.

Using more guard() statements will certainly help.

>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>> index 05536964d37f..482bf78555e2 100644
>> --- a/fs/overlayfs/file.c
>> +++ b/fs/overlayfs/file.c
>> @@ -42,7 +42,8 @@ static struct file *ovl_open_realfile(const struct fil=
e *file,
>>         if (flags & O_APPEND)
>>                 acc_mode |=3D MAY_APPEND;
>>
>> -       old_cred =3D ovl_override_creds(inode->i_sb);
>> +       old_cred =3D ovl_creds(inode->i_sb);
>> +       guard(cred)(old_cred);
>>         real_idmap =3D mnt_idmap(realpath->mnt);
>>         err =3D inode_permission(real_idmap, realinode, MAY_OPEN | acc_m=
ode);
>>         if (err) {
>> @@ -54,7 +55,6 @@ static struct file *ovl_open_realfile(const struct fil=
e *file,
>>                 realfile =3D backing_file_open(&file->f_path, flags, rea=
lpath,
>>                                              current_cred());
>>         }
>> -       revert_creds(old_cred);
>>
>>         pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
>>                  file, file, ovl_whatisit(inode, realinode), file->f_fla=
gs,
>> @@ -214,9 +214,9 @@ static loff_t ovl_llseek(struct file *file, loff_t o=
ffset, int whence)
>>         ovl_inode_lock(inode);
>>         real.file->f_pos =3D file->f_pos;
>>
>> -       old_cred =3D ovl_override_creds(inode->i_sb);
>> -       ret =3D vfs_llseek(real.file, offset, whence);
>> -       revert_creds(old_cred);
>> +       old_cred =3D ovl_creds(inode->i_sb);
>> +       scoped_guard(cred, old_cred)
>> +               ret =3D vfs_llseek(real.file, offset, whence);
>>
>>         file->f_pos =3D real.file->f_pos;
>>         ovl_inode_unlock(inode);
>> @@ -388,7 +388,6 @@ static ssize_t ovl_splice_write(struct pipe_inode_in=
fo *pipe, struct file *out,
>>  static int ovl_fsync(struct file *file, loff_t start, loff_t end, int d=
atasync)
>>  {
>>         struct fd real;
>> -       const struct cred *old_cred;
>>         int ret;
>>
>>         ret =3D ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
>> @@ -401,9 +400,11 @@ static int ovl_fsync(struct file *file, loff_t star=
t, loff_t end, int datasync)
>>
>>         /* Don't sync lower file for fear of receiving EROFS error */
>>         if (file_inode(real.file) =3D=3D ovl_inode_upper(file_inode(file=
))) {
>> -               old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
>> +               const struct cred *old_cred;
>> +
>> +               old_cred =3D ovl_creds(file_inode(file)->i_sb);
>> +               guard(cred)(old_cred);
>>                 ret =3D vfs_fsync_range(real.file, start, end, datasync);
>> -               revert_creds(old_cred);
>>         }
>>
>>         fdput(real);
>> @@ -441,9 +442,9 @@ static long ovl_fallocate(struct file *file, int mod=
e, loff_t offset, loff_t len
>>         if (ret)
>>                 goto out_unlock;
>>
>> -       old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
>> -       ret =3D vfs_fallocate(real.file, mode, offset, len);
>> -       revert_creds(old_cred);
>> +       old_cred =3D ovl_creds(file_inode(file)->i_sb);
>> +       scoped_guard(cred, old_cred)
>> +               ret =3D vfs_fallocate(real.file, mode, offset, len);
>>
>>         /* Update size */
>>         ovl_file_modified(file);
>> @@ -466,9 +467,9 @@ static int ovl_fadvise(struct file *file, loff_t off=
set, loff_t len, int advice)
>>         if (ret)
>>                 return ret;
>>
>> -       old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
>> -       ret =3D vfs_fadvise(real.file, offset, len, advice);
>> -       revert_creds(old_cred);
>> +       old_cred =3D ovl_creds(file_inode(file)->i_sb);
>> +       scoped_guard(cred, old_cred)
>> +               ret =3D vfs_fadvise(real.file, offset, len, advice);
>>
>>         fdput(real);
>>
>> @@ -509,25 +510,25 @@ static loff_t ovl_copyfile(struct file *file_in, l=
off_t pos_in,
>>                 goto out_unlock;
>>         }
>>
>> -       old_cred =3D ovl_override_creds(file_inode(file_out)->i_sb);
>> -       switch (op) {
>> -       case OVL_COPY:
>> -               ret =3D vfs_copy_file_range(real_in.file, pos_in,
>> -                                         real_out.file, pos_out, len, f=
lags);
>> -               break;
>> +       old_cred =3D ovl_creds(file_inode(file_out)->i_sb);
>> +       scoped_guard(cred, old_cred)
>> +               switch (op) {
>> +               case OVL_COPY:
>> +                       ret =3D vfs_copy_file_range(real_in.file, pos_in,
>> +                                                 real_out.file, pos_out=
, len, flags);
>> +                       break;
>>
>> -       case OVL_CLONE:
>> -               ret =3D vfs_clone_file_range(real_in.file, pos_in,
>> -                                          real_out.file, pos_out, len, =
flags);
>> -               break;
>> +               case OVL_CLONE:
>> +                       ret =3D vfs_clone_file_range(real_in.file, pos_i=
n,
>> +                                                  real_out.file, pos_ou=
t, len, flags);
>> +                       break;
>>
>> -       case OVL_DEDUPE:
>> -               ret =3D vfs_dedupe_file_range_one(real_in.file, pos_in,
>> -                                               real_out.file, pos_out, =
len,
>> -                                               flags);
>> -               break;
>> -       }
>> -       revert_creds(old_cred);
>> +               case OVL_DEDUPE:
>> +                       ret =3D vfs_dedupe_file_range_one(real_in.file, =
pos_in,
>> +                                                       real_out.file, p=
os_out, len,
>> +                                                       flags);
>> +                       break;
>> +               }
>>
>>         /* Update size */
>>         ovl_file_modified(file_out);
>
> This is another case where extending the scope to the end of the function
> is the simpler/cleaner solution.
>
> Thanks,
> Amir.

--=20
Vinicius

