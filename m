Return-Path: <linux-kernel+bounces-149090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C968A8BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8F21F22F02
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD22232A;
	Wed, 17 Apr 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLlIW279"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279118C05
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380212; cv=none; b=thJWvbyXw49O7Qsv1MScTD2yoQ512T0qHpP94Q8ki8En0VsimXjMhmC1HNkk+qerCJBmhnLRt5Wd6Eio8YN9igbRLKzoI4Wzi9KgEnr2J5tbd1O7ZlMZi6N/lDZbFqG9vIyiVrjjfAM6kqd/iWKna1oRx4s+sWdosLRpwv7HBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380212; c=relaxed/simple;
	bh=sPqZMnA6bmhHx8Ahb4AT6tcnGf3j7aV6N9Ym3Peg6T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkKuUje32Eq+sRwQy3MeVKSaGcMCir8+aDpVKLcjzlt5JbK7vF+I5GzE1mv9RnWklLwdoDbCfWtQbeRy0BsHUNGKbf6ri+Q/AZnhbP5/Cge9Vp9h8qWDvigMycbamtpEyl87bC9Djc8OHCki3xMt0NDRgSo4jjaUr1Rucc3qYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLlIW279; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so2068a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713380208; x=1713985008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+LOjuOeZLA1cB2jFNrrZxNOPlpFBgxe5NMS3Kv4FaI=;
        b=YLlIW279M9Cn0A2+jVjktMKIpQHPVLwVdTHOM3n9vN6ewtHw46DvGecNLeXy2gEfap
         U/D2fx33jIdY07MDHzjPRIW9ZQmNkVI0dIQxNCt9rdkSkDT9vw8TzImz4HYM6NXycaYO
         I0xAJmd9kw5dX6An3p+nz46HR5Nz9Pf1L4biPBV3COvo4S0BHAEjWrNAr2lcg9Wzk2TX
         SQIn+zqGeKQoiujIX8HI5TvIGQ22NBTXLl+ZXzZ3BkWopuGD19MqscFh/GQmMOmXH7jr
         HFpCEY6mN5tJPLhls7MxHpdh4bLhWnk7LXFjDRUwN/3HU18sY8xe3jTOSe/O8kBLRbHM
         9vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713380208; x=1713985008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+LOjuOeZLA1cB2jFNrrZxNOPlpFBgxe5NMS3Kv4FaI=;
        b=kK1eCZKvSLMMoW83+S8iVOZHjaESUMEwIBwfTKZwhX+0No1HXhd0Wjfh6zmvo2shK7
         Q5jGmG/5mNELd0HVukpa16WEtGT080YMoBr/ooD+xcrgqRzlv7olAXM00pPNMBFHBnQD
         V3OfaON4sa+i/hR6R4q005q5/ri265OC6UIAGOU+P0fX7MjbO7CijPDUza59wanjkw0l
         w7gBBdoKcVvIPpwsaHMUM3MBZSMblrAboCJm/3vguVanR6CbwoOJAjLzq9l8gdOIcfRx
         XvtHRD+JxmnQva51HfcGHEITIL1mj9bQE47o6P5VeBt1fBLG29N0fh9ER+5870uDEl2E
         y0gg==
X-Forwarded-Encrypted: i=1; AJvYcCU4EMI7CretE3+D4L6jfED3KSJ8l8UZ8d2B0O86DeVHRTxCRjBVfiZKSBZEFLoQ61WLc01olwKQU8bXo4pgia3uvp9/dpKsHu6kFn/U
X-Gm-Message-State: AOJu0YzA6IqHN9uLANBpW/CSf1f3wk36TtzH3Psx7esR4LUIS/uQPpIv
	rQfuDlMkSXhPuFZ0YgBlxiQx73dVSB60OspazcxGhOPScLAr/roYoE1Amm6fUKbyuTJiFbrz12L
	zxQ+580xBIQxa1Nc5rbe8GJ0ASN1m3LLkldjo
X-Google-Smtp-Source: AGHT+IFhRlSCCBy0frP0M3uf67g0LNtigXKBw7N9Xg+JN73Z25CPFSqS1XaGM1HBjRSd9jzfZsk0UlVyGc55jTKnrZc=
X-Received: by 2002:a05:6402:893:b0:570:481a:8a20 with SMTP id
 e19-20020a056402089300b00570481a8a20mr19948edy.5.1713380208294; Wed, 17 Apr
 2024 11:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009db84e0615a73698@google.com> <20240409164627.b4803e09c81c01ccb6f55601@linux-foundation.org>
 <CAAa6QmQ-fSNHu0VWQod+Cz89zOtQ9Ayet_2OEQsrp2zeCfos3A@mail.gmail.com> <CAAa6QmS6Kw_E5wfabE1Sg8WHUXYYWsUo9e2KQNo-OiQVRDk-Ag@mail.gmail.com>
In-Reply-To: <CAAa6QmS6Kw_E5wfabE1Sg8WHUXYYWsUo9e2KQNo-OiQVRDk-Ag@mail.gmail.com>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Wed, 17 Apr 2024 11:56:09 -0700
Message-ID: <CAAa6QmSu+Z6riu=asD3L0MFXXgPm1fCUgO549CcTdQrK=xUkkg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] general protection fault in hpage_collapse_scan_file
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+57adb2a4b9d206521bc2@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:07=E2=80=AFPM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> On Tue, Apr 9, 2024 at 5:32=E2=80=AFPM Zach O'Keefe <zokeefe@google.com> =
wrote:
> >
> > On Tue, Apr 9, 2024 at 4:46=E2=80=AFPM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > >
> > > On Tue, 09 Apr 2024 03:16:20 -0700 syzbot <syzbot+57adb2a4b9d206521bc=
2@syzkaller.appspotmail.com> wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    8568bb2ccc27 Add linux-next specific files for 2024=
0405
> > > > git tree:       linux-next
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D152f480=
5180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D48ca5ac=
f8d2eb3bc
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D57adb2a4b=
9d206521bc2
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12682=
58d180000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1256598=
d180000
> > >
> > > Help.  From a quick look this seems to be claiming that collapse_file=
()
> > > got to
> > >
> > >         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> > >
> > > with folio=3D=3DNULL, but the code look solid regarding this.
> > >
> > > Given that we have a reproducer, can we expect the bot to perform a
> > > bisection for us?
> > >
> >
> > I often don't see a successful automatic bisect, even with
> > reproducers. Hit or miss. I will take a closer look tomorrow -- the
> > reproducer doesn't look to be doing anything crazy.
>
> I've only been able to reproduce this using the disk image provided by sy=
zbot.
>
> What is happening is we are calling MADV_COLLAPSE on an empty mapping
> -- which actually reaches collapse_file() -> filemap_lock_folio()
> after page_cache_sync_readahead() attempt. This of course fails
> correctly, and I can see right before GPF that the returned pointer is
> 0xfffffffffffffffe, which is correctly ERR_PTR(-ENOENT). This should
> be causing us to take the if (IS_ERR(folio)) {..} path .. but we
> don't, and I don't know why. I haven't yet attempted to repro this
> against other images. Will continue looking, but wanted to provide
> some type of update -- even if it is a disappointing one -- so as to
> not appear like I've disappeared.

Ugh. Was looking at the wrong source. Thanks hughd@ for mentioning
that IS_ERR(folio) changed recently, else I'd have spent more time on
it. Fixed by https://lore.kernel.org/all/ZhIWX8K0E2tSyMSr@casper.infradead.=
org/

> Thanks,
> Zach
>
> > Thanks,
> > Zach

