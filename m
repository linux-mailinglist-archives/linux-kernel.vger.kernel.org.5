Return-Path: <linux-kernel+bounces-148727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238988A86AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5566E1C20FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E55142911;
	Wed, 17 Apr 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6oY5ILm"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84303E493
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365445; cv=none; b=ZWD472w2OT1BhiLw7co7TIcrkh8LSgNNZizZ6jAmzQt63pn3FOaSttHFV02lovBmayacsF1JXD2YOT7bW7xljCZzrfdQFxYe1vaegZ59rDHul8wToAgBtAXRyr0RulfLt2XAVxOtZ0UICHYiqU3ku2nOSn7xlH7zWH4DweDqyDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365445; c=relaxed/simple;
	bh=3xQjIKuzza23PA8iMmF/ZaihPTYzQa4id/sKfn3o+Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkNpvOu7rVWdGYPEYKCOYKhgIMAeMWZ0EkdMCM+zWgfBNDRs62B1RrC/e3VNh2PnjZWCkXYX/o70OpS+zUXnW+Ty6vM8gYfW6G7XjzAuV1P3TAMyYKSgAGZvcsJVMKkCKuNA+th1/iiO2G0ocuMaRXOv3glYrvA4HcfAagikYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O6oY5ILm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3c89f3d32so221185ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713365443; x=1713970243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxj80oam7Il+91X8ofj6LPJmgE1D5E+WVqYl1M/aFRo=;
        b=O6oY5ILmgiqKuEE6iElybv2Ub9WHKOEhLmXEmwUOaX5zfBnjiDrRYHLiAKDNMoz6co
         e25zKESy77M6a/uxtxaBGAyTnJ7suprR/puZL3FScnbwnYebEnh9zH7OmK5Mp3P/zf48
         3X2U/LxOdgyacu26zOqARLxhWZQBVShE5i1omT/noNt2EHV0ufnLw3Td6NLy1zsDejPz
         HT23jtuo63UUulEqbt2Ab6qeXeMWbcXhh+fl2X2iWFWZfvpQGSVgIG6gg3LdLG5zaPQR
         4QzDTWWRhe/rh9xFGQyV2f9onxwO7TL2ucjco4R/fUOl+56FyC7mvxupB4o1WARt43z9
         CRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365443; x=1713970243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxj80oam7Il+91X8ofj6LPJmgE1D5E+WVqYl1M/aFRo=;
        b=Sqva5ePrynySu8OfgP5f8Ofag3A3PzUERCfCVxscoQkrtzO9t6bCkEOatNhIlROeQZ
         6hYxjj3DbF4K9zBQlENMb4hfoVIuzZ+dKvQhx9sB3Zvcnz+o5ewzeGFWElNqBk5RnuIU
         h4gXOEozXWD2p854oga/6NOP7Om3G67gcpkxHnwHsri7fscWqJWS/kBwBqSXZ5yjR/3/
         eC8ipf7uQFQP+wFEB14xqz6BdENhN7ugbPCacPHvbio7FgiR1zq93irX++cNRdOB1yWF
         9XmsSD9L8uiAKX43sBiZbLR41YHJKdljE14glW9tu77P7k5rqgiasATkfM8yz4udiIFK
         WoBQ==
X-Gm-Message-State: AOJu0YxwN8kBKU5pkpt+KngBC6AbkMaAkRy8kl29MNl4X8EpYBzp9dge
	8wW0uVGYLsEJs6KZFj3zUly5ogMq0t9hrXcd03crN69Lz3fxBwm6TSQpZF0cJes9S5etlwCTEQn
	9ibZyPxaE8/m0amTEIKGCamOMQjJDwMizzuQzIA7xx2GfvyNoW+89aCw=
X-Google-Smtp-Source: AGHT+IGHxKwu98YvospB91+YQLFfAJMnppT/6GTQ5TqAb0PWkruGOWlmlwOEwP83YxDHUDlUQUZTDwY8gkvcPDj3jKI=
X-Received: by 2002:a17:903:42c6:b0:1e3:d23a:2d5e with SMTP id
 jy6-20020a17090342c600b001e3d23a2d5emr196816plb.21.1713365442847; Wed, 17 Apr
 2024 07:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYO9Heg9s5b=v23fb12S3LH=3oyUDLFWhba4nYTXL98CQg@mail.gmail.com>
In-Reply-To: <CAEkJfYO9Heg9s5b=v23fb12S3LH=3oyUDLFWhba4nYTXL98CQg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Apr 2024 07:50:27 -0700
Message-ID: <CAP-5=fVKp8o8uYEydJEE++ORtiVgxHVYYrQW5aPNoX2AiHbq3Q@mail.gmail.com>
Subject: Re: [Linux kernel bug] WARNING in free_event
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	adrian.hunter@intel.com, jolsa@kernel.org, alexander.shishkin@linux.intel.com, 
	mark.rutland@arm.com, namhyung@kernel.org, acme@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com, 
	zqq0103.hey@gmail.com, Frederic Weisbecker <frederic@kernel.org>, haifeng.xu@shopee.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 6:38=E2=80=AFAM Sam Sun <samsun1006219@gmail.com> w=
rote:
>
> Dear developers and maintainers,
>
> We encountered a kernel warning in the function free_event() while
> using our modified syzkaller. It was tested on the latest upstream
> linux(6.9-rc4). C repro and kernel config are attached to this email.
> Kernel dump log is listed below.
> ```

Thank you for the report, unfortunately there have also been similar
reports and some possibly related fixes posted:
https://lore.kernel.org/linux-perf-users/CAP-5=3DfUa+-Tj2b_hxk96Qg5=3DQu7jY=
HgHREbsmBa2ZmuF-X9QaA@mail.gmail.com/
https://lore.kernel.org/lkml/20240329235812.18917-1-frederic@kernel.org/
https://lore.kernel.org/lkml/20240410035506.599192-1-haifeng.xu@shopee.com/

Thanks,
Ian

> ------------[ cut here ]------------
> unexpected event refcount: 2; ptr=3Dffff88801931e0c0
> WARNING: CPU: 0 PID: 8082 at kernel/events/core.c:5254
> free_event+0xa3/0xc0 kernel/events/core.c:5254
> Modules linked in:
> CPU: 0 PID: 8082 Comm: syz-executor381 Not tainted 6.7.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:free_event+0xa3/0xc0 kernel/events/core.c:5254
> Code: b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 25 48 8b
> b5 38 02 00 00 48 89 ea 48 c7 c7 c0 38 b7 8a e8 6e 30 9e ff 90 <0f> 0b
> 90 90 5d 41 5c 41 5d e9 bf 45 d7 ff 4c 89 ef e8 d7 e9 2b 00
> RSP: 0018:ffffc9000176f9e8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff814c00fa
> RDX: ffff888063d919c0 RSI: ffffffff814c0107 RDI: 0000000000000001
> RBP: ffff88801931e0c0 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000002
> R13: ffff88801931e2f8 R14: ffff88801931e3a0 R15: ffff88801931e0c0
> FS:  0000000000000000(0000) GS:ffff888044200000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000008 CR3: 000000000cd78000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  perf_event_release_kernel+0x5d4/0x8f0 kernel/events/core.c:5421
>  perf_release+0x37/0x50 kernel/events/core.c:5442
>  __fput+0x282/0xbb0 fs/file_table.c:394
>  task_work_run+0x168/0x260 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xaf0/0x2a40 kernel/exit.c:869
>  do_group_exit+0xd4/0x2a0 kernel/exit.c:1018
>  get_signal+0x243c/0x2630 kernel/signal.c:2904
>  arch_do_signal_or_restart+0x81/0x7d0 arch/x86/kernel/signal.c:309
>  exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
>  exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> ```
> If you have any questions, please contact us.
> Reported by: Yue Sun <samsun1006219@gmail.com>
> Reported by: xingwei lee <xrivendell7@gmail.com>
>
> Best Regards,
> Yue

