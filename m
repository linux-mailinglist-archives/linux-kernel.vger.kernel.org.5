Return-Path: <linux-kernel+bounces-143598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C438A3B46
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6A82845E6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95321CD1B;
	Sat, 13 Apr 2024 06:42:21 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86781C69A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712990541; cv=none; b=HfnOIf2D+3EJT6uY3GLEJ17yUI0C9wns2ZKYJ4AIujxy5SKwVmeRvxYOL2m1qJNxfHF/SN+OPH0oQ5GaJNfcPfrkxPRijFaDpo9jLLeqXGsPYHBGbot9K7koo8/pjj2mVNmjssNVwrVRIccTtBTtaN/i8ocXCVI4HDcdL7ksTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712990541; c=relaxed/simple;
	bh=EeRF4NIJhixBQKKPaOfdMlUmhBA4b7p+zWA1c7XPyTE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y9VFCMKaJTNQ6oOGfdKaY2E/xYJ0Up2vOu1xL22Ms8+VC3w0ylYxwVZn44cTFo5XLWiEf9ILKNS4j2UwM8vDhXMWhT2d6Gz+EayhkpZk6EQdG0DUrAK3F/+xazwwy0wm/l/zs0T0kejQ+LABi1mWw8FZwCciI3T8pXGaMLKe5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so181388139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 23:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712990539; x=1713595339;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5c4VAK8csd8QMLijn8CGzk+0RoQn1Y1vW2k6Z3FW0Q=;
        b=ww4Pz9SDivloNMcC0BkZmDVIP9RMNk+XZPTxhYSPzVz9VMz1zLoRIlESQKVSnzGnfa
         y65Y+ikkKQkd0hgL91U3XqeBIChMLPRMGQEGD+WVkYx0OLFEtp4OVmG2+gPJhB0pbA9Z
         RhYYsAl5jqwL1eO/B8ial12cnD1D5sIaaKNDLfKbCrq6sY2fdEArevyPKfGjlRlwalwf
         1NJuImamcSI0VUejE4lqgt9YYlST/irUnvfyshUtVssyYwUUnLMotpaVPXuZ+AgkbD57
         51QDjNkDn4YaxC330xeP5x7DHRTsfdtsFZ994pUGmeF8Twi+POTtdRhpWIRTeyBadepN
         UsIg==
X-Gm-Message-State: AOJu0YyjBlcxXdwydljuUj2knHIMfuwLiJODBKFi9S0oONLp1nJ7m43U
	is7BPbEdiTTOXHVOiR/dcxUUXNdgYtVadfx7mgNJEBeS5CXUmR56rCOjDsrzAf339YcwgGlX8RT
	llxqO/ikXWgZO3h7G4B6XCpjrzA8SOMifWogkfZWrMZDbHO+OidW8g4k=
X-Google-Smtp-Source: AGHT+IHYnOs5HwFEytXDfOuE7YL+WG6l2cXg9TgoIJrl5bt+zVWVggGzYyQ0gV/X6uoiyGN5V0a0df31qW6nIcZK9UdU2BKrAkhz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174a:b0:367:472c:e7d7 with SMTP id
 y10-20020a056e02174a00b00367472ce7d7mr391538ill.0.1712990539064; Fri, 12 Apr
 2024 23:42:19 -0700 (PDT)
Date: Fri, 12 Apr 2024 23:42:19 -0700
In-Reply-To: <00000000000042c9190615cdb315@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095bb400615f4b0ed@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
From: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
Author: amir73il@gmail.com

On Sat, Apr 13, 2024 at 4:41=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Thu, 11 Apr 2024 01:11:20 -0700
> > syzbot found the following issue on:
> >
> > HEAD commit:    6ebf211bb11d Add linux-next specific files for 20240410
> > git tree:       linux-next
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1621af9d180=
000
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
git  6ebf211bb11d
>
> --- x/fs/notify/fsnotify.c
> +++ y/fs/notify/fsnotify.c
> @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
>         wait_var_event(fsnotify_sb_watched_objects(sb),
>                        !atomic_long_read(fsnotify_sb_watched_objects(sb))=
);
>         WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTE=
NT));
> -       WARN_ON(fsnotify_sb_has_priority_watchers(sb,
> -                                                 FSNOTIFY_PRIO_PRE_CONTE=
NT));
> +       WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_PRE_C=
ONTENT));
> +       synchronize_srcu(&fsnotify_mark_srcu);
>         kfree(sbinfo);
>  }
>
> @@ -499,7 +499,7 @@ int fsnotify(__u32 mask, const void *dat
>  {
>         const struct path *path =3D fsnotify_data_path(data, data_type);
>         struct super_block *sb =3D fsnotify_data_sb(data, data_type);
> -       struct fsnotify_sb_info *sbinfo =3D fsnotify_sb_info(sb);
> +       struct fsnotify_sb_info *sbinfo;
>         struct fsnotify_iter_info iter_info =3D {};
>         struct mount *mnt =3D NULL;
>         struct inode *inode2 =3D NULL;
> @@ -529,6 +529,8 @@ int fsnotify(__u32 mask, const void *dat
>                 inode2_type =3D FSNOTIFY_ITER_TYPE_PARENT;
>         }
>
> +       iter_info.srcu_idx =3D srcu_read_lock(&fsnotify_mark_srcu);
> +       sbinfo =3D fsnotify_sb_info(sb);
>         /*
>          * Optimization: srcu_read_lock() has a memory barrier which can
>          * be expensive.  It protects walking the *_fsnotify_marks lists.


See comment above. This kills the optimization.
It is not worth letting all the fsnotify hooks suffer the consequence
for the edge case of calling fsnotify hook during fs shutdown.

Also, fsnotify_sb_info(sb) in fsnotify_sb_has_priority_watchers()
is also not protected and using srcu_read_lock() there completely
nullifies the purpose of fsnotify_sb_info.

Here is a simplified fix for fsnotify_sb_error() rebased on the
pending mm fixes for this syzbot boot failure:

#syz test: https://github.com/amir73il/linux fsnotify-fixes

Jan,

I think that all the functions called from fs shutdown context
should observe that SB_ACTIVE is cleared but wasn't sure?

Thanks,
Amir.

