Return-Path: <linux-kernel+bounces-108644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FCD880DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7A7B2372D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23BE38FB6;
	Wed, 20 Mar 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlHYYPYF"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B06B38DE1;
	Wed, 20 Mar 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924490; cv=none; b=uvvDySDkc9a0Y4b259c+ZPm10pRu1Htcgb7LnUyR6be9cTYrytKEJ3c48XtcogNrb7mEGFjX0BCHUkdpkfo3yHXMGv8AcfmhUeLSw8C8M9Uu1ZC7u6wtGmAC1p4X0TZAXtec+Q2JKViyjOZQzpYo6uQAkfss1zwsLO+ekCnj7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924490; c=relaxed/simple;
	bh=uXKsSVWCgYYsbuqtwTD65wtWe0vqcX1ynDfeFuCz4Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHhgfoIPqQ1Bn1xIz0Cji+HAKxXo5uM1S3P+vef6n3gzIyEQ1lbptfZGfL85Mlf3GBzU9QRXKuS5qrKzoOhbH7fVZV599j/MtF3c241UrUbHMEnrfQAn43lV8gYhFgNp9+XwPI9PZrkmzcfjdC9tx7Wd1LGjH+yjzztfRLlhpMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlHYYPYF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ff53528ceso2448690f8f.0;
        Wed, 20 Mar 2024 01:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710924487; x=1711529287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXKsSVWCgYYsbuqtwTD65wtWe0vqcX1ynDfeFuCz4Wc=;
        b=HlHYYPYFye3hGnhD9buM6rfyJSW7LjLOEPWmdBenb+UhkUnWnE9bt8xHtbQvJsORiS
         HTk9wFBHFuGu6IuOrFJxNXcq4NAQJCzDG54/7Uy5sK0yGxvh6NRdFbr7tjzFS0LFOjLo
         R4Mh2uuZnnKYC42wlW2Ci+ID+tQ+ew3dgvsp2aVkZBpQIp3iPz21nm0pNR02CQidWgdd
         F+nRCidKGVMMbAEO/fX0KSXSs7s+6kMbpLe7SiwirAY1l9V6QTRc9uNlS2iQ10XcCT24
         z4YJzZ3rtPsDmJd2xpsLOH02pZDl8W5ipzIKdyFTAohr/ssEvf5dzo/DBmA842iVi86B
         E/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710924487; x=1711529287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXKsSVWCgYYsbuqtwTD65wtWe0vqcX1ynDfeFuCz4Wc=;
        b=PwUBIBHy+9yI9T/Ts26NPSSUH4gOX6dwmOMY5xvCFYNvP4C8dCccLALV6HQK7cBc5G
         qutJRjz2NHn1s8n/lZHSxGFa5TzUp8wmvLVjVHORG1c7Aq2vD4O5WXkANIuzuXgWfrC4
         VcceJCgJc9wzAwg8M7phitCqT4qgAr+B49qTbtVhs1kbNb3m8u8kbBrDdu448BbIBoTS
         GsyJCA572NQnWQVHOb9EWSdHPwMpHKjDkuxIcIf1vDkR/lclki3SyV5ZUyL2mPRtk8V1
         kDt2BIOgtegWpwVurYDH8PwTli/LrEBIYN6YxgdTPGW1A8qBlkIL6zUm1D0O6sK3KeW1
         o6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXeNovNnlwCgRHLnMUzVfyOCknYN1qeflItHW7Ox+oejFe48F0XKugX5iNlH+SBsa5LWi0IeKMPwxvflQ/Rpz6qdj5VVU+UrWlXW1rOki/J3tGNp67ez0wv9CVotw9OC0Cw
X-Gm-Message-State: AOJu0YzTiXYVtYbKRtjUfnAQv244DDKHo45t8GjvuMCX00tn8o7qegL4
	4VS6nDOwcgiM99j0cMCTagq4dC8V6OViIwtS4PhU4ezIycVX9zV/tcreEuAhzfnMyXWgWmcaIN5
	BS5kkB9sX8EvyrBJ/LmYJJqk/3SA=
X-Google-Smtp-Source: AGHT+IEbRSoAf/Cstz4Wwky7NwyWg0XJwZnmR2GVRJGxefhx2KNNwEU+bH2PUJLdWCN3+0n6oVgcJj/nDe3TQ9LYWko=
X-Received: by 2002:a5d:51c3:0:b0:33e:c03e:62 with SMTP id n3-20020a5d51c3000000b0033ec03e0062mr11674306wrv.40.1710924486606;
 Wed, 20 Mar 2024 01:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e40a2906072e9567@google.com> <ab273ae2-80ec-45da-910a-e74298c71d50@I-love.SAKURA.ne.jp>
 <CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_zxJQ@mail.gmail.com>
 <596aad11-ee69-4ef1-b945-7b67a9fb22d7@I-love.SAKURA.ne.jp>
 <CAADnVQL6Q3k0+-5X3Xjov7W_xESxkmVXcsCxQRWitQvhTBsf7A@mail.gmail.com> <dd264bf7-821b-4cf4-802b-60ae3c7b83bd@I-love.SAKURA.ne.jp>
In-Reply-To: <dd264bf7-821b-4cf4-802b-60ae3c7b83bd@I-love.SAKURA.ne.jp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Mar 2024 01:47:55 -0700
Message-ID: <CAADnVQJt+aP=Zo4edCu4iQEmdQjiruR1pJn0qyZZboNym+zd0w@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Fastabend <john.fastabend@gmail.com>
Cc: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:30=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/03/20 16:12, Alexei Starovoitov wrote:
> > On Wed, Mar 20, 2024 at 12:05=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> On 2024/03/20 15:56, Alexei Starovoitov wrote:
> >>> This has nothing to do with bpf.
> >>> bpf never calls printk().
> >>
> >> Please see the Sample crash report in the dashboard.
> >> bpf program is hitting printk() via report_bug().
> >
> > Exactly. local_bh_neable is simply asking for a splat.
> > _this_ bug is in printk.
> > It's a generic issue.
>
> I can't catch. printk() is called due to report_bug().
>
> If the reason report_bug() is called is that spin_unlock_bh() is bad,
> this is a bug in sock_map_delete_elem() rather than a bug in printk(), is=
n't it.

There are two bugs.
The one you've started the thread about is in printk.

The sockmap bug that triggered report_bug() is separate.

>
> >
> > sockmap bug is orthogonal.
> > It's already being looked at.
>
> Then, can we expect that this bug is also fixed shortly?

cc-ing John.
I don't think it's hi-pri.

