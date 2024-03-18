Return-Path: <linux-kernel+bounces-106490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ABD87EF60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DCE1C22335
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BFB5644D;
	Mon, 18 Mar 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2DF19Ko"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5930556441
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784823; cv=none; b=Y5ZluXoKrwcHEo6NCzbCU0N4rb/YikFnIES0qjdYlXyaJOabAjHRKk4oM1pEZqASpvEyjIuXtEwEQqYUEkv012xCnn6MdiDZuRYhbYRUeFLHUL0fk2WfRjh2jxrsMI+4LuoHk6JZrPrqU5fhuQd0jiwmQ8qO+l6VtuMTRriiigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784823; c=relaxed/simple;
	bh=eNaWzHwNj3QZt2dWYrjaUfb/9+YCw0Oyy4J3VsiMlhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjHOJqRd3BepFi9Dzv00FcWSNVGsywJOLkHWUn1sWNNZlZtPocpVhHYfiL+kuDfOeDvHp47sNrg04040w5k2Ay8B9dFOOe5hslSX76iDXcDN5l/n+vHcmt4p686FhAebQn2911/i66Trae/Qk3cSxSZDHeHDd7tRnrUVYWgaueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2DF19Ko; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d44fb48077so578262e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710784821; x=1711389621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDpZJpAnayVu37/DhZQcXIKE2Hk/ZuslD6AOd+9Bwus=;
        b=g2DF19KoVbFvX9dTA898KKOCqX2OrwE0oyoC9Xtmn/gkqLyDcbC+eT8r/T2wZ4n5c0
         hEQWpSwwn9mimIUaqaoSNbOGwzZldDd+MXqvw6Bf1iO2WUW9PACVVqF/7RbhyY52/9T0
         2yEChZe783CXCI6Q/Scwi7zceU/qeqx4wsiXWkjdCLchgaf1NW4MENksiep0jAVysaqt
         nq5AuW57lCHHMFM5tb2m/2xqrAJQziAfs9i59jwBlXrCOmzlbHPT839Znl+8FG1eCpxC
         KL466LDkwtHQ0dR+/Lcp7CgLfJmfZwpIxjsGLcgUEjWt2VjfVVTEydNbmT3VyUd3Xy6P
         /1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710784821; x=1711389621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDpZJpAnayVu37/DhZQcXIKE2Hk/ZuslD6AOd+9Bwus=;
        b=dvEb/RKXpd/V1JgDZiwZmqvzj3VISdZVFz231m0g1QYaLTE1fiS+sDEpsbTgzVIViX
         xcDjgC5HT40Z9AUJGMpYZWKbmS5tdn/uwqx+pWoSrIL4yMXcONLwXwI6yIfw1SfYMAeV
         b/Veh7CpuPkdZMuiSyeLrN4DkmWvQbwENuAWPppIQ2I/79KVM8V/96g1jMUwr+bddnIQ
         5pBGWAINKYk3LkCtHtUDl27S6ItFL/oOazgLgLfnQKlmmlhWCEPU2RMUHHVv4NGLfz1Z
         ikdIJFcV2X8fZoiqcxUqxnJzj2/LXGu+bsycLCdrnQdWawySp2UENldSCWCw1XuFx1AM
         nA5g==
X-Forwarded-Encrypted: i=1; AJvYcCXBs8R8oZanQqgeaxFtSarToRHp692wpH2E1g0ja4tCfE8naJBj3VUVTjOPH3nVj2RU/27VQekvoXEXqhcv2YyL967/RnO3BNRrWXFQ
X-Gm-Message-State: AOJu0Yyk4DghEuwaRqaE6nRfSFYe2R2S+UiXDJs+RY1PXNibItP7xNXp
	njDS1S2aChGErQ/SEGnXsYMXfd2Nyht+PxUILur59MzGr5NOjU7VypCYf08VbxOgHsWeqqzgzLs
	IOFEyX9vSbV4ZWsPIjByZTS8xWKA=
X-Google-Smtp-Source: AGHT+IEr3h6RcgR2VPFctn3htgX7ul9X56SnWgtH8XpIwxTL2QN0E1UPZkkQvfhoH5mn1/xHBcnX8pfMY4vKRjn3zH8=
X-Received: by 2002:a05:6122:4493:b0:4d4:20cb:8c0 with SMTP id
 cz19-20020a056122449300b004d420cb08c0mr10803190vkb.8.1710784821081; Mon, 18
 Mar 2024 11:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bbb3d80613f243a6@google.com>
In-Reply-To: <000000000000bbb3d80613f243a6@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 18 Mar 2024 11:00:10 -0700
Message-ID: <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 9:58=E2=80=AFAM syzbot
<syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36'=
 ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13043abe18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D19bb57c23dffc=
38e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadbc983a1588b78=
05de3
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (=
GNU Binutils for Debian) 2.40
> userspace arch: arm
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1706d231180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13ba795918000=
0
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8=
ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff2/vmlinu=
x-e5eb28f6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7539441b4add/z=
Image-e5eb28f6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> kernel BUG at include/linux/scatterlist.h:187!

Looks like the provided buffer is invalid:

#ifdef CONFIG_DEBUG_SG
BUG_ON(!virt_addr_valid(buf));
#endif

which is "src" from:

sg_init_one(&input, src, entry->length);

Looking at the surrounding code and recent history, there's this
commit that stands out:

mm/zswap: remove the memcpy if acomp is not sleepable
(sha: 270700dd06ca41a4779c19eb46608f076bb7d40e)

which has the effect of, IIUC, using the zpool mapped memory directly
as src, instead of acomp_ctx->buffer (which was previously the case,
as zsmalloc was not sleepable).

This might not necessarily be a bug with that commit itself, but might
have revealed another bug elsewhere.

Anyway, cc-ing the author, Barry Song, to fact check me :) Will take a
closer look later.

