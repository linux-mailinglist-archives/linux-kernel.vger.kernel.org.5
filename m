Return-Path: <linux-kernel+bounces-52018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAFD8492DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6462818B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D769470;
	Mon,  5 Feb 2024 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSJVWnY9"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124798C09
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 03:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707104932; cv=none; b=Y+KhVGnTrdCab+/pNN6K+ZLGgQl6psfYb7Gt+ot7R8K/x10G3z6YXwPD1yZdrjKm9VQ21RTFOjBsd1HQ8XKpoR4u8woADbid8DKjsXy3RunUl2HuPJNEWAuJLWAUZ7el8cOCirgOutpsqUBIFVmEsMRE8nv6vQvoPHOcVd0VvxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707104932; c=relaxed/simple;
	bh=PDbAVi/fO7duuFQBHIBRw4Flpb5T6TniBdbCLEpzRl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZWLtKQHoCMBSz4QFWBNBmHLBwNLOQea++KpSYbqexyVl4Neg3+vKPq7zAH+lgQ8v+2RqPQsIavM8loZWjdKuThe2pCB1p2ugEdSbzFmjDawM1iA2iLDj8iqF1zXbSJqji3isOowU6BINhXQD3Se8bi+U+eeDGVwfvfA78QYWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSJVWnY9; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ba9f1cfe94so153067839f.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 19:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707104930; x=1707709730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gj4GfNndW5LkU+ifPKRGdE3GovZ7M7Z/ViVrpmdWeQ=;
        b=fSJVWnY9v9wcvETFiERLreiWt0zkwJclCe1ui8VPXYyqsTWmCqBFl1KpRFmV77n31T
         atlj9Z/v79WXucwJhpa/dN7MwoIsitaiqCIXPVxgmCMxv+sf+dDU+r9VqcC6KYSXZB2u
         jJ3i5Bv/s2Tu1uBRLn88dEAC9klEM2oyDZMJlrIJpMGBz4UIBJRJRtuVIu1yGAAXRcsW
         K3cKpHEx1eF62F+jnnXlur7iwhURPhOs0AmvwyJ43FBGsQ6U2OLlPv7xwmDJ4jCePgPh
         FnU1ly149EH7Ausk6RZsqdAGa1qhODHe9x6VebnvEY/nhLIxuFgSB6BF1njkqhDO67xA
         OVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707104930; x=1707709730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gj4GfNndW5LkU+ifPKRGdE3GovZ7M7Z/ViVrpmdWeQ=;
        b=sNc0wZgiUUcfucDz2xNX/pK4k3eiaW8zYnyl3bFlLxUms5DR3cKnQH2zcm4x+B43VM
         oxsGDruHbmB3EGFCZSKwle5Yu7Nq/Sx33K9ldNeDt+HDFq3Bun2qpYALjVemH9wctyGh
         ci4doLEScfON/KDmeQAMDfdd/ebXNewHBFz+h1dQSOUpXACE0Zszakg6YI7Jb/suoBF5
         aCKTvKYxmue4PpM2fHoEKxKsfh5t0tFHrZVA91dEKLjN86Wmkk5k9DKX4xQniP3y1KiW
         7yayR8flMMOfjCYx35kzD7kdW0qQJZzR44a+kpvI2oyKfbXXOxE6fjAjG9J2cvXeAJ18
         DIjg==
X-Gm-Message-State: AOJu0Yyx/OaJ/nhh6zK3iQAvhjVU+LwgMCYBhDonaP03fIU0byPJ7J/x
	Of4LAg8G/f7McKLtkyt3PrxorkTlQkD5BZ4eGeQX9NHULlCifcWoh1HE8XhhLHtSbjTusPYYhaN
	2FgyJr2rYVA+w9qZc02+LxTcbHzE=
X-Google-Smtp-Source: AGHT+IFRMLjtsdDgwlkMvwDBJc/wBTdkYch7X/QKUIlAyWYwSYbhXAi7m2/CpKXl6EQiqGtWvzEyEV4s43veWs+Gd3Q=
X-Received: by 2002:a05:6e02:2191:b0:363:a442:3723 with SMTP id
 j17-20020a056e02219100b00363a4423723mr3694023ila.3.1707104930090; Sun, 04 Feb
 2024 19:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ae47f90610803260@google.com> <CAKEwX=O1xg=BuLMbmv=n3L_mNRwhrumZ-ig4Y5N4JJ4Mu=d4Hg@mail.gmail.com>
 <5ea0950d-1b2e-47ae-b8a0-8bc0e99479f1@linux.dev>
In-Reply-To: <5ea0950d-1b2e-47ae-b8a0-8bc0e99479f1@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 4 Feb 2024 19:48:38 -0800
Message-ID: <CAKEwX=Nzipr_nWTVPsUC_JKzoKu=6CX7rMSRv+T1YoQ8WheuWw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_folio_swapin
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: syzbot <syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 6:59=E2=80=AFPM Chengming Zhou <chengming.zhou@linux=
dev> wrote:
>
> On 2024/2/4 09:28, Nhat Pham wrote:
> > On Sat, Feb 3, 2024 at 12:37=E2=80=AFPM syzbot
> > <syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    861c0981648f Merge tag 'jfs-6.8-rc3' of github.com:kle=
ikam..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D174537bbe8=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db168fa511d=
b3ca08
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D17a611d10af7=
d18a7092
> >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils fo=
r Debian) 2.40
> >> userspace arch: i386
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> Downloadable assets:
> >> disk image (non-bootable): https://storage.googleapis.com/syzbot-asset=
s/7bc7510fe41f/non_bootable_disk-861c0981.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/b2b204c7b4a0/vml=
inux-861c0981.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/170ec316e55=
7/bzImage-861c0981.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
> >>
> >>  kcov_ioctl+0x4f/0x720 kernel/kcov.c:704
> >>  __do_compat_sys_ioctl+0x2bf/0x330 fs/ioctl.c:971
> >>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
> >>  __do_fast_syscall_32+0x79/0x110 arch/x86/entry/common.c:321
> >> page has been migrated, last migrate reason: compaction
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 2 PID: 5104 at include/linux/memcontrol.h:775 folio_lruv=
ec include/linux/memcontrol.h:775 [inline]
> >> WARNING: CPU: 2 PID: 5104 at include/linux/memcontrol.h:775 zswap_foli=
o_swapin+0x47d/0x5a0 mm/zswap.c:381
> >> Modules linked in:
> >> CPU: 2 PID: 5104 Comm: syz-fuzzer Not tainted 6.8.0-rc2-syzkaller-0003=
1-g861c0981648f #0
> >> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian=
-1.16.2-1 04/01/2014
> >> RIP: 0010:folio_lruvec include/linux/memcontrol.h:775 [inline]
> >
> > Hmm looks like it's this line:
> > VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled(), folio);
> >
> > Looks like memcg was cleared from the folio. Haven't looked too
> > closely yet, but this (and the "page has been migrated" line above)
> > suggests maybe there is some migration business going on -
> > mem_cgroup_migrate() clears the old folio's memcg_data (via
> > old->memcg_data =3D 0).
>
> Yeah, I think it's this case.
>
> >
> > Here's my theory (which could be wrong - someone please fact-check
> > me): swap_read_folio(), which precedes zswap_folio_swapin(), unlocks
>
> And another case is !page_allocated, the returned folio is unlocked, righ=
t?

I think you're correct. That said, it's probably fine to keep the
protection size if we find the folio in the swapcache anyway - IIUC,
we are not performing a swapin in that case (since !page_allocated
means no swap_read_folio() called), which is the scenario that the
heuristics cares about :)

IOW, something like this:

if (unlikely(page_allocated)) {
    zswap_folio_swapin(folio);
    swap_read_folio(folio, false, NULL);
}

make sense to me, both from the correctness POV, and the heuristics POV.


>
> > the folio. Could this be sufficient to allow for migration? If this is
>
> IMHO, folio locked is sufficient to avoid concurrent memcg migration.
>
> > the case, all we need to do is move this to above swap_read_folio(),
> > while the folio is still locked. __read_swap_cache_async() already
> > charges the folio to an memcg, so no need to wait till after
> > swap_read_page() anyway.
>
> Should we call zswap_folio_swapin() in the !page_allocated case?
>
> Thanks.

