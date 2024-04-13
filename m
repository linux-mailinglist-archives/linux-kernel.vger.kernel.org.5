Return-Path: <linux-kernel+bounces-143634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C63D48A3BB0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AD91F22248
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6B2208B6;
	Sat, 13 Apr 2024 08:46:11 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E05366
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712997971; cv=none; b=XRZjoiFWH9snixFWU5FkjP3uqxAazzjIZDmFxcROwPDaQPtghKKq6rdJySsZl396p8kXZiP88nRki5A81fr4xA2oO9qWZglblVp1HVWFYLBaqhH7s/aw7rfMLKYrCF0pm7bMkKbymIiYKg0aPF2bz7qedK+Fu/kg3O04GaBg9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712997971; c=relaxed/simple;
	bh=UWWc0EfDzeo1KhUuECrIHIrSFuJFcZtoao1je9C1Tk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKu+t1YgwZYHPGk9jRi8PdFoKvjpP/nUVLKH99IrzaUhde5fhcFWvw6k1Hatue0/eeownXFM8GvMq5k3+/9p0YcCZol35ssa77r9S2M5E+7JfbVoCZM5SwrT1gvN6FNzOpuY7RRhypCGRxmha2RWZYJOv8O//PnN1mdaYyb6xx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.22])
	by sina.com (10.75.12.45) with ESMTP
	id 661A4624000059B8; Sat, 13 Apr 2024 16:45:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 57740031457756
X-SMAIL-UIID: 1A7EB68A59634771834D1050F8AB7392-20240413-164526-1
From: Hillf Danton <hdanton@sina.com>
To: amir73il@gmail.com
Cc: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>,
	linux-fsdevel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [syzbot] Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
Date: Sat, 13 Apr 2024 16:45:19 +0800
Message-Id: <20240413084519.1774-1-hdanton@sina.com>
In-Reply-To: <00000000000095bb400615f4b0ed@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 23:42:19 -0700 Amir Goldstein
> On Sat, Apr 13, 2024 at 4:41=E2=80=AFAM Hillf Danton <hdanton@sina.com> wrote:
> >
> > On Thu, 11 Apr 2024 01:11:20 -0700
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    6ebf211bb11d Add linux-next specific files for 20240410
> > > git tree:       linux-next
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1621af9d180000
> >
> > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  6ebf211bb11d
> >
> > --- x/fs/notify/fsnotify.c
> > +++ y/fs/notify/fsnotify.c
> > @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
> >         wait_var_event(fsnotify_sb_watched_objects(sb),
> >                        !atomic_long_read(fsnotify_sb_watched_objects(sb)));
> >         WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTENT));
> > -       WARN_ON(fsnotify_sb_has_priority_watchers(sb,
> > -                                                 FSNOTIFY_PRIO_PRE_CONTENT));
> > +       WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_PRE_CONTENT));
> > +       synchronize_srcu(&fsnotify_mark_srcu);
> >         kfree(sbinfo);
> >  }
> >
> > @@ -499,7 +499,7 @@ int fsnotify(__u32 mask, const void *dat
> >  {
> >         const struct path *path =3D fsnotify_data_path(data, data_type);
> >         struct super_block *sb =3D fsnotify_data_sb(data, data_type);
> > -       struct fsnotify_sb_info *sbinfo =3D fsnotify_sb_info(sb);
> > +       struct fsnotify_sb_info *sbinfo;
> >         struct fsnotify_iter_info iter_info = {};
> >         struct mount *mnt =3D NULL;
> >         struct inode *inode2 =3D NULL;
> > @@ -529,6 +529,8 @@ int fsnotify(__u32 mask, const void *dat
> >                 inode2_type =3D FSNOTIFY_ITER_TYPE_PARENT;
> >         }
> >
> > +       iter_info.srcu_idx =3D srcu_read_lock(&fsnotify_mark_srcu);
> > +       sbinfo =3D fsnotify_sb_info(sb);
> >         /*
> >          * Optimization: srcu_read_lock() has a memory barrier which can
> >          * be expensive.  It protects walking the *_fsnotify_marks lists.
> 
> 
> See comment above. This kills the optimization.
> It is not worth letting all the fsnotify hooks suffer the consequence
> for the edge case of calling fsnotify hook during fs shutdown.

Say nothing before reading your fix.
> 
> Also, fsnotify_sb_info(sb) in fsnotify_sb_has_priority_watchers()
> is also not protected and using srcu_read_lock() there completely
> nullifies the purpose of fsnotify_sb_info.
> 
> Here is a simplified fix for fsnotify_sb_error() rebased on the
> pending mm fixes for this syzbot boot failure:
> 
> #syz test: https://github.com/amir73il/linux fsnotify-fixes

Feel free to post your patch at lore because not everyone has 
access to sites like github.
> 
> Jan,
> 
> I think that all the functions called from fs shutdown context
> should observe that SB_ACTIVE is cleared but wasn't sure?

If you composed fix based on SB_ACTIVE that is cleared in
generic_shutdown_super() with &sb->s_umount held for write,
I wonder what simpler serialization than srcu you could
find/create in fsnotify.

