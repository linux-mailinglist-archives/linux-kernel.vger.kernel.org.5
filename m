Return-Path: <linux-kernel+bounces-147735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A738A785A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6ABA1C20E50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888C13A885;
	Tue, 16 Apr 2024 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMK+GTlm"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0F13A869
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308902; cv=none; b=Bq9++429g9AQXTFqQ+KwRQbkfPG4Ao7fnWsAonnTO6JiTF/PIRRsrz1up75WWHaAoTLnb42PMnNNo8FBR2w100R8gT9ePrgu2rCFk6iQDrNo+re/vobrNxemyprNTTPzelEspVcKcB9PhtvHB18dzMDTBMxpIjBI7uKpamydGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308902; c=relaxed/simple;
	bh=/vIsnAKq8bf1u4kLAh1Kfg/s9oWW3TeQ5VA71aykdbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1UmeCCStxlRbwbSlP9kY1MI+z+aaSI7l+fpZPxnlFyJX3zLo4X9qkAK3F59Z9iykl1dKh0ocpYwVN2/6IF36uHaeh2WTIWUWT12Bc9PYKgT28lbOVD/1BYHV+0WdUwdZz4vN/g2Hq81V33Lr3v4p6a6to+mJ8c6rZxktkPuriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMK+GTlm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so2988a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713308899; x=1713913699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOdiC0tL+G3FANw6Y9F4LL53FfietZiL2c5R415IOXg=;
        b=bMK+GTlmy09ymhQacmF7/ZuUXTDpnvA5O5aDFgvgg33N+gBii5eNEAlzZK/cC3hfML
         DrB70z8Ut5QHIADD8OmvaOSKJoB1O5YOkxJm8wIKxd4MQhjlW4se6vjDR1d4YrsEdGH+
         2s+0ClnWJVTqGJfut6FJd8lms3FcBFOiTMJKRyvnqXb/6IG15hw/CR9za0OiUiuIXnDB
         ftDKsfxcV/1LDX6rD72XMI294fM0fnR9W8NaHVCbhSiywtHAh087BRTauI6iiLGKNO6H
         nfqyzCna08aRGvAFq4OqvUutArG3u7bwrQm+ihR68P9afD2B3Kvl0dMUyGCOnl0N0adz
         PFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308899; x=1713913699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOdiC0tL+G3FANw6Y9F4LL53FfietZiL2c5R415IOXg=;
        b=vfgEKxm1PU2xJWNtElvZowGaJ4LtQnm5ioFium8SVuoVkt7Bm1NX6lHtzLKroKMQzB
         QLhn8NWMT5U4qNqTjq1D5weiYf434mg6TdblyiFQsvitBhVgUIycvkY/cAwtNteQeRir
         bh303f+cvj7nPYHtbK6zCVqezpSQD96N1PiQx2CSFFeyFPCwupGr/c4zD9gR0ToLOSC0
         J0/IBypV8JJwkHb9oS+SamEUdPHgLjGv0VDT/SliUKvTgRxMPVXuHXRC1RrQhTOS7Tme
         YdzWlaTH7YWAVx7U0kZmEs37P+HaiXSVewziZpvpwUTriCe7jCtHw4HxeJ067tUJfXrn
         a4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnVLSO9CJnvzB4S7QBBF53nwv4W761PNCBBhMlFcW+Wy3Pttcx5CODf8zM2t4FIl32WaHwBQYJmHf13UCV+N11mfGZWxlrmgGsIyRU
X-Gm-Message-State: AOJu0YzTvl3LNc4g6n34WFSVlg5ecpkpwJBENLDI3M2Is2qb4faDtB5Y
	98aHzWeADy1i46tNuDpKAp74IHLZ1NJCrVKMz4hbHlsNJnIIbYJD+UbZC3lBrmdM5qdVnfq5nUB
	ILMGz6OXiKOgy24Dr1nwUVZSLlp9YAtgZdAZU
X-Google-Smtp-Source: AGHT+IGkH8dcsSd2mHEmIvZNmPTDJjKG22oRPWWX1ECCNsJoXjeJV4w8yQaudJm2VHLYAmkWNYyZwliEX9Gq/R0Jt28=
X-Received: by 2002:a50:9f2c:0:b0:570:5d40:5e3b with SMTP id
 b41-20020a509f2c000000b005705d405e3bmr10618edf.6.1713308898764; Tue, 16 Apr
 2024 16:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009db84e0615a73698@google.com> <20240409164627.b4803e09c81c01ccb6f55601@linux-foundation.org>
 <CAAa6QmQ-fSNHu0VWQod+Cz89zOtQ9Ayet_2OEQsrp2zeCfos3A@mail.gmail.com>
In-Reply-To: <CAAa6QmQ-fSNHu0VWQod+Cz89zOtQ9Ayet_2OEQsrp2zeCfos3A@mail.gmail.com>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Tue, 16 Apr 2024 16:07:41 -0700
Message-ID: <CAAa6QmS6Kw_E5wfabE1Sg8WHUXYYWsUo9e2KQNo-OiQVRDk-Ag@mail.gmail.com>
Subject: Re: [syzbot] [mm?] general protection fault in hpage_collapse_scan_file
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+57adb2a4b9d206521bc2@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 5:32=E2=80=AFPM Zach O'Keefe <zokeefe@google.com> wr=
ote:
>
> On Tue, Apr 9, 2024 at 4:46=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Tue, 09 Apr 2024 03:16:20 -0700 syzbot <syzbot+57adb2a4b9d206521bc2@=
syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    8568bb2ccc27 Add linux-next specific files for 202404=
05
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D152f48051=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D48ca5acf8=
d2eb3bc
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D57adb2a4b9d=
206521bc2
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1268258=
d180000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1256598d1=
80000
> >
> > Help.  From a quick look this seems to be claiming that collapse_file()
> > got to
> >
> >         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> >
> > with folio=3D=3DNULL, but the code look solid regarding this.
> >
> > Given that we have a reproducer, can we expect the bot to perform a
> > bisection for us?
> >
>
> I often don't see a successful automatic bisect, even with
> reproducers. Hit or miss. I will take a closer look tomorrow -- the
> reproducer doesn't look to be doing anything crazy.

I've only been able to reproduce this using the disk image provided by syzb=
ot.

What is happening is we are calling MADV_COLLAPSE on an empty mapping
-- which actually reaches collapse_file() -> filemap_lock_folio()
after page_cache_sync_readahead() attempt. This of course fails
correctly, and I can see right before GPF that the returned pointer is
0xfffffffffffffffe, which is correctly ERR_PTR(-ENOENT). This should
be causing us to take the if (IS_ERR(folio)) {..} path .. but we
don't, and I don't know why. I haven't yet attempted to repro this
against other images. Will continue looking, but wanted to provide
some type of update -- even if it is a disappointing one -- so as to
not appear like I've disappeared.

Thanks,
Zach

> Thanks,
> Zach

