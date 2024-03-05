Return-Path: <linux-kernel+bounces-91519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79D6871287
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4034B281B3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69DC17C76;
	Tue,  5 Mar 2024 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMXTK9Li"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C32F43
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709603831; cv=none; b=RjFjJvlbcGzAtc1LCpKGKYyOrWozsGIAJRQaSypeJL+O8sG19h/dRKax8vnhMr9MCnSL1OqrCWolRW7tjIasyIzhzYUyxcqxTjTsYV5zk/e4/imFZ+5zrLVbJVqc3+gpHisLJr13FBMN4KA/oU/wc4UcCSiTMKHKVlrWGiaPOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709603831; c=relaxed/simple;
	bh=h7470jmyjrsjrrki75+l9L+bS5EMmOVKCTOcuVbUs3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f01ZJlkxe7CxFDO8mc485JBmQmT0m+QLri1dVd86lBOewFIy5/+vMKfz/XKPylzlQ6i4EA7HN+aBD+aypMsWr0hM1leGiGcf4h62OV/a7lbRhNb3UVXof25wDwM1Bcjo6EqfSjDF+/od3eh65DkNgm8MKrVLiQucH07LCKNCEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMXTK9Li; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so6622822a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 17:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709603828; x=1710208628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw7us6PtslL66jWV5rgbddJX+ZH8W/kC7W1JeYDVces=;
        b=AMXTK9LiEBjyaBIb/ECI11p+hJgt9gqtmLzgbNwLMeUEdO/Lrk1NZ5c/mIcFp689AM
         DTqC4pEu7lqPxxqMN7+I3wwFK4syrRjQC38gxldvZeyEl7rmgz5+icit2WMJuiYzzsUR
         t2eCnTB8EB/JEesekNrLETIGVNyJgb6utKudB6gIsQIurr6VlovEI/J946MS+op7/4C1
         oXcZnBFNLb015jegEkZfoy2YIs6YfM+9+eyzjruPojTflkaJdKpeLu6Ix5LOI+8VWdOo
         bQhwGzVb/xAkPd23l6WGvaGIOLvQhdhLt4i2pG5USp+ER8J+cHammeocCylJgJ2SeW78
         Yy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709603828; x=1710208628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw7us6PtslL66jWV5rgbddJX+ZH8W/kC7W1JeYDVces=;
        b=iDPIseCBL6VKcV1e9a9KTTn/rr59S937XqZtlHv7fXXK3yrYS8mEAO7YRMLzfUrXJ5
         +gseETi8sOwiTT4cL/aFt0QeQmlGNjZsOdCjuZ7ZKhdF2BXqmTJsmdo17/KWI//R55Gl
         cZ3W8jQhjcZ7ZLvdnkkAWPnC6gG3AnRo3mXcCrEIH+WhhjsWp6TYXnaOI1wPpxRuRKoO
         0jPuVlauzA4rq6yNeak2OSiXa2GMY/SGgqUXSdrfqDlH0l0+6eGyEX8Ut3M1JVV3LujP
         3SsQbmd6fSlVJLWzAHXfYDrF4bgC92KHkRuMkBYVjaMwLvOR+O0/e+zt5njAXj1DLRte
         Nwcg==
X-Forwarded-Encrypted: i=1; AJvYcCU4/U76RRN8wSjd4Os9F82ef9dnv6jAbjhYUq/H3AFs0hu1aOGTloS1vbiCxPT5fsuwY5EmTpM5Fdpmn2LVZvxUymABRKxbxmc48FEQ
X-Gm-Message-State: AOJu0YykpKDh5bNkyoGkZM78kWZdFc1t653I8BtxE8ooREWKqed112dt
	2LoT+S3riT4mcc/wC2oY43kWEXBxb/7hozEzqYqb1NAFG0oKExi804QKmZ8tLxwHoITcasVL3U3
	6KgFrl0NhCtjAvE87UbU7i73XInE=
X-Google-Smtp-Source: AGHT+IH/roTdZh/Go7x9sWPisWOSOQ3FEPoCnx1VP18PVkLL9PgiV1f6MXWEzhUqmNBNr6rZAzmGwd6hh1uAeKPjTUM=
X-Received: by 2002:a50:a41b:0:b0:565:7b88:1cff with SMTP id
 u27-20020a50a41b000000b005657b881cffmr7787242edb.11.1709603827695; Mon, 04
 Mar 2024 17:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111081743.2999210-1-chao@kernel.org> <ae43ed8a-49b5-44bf-8fea-a222091e9790@kernel.org>
 <ed3eecaf9e2f4c8fae2fd01241aa097e@BJMBX02.spreadtrum.com>
In-Reply-To: <ed3eecaf9e2f4c8fae2fd01241aa097e@BJMBX02.spreadtrum.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 5 Mar 2024 09:56:56 +0800
Message-ID: <CAHJ8P3JzanzGqjuJ8ODMxE4rguxrQ-yd4Ho16RCDH9u975gOEA@mail.gmail.com>
Subject: Re: [PATCH v3] f2fs: reduce expensive checkpoint trigger frequency
To: =?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, 
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, 
	=?UTF-8?B?6YeR57qi5a6HIChIb25neXUgSmluKQ==?= <hongyu.jin@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear  Jaegeuk,

Let me describe the problem process, it is reproduced by monkey stability t=
est:

 1.SBI_NEED_CP flag bit is set=EF=BC=8C
 set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);

 2.Ckpt thread is blocked by IO busy when it is doing CP,  it can not
get request tag from block queue,
 PID: 505      TASK: ffffff80ed7f49c0  CPU: 4    COMMAND: "f2fs_ckpt-254:4"
 #0 [ffffffc015fcb330] __switch_to at ffffffc010196350
 #1 [ffffffc015fcb390] __schedule at ffffffc01168e53c
 #2 [ffffffc015fcb3f0] schedule at ffffffc01168ed7c
 #3 [ffffffc015fcb450] io_schedule at ffffffc01168f7a0
 #4 [ffffffc015fcb4c0] blk_mq_get_tag at ffffffc0101008a4
 #5 [ffffffc015fcb530] blk_mq_get_request at ffffffc0109241b0
 #6 [ffffffc015fcb5f0] blk_mq_make_request at ffffffc0109233bc
 #7 [ffffffc015fcb680] generic_make_request at ffffffc0100fc6ec
 #8 [ffffffc015fcb700] submit_bio at ffffffc0100fc3b8
 #9 [ffffffc015fcb750] __submit_bio at ffffffc01081a2e0
 #10 [ffffffc015fcb7d0] __submit_merged_bio at ffffffc01081b07c
 #11 [ffffffc015fcb8a0] f2fs_submit_page_write at ffffffc0100ecd3c
 #12 [ffffffc015fcb990] f2fs_do_write_meta_page at ffffffc010845738
 #13 [ffffffc015fcb9d0] __f2fs_write_meta_page at ffffffc01080a8f4
 #14 [ffffffc015fcbb60] f2fs_sync_meta_pages at ffffffc01080a684
 #15 [ffffffc015fcbca0] do_checkpoint at ffffffc01080f0a8
 #16 [ffffffc015fcbd10] f2fs_write_checkpoint at ffffffc01080e50c
 #17 [ffffffc015fcbdb0] __checkpoint_and_complete_reqs at ffffffc010810f54
 #18 [ffffffc015fcbe40] issue_checkpoint_thread at ffffffc0108113ec
 #19 [ffffffc015fcbe80] kthread at ffffffc0102665b0

 3.Subsequent regular file fsync will trigger ckpt because SBI_NEED_CP
has not been cleared.
 In fact, these cases should not trigger ckpt.

 4.If some processes that perform f2fs_do_sync_file are important processes
 in the system(such as init) and are blocked for too long, it will
cause other problems in the system, ANR or android reboot
 PID: 287      TASK: ffffff80f9eb0ec0  CPU: 2    COMMAND: "init"
 #0 [ffffffc01389bab0] __switch_to at ffffffc010196350
 #1 [ffffffc01389bb10] __schedule at ffffffc01168e53c
 #2 [ffffffc01389bb70] schedule at ffffffc01168ed7c
 #3 [ffffffc01389bbc0] wait_for_completion at ffffffc011692368
 #4 [ffffffc01389bca0] f2fs_issue_checkpoint at ffffffc010810cb0
 #5 [ffffffc01389bd00] f2fs_sync_fs at ffffffc0107f4e1c
 #6 [ffffffc01389bdc0] f2fs_do_sync_file at ffffffc0107d4d44
 #7 [ffffffc01389be20] f2fs_sync_file at ffffffc0107d492c
 #8 [ffffffc01389be30] __arm64_sys_fsync at ffffffc0105d31d8
 #9 [ffffffc01389be70] el0_svc_common at ffffffc0101aa550
 #10 [ffffffc01389beb0] el0_svc_handler at ffffffc0100886fc

and I tested Chao's patch can avoid the above case, please help
consider this patch or
any comment/suggestions about this?

thanks!

On Mon, Feb 26, 2024 at 9:22=E2=80=AFAM =E7=89=9B=E5=BF=97=E5=9B=BD (Zhiguo=
 Niu) <Zhiguo.Niu@unisoc.com> wrote:
>
>
> Hi Jaegeuk
>
> Sorry for disturbing you, Do you have any comments about this patch from =
Chao, I=E2=80=99ve met this issue several times on our platform when do mon=
key test.
> Thanks!
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Chao Yu <chao@kernel.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B42=E6=9C=8819=E6=97=A5 =
15:19
> =E6=94=B6=E4=BB=B6=E4=BA=BA: jaegeuk@kernel.org
> =E6=8A=84=E9=80=81: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@=
vger.kernel.org; =E7=89=9B=E5=BF=97=E5=9B=BD (Zhiguo Niu) <Zhiguo.Niu@uniso=
c.com>
> =E4=B8=BB=E9=A2=98: Re: [PATCH v3] f2fs: reduce expensive checkpoint trig=
ger frequency
>
>
> =E6=B3=A8=E6=84=8F: =E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=
=AA=E4=BA=8E=E5=A4=96=E9=83=A8=E3=80=82=E9=99=A4=E9=9D=9E=E4=BD=A0=E7=A1=AE=
=E5=AE=9A=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=B9=E5=AE=89=E5=85=A8=EF=BC=8C=E5=
=90=A6=E5=88=99=E4=B8=8D=E8=A6=81=E7=82=B9=E5=87=BB=E4=BB=BB=E4=BD=95=E9=93=
=BE=E6=8E=A5=E5=92=8C=E9=99=84=E4=BB=B6=E3=80=82
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you recognize the sender and know the=
 content is safe.
>
>
>
> Jaegeuk,
>
> Any comments?
>
> On 2024/1/11 16:17, Chao Yu wrote:
> > We may trigger high frequent checkpoint for below case:
> > 1. mkdir /mnt/dir1; set dir1 encrypted 2. touch /mnt/file1; fsync
> > /mnt/file1 3. mkdir /mnt/dir2; set dir2 encrypted 4. touch /mnt/file2;
> > fsync /mnt/file2 ...
> >
> > Although, newly created dir and file are not related, due to commit
> > bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will trigger
> > checkpoint whenever fsync() comes after a new encrypted dir created.
> >
> > In order to avoid such condition, let's record an entry including
> > directory's ino into global cache when we initialize encryption policy
> > in a checkpointed directory, and then only trigger checkpoint() when
> > target file's parent has non-persisted encryption policy, for the case
> > its parent is not checkpointed, need_do_checkpoint() has cover that by
> > verifying it with f2fs_is_checkpointed_node().
> >
> > Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Reported-by: Yunlei He <heyunlei@hihonor.com>
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> > v3:
> > - Recently, Zhiguo Niu reported the same issue, so I repost this patch
> > for comments.
> >   fs/f2fs/f2fs.h              |  2 ++
> >   fs/f2fs/file.c              |  3 +++
> >   fs/f2fs/xattr.c             | 16 ++++++++++++++--
> >   include/trace/events/f2fs.h |  3 ++-
> >   4 files changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index
> > e2e0ca45f881..0094a8c85f4a 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -279,6 +279,7 @@ enum {
> >       APPEND_INO,             /* for append ino list */
> >       UPDATE_INO,             /* for update ino list */
> >       TRANS_DIR_INO,          /* for transactions dir ino list */
> > +     ENC_DIR_INO,            /* for encrypted dir ino list */
> >       FLUSH_INO,              /* for multiple device flushing */
> >       MAX_INO_ENTRY,          /* max. list */
> >   };
> > @@ -1147,6 +1148,7 @@ enum cp_reason_type {
> >       CP_FASTBOOT_MODE,
> >       CP_SPEC_LOG_NUM,
> >       CP_RECOVER_DIR,
> > +     CP_ENC_DIR,
> >   };
> >
> >   enum iostat_type {
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index
> > 8198afb5fb9c..18b33b1f0c83 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -218,6 +218,9 @@ static inline enum cp_reason_type need_do_checkpoin=
t(struct inode *inode)
> >               f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
> >                                                       TRANS_DIR_INO))
> >               cp_reason =3D CP_RECOVER_DIR;
> > +     else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
> > +                                                     ENC_DIR_INO))
> > +             cp_reason =3D CP_ENC_DIR;
> >
> >       return cp_reason;
> >   }
> > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c index
> > f290fe9327c4..cbd1b88297fe 100644
> > --- a/fs/f2fs/xattr.c
> > +++ b/fs/f2fs/xattr.c
> > @@ -629,6 +629,7 @@ static int __f2fs_setxattr(struct inode *inode, int=
 index,
> >                       const char *name, const void *value, size_t size,
> >                       struct page *ipage, int flags)
> >   {
> > +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> >       struct f2fs_xattr_entry *here, *last;
> >       void *base_addr, *last_base_addr;
> >       int found, newsize;
> > @@ -772,8 +773,19 @@ static int __f2fs_setxattr(struct inode *inode, in=
t index,
> >       if (index =3D=3D F2FS_XATTR_INDEX_ENCRYPTION &&
> >                       !strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT)=
)
> >               f2fs_set_encrypted_inode(inode);
> > -     if (S_ISDIR(inode->i_mode))
> > -             set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
> > +
> > +     if (S_ISDIR(inode->i_mode)) {
> > +             /*
> > +              * In restrict mode, fsync() always tries triggering chec=
kpoint
> > +              * for all metadata consistency, in other mode, it only t=
riggers
> > +              * checkpoint when parent's encryption metadata updates.
> > +              */
> > +             if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_STRICT)
> > +                     set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
> > +             else if (IS_ENCRYPTED(inode) &&
> > +                     f2fs_is_checkpointed_node(sbi, inode->i_ino))
> > +                     f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO=
);
> > +     }
> >
> >   same:
> >       if (is_inode_flag_set(inode, FI_ACL_MODE)) { diff --git
> > a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h index
> > 7ed0fc430dc6..48f2e399e184 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -139,7 +139,8 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
> >               { CP_NODE_NEED_CP,      "node needs cp" },              \
> >               { CP_FASTBOOT_MODE,     "fastboot mode" },              \
> >               { CP_SPEC_LOG_NUM,      "log type is 2" },              \
> > -             { CP_RECOVER_DIR,       "dir needs recovery" })
> > +             { CP_RECOVER_DIR,       "dir needs recovery" },         \
> > +             { CP_ENC_DIR,           "persist encryption policy" })
> >
> >   #define show_shutdown_mode(type)                                    \
> >       __print_symbolic(type,                                          \

