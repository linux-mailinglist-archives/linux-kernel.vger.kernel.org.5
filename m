Return-Path: <linux-kernel+bounces-34725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C70A58386C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DB71F2537D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BF75243;
	Tue, 23 Jan 2024 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mkl2eeVG"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DCF5220
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988062; cv=none; b=K/AjPE+DNeglmILOgr0m6UKKKcVJWEpELoUoHUqNPt8Sxhoz9tMQJ1ej5S1uRqLAk63CYIKhxsRQARnfGPYTaQfY7m25PMdlq/osnWiq42fhFTCzf+DBwuNn/efjfGNi6VFcaOzMTp1smtt1GJSMRY1r07HLbqzEetndsfK9h2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988062; c=relaxed/simple;
	bh=05iOvp2t2GTVQ0v6IEkxDMRSaKcObKhdziy74COWLtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1exNPILxR6DPFsHJJcF0zTeYPzVvEVPg7n9LraOTNIWT/cOC2LebYTQuSUtWQrKDixBwSafLYlX86qCborQgtzNea/xxZD7Lvw2qSZUyTxgPnDw6G5DwXvUx53C3DDkYQTP8Ds8zBI4XagQfau4HDqaKsBeBp/rzCEhWiTBYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mkl2eeVG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a277339dcf4so425124966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705988058; x=1706592858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE+KZeEYVb1K/Fr/C+bxoTCDGKC1AQGgVq4rfstEFAY=;
        b=Mkl2eeVGY49kpN7Fz4wt8/epkrCXMBq3S+zz+AVL4RBBS4HbeiwJF8b4n59M14wg8j
         NW6/3y3DovbEre4r2Uob4RNHt0hDK06jVtHeTFjwrV211xjodBN1VqihsHSK1lwKCdKh
         lv6BYc7DN97enW82QBDMKIIpPHxIEpJoVAA6HqH5VLh6dhh6l7u03qvA1Ai5Bs16jb8b
         tXgwq1HP+MJjtnmGjx/uLnSzJMac5iwuhaIU2vfmt9ew+sFa1/hTMAmr4wXCotTZNXGa
         VZdZmG/sd9jQ/YYvvgr6+OPprdzPbpIYjsAziub9KEPPOvtzTyg1/qd+w7YP+vxIAlSi
         MRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705988058; x=1706592858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UE+KZeEYVb1K/Fr/C+bxoTCDGKC1AQGgVq4rfstEFAY=;
        b=Aw4/ekcS3LJWQSK183Xoc/sTUysHx4DU2dx+beKf0DGnleF99J8QO7LRd2Ymmb81pc
         1Q/wtCiDdl1qFrqanpImNA3A1ak0KTZXnXpNQGAsSJX4I2yy1a4MhteSrAHf89xPHqti
         LUm9+fZ+9nA0SmFRSjVF16C7M8NqzHVPnaOMM9pnrbCyE/Pecjte/Yh0R+6KCB1tscDr
         k3d383PudhQ8KoAHRopnii7ATZDGZS8r2edrSiRSB4ZPhbW2c0ZCyftjWSiJZUPwSbG8
         NqtOvLLodBJcjafud8qWzmrKRiTvrPMnTND2jBdvbFcp4YydXY6peziFIg9K6k2c/1R1
         Rmjw==
X-Gm-Message-State: AOJu0YwVxEbwE3jItrXYw6CgSJxxWJwoJQCUI1XSpClKvjA5cekwHUf8
	5hWXHvoMF/hiYbdRhAu9yJmKGQ2eHUB3iqkB2L3uBEnxdIoU7pKdNbXpMvGTAYUY7Wir5PC378G
	dcXVjld1/msCdUTbVKCpK6+XfJw4thVYXYPr0
X-Google-Smtp-Source: AGHT+IGuPQx3wn0/c89vzEE44s3f1mzQfMcUi8yukxKRvP28p62iDVaJaGpAEFwlqRiCzzCdlnT2G/HduTzjnzHWhFE=
X-Received: by 2002:a17:907:31c5:b0:a28:ce1f:6995 with SMTP id
 xf5-20020a17090731c500b00a28ce1f6995mr3259459ejb.36.1705988058321; Mon, 22
 Jan 2024 21:34:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108113950.360438-1-jackmanb@google.com>
In-Reply-To: <20240108113950.360438-1-jackmanb@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jan 2024 21:33:42 -0800
Message-ID: <CAJD7tkZzYp56d=wms7sgji1A=84Ax2Uo+=xvs7u1PtZ+mLvFhQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] x86/entry: Avoid redundant CR3 write on
 paranoid returns
To: Brendan Jackman <jackmanb@google.com>
Cc: luto@kernel.org, tglx@linutronix.de, peterz@infradead.org, 
	dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, linux-kernel@vger.kernel.org, laijs@linux.alibaba.com, 
	reijiw@google.com, oweisse@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 3:39=E2=80=AFAM Brendan Jackman <jackmanb@google.com=
> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> This path gets used called from:
>
> 1. #NMI return.
> 2. paranoid_exit (i.e. #MCE, #VC, #DB and #DF return)
>
> Contrary to the implication in commit 21e94459110252 ("x86/mm: Optimize
> RESTORE_CR3"), the kernel never modifies CR3 in any of these exceptions,
> except for switching from user to kernel pagetables under PTI. That
> means that most of the time when returning from an exception that
> interrupted the kernel no CR3 restore is necessary. Writing CR3 is
> expensive on some machines, so this commit avoids redundant writes.
>
> I said "most of the time" because the interrupt might have come during
> kernel entry before the user->kernel CR3 switch or the during exit after
> the kernel->user switch. In the former case skipping the restore might
> actually be be fine, but definitely not the latter. So we do still need
> to check the saved CR3 and restore it if it's a user CR3.
>
> Note this code is ONLY used for returning _to kernel code_. So the only
> times where the CR3 write is necessary are in those rather special cases
> mentioned above where we are in kernel _code_ but a userspace CR3.
>
> While changing this logic the macro is given a new name to clarify its
> usage, and a comment that was describing its behaviour at the call site
> is removed.  We can also simplify the code around the SET_NOFLUSH_BIT
> invocation as we no longer need to branch to it from above.
>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> [Rewrote commit message; responded to review comments]
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> Change-Id: I6e56978c4753fb943a7897ff101f519514fa0827

The Change-Id line here needs to be deleted. Otherwise, it seems like
this patch keeps falling through the cracks :)

Is there anything that needs to be done here?

> ---
>
> Notes:
>     v1: https://lore.kernel.org/lkml/20230817121513.1382800-1-jackmanb@go=
ogle.com/
>
>     v1->v2: Rewrote some comments, added a proper commit message, cleaned=
 up
>         the code per tglx's suggestion.
>
>         I've kept Lai as the Author. If you prefer for the blame to
>         record the last person that touched it then that's also fine
>         though, I can credit Lai as Co-developed-by.
>
>     v2: https://lore.kernel.org/lkml/20230920150443.1789000-1-jackmanb@go=
ogle.com/
>
>     v2->v3: Clarified the commit message per Dave's suggestion and rename=
d the
>         macro. I did not carry PeterZ's ack since I have made some change=
s.
>
>     original v3 (no responses):
>         https://lore.kernel.org/lkml/20231108171656.3444702-1-jackmanb@go=
ogle.com/

