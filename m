Return-Path: <linux-kernel+bounces-45536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78527843224
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846C9B22406
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D9138387;
	Wed, 31 Jan 2024 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddCKysz5"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577FF364AE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661453; cv=none; b=RKZCcXwKz7BOctSADA5V6RVxIYpPVQ7zbB357vsgdcrspA9XfQNPasMVkown2g7DgxUy+WYK2hwD6CVyUK0QceK7jOcOiJ696bAmFr9buKMgKx5TSGoebzxLsFj9/1cia2NesUmiQfmYD7XGxIjCuIJGLE82FbKXk+Pl58sdd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661453; c=relaxed/simple;
	bh=zeylMOsdJd/dJk76pyz8wAk5p6kMqJH/DY8gjEqi2II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcTBGmD39HDupDeAA1FfAJrF/GcAyzwPIGnOAj0vBsztIdI8vUlrzfcaqxtm/o209+Mvd4DqnvsMgQ/cdUWBE34gvG60DKywpbMBmVTqmk0D6JZgkhVoMjvSRCd2lsLboPNgNITbUvPaiDoMzvXwdOrhpcMnYTf7KqPcKOvaXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddCKysz5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6040a879e1eso2446417b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706661451; x=1707266251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeylMOsdJd/dJk76pyz8wAk5p6kMqJH/DY8gjEqi2II=;
        b=ddCKysz5adpJoHFEcjmdv+SYQQeGTT6xKR9Ax3BbU0hknu1+vYOGqrP9maJXcSWT63
         RkNz+T5MWx+HAiMCJd+XoVtNyjRlgB+wyu6m1L0jffM8DAcJjjW2tv1cJJf5toDHFgkl
         RAFqVEZrgWzYEWJs1vzVfxWYqxSIv/v4ajM6dGLMkN3BNqRYxSNgP7wz0AQqmtiXvG7W
         eFYtxODhN3141sN9P3JBQHEsppIEbA7sP4Hz84zbg20mZH2DaW38hJqPbiEDclEIKWsH
         zfwJ2V2/9L2E630snrlrTz1qUSoTrAApx+z3RIV65M6j/5g8nhskemTlVIQKilqjfI8A
         5QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706661451; x=1707266251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeylMOsdJd/dJk76pyz8wAk5p6kMqJH/DY8gjEqi2II=;
        b=fHcLuNAC275hHrcDbGypphrG7xBA1f5/sqV57/9oriHz2+73C+OuCp4/XnqrMwN+5v
         V6f3lVXiXxrVhrO3junMOu5ue1KioIDt911/APYamZ8SQMh6+3e9VhgIBoN7QP/YUo5K
         LfacplY76Xrc8iXGqhnRb9NxFTbZzhAI+wYZnQCzPc7Sbu389hQvNt90huipDoyj4scz
         rJJpzfDSsJdcg7JZEr5bV+KL2P5yybcAi9YwwL0HWULb9RJDAROKr7AVCZcg3mveho5k
         3fmMyRmF8pTLtbjvRy/0bXeSAHBHfmO4DZK+XjmqjmyFwOrHs3aBINI87bXYCa/80y69
         QgaQ==
X-Gm-Message-State: AOJu0YyTZPVSMtGqpc+qm564PfUIa3dpnLfvIwsxGwmGdUzH9XGSQhFq
	MWXAS1HOvluY87E8O4eiI56H2Ru7OAoA6ubduyZw3M4t5NAG+qTaLJVowWfVYJJeQq/Lxb4vR2v
	qfYRqtOIoW+TjOn0OE+mDDLWGIfA=
X-Google-Smtp-Source: AGHT+IHrjwhtf52NduE2KBj6/w7wzsp7q7IXLVQGOiYBvjNf557qm3vyjtLLdn9JtVKgVVnh8MBV7hCmmyfvKzhqkQE=
X-Received: by 2002:a25:83cd:0:b0:dc2:4468:d4ae with SMTP id
 v13-20020a2583cd000000b00dc24468d4aemr213462ybm.57.1706661451256; Tue, 30 Jan
 2024 16:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <ZbfSP6xt6JAE2NrH@tiehlicka>
 <CAK1f24miiADZCpugOa4QUmerG70kOsMT97Zvmy=5ifOG4mW=+g@mail.gmail.com>
 <CAK1f24=2YE+BCYiizkqc8rmN8NaFv_Q6ZtE+4DiFK0PpcefOrQ@mail.gmail.com>
 <ZbjC7KyI21ik1xpK@tiehlicka> <CAK1f24=WJa7qpwBW8J-eYBc2TGrViE_8vtCTESXxMDd=hhQdjw@mail.gmail.com>
In-Reply-To: <CAK1f24=WJa7qpwBW8J-eYBc2TGrViE_8vtCTESXxMDd=hhQdjw@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 31 Jan 2024 08:37:20 +0800
Message-ID: <CAK1f24kLYK-yCQQJO7eJbuMwg02TLi8C_SeES3fbqAOgQ4AAjQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Michal Hocko <mhocko@suse.com>, "Zach O'Keefe" <zokeefe@google.com>, Yang Shi <shy828301@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Zach and Yang,

Could I start a new version?

Thanks,
Lance

On Tue, Jan 30, 2024 at 5:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> On Tue, Jan 30, 2024 at 5:35=E2=80=AFPM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Tue 30-01-24 11:08:10, Lance Yang wrote:
> > > On Tue, Jan 30, 2024 at 10:12=E2=80=AFAM Lance Yang <ioworker0@gmail.=
com> wrote:
> > > >
> > > > Hey Michal,
> > > >
> > > > Thanks for taking time to review!
> > > >
> > > > On some servers within our company, we deploy a
> > > > daemon responsible for monitoring and updating
> > > > local applications. Some applications prefer not to
> > > > use THP, so the daemon calls prctl to disable THP
> > > > before fork/exec. Conversely, for other applications,
> > > > the daemon calls prctl to enable THP before fork/exec.
> > > >
> > > > Ideally, the daemon should invoke prctl after the fork,
> > > > but its current implementation follows the described
> > > > approach.
> > >
> > > In the Go standard library, there is no direct encapsulation
> > > of the fork system call. Instead, fork and execve are
> > > combined into one through syscall.ForkExec.
> >
> > OK, this is an important detail. Something that should be a part
> > of the chnagelog. It is also important to note that this is not
> > a correctness issue but rather an optimization to save expensive
> > checks on each VMA when userspace cannot prctl itself before spawning
> > into the new process.
>
> Thanks for pointing that out!
>
> I'll include it in the changelog. Good to know it's an optimization
> rather than a correctness issue.
>
> Thanks,
> Lance
>
> > --
> > Michal Hocko
> > SUSE Labs

