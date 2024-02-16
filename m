Return-Path: <linux-kernel+bounces-68408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BC58579D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFACEB22A90
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987D11BF53;
	Fri, 16 Feb 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeIvPRj/"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376BE23750;
	Fri, 16 Feb 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077735; cv=none; b=T/gI8yY3rTB2MshOEnu4GFlH0UEM8fLo89nAiQkmz7qkUrMvmf7XBpklckNXms/vP6ZKl+dBsYPKY/lQiNz8wG7rWlkZwXyo6ICz+VD5AJJIQKLKmLpVOJQyX2nNa7PrO7kA8awWk9+4mwatanJ42VL2UEal0TiHiAqaq1qZWGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077735; c=relaxed/simple;
	bh=O+93pBFgZM/jk9pzYDTtxeiT8dZVqTKFySwAmt2XakA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=az27yt9PfFwrF6qe8Lpxi5wwO2M4PTnZtZ7okYmQWzoNa/oE+/E53Eu/ISg25DkSIyQR3cXSfUs7PiePncYEKR7YltLPvCRXZmirqJy5ZxRq6F5bP84pN0jkjf1/+akKvhcJJ/IS3VlFVO+Y2eePEV0MXE/qauV/AX6TAj1wAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeIvPRj/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso2699361fa.2;
        Fri, 16 Feb 2024 02:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708077732; x=1708682532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+r76o2JwpW191mB0cdSBI4QA1SjwNLwOUYY+I3l0fo=;
        b=KeIvPRj/WY1h4bnALycH99ZKoFW1FVdoMvbQC/yJ78v3UMQg+fRS5D2t0Jk4NOAAp0
         8YgmvLR3HQwG273oqu1/DqwildpKEJ7k5rGp/pnNctlNCCnE8ZMCZJnDQWNLxIXYi99s
         SUfqLHQm/gf+oopZaHGCXrcU4XpMxFuLSsSjtYzTgc1bGu4BggEV4InE3aowD9ZgIJAN
         Z7kAtF+PVKmSUy3ZE2lKT/Xu4Iq6Rq3PQib/ckqoFHmVmmDpzrbJXNhI6hUs7UVhPi6U
         qjsYtvfKa+fJDu66MBf7ct/kDssETgB3S/f2AoKLqPw8f6k8/zRiqEAPzNo3PfVOvo2Y
         XQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708077732; x=1708682532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+r76o2JwpW191mB0cdSBI4QA1SjwNLwOUYY+I3l0fo=;
        b=UWdAFo/M8cJHKumaBZn90BvsahwF5qhWZr6a2qFn6H/ELpdGV7MXLcMpZOZGbEFprk
         JVvqM4mpeh/1rDoBgeMO0zN8b79bhd4NhPT4Dz5VN8HaVxNN4ROH995RcBePbi5pTBZ8
         rZdXbsV8TwSMahNeQIv7m6VLqBENtS7FqdYiDT+VbeSnxpBK5ABx0bHOXAAT2BOPP55C
         BOdch+w5Sg+qDaK3XqjOicc5iLvEQwO4BWZkE9fgyoKz2QL1WFOIoG/zxDANxSiCmR/M
         TjBXtoM8yxIAoYRozKP+CegpasHPjc5lmQIC59zNfKyZ2W+Ud2gxW31VyEN+GmgBg+vz
         QGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC4OrNQ2HUy5/4QZ3QA1Q54G1+rPgLAHDE/zpoS7hvOenPDfrIYsZFl4OJ1WX4CpR9CMwCibq99MUlxSKy/pnwqVyl+DNkBDEJ4TU6nK7aK6BYfH9GA9B6LxG8cdsOxygyMRQa
X-Gm-Message-State: AOJu0YweeoxSYuZYu/aT34L91D456fTceKHjksilk+09VWegmdsNG97w
	5Pj3IkYsKUA2G1a5ZQq4iZKi041HEgKxwm/uvusvcTSSYQ23eckIGWwn/7HPHUIatypYiY4mLNT
	NATzrd8kYbH8SvRPLgyyHVVLkP20=
X-Google-Smtp-Source: AGHT+IHbTtXkIU6FJpAiPx0y7F1gaeijHLB/wVYaW/EFpk1Pev9GaYTryS4GHL+6L4Bo1aidj5Jo/x2kQwQI6uW0YvE=
X-Received: by 2002:a2e:9214:0:b0:2d2:a27:200f with SMTP id
 k20-20020a2e9214000000b002d20a27200fmr2584021ljg.46.1708077731548; Fri, 16
 Feb 2024 02:02:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <1d259a51-46e6-4d3b-9455-38dbcc17b168@redhat.com>
 <CAMgjq7Cy3njsQzGi5Wa_JaM4NaO4eDGO5D8cY+KEB0ERd_JrGw@mail.gmail.com>
 <4c651673-132f-4cd8-997e-175f586fd2e6@redhat.com> <Zc56L6oL4JmxqaFN@google.com>
 <20240215145836.6db8f62824e1547f0608591c@linux-foundation.org>
In-Reply-To: <20240215145836.6db8f62824e1547f0608591c@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 16 Feb 2024 18:01:53 +0800
Message-ID: <CAMgjq7DhRu0qAgLY_cw-WuWmx9vchOAN0MeumRtCLFtoD3Kz8Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 6:58=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> On Thu, 15 Feb 2024 12:55:11 -0800 Minchan Kim <minchan@kernel.org> wrote=
:
> > Only concern of the approach is that it would be harder to have the fix
> > in the stable tree. If there isn't strong objection, I prefer the
> > Kairui's orginal solution(with some tweak of scheduler if it's
> > necessary) first and then pursue your idea on latest tree.
>
> Do we agree that this fix is needed in -stable?  For some reason I
> don't have a cc:stable in the changelog.
>
> I'd like to move this patch into mm-hotfixes-stable in order to get it
> upstream very soon.  Are we all agreeable with that?  I don't have an
> Acked-by: David?
>
> I have a note (which dates back to an earlier version) that Barry would
> be performing runtime testing.  Has that occurred?
>
> Thanks.
>

Hi Andrew,

I think this fix is needed for stable, I've sent V3, if we agree on
that, please consider V3 which includes changes we have discussed so
far, thanks!

