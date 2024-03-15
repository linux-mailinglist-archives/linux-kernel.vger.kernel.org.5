Return-Path: <linux-kernel+bounces-103972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6361787C74E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F4B282D65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1096A53A0;
	Fri, 15 Mar 2024 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaswfEPZ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6450933CA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710467204; cv=none; b=HPyCN+ovZ89UqLptEB8jrYD9iqd7dDwp/OGgYsEKXrBKTuJ9ekNPdIQGVkNQNFPvRWQsJ30d+kUxa3uqlgkEwGqACkM5pn7GFazGKUmDh5IGTzJdLRKpZ1Ay5kbr85HClUHzyqk4edsx/DQLOg6RPnnUHrZROTNxFxbRHN/mDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710467204; c=relaxed/simple;
	bh=q8iNWbjGQ+D2fJoo5tG/XMd3JR2XkDgUd51iBpSBcvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nR+F9vxm6apYb3ORmo4RxP/6wlJGC8V84cXEMBDelAcJnbCutzLJTSMdrNeGhj83Ga0/tWtLybGBuShhfwDP12Db3GMMIAfDPvRMfU7olWSNwLtU1zZ6krVohztAqhKTC2U2OnvPHIKuQBgr4ctiIG7XchU0HC/u+UnPWIaGnas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaswfEPZ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d204e102a9so19527601fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710467200; x=1711072000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RK3WS8YU/TIO9C5L+2WMErB8Z6UUjxPHl/ZVfvjJt24=;
        b=iaswfEPZT5rbY3cOYprl4IwFdQ0jFzaompVy30DWJtfA7jtjYHtyLot3Xu39EdnRzA
         vctpSOwaQMYXTYH6goHGiEj7t1Lo6HAZWHdarau8M1JSsjf1ZYAcaZyg2DFWal32ylMS
         +uRLWMV4QuvHhbUuu0xS8FFq7DBR5KaIc/PrHylcAnylc/SPbXd55UH8Yaxe55X18ykz
         u2EQUe8eygBeEudVMpAcB9dx1ipmJKBwpHAWAXQez9cWaYuB/b+PgIUSqI2oXG9btuQ7
         qpaTI5riUAQUqPHDJYISLvfQMiXp5zZkVlkSu48gSTChAM2kr/hiu3wnYZfvjV5GE29w
         tm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710467200; x=1711072000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RK3WS8YU/TIO9C5L+2WMErB8Z6UUjxPHl/ZVfvjJt24=;
        b=vX9eHYmNK+Tp4JDcHy97PES6LnHxcjMfvhvG4BUwm9o0vVCOJxTMLUpG/lyJvdRTAp
         42qOuY7OZOfPnAIgsim6Vs/rYxHnzRybkarmeRN+YrkchSgEkWI4i1KOtEoj0mwhGF7N
         kchWlLBFqcelQ/Fz+hAPLSL6kHQOLTpfzlGGg8FlmW4RPLJ2WKYArp/bwisSU+PkuvRY
         4o/AnCkZFAND1HHHGoUqi5oFfGo25PgAQjiaOvVFn7rvZDDzFJ59J6iZN+3ZNkB9I8qM
         RyfncIfMu7W/yCBzrGK5jRCQL2NJS3qCD+HpjFBtVUHHX/N6YBJFJl4ddXmaZXK/fkDc
         mxvw==
X-Forwarded-Encrypted: i=1; AJvYcCUttaJXjiDTYJpqOOwdfWhOwp9CEN3qNp6NnAC79lzNTyb2YTXE3wfnRRDgDBtG+UQ3ThSH8pWCgs6M4P0QTD3T7tdGaGHbKcrZDyf2
X-Gm-Message-State: AOJu0YyJhgLjrKpng5+EFIUewbHNoCmIEns7cQauPllrGfOwf6qJfqC3
	w3VNRPt8csVt+AopwtbmO9wCvjZOGNqp77+PseA/nMbnq+71Q5kb3NE41UEBS9ifqHaQwQXZein
	Rw/gKzWT1NNrjU2QHO20Gkjvuf5w=
X-Google-Smtp-Source: AGHT+IErr3X67ESANY5oZyQc3OQLFn3z4WEmx0f2jrHn04v+Ur73VCVeriymLwGz/734BKBZHnJAHIsYO4kZAqD4yqs=
X-Received: by 2002:a05:651c:32a:b0:2d4:3c64:53f5 with SMTP id
 b10-20020a05651c032a00b002d43c6453f5mr1972795ljp.19.1710467200055; Thu, 14
 Mar 2024 18:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710303061-16822-1-git-send-email-zhiguo.niu@unisoc.com> <eeefebcb-54db-4087-9319-dd5f9b63a1da@kernel.org>
In-Reply-To: <eeefebcb-54db-4087-9319-dd5f9b63a1da@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 15 Mar 2024 09:46:28 +0800
Message-ID: <CAHJ8P3+mo+yT8wfv2Xd3Rb7sFtXufmOgh_6CLzZxM5CjtYWC2Q@mail.gmail.com>
Subject: Re: [PATCH] f2fs: add REQ_TIME time update for some user behaviors
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:06=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/3/13 12:11, Zhiguo Niu wrote:
> > some user behaviors requested filesystem operations, which
> > will cause filesystem not idle.
> > Meanwhile adjust f2fs_update_time(REQ_TIME) of
> > f2fs_ioc_defragment to successful case.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/f2fs/file.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 4dfe38e..dac3836 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -2784,7 +2784,6 @@ static int f2fs_ioc_defragment(struct file *filp,=
 unsigned long arg)
> >       err =3D f2fs_defragment_range(sbi, filp, &range);
> >       mnt_drop_write_file(filp);
> >
> > -     f2fs_update_time(sbi, REQ_TIME);
>
> I guess we need to call f2fs_update_time() here if any data was
> migrated.
OK!
>
> if (range->len)
>         f2fs_update_time(sbi, REQ_TIME);
>
> >       if (err < 0)
> >               return err;
> >
> > @@ -2792,6 +2791,7 @@ static int f2fs_ioc_defragment(struct file *filp,=
 unsigned long arg)
> >                                                       sizeof(range)))
> >               return -EFAULT;
> >
> > +     f2fs_update_time(sbi, REQ_TIME);
> >       return 0;
> >   }
> >
> > @@ -3331,6 +3331,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, =
unsigned long arg)
> >       if (copy_from_user(&block_count, (void __user *)arg,
> >                          sizeof(block_count)))
> >               return -EFAULT;
> > +     f2fs_update_time(sbi, REQ_TIME);
>
> There will be no further IO in the end of f2fs_ioc_resize_fs(), so we don=
't
> need to update time to delay gc/discard thread?
>
> >
> >       return f2fs_resize_fs(filp, block_count);
> >   }
> > @@ -3424,6 +3425,7 @@ static int f2fs_ioc_setfslabel(struct file *filp,=
 unsigned long arg)
> >       f2fs_up_write(&sbi->sb_lock);
> >
> >       mnt_drop_write_file(filp);
> > +     f2fs_update_time(sbi, REQ_TIME);
>
> Ditto,
Dear Chao,

The two parts you proposed should be similar to the below scenario?
---------------------------------------------------------
static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long =
arg)
{
struct inode *inode =3D file_inode(filp);

if (!f2fs_sb_has_encrypt(F2FS_I_SB(inode)))
return -EOPNOTSUPP;

f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);

return fscrypt_ioctl_set_policy(filp, (const void __user *)arg);
}
-----------------------------------------------------------
thanks!


>
> Thanks,
>
> >   out:
> >       kfree(vbuf);
> >       return err;
> > @@ -3597,6 +3599,7 @@ static int f2fs_release_compress_blocks(struct fi=
le *filp, unsigned long arg)
> >
> >       filemap_invalidate_unlock(inode->i_mapping);
> >       f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > +     f2fs_update_time(sbi, REQ_TIME);
> >   out:
> >       inode_unlock(inode);
> >
> > @@ -3766,6 +3769,7 @@ static int f2fs_reserve_compress_blocks(struct fi=
le *filp, unsigned long arg)
> >               clear_inode_flag(inode, FI_COMPRESS_RELEASED);
> >               inode_set_ctime_current(inode);
> >               f2fs_mark_inode_dirty_sync(inode, true);
> > +             f2fs_update_time(sbi, REQ_TIME);
> >       }
> >   unlock_inode:
> >       inode_unlock(inode);
> > @@ -3964,6 +3968,7 @@ static int f2fs_sec_trim_file(struct file *filp, =
unsigned long arg)
> >       if (len)
> >               ret =3D f2fs_secure_erase(prev_bdev, inode, prev_index,
> >                               prev_block, len, range.flags);
> > +     f2fs_update_time(sbi, REQ_TIME);
> >   out:
> >       filemap_invalidate_unlock(mapping);
> >       f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > @@ -4173,6 +4178,7 @@ static int f2fs_ioc_decompress_file(struct file *=
filp)
> >       if (ret)
> >               f2fs_warn(sbi, "%s: The file might be partially decompres=
sed (errno=3D%d). Please delete the file.",
> >                         __func__, ret);
> > +     f2fs_update_time(sbi, REQ_TIME);
> >   out:
> >       inode_unlock(inode);
> >       file_end_write(filp);
> > @@ -4252,6 +4258,7 @@ static int f2fs_ioc_compress_file(struct file *fi=
lp)
> >       if (ret)
> >               f2fs_warn(sbi, "%s: The file might be partially compresse=
d (errno=3D%d). Please delete the file.",
> >                         __func__, ret);
> > +     f2fs_update_time(sbi, REQ_TIME);
> >   out:
> >       inode_unlock(inode);
> >       file_end_write(filp);

