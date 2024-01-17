Return-Path: <linux-kernel+bounces-28911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF668830485
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD0A1F24E97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE801DDEB;
	Wed, 17 Jan 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCmspbtP"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F21DDEA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490859; cv=none; b=G6GEUypyROpgJ2gpplPEhXHOBCtDj3z7LHRseaDntoe8MZfqg0VDGDhMSZVgFTeA94rl0f5xUm0AX/TY1X9igQnbouE0ZQIEQT3SQQX/Sf3fab5Z0jgdL2LryJgtpW6uVulitJqtiIvJ9wZcmdeHcN0Hbqh0oRI9QTvCIDPsqWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490859; c=relaxed/simple;
	bh=1OR+xPZ6Pg7n5BBFW9SfbEotYULYikt0P7tLlgmn9WM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=li83IV9MQWoLwSQiYMBTVA/X1DgN5TSHr4v5a4GiHdWm/xQKEDOvwGCc4l7iQxQLuWohiSWgxIExV8E7X2jRes3RZFmwNUyawuhr3iFxMJaa71W43wO4j0ufm+aBsMaHG+7MDz1j9zmGWtOQs0V5QMLjYp2O/TAMVapZkT3DqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCmspbtP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783045e88a6so809250985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705490857; x=1706095657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yX7YAU0jZ00+RmLgD3hlICEdBYU3XjNXhe6NXBaxDVg=;
        b=hCmspbtP8ajmmpWt2s8MLVUjUDkWRUsDXxlcg076ye1i2tydgjka9Ckeii0bvo63LI
         sIK7bV8roxYaS9Vsl2ZxCQwhy93LbEJobFWAO5wtQvrIYBcKF3MBCZyWAcBZ7hvNQhCt
         CCLMkB70cKVWTBE9+op8MUMJlLS3fgia/9WIuwjcz7IsgnqcW8gRJgWNIFy+jjtIxAgt
         dd6czHZiWqLdXRPbDRDeR0+GMARyeUChBQWNU9MkZq8oCZZjwrDqYeJ/4eXuDHgZ+SE2
         Ka87Zyb3uausekrEUBKyR9VEoellZr1wGO+jDQNjN/C/J76slf8OA0DkFnqA9TG8ux0O
         VFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705490857; x=1706095657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yX7YAU0jZ00+RmLgD3hlICEdBYU3XjNXhe6NXBaxDVg=;
        b=WjgJFaxKRra1fmyb4qjN/UjBwO2QPWg0V70F70pUHbdjTh8SepkPzMM4mpL/SdrcaF
         AhxrM64ShesQtAVC4g4GsIrK5sMye0k1NilAL/g2lxIoCHpvgmJVMsYnN8v+irnNUtNl
         5MTg21R286L13TTGw0b/pgO1pr8EDOsae5TkSsQWYY+CFmS7xVj3NmX1GCBoWwxP4hI+
         YOz5B7oW6cZnVuRxS+qehGU+6IOcnjWI+aFnKKtgKupGZwcW6pD8cvVAy5/sV7H+ngEz
         1x9tZBsvcDLtZd/sP0yLaOwf4oHEDL/EEx02wR6l0CW8NMoMAU0iLKg5zQ3MTBhLFPBo
         X/Aw==
X-Gm-Message-State: AOJu0YzzVb16O/bBG67THBVD7k6nEZ4dU1gJdTY9jelJv2ZZBat/7q8a
	52WZu6kQE8jN/bollIPpnwkocFbhOKauGrGx/Co=
X-Google-Smtp-Source: AGHT+IHE0yvbhot0VosNjsRVCkFmWT7zswkOjBw+fzEJUuBFrRzSPtNMJIJ5y5vZfZcNgwdhn+bBcyOLmZNGI+U1Py0=
X-Received: by 2002:ac8:4e96:0:b0:42a:de7:3244 with SMTP id
 22-20020ac84e96000000b0042a0de73244mr984144qtp.59.1705490856737; Wed, 17 Jan
 2024 03:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116141138.1245-1-qwjhust@gmail.com> <CACOAw_yL7fLmjLkK29yEb3hgTqoDO2hntOX5LMHmWjZWWix1ig@mail.gmail.com>
 <CAGFpFsSSg+Xs9TAw8qOadUxj8kYfyc+h3cCu_UJsxXUzMu50vQ@mail.gmail.com> <601da6d0-8e22-4e6f-a791-5db9d5ebc793@oppo.com>
In-Reply-To: <601da6d0-8e22-4e6f-a791-5db9d5ebc793@oppo.com>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Wed, 17 Jan 2024 19:27:26 +0800
Message-ID: <CAGFpFsT6XyTNPRxrTg+=F_eQ_-cryhdYd-k7rXxy1oJn4F4oLA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix NULL pointer dereference in f2fs_submit_page_write()
To: Yongpeng Yang <yangyongpeng1@oppo.com>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, hustqwj@hust.edu.cn, 
	linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Yongpeng,
I don't think that's correct.
If list_empty(&io->io_list) and fio->in_list are true, it will jump to
the "out" label. This does not enter the judgment process.
In addition,  __bio_alloc() will ensure that io->bio ! =3D NULL.

On Wed, Jan 17, 2024 at 6:17=E2=80=AFPM Yongpeng Yang <yangyongpeng1@oppo.c=
om> wrote:
>
> Hello Wenjie,
> This patch does not prevent the simultaneous truth of
> list_empty(&io->io_list), fio->in_list, and is_end_zone_blkaddr(sbi,
> fio->new_blkaddr). NULL pointer dereference error still exists in
> =E2=80=9Cbio_get(io->bio)=E2=80=9D. Is that correct?
>
> On 1/17/2024 9:39 AM, Wenjie Qi wrote:
> > Hello Daeho,
> > I don't think moving just the "out" label will work.
> > If a fio is zone end and in_list =3D 1, that fio is missed without bein=
g judged.
> >
> > On Wed, Jan 17, 2024 at 5:58=E2=80=AFAM Daeho Jeong <daeho43@gmail.com>=
 wrote:
> >>
> >> On Tue, Jan 16, 2024 at 6:13=E2=80=AFAM Wenjie Qi <qwjhust@gmail.com> =
wrote:
> >>>
> >>> BUG: kernel NULL pointer dereference, address: 0000000000000014
> >>> RIP: 0010:f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> >>> Call Trace:
> >>> <TASK>
> >>> ? show_regs+0x6e/0x80
> >>> ? __die+0x29/0x70
> >>> ? page_fault_oops+0x154/0x4a0
> >>> ? prb_read_valid+0x20/0x30
> >>> ? __irq_work_queue_local+0x39/0xd0
> >>> ? irq_work_queue+0x36/0x70
> >>> ? do_user_addr_fault+0x314/0x6c0
> >>> ? exc_page_fault+0x7d/0x190
> >>> ? asm_exc_page_fault+0x2b/0x30
> >>> ? f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> >>> ? f2fs_submit_page_write+0x736/0x780 [f2fs]
> >>> do_write_page+0x50/0x170 [f2fs]
> >>> f2fs_outplace_write_data+0x61/0xb0 [f2fs]
> >>> f2fs_do_write_data_page+0x3f8/0x660 [f2fs]
> >>> f2fs_write_single_data_page+0x5bb/0x7a0 [f2fs]
> >>> f2fs_write_cache_pages+0x3da/0xbe0 [f2fs]
> >>> ...
> >>> It is possible that other threads have added this fio to io->bio
> >>> and submitted the io->bio before entering f2fs_submit_page_write().
> >>> At this point io->bio =3D NULL.
> >>> If is_end_zone_blkaddr(sbi, fio->new_blkaddr) of this fio is true,
> >>> then an NULL pointer dereference error occurs at bio_get(io->bio).
> >>> The original code for determining zone end was after "out:",
> >>> which would have missed some fio who is zone end. I've moved
> >>>   this code before "skip:" to make sure it's done for each fio.
> >>>
> >>> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> >>> ---
> >>>   fs/f2fs/data.c | 8 ++++----
> >>>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>> index dce8defdf4c7..4f445906db8b 100644
> >>> --- a/fs/f2fs/data.c
> >>> +++ b/fs/f2fs/data.c
> >>> @@ -1080,10 +1080,6 @@ void f2fs_submit_page_write(struct f2fs_io_inf=
o *fio)
> >>>          io->last_block_in_bio =3D fio->new_blkaddr;
> >>>
> >>>          trace_f2fs_submit_page_write(fio->page, fio);
> >>> -skip:
> >>> -       if (fio->in_list)
> >>> -               goto next;
> >>> -out:
> >>>   #ifdef CONFIG_BLK_DEV_ZONED
> >>>          if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
> >>>                          is_end_zone_blkaddr(sbi, fio->new_blkaddr)) =
{
> >>> @@ -1096,6 +1092,10 @@ void f2fs_submit_page_write(struct f2fs_io_inf=
o *fio)
> >>>                  __submit_merged_bio(io);
> >>>          }
> >>>   #endif
> >>> +skip:
> >>> +       if (fio->in_list)
> >>> +               goto next;
> >>> +out:
> >>
> >> How about moving only the "out" label instead of the whole block from
> >> "skip" to "out"?
> >>
> >>>          if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
> >>>                                  !f2fs_is_checkpoint_ready(sbi))
> >>>                  __submit_merged_bio(io);
> >>> --
> >>> 2.34.1
> >>>
> >>>
> >>>
> >>> _______________________________________________
> >>> Linux-f2fs-devel mailing list
> >>> Linux-f2fs-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

