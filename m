Return-Path: <linux-kernel+bounces-137515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DFD89E332
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E10E1F232AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8E15746F;
	Tue,  9 Apr 2024 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04nXNOxE"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C91386C0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690547; cv=none; b=nLXiyBJQdV3o/OaOxExrQG6NCnPlOfz0ewLpdqm3x0+Zl10U/GQ8amRQP+TL3IrmGllcpVZDuIOH+HpcKOyHF4Lu+uKkQFGjFOUtTqOqYr71jWIu1lQpfxFA7rke7sEWu3LR1IQXsK5m/ObkF2EkoJ+Stvdmvj3g4CvnFa/cihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690547; c=relaxed/simple;
	bh=mgXxAGNeB9LYq0VkWdZHBGaheebBxETxANMV0aQv8tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7f4O42nCIC7ANFLiJSeXO9RXUx8dmmDDwjiM+KonUB2ohT9Ze5T1Ah+BJc6mXoTXJiGxm5y5cFO4mZNNyYDCBF8RsQMb2xkA5pvqKZS/K/FhfRSlWQIouorape3dOkUWcgyxjQXJ4rt1X3knWQthu2nBQXBIGxj7R+UGQcTqKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=04nXNOxE; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4daa1be011dso1749576e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712690545; x=1713295345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6tJNUDO0MMVmBUJFDnCuInyM8ZpQ/ZJFxGiIT+wCvI=;
        b=04nXNOxEJvyZTnLhCRA4MALE0qbltEwvWhqFaYBgwmAswYLzXbZ7pL2icHiotql6gb
         DMOCjp6HDu+r3VzfzCXV+Gyg9aXyiCy5vLKlArthj+45nV8qn0Wvj5AD7KtkDW9c+0y+
         vnrJy/NoZex7sGoUtMW6SpzbNzs1+cGFOcQhNbPTVvSq0CTli56vt0gjxvo+pXhIkrFL
         gkiFJnR73uxApydKII+MsMYs+U0vWaTUavifKpTjAykUIzNKMS0WKtz7MdYky1gfXPVX
         L//joQ0zlQ+k0aBX4qKrIfkM4RhPoHTH86SBmStFzSyJ51nFO0t25fb4EFLwScjg4pa3
         3GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712690545; x=1713295345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6tJNUDO0MMVmBUJFDnCuInyM8ZpQ/ZJFxGiIT+wCvI=;
        b=saqhciplXWcot40io2Dy928mJRH+RJahf96aCqWneh2usS6OBSbgVjvoIFlPKQugTq
         vkMqdPFwQuBbxi2Cm6LAqdBcuN1RPJBCzKSf72Nd20acrZNXp6Hns09xsxKv0svyj73x
         M80RC4Cu3S3akBtJn6pJXIkT30wQgjcoWP/7ZXUbxCPHVNqUoataYT+2GBr8tmy14weE
         HnqHJbqXI4Mcr5mtT4vRe91SbV5clSjGtZa3sYaLKLyrJTrUWHqrhoRnJHkSzVrKwGsA
         cAnJZp9XwZy0qG74Xdb0TzarmUIUP9iql3PBKAUlA4cdK7L/L7yPkCSqirzGc+1fM44j
         pwAg==
X-Forwarded-Encrypted: i=1; AJvYcCVNVfHBkmzHkFSiT0usgRLlV71qaq6exa1EmZcmNA23XA1sHz9MQzt33sv4o5zN8onY0hmSuKCGSytpE9x4AVtIWVl9zOEEHle65OMZ
X-Gm-Message-State: AOJu0Ywe9HTqldZIPuq2+3bVODq2yXzoLO50iYCDG3QySm3II5yBQrDK
	PjX0uuXZy0fjkyBYxZO0/71RB/N2JjgoJ+3O2hnPLxof+2sNWSmbXSI1mrhnVGnayx0ec+lrKkH
	ozRDMtQBMdJJgQx1H3jgh7Z5QIgQZ4d+FJk9i
X-Google-Smtp-Source: AGHT+IHhUi0f43o+Q+3qmToYt7MPaLonCa6pX4N3CXqzbxJpERA5UXtUqR140PmlhoPPAn5mE1gamjGCQVAv158d7Oc=
X-Received: by 2002:a05:6122:1685:b0:4da:aff6:5eee with SMTP id
 5-20020a056122168500b004daaff65eeemr715039vkl.15.1712690544607; Tue, 09 Apr
 2024 12:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd455761-3dbf-4f44-a0e3-dff664284fcc@molgen.mpg.de>
 <CANpmjNMAfLDZtHaZBZk_tZ-oM5FgYTSOgfbJLTFN7JE-mq0u_A@mail.gmail.com>
 <05ba71e6-6b4e-4496-9183-c75bfc8b64cd@molgen.mpg.de> <782006d6-c3f1-4f61-aa40-e9b3903bdbf4@molgen.mpg.de>
In-Reply-To: <782006d6-c3f1-4f61-aa40-e9b3903bdbf4@molgen.mpg.de>
From: Marco Elver <elver@google.com>
Date: Tue, 9 Apr 2024 21:21:46 +0200
Message-ID: <CANpmjNOsZydmYVU-waN1BdA=2RH0fhjmZcjnaf4JiObA++1p2w@mail.gmail.com>
Subject: Re: BUG: unable to handle page fault for address: 0000000000030368
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: kasan-dev@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Mar 2024 at 17:17, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Marco, dear Linux folks,
>
>
> Am 26.03.24 um 13:44 schrieb Paul Menzel:
> > [Cc: +X86 maintainers]
>
> > Thank you for your quick reply. (Note, that your mailer wrapped the
> > pasted lines.)
> >
> > Am 26.03.24 um 11:07 schrieb Marco Elver:
> >> On Tue, 26 Mar 2024 at 10:23, Paul Menzel wrote:
> >
> >>> Trying KCSAN the first time =E2=80=93 configuration attached =E2=80=
=93, it fails to boot
> >>> on the Dell XPS 13 9360 and QEMU q35. I couldn=E2=80=99t get logs on =
the Dell
> >>> XPS 13 9360, so here are the QEMU ones:
> >>
> >> If there's a bad access somewhere which is instrumented by KCSAN, it
> >> will unfortunately still crash inside KCSAN.
> >>
> >> What happens if you compile with CONFIG_KCSAN_EARLY_ENABLE=3Dn? It
> >> disables KCSAN (but otherwise the kernel image is the same) and
> >> requires turning it on manually with "echo on >
> >> /sys/kernel/debug/kcsan" after boot.
> >>
> >> If it still crashes, then there's definitely a bug elsewhere. If it
> >> doesn't crash, and only crashes with KCSAN enabled, my guess is that
> >> KCSAN's delays of individual threads are perturbing execution to
> >> trigger previously undetected bugs.
> >
> > Such a Linux kernel booted with a warning on the Dell XPS 13 9360 (but
> > booted with *no* warning on QEMU q35) [1], but enabling KCSAN on the
> > laptop hangs the laptop right away. I couldn=E2=80=99t get any logs of =
the laptop.
>
> In the QEMU q35 virtual machine `echo on | sudo tee
> /sys/kernel/debug/kcsan` also locks up the system. Please find the logs
> attached.
>
>      [   78.241245] BUG: unable to handle page fault for address:
> 0000000000019a18
>      [   78.242815] #PF: supervisor read access in kernel mode
>      [   78.244001] #PF: error_code(0x0000) - not-present page
>      [   78.245186] PGD 0 P4D 0
>      [   78.245828] Oops: 0000 [#1] PREEMPT SMP NOPTI
>      [   78.246878] CPU: 4 PID: 783 Comm: sudo Not tainted 6.9.0-rc1+ #83
>      [   78.248289] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
>      [   78.250763] RIP: 0010:kcsan_setup_watchpoint+0x2b3/0x400
>      [   78.252108] Code: ea 00 f0 48 ff 05 25 b4 8f 02 eb e0 65 48 8b
> 05 7b 53 23 4f 48 8d 98 c0 02 03 00 e9 9f fd ff ff 48 83 fd 08 0f 85 fd
> 00 00 00 <4d> 8b 04 24 e9 bf fe ff ff 49 85 d1 75 54 ba 01 00 00 00 4a 84
>      [   78.256284] RSP: 0018:ffffbae1c0f5bc48 EFLAGS: 00010046
>      [   78.257548] RAX: 0000000000000000 RBX: ffff9b95c4ba93b0 RCX:
> 0000000000000019
>      [   78.259158] RDX: 0000000000000001 RSI: ffffffffb0f82d36 RDI:
> 0000000000000000
>      [   78.260781] RBP: 0000000000000008 R08: 00000000aaaaaaab R09:
> 0000000000000000
>      [   78.262417] R10: 0000000000000086 R11: 0010000000019a18 R12:
> 0000000000019a18
>      [   78.264040] R13: 000000000000001a R14: 0000000000000000 R15:
> 0000000000000000
>      [   78.265658] FS:  00007f65e3a91f00(0000)
> GS:ffff9b9d1f000000(0000) knlGS:0000000000000000
>      [   78.267480] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      [   78.268804] CR2: 0000000000019a18 CR3: 0000000102e26000 CR4:
> 00000000003506f0
>      [   78.270424] Call Trace:
>      [   78.271036]  <TASK>
>      [   78.271572]  ? __die+0x23/0x70
>      [   78.272344]  ? page_fault_oops+0x173/0x4f0
>      [   78.273400]  ? exc_page_fault+0x81/0x190
>      [   78.274373]  ? asm_exc_page_fault+0x26/0x30
>      [   78.275395]  ? refill_obj_stock+0x36/0x2e0
>      [   78.276410]  ? kcsan_setup_watchpoint+0x2b3/0x400
>      [   78.277556]  refill_obj_stock+0x36/0x2e0
>      [   78.278540]  obj_cgroup_uncharge+0x13/0x20
>      [   78.279596]  __memcg_slab_free_hook+0xac/0x140
>      [   78.280661]  ? free_pipe_info+0x135/0x150
>      [   78.281631]  kfree+0x2de/0x310
>      [   78.282419]  free_pipe_info+0x135/0x150
>      [   78.283395]  pipe_release+0x188/0x1a0
>      [   78.284303]  __fput+0x127/0x4e0
>      [   78.285114]  __fput_sync+0x35/0x40
>      [   78.285958]  __x64_sys_close+0x54/0xa0
>      [   78.286914]  do_syscall_64+0x88/0x1a0
>      [   78.287810]  ? fpregs_assert_state_consistent+0x7e/0x90
>      [   78.289185]  ? srso_return_thunk+0x5/0x5f
>      [   78.290203]  ? arch_exit_to_user_mode_prepare.isra.0+0x69/0xa0
>      [   78.291568]  ? srso_return_thunk+0x5/0x5f
>      [   78.292518]  ? syscall_exit_to_user_mode+0x40/0xe0
>      [   78.293651]  ? srso_return_thunk+0x5/0x5f
>      [   78.294606]  ? do_syscall_64+0x94/0x1a0
>      [   78.295516]  ? arch_exit_to_user_mode_prepare.isra.0+0x69/0xa0
>      [   78.296876]  ? srso_return_thunk+0x5/0x5f
>
> Can you reproduce this?

This seems to be a compiler issue with a new feature introduced in
6.9-rc1, and it's fixed in 6.9-rc2. It was fixed by: b6540de9b5c8
x86/percpu: Disable named address spaces for KCSAN

