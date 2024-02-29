Return-Path: <linux-kernel+bounces-86938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A3186CD42
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A243E1C211AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53314A0B5;
	Thu, 29 Feb 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="s1L7tTd1"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2B145FE1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221221; cv=none; b=Ir1yxfKCos7usJFlYCvvfYcVXMIgwrPhX6iyAENzYpHfNsuKduzzduMaAvu+/3XedMZGFR/cOk+dxFgxaJXbxxXEPWvU53Si0lYlTdPhnwhLrEHsVUsDamAAaBMaQSg4edbg+FS6AyQnDEHUT2rqBaYzci5b/TxV2uxAbYPRIQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221221; c=relaxed/simple;
	bh=vl4r6f9A4c/KKfnU4Nr5FNHhSTwmYeD20JiNkU2673c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRleSYWfycqC/98zdrqdf8Hu/GAhsRuRzyKdpLfuUQtk+JOMuIXFW/dPZ8v0HRi+b742YkBbeo41M4X+2eU6V2iZEvkHbwQxQwtBdZ1bRcSc9iDPdSZqvYWuyqa1YeSeVRSD87KbSK9dUW244UcidJ3s3+flaoeZrSS5pbO745U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1L7tTd1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc9f4d1106so176495ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709221219; x=1709826019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPtYyP7t0NFgMkniDi99zk16rKwZpHYjTsBi+fDdWUA=;
        b=s1L7tTd1VXOAJTGj4fK0Hwnaw8DI24qElE1BxsimrLHDvjfn0y2JfqTLVTfvN8OdYQ
         yazMEHKOWyUTFu3PcFwmdwcnghPjmBJFIC0SSKSzG/vhgiWxlHy/4qqQSa76rUJYehAx
         0I8mmJif35bl/Vdwc65sVSyRl+5iVbawF49SdsPRwCsy9Bi5ZpNqPg599Cb72G1tGiB8
         tY33ZtjnrIAWQAAP13u/Fz6RLaFiqatEU1vrcIIS5rrJMkF2AOhd5QZVYf3S7JVKcVk9
         MGpNNb1oIV/R81L+K+kS5IDpFG5BJCYE4FLM3s/klARqraPxvef+FKczTd+HPAPcl2Is
         NRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709221219; x=1709826019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPtYyP7t0NFgMkniDi99zk16rKwZpHYjTsBi+fDdWUA=;
        b=MhynBkXD6DVr1htqwEg748WTpGgvl+iDh8VxQPGXowy4UYHBGpaA/fRB7tAKllbCfi
         1F781oRHx4WcGZ5SyIDM+Ws4dHlO/V5yprmuTzdk30f8Yr9UWLO9ij2uEhD0Fc0Ecgs6
         N+QQ1auxmbnPtKxBzukwyP1yM5S1UJbnW9AReupiO8DJM/6tWdq+/s6UPVKZ9CHkLxUu
         EecOoRBu+WV+oj4fzYJVi+CrsfYrzVqkUAM1221X6ONXrJGpSDpHnU9JonqmRxMlxQ2o
         H1GNJutl1eGIAZ1K2V6iABIYvEKa211YxZqdf8GlVl6g508cTv9LdE6wbZeIaU0yBJYS
         I8qw==
X-Forwarded-Encrypted: i=1; AJvYcCVzJF3A/xDLqph/MZMwfAW+bpxY8yqM0CQk4PgoDFdQhxHs/0G2cy8WcjGlnIQaZIskG/1nFvcLbmKcuMBhTunXTmf1AIvG5k4HKSBj
X-Gm-Message-State: AOJu0Yz8ie33Au4tCgJRaUjLQypKnO1K0zXeNj9t6T3txgPCMPCpY8uQ
	sYBMcxh2rzckKqwJ77aCy51jiu8pcsgl+vZ3NX/oGW/BHaW96AuWN8mbjWZhtoyHHfDq09JvLvT
	6jWBsEJb56L+nfQZ4bMXYa0pE0cRm1so2aqeN
X-Google-Smtp-Source: AGHT+IGJ5mMwE6a5kfljnmhnT6OZDy4x9vElVLco6stAHf587GWn8SLkw78sNLANF+y/oYXXQ5FpGDiJXkwmBKUgfOk=
X-Received: by 2002:a17:902:e88d:b0:1db:9fed:c591 with SMTP id
 w13-20020a170902e88d00b001db9fedc591mr193659plg.22.1709221219060; Thu, 29 Feb
 2024 07:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fe3f46c-4ee5-4597-bf2d-12a5d634a264@rowland.harvard.edu>
 <0000000000008b026406126a4bbe@google.com> <13add23d-af18-4f84-9f1a-043932a9712b@rowland.harvard.edu>
 <CANp29Y4DUvL5zsnqQmhPGkbc=EN6UjFrWF9EZGE5U_=0C9+1Nw@mail.gmail.com> <380909e4-6e0a-402f-b3ac-de07e520c910@rowland.harvard.edu>
In-Reply-To: <380909e4-6e0a-402f-b3ac-de07e520c910@rowland.harvard.edu>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 29 Feb 2024 16:40:05 +0100
Message-ID: <CANp29Y6hPF--pjWCa4bsAXWY15XoP2kmSg8BFP4ATGUpVbQgHQ@mail.gmail.com>
Subject: Re: [syzbot] [usb-storage?] divide error in isd200_ata_command
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>, 
	bvanassche@acm.org, emilne@redhat.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com, 
	tasos@tasossah.com, usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:18=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Wed, Feb 28, 2024 at 05:52:50PM +0100, Aleksandr Nogikh wrote:
> > Hi Alan,
> >
> > Please try it once more with the full commit hash.
>
> Thanks for the advice.  Are you a good person to complain to about the
> difference between what syzbot provides and what it will accept?  This
> bug report states
>
> HEAD commit:    f2e367d6ad3b Merge tag 'for-6.8/dm-fix-3' of git://git.ke=
r..
> git tree:       upstream
>
> But if I specify "upstream" as the git tree on a syz test request, it
> doesn't accept it.  Now you're suggesting that if I put f2e367d6ad3b as
> the commit ID, it won't accept it.
>
> There's probably already a bugfix request for this, but I'd like to push
> on it some more.  Syzbot's output should be acceptable as its input!

That all totally makes sense. Thanks for highlighting the problems!

For accepting "upstream" (and alike) as input, there was already a github i=
ssue:
https://github.com/google/syzkaller/issues/2265
That syzbot is not able to fetch commits by their short hashes was
only discovered yesterday.

I've just sent PRs with fixes for both issues.

If there's anything else that can make syzbot reports better, please
let me know :)

--=20
Aleksandr

>
> Okay, here goes with the full commit ID...
>
> Alan Stern
>
> On Mon, Feb 26, 2024 at 01:42:26AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    f2e367d6ad3b Merge tag 'for-6.8/dm-fix-3' of git://git.=
ker..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D114e10e4180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Deff9f3183d0=
a20dd
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D28748250ab47a=
8f04100
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1064b3721=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10aca6ac180=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c55ca1fdc5ad/d=
isk-f2e367d6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/4556a82fb4ed/vmli=
nux-f2e367d6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/95338ed9dad1=
/bzImage-f2e367d6.xz
> >
> > The issue was bisected to:
> >
> > commit 321da3dc1f3c92a12e3c5da934090d2992a8814c
> > Author: Martin K. Petersen <martin.petersen@oracle.com>
> > Date:   Tue Feb 13 14:33:06 2024 +0000
> >
> >     scsi: sd: usb_storage: uas: Access media prior to querying device p=
roperties
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15a3934a=
180000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D17a3934a=
180000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13a3934a180=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com
> > Fixes: 321da3dc1f3c ("scsi: sd: usb_storage: uas: Access media prior to=
 querying device properties")
> >
> > divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> > CPU: 0 PID: 5070 Comm: usb-storage Not tainted 6.8.0-rc5-syzkaller-0029=
7-gf2e367d6ad3b #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/25/2024
> > RIP: 0010:isd200_scsi_to_ata drivers/usb/storage/isd200.c:1318 [inline]
> > RIP: 0010:isd200_ata_command+0x776/0x2380 drivers/usb/storage/isd200.c:=
1529
>
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
git/ f2e367d6ad3bdc527c2b14e759c2f010d6b2b7a1
> Index: usb-devel/drivers/usb/storage/isd200.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/drivers/usb/storage/isd200.c
> +++ usb-devel/drivers/usb/storage/isd200.c
> @@ -1105,7 +1105,7 @@ static void isd200_dump_driveid(struct u
>  static int isd200_get_inquiry_data( struct us_data *us )
>  {
>         struct isd200_info *info =3D (struct isd200_info *)us->extra;
> -       int retStatus =3D ISD200_GOOD;
> +       int retStatus;
>         u16 *id =3D info->id;
>
>         usb_stor_dbg(us, "Entering isd200_get_inquiry_data\n");
> @@ -1137,6 +1137,13 @@ static int isd200_get_inquiry_data( stru
>                                 isd200_fix_driveid(id);
>                                 isd200_dump_driveid(us, id);
>
> +                               /* Prevent division by 0 in isd200_scsi_t=
o_ata() */
> +                               if (id[ATA_ID_HEADS] =3D=3D 0 || id[ATA_I=
D_SECTORS] =3D=3D 0) {
> +                                       usb_stor_dbg(us, "   Invalid ATA =
Identify data\n");
> +                                       retStatus =3D ISD200_ERROR;
> +                                       goto Done;
> +                               }
> +
>                                 memset(&info->InquiryData, 0, sizeof(info=
->InquiryData));
>
>                                 /* Standard IDE interface only supports d=
isks */
> @@ -1202,6 +1209,7 @@ static int isd200_get_inquiry_data( stru
>                 }
>         }
>
> + Done:
>         usb_stor_dbg(us, "Leaving isd200_get_inquiry_data %08X\n", retSta=
tus);
>
>         return(retStatus);
> @@ -1481,22 +1489,27 @@ static int isd200_init_info(struct us_da
>
>  static int isd200_Initialization(struct us_data *us)
>  {
> +       int rc =3D 0;
> +
>         usb_stor_dbg(us, "ISD200 Initialization...\n");
>
>         /* Initialize ISD200 info struct */
>
> -       if (isd200_init_info(us) =3D=3D ISD200_ERROR) {
> +       if (isd200_init_info(us) < 0) {
>                 usb_stor_dbg(us, "ERROR Initializing ISD200 Info struct\n=
");
> +               rc =3D -ENOMEM;
>         } else {
>                 /* Get device specific data */
>
> -               if (isd200_get_inquiry_data(us) !=3D ISD200_GOOD)
> +               if (isd200_get_inquiry_data(us) !=3D ISD200_GOOD) {
>                         usb_stor_dbg(us, "ISD200 Initialization Failure\n=
");
> -               else
> +                       rc =3D -EINVAL;
> +               } else {
>                         usb_stor_dbg(us, "ISD200 Initialization complete\=
n");
> +               }
>         }
>
> -       return 0;
> +       return rc;
>  }
>
>
>
>

