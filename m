Return-Path: <linux-kernel+bounces-81160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5A986714C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FD51C28328
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E6351C40;
	Mon, 26 Feb 2024 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6+4sX25"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648751004
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943305; cv=none; b=V4/8jJA0arGCNoCU+pw19uEST6bE2mWe9iF+FC47tafORHg9Uy/nbqveBiXBSwxMDoDvY3lYL9taAMjkf0kHKgnVE76Wuarx2pS2hOcOBlqCqvgiyc9o2K7VJA950qTgh8P3Fz35SdiJzzBIpJdL515z66/revUnirEZ9qWswuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943305; c=relaxed/simple;
	bh=AbDPqfMVwKxacT39pPgPW9qMKdyaD214FgXZSwjGNBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGzOywwYX70Pb7E/rdSXOTP8+7sAgxeYxodbLKyxgQsSZCpdTwckP+q0b2ZdDkphqzy/X+c13w1ffbZmXgi+/ttVhqounXj+n2xuvtNGV4z534WxPbf1ARBt1kRAZ6Qk3u7unLon4KjB7drsB6BU3CONkBByjgKycEMPK8I0Up8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6+4sX25; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so3699853a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708943302; x=1709548102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRBFXTJCVRtEGA+hrXGUuCjVOI5AX562PyFUCsem+h8=;
        b=D6+4sX25DtgIcnpSnFFNPlhPCmyg3D6MDivLynYQcYDY5rloqGc0TxZCVxcUoWAZby
         MSjfArzrGqEBt3IloGeI//XewtESoCQt+7L3tRgwDmpM52H6TDRKVEUpVBtDmjJeCfiY
         dmOdqJ39mhOoywCbFb3oxdfvwTDx353vvE6zTbJFNv/VG6hVDsVtA7KoHT8/ZzSufKT4
         lXLSeL3mq+TKDHKQKfB3WbRTt6mrTCcTqtP37VAm2ftPHVNGz6tEmwfqO9hKMTA/kQnF
         jC19q1QCJvnHsCfLFPipgrqH6qRSc6ZCcJXAdJQ9K/3JunawEiHf3Zr5PiyG59wCn39e
         wqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708943302; x=1709548102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRBFXTJCVRtEGA+hrXGUuCjVOI5AX562PyFUCsem+h8=;
        b=MfO4/MkejH/SesozCkCXbKzyHS3C73gBjaoNVzJ6uJclpOnX0z9x3dXhJOlfw5PPmA
         2o4Wlzz3q/wy2478HJjEITOJ/0o3V6bWJBrsjwIJX/2S7BDhl/8DZYyEbqUNtptfVfGl
         WO3PsfstbiVrWWiURutkmrLoCgoLtOuGY3XiLSmGzWOWnzcB3ymdVsFMOZaf+DCvexUr
         jtOklE8HkqOdWTubkYFOGs5DKh99aZsVElDX2oSHldPBS+w6j169eQ/xjaY4qWqNMJcI
         YSJuOzQfBJcU4xTuWxuP2PGl8wbC4auuKCixwVvxeNF5Npv8ttoULIMivRiOvl3Eh6PN
         yWDA==
X-Forwarded-Encrypted: i=1; AJvYcCWmVGX+FHrdv31z5VyFJLZCgYe3Bmz+wWbq98kKAtwv++hjk4vpvARCZwZK5zwrv6oe+8eiyYUe8GWzP1ZqePkCeFBj8Zt4mJs2s6Jr
X-Gm-Message-State: AOJu0YwOyWBC8q2ZtG8oqqA5+tublYJIlJT+rMO1CBx/YSmEhjVlv+3Z
	+4R500CsixpW0ZxvduMkgCIbmR4jahjwmYELX8SDlg6Nxom4iWSf3s9kz1pR+DpSgqjCfbNMJGb
	YXtiCaaNjvrR0/QXeiMHc/PLFArY=
X-Google-Smtp-Source: AGHT+IEM17THi24tm4/ZbX2IZRgGybQnFgdb8eGO52rCgNXjgcYRwkRPk9ipp/IYJlbRLhY8Rm3MCt9QtGkH+RLfpIo=
X-Received: by 2002:aa7:d841:0:b0:566:f60:4fc4 with SMTP id
 f1-20020aa7d841000000b005660f604fc4mr786873eds.37.1708943301723; Mon, 26 Feb
 2024 02:28:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222121851.883141-1-chao@kernel.org> <20240222121851.883141-3-chao@kernel.org>
 <873304dc-112d-4c34-b966-e0905ee748fb@kernel.org>
In-Reply-To: <873304dc-112d-4c34-b966-e0905ee748fb@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 26 Feb 2024 18:28:10 +0800
Message-ID: <CAHJ8P3LvAJxHwq3yy7kg1mfcDi6mSUf95ODaEkiWcAw9JXD+MQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] f2fs: fix to handle segment allocation failure correctly
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, jaegeuk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 3:46=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> Loop to Zhiguo,
>
> On 2024/2/22 20:18, Chao Yu wrote:
> > If CONFIG_F2FS_CHECK_FS is off, and for very rare corner case that
> > we run out of free segment, we should not panic kernel, instead,
> > let's handle such error correctly in its caller.
> >
> > Signed-off-by: Chao Yu <chao@kernel.org>
Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Thanks!
> > ---
> >   fs/f2fs/data.c    |  7 +++++--
> >   fs/f2fs/f2fs.h    |  2 +-
> >   fs/f2fs/file.c    |  7 ++++++-
> >   fs/f2fs/gc.c      |  7 ++++++-
> >   fs/f2fs/segment.c | 46 +++++++++++++++++++++++++++++++++++++++-------
> >   5 files changed, 57 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 0c9aa3082fcf..c21b92f18463 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1416,8 +1416,11 @@ static int __allocate_data_block(struct dnode_of=
_data *dn, int seg_type)
> >
> >       set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
> >       old_blkaddr =3D dn->data_blkaddr;
> > -     f2fs_allocate_data_block(sbi, NULL, old_blkaddr, &dn->data_blkadd=
r,
> > -                             &sum, seg_type, NULL);
> > +     err =3D f2fs_allocate_data_block(sbi, NULL, old_blkaddr,
> > +                             &dn->data_blkaddr, &sum, seg_type, NULL);
> > +     if (err)
> > +             return err;
> > +
> >       if (GET_SEGNO(sbi, old_blkaddr) !=3D NULL_SEGNO)
> >               f2fs_invalidate_internal_cache(sbi, old_blkaddr);
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index fbbe9a0a4221..6390c3d551cb 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3726,7 +3726,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi,=
 struct dnode_of_data *dn,
> >                       block_t old_addr, block_t new_addr,
> >                       unsigned char version, bool recover_curseg,
> >                       bool recover_newaddr);
> > -void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *p=
age,
> > +int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *pa=
ge,
> >                       block_t old_blkaddr, block_t *new_blkaddr,
> >                       struct f2fs_summary *sum, int type,
> >                       struct f2fs_io_info *fio);
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 088d0e79fbbc..d6ec744f1545 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -2262,8 +2262,11 @@ static int f2fs_ioc_shutdown(struct file *filp, =
unsigned long arg)
> >       case F2FS_GOING_DOWN_METASYNC:
> >               /* do checkpoint only */
> >               ret =3D f2fs_sync_fs(sb, 1);
> > -             if (ret)
> > +             if (ret) {
> > +                     if (ret =3D=3D -EIO)
> > +                             ret =3D 0;
> >                       goto out;
> > +             }
> >               f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN)=
;
> >               break;
> >       case F2FS_GOING_DOWN_NOSYNC:
> > @@ -2279,6 +2282,8 @@ static int f2fs_ioc_shutdown(struct file *filp, u=
nsigned long arg)
> >               set_sbi_flag(sbi, SBI_IS_DIRTY);
> >               /* do checkpoint only */
> >               ret =3D f2fs_sync_fs(sb, 1);
> > +             if (ret =3D=3D -EIO)
> > +                     ret =3D 0;
> >               goto out;
> >       default:
> >               ret =3D -EINVAL;
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 6d160d50e14e..42e75e9b8b6b 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1358,8 +1358,13 @@ static int move_data_block(struct inode *inode, =
block_t bidx,
> >       set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
> >
> >       /* allocate block address */
> > -     f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr=
,
> > +     err =3D f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, =
&newaddr,
> >                               &sum, type, NULL);
> > +     if (err) {
> > +             f2fs_put_page(mpage, 1);
> > +             /* filesystem should shutdown, no need to recovery block =
*/
> > +             goto up_out;
> > +     }
> >
> >       fio.encrypted_page =3D f2fs_pagecache_get_page(META_MAPPING(fio.s=
bi),
> >                               newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 8edc42071e6f..71f523431e87 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -400,6 +400,9 @@ int f2fs_commit_atomic_write(struct inode *inode)
> >    */
> >   void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
> >   {
> > +     if (f2fs_cp_error(sbi))
> > +             return;
> > +
> >       if (time_to_inject(sbi, FAULT_CHECKPOINT))
> >               f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_FAULT_INJ=
ECT);
> >
> > @@ -2636,7 +2639,7 @@ static int is_next_segment_free(struct f2fs_sb_in=
fo *sbi,
> >    * Find a new segment from the free segments bitmap to right order
> >    * This function should be returned with success, otherwise BUG
> >    */
> > -static void get_new_segment(struct f2fs_sb_info *sbi,
> > +static int get_new_segment(struct f2fs_sb_info *sbi,
> >                       unsigned int *newseg, bool new_sec, bool pinning)
> >   {
> >       struct free_segmap_info *free_i =3D FREE_I(sbi);
> > @@ -2711,6 +2714,7 @@ static void get_new_segment(struct f2fs_sb_info *=
sbi,
> >               f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMEN=
T);
> >               f2fs_bug_on(sbi, 1);
> >       }
> > +     return ret;
> >   }
> >
> >   static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modi=
fied)
> > @@ -2719,6 +2723,10 @@ static void reset_curseg(struct f2fs_sb_info *sb=
i, int type, int modified)
> >       struct summary_footer *sum_footer;
> >       unsigned short seg_type =3D curseg->seg_type;
> >
> > +     /* only happen when get_new_segment() fails */
> > +     if (curseg->next_segno =3D=3D NULL_SEGNO)
> > +             return;
> > +
> >       curseg->inited =3D true;
> >       curseg->segno =3D curseg->next_segno;
> >       curseg->zone =3D GET_ZONE_FROM_SEG(sbi, curseg->segno);
> > @@ -2783,7 +2791,10 @@ static int new_curseg(struct f2fs_sb_info *sbi, =
int type, bool new_sec)
> >               write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, s=
egno));
> >
> >       segno =3D __get_next_segno(sbi, type);
> > -     get_new_segment(sbi, &segno, new_sec, pinning);
> > +     if (get_new_segment(sbi, &segno, new_sec, pinning)) {
> > +             curseg->segno =3D NULL_SEGNO;
> > +             return -ENOSPC;
> > +     }
> >       if (new_sec && pinning &&
> >           !f2fs_valid_pinned_area(sbi, START_BLOCK(sbi, segno))) {
> >               __set_free(sbi, segno);
> > @@ -3425,7 +3436,7 @@ static void f2fs_randomize_chunk(struct f2fs_sb_i=
nfo *sbi,
> >               get_random_u32_inclusive(1, sbi->max_fragment_hole);
> >   }
> >
> > -void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *p=
age,
> > +int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *pa=
ge,
> >               block_t old_blkaddr, block_t *new_blkaddr,
> >               struct f2fs_summary *sum, int type,
> >               struct f2fs_io_info *fio)
> > @@ -3442,6 +3453,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info=
 *sbi, struct page *page,
> >       mutex_lock(&curseg->curseg_mutex);
> >       down_write(&sit_i->sentry_lock);
> >
> > +     if (curseg->segno =3D=3D NULL_SEGNO)
> > +             goto out_err;
> > +
> >       if (from_gc) {
> >               f2fs_bug_on(sbi, GET_SEGNO(sbi, old_blkaddr) =3D=3D NULL_=
SEGNO);
> >               se =3D get_seg_entry(sbi, GET_SEGNO(sbi, old_blkaddr));
> > @@ -3500,6 +3514,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info=
 *sbi, struct page *page,
> >                               change_curseg(sbi, type);
> >                       stat_inc_seg_type(sbi, curseg);
> >               }
> > +
> > +             if (curseg->segno =3D=3D NULL_SEGNO)
> > +                     goto out_err;
> >       }
> >
> >   skip_new_segment:
> > @@ -3534,8 +3551,15 @@ void f2fs_allocate_data_block(struct f2fs_sb_inf=
o *sbi, struct page *page,
> >       }
> >
> >       mutex_unlock(&curseg->curseg_mutex);
> > -
> >       f2fs_up_read(&SM_I(sbi)->curseg_lock);
> > +     return 0;
> > +out_err:
> > +     *new_blkaddr =3D NULL_ADDR;
> > +     up_write(&sit_i->sentry_lock);
> > +     mutex_unlock(&curseg->curseg_mutex);
> > +     f2fs_up_read(&SM_I(sbi)->curseg_lock);
> > +     return -ENOSPC;
> > +
> >   }
> >
> >   void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
> > @@ -3573,8 +3597,16 @@ static void do_write_page(struct f2fs_summary *s=
um, struct f2fs_io_info *fio)
> >       if (keep_order)
> >               f2fs_down_read(&fio->sbi->io_order_lock);
> >
> > -     f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> > -                     &fio->new_blkaddr, sum, type, fio);
> > +     if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkadd=
r,
> > +                     &fio->new_blkaddr, sum, type, fio)) {
> > +             if (fscrypt_inode_uses_fs_layer_crypto(fio->page->mapping=
->host))
> > +                     fscrypt_finalize_bounce_page(&fio->encrypted_page=
);
> > +             if (PageWriteback(fio->page))
> > +                     end_page_writeback(fio->page);
> > +             if (f2fs_in_warm_node_list(fio->sbi, fio->page))
> > +                     f2fs_del_fsync_node_entry(fio->sbi, fio->page);
> > +             goto out;
> > +     }
> >       if (GET_SEGNO(fio->sbi, fio->old_blkaddr) !=3D NULL_SEGNO)
> >               f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr=
);
> >
> > @@ -3582,7 +3614,7 @@ static void do_write_page(struct f2fs_summary *su=
m, struct f2fs_io_info *fio)
> >       f2fs_submit_page_write(fio);
> >
> >       f2fs_update_device_state(fio->sbi, fio->ino, fio->new_blkaddr, 1)=
;
> > -
> > +out:
> >       if (keep_order)
> >               f2fs_up_read(&fio->sbi->io_order_lock);
> >   }

