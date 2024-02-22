Return-Path: <linux-kernel+bounces-76019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B638185F201
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22793B24E31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE6D1799E;
	Thu, 22 Feb 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqmMrrn5"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A46D533
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587814; cv=none; b=dCM3PwC2jWKY/ky15EKIvVPS17dBRTCTAJfebvBs4XgHAsoW/fn67FxEkLIExOXZAclNAaR6br6pSjQuza8BPmVVMYd6Rhocw8QRdnPUFx2/xHay/TvD7/92/N6r21hz1g3fdzohjWTGIqo3c7d60RAhfGxcedCheeaXtbS23mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587814; c=relaxed/simple;
	bh=J+Of/Gb6IOHr6IVoZzbj9HFtwypj+rnvHcCQgqMqG70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5hymsDoEnt8B25bIlNxFF6tcxttCOZjzmGsudPzU0zGtTT14qCqK8e/ZMRh1htgkuqfGS45ZsD5C99D8h3gTsUZkTcdsuE8svrI+wTtTa2gpJraSN057i+hM6NmUct1Bh22bGfeoJZxzU5xGac8NaeBZPfkmpg+81TE4jRLq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqmMrrn5; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6079d44b02bso55352937b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708587811; x=1709192611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sqllwmMdInDIe20Q1qFJaLb0vW0NHDiyKJEVgWyWzI=;
        b=cqmMrrn50ujNZoy2VafOOqlFHPR/q6IflHRC4AKl+v9TmpaK11FN54RN3FobChmxf6
         92wEq6KSFQiqrig2DHCShoN4WDKQmf7S4QU0BJHHGzDITiqGFPOTtRIHkMCPTT/836HH
         oqiWzbnb+7ED42gmVtXAMy0VNUiJ2OAUwAKNsCWs11qJuhZkhWEgYTlBNqHjUKJ2Pm3C
         LjOOsMf9NSD4W4GlGh5DLs8t4CMgVovB2FEj1G8luY5do90x5GX6K7ydc7a2mRDq+CCO
         anAAon2ZKslZZ+fSdJnI2UPHaOXZq9EL2oODMd9aMjuRSXnefz11yvRYVKRunXQh2F69
         Cw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708587811; x=1709192611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sqllwmMdInDIe20Q1qFJaLb0vW0NHDiyKJEVgWyWzI=;
        b=qbFjgtu0m+FZ+O/Q5snfZwgtioD8wgwlZQVRxcVS47YHXDnr9Huq9vvuQ0xB0SDJB9
         BRU5nJ+JTM0pj9WCKMmCVfrQI2PS6AJNcZUUqfGnEJsDsEFI/wh2iSir4ynWW1xUktdX
         i9NhcN8Pu/UDP9V28OKl+sjfWx+KHGCvGQJlMrROyQSSFfAQDh+DFZpKkopKeXRhMdO6
         2z52FHfGPIuUtnrZHP204+9BwZTLfg2dB+FyRjRISs47FOlIfR2izvWn3/+kRpQVt1KG
         13X4JFBNp8xg04k9a8/EKwVsp13mcFAKo47Ul3XaIo/CF5DrDPFAo0NsroPkH2uoIWwX
         1Yrg==
X-Forwarded-Encrypted: i=1; AJvYcCVXYx/Mb4ojTPke7ZjEIGqMXgWAj1TywtIU1mXg1SpqTkmz6EggouJHWwrfONKNASFApuQpQE0jJSKw5IpB8AZgScUQHtcuiQWa20Hj
X-Gm-Message-State: AOJu0Yx8zKiYYs4fvHnGJ4KfESi4jCqZYNxmJqEVVXtTbNL1qen/LLN+
	sPLFnlmsxDGRx1h2e+Z2a1nefxPm6/kWHJfXl4lH2P5aSrm08tCZj8114yka19L1uSvvDrQLsn0
	VQcr53avWCCKCMqlywwxDjSr+Av0=
X-Google-Smtp-Source: AGHT+IEB0Sxyp4bTrLUSmzOTVsMvWTpbFwxuWDCni7OCfr7nYgHwikgibD0wz2CAwJQN6UvT6AdsIy9nKQ7TBPgR95o=
X-Received: by 2002:a0d:df45:0:b0:607:925a:3bfe with SMTP id
 i66-20020a0ddf45000000b00607925a3bfemr275058ywe.24.1708587811596; Wed, 21 Feb
 2024 23:43:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
 <20240221141158.8217ff2caf4f86c11a430058@linux-foundation.org>
In-Reply-To: <20240221141158.8217ff2caf4f86c11a430058@linux-foundation.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 22 Feb 2024 15:43:20 +0800
Message-ID: <CAK1f24=D1e=tKCjMMG1cr3bT4mow2ZinOOsYmwkv8oD2LHQbBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mhocko@suse.com, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Andrew,

Thanks for taking time to review!

I appreciate your suggestion and will be
supplementing with test results shortly.

Best,
Lance

On Thu, Feb 22, 2024 at 6:12=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 31 Jan 2024 17:30:11 +0800 Lance Yang <ioworker0@gmail.com> wrote=
:
>
> > Updating the change log.
> >
> > khugepaged scans the entire address space in the
> > background for each given mm, looking for
> > opportunities to merge sequences of basic pages
> > into huge pages. However, when an mm is inserted
> > to the mm_slots list, and the MMF_DISABLE_THP
> > flag is set later, this scanning process becomes
> > unnecessary for that mm and can be skipped to
> > avoid redundant operations, especially in scenarios
> > with a large address space.
> >
> > This commit introduces a check before each scanning
> > process to test the MMF_DISABLE_THP flag for the
> > given mm; if the flag is set, the scanning process is
> > bypassed, thereby improving the efficiency of khugepaged.
> >
> > This optimization is not a correctness issue but rather an
> > enhancement to save expensive checks on each VMA
> > when userspace cannot prctl itself before spawning
> > into the new process.
> >
> > On some servers within our company, we deploy a
> > daemon responsible for monitoring and updating local
> > applications. Some applications prefer not to use THP,
> > so the daemon calls prctl to disable THP before fork/exec.
> > Conversely, for other applications, the daemon calls prctl
> > to enable THP before fork/exec.
> >
> > Ideally, the daemon should invoke prctl after the fork,
> > but its current implementation follows the described
> > approach. In the Go standard library, there is no direct
> > encapsulation of the fork system call; instead, fork and
> > execve are combined into one through syscall.ForkExec.
>
> I pasted the above into the v1 patch's changelog.
>
> However I'm not seeing a good level of reviewer enthusiasm.  Pertially
> because of the lack of quantitative testing results.  Is is possible to
> generate such results, to give people an overall feel of the
> desirability of this change?
>

