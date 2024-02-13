Return-Path: <linux-kernel+bounces-62884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF37485277A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CA11C2338C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1807046B5;
	Tue, 13 Feb 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Jrb9xtg"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73BD17CE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790828; cv=none; b=kvhPM4r+Q646MzxHl7N7txU+ZXeAs33BCJLqFNna3PbtF6gY6fz4B9Xo9YKzbmkvvGf+tf4UFiAGPpAv5jEr5CfgB0jCsvzlaeTcW+fYeAveYghZYZqMOnDHu2rlwbBKSrtiwEn1tP7V75u3HiDLpUiSJXUvZl928fLHwq9EPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790828; c=relaxed/simple;
	bh=S9sbRuvYiarABejv+1FZRtHjtyC1exllh7yCDkk639Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbqOT6CuUy6KdX5J/p80Lul4CLLLwq0vNF06NGRcQo59hMNgMvzGViFUE+tf0aBIDsUFtHFJyRHAvqWoUuds5Vh/0WujeY310PEioilMKFkO8xn4O1PzTpslZPlcBI/YH1v1SQqxXaJuRAAGptZSWVXsvivBbvx6cI+iqsgMmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Jrb9xtg; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3416147276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707790825; x=1708395625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9sbRuvYiarABejv+1FZRtHjtyC1exllh7yCDkk639Q=;
        b=4Jrb9xtgZZd68Cd8qtWKkms3W8lyscetML+GV9VkniajxjX00oCm8vO3er0J1tOJYG
         KXV6U73T7/ahxivChBXpV+Epa+r+05A2t154aRf14aPl3XbChON6p22PKWX4U7vAzS9o
         brwAToX8177IfGEf9W+XIqe1YPvjrVvfL9p54qZ1sWP3PGzpzREqC3UGYZKQKBZySG2k
         Ww0YUiGkRHSadsneVBJVnVGSj/Fif1gMg/8vv70xOYtj2wcjiPng2kr+bKGBZYgVzATG
         OKxyy6fQiAVrWs5pOrlgKVY84DYPBwXY7IoUnb6KCj+HNchnZ6OPi4x27n09k46FAdxz
         ByRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707790825; x=1708395625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9sbRuvYiarABejv+1FZRtHjtyC1exllh7yCDkk639Q=;
        b=QmWSRZbyPLZFwJD7Ci0ghkvXdHwvfDHwfMFwQzc9GU8m20vATsT0380x0W4ff69ugo
         oJNAkUDDl0D/Enfr3GyQOUjfJvlgK6Vo1yO6xsSWFrM7ePQOU9ViEHAyrbPSAG+54559
         VgoOzjnVhZ9DcBGjvPtN3Jh0pCXPYireYxApnPVD21m0O5hxJ+4NMgbAMC2W6cIW+1pg
         tkwnZucZcYSs+4lWstv8v0r/2L7F/z50CWzjad0EYTHHdeTe6ZFbzVn4Ri9z10BPnC0P
         gb4q2uxrKVjlDIhKjP6YpyVN+AAgDU/U2blBsgd9sc9i6dvcTWAgjiswBn6aGxAlit7J
         B7qw==
X-Gm-Message-State: AOJu0YxJjGPplsy3U8BlMCpB8HLULTgl3ojz+64BPSL1jYR6PxU+q9aA
	bYBE+NNndJ6YvUeGgZtih7w6QnPwLrWoo2ddeiXc+bQHDCWdyi646jxuHebSN6tNi4a2rIWiqLA
	dmK76WDS5V2A2/uG7DMN1zRw4RDDZ0U5cp0ax
X-Google-Smtp-Source: AGHT+IF7VIKyAprzsQj97Z263Qoier3okujGUFo7m34RyS9jjnxf5dSV3vlCD/UI6jUXKLUqELRXLl2excxB7HnDSlw=
X-Received: by 2002:a25:df91:0:b0:dc6:de93:7929 with SMTP id
 w139-20020a25df91000000b00dc6de937929mr863370ybg.26.1707790825358; Mon, 12
 Feb 2024 18:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-6-surenb@google.com>
 <202402121413.94791C74D5@keescook>
In-Reply-To: <202402121413.94791C74D5@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Feb 2024 18:20:13 -0800
Message-ID: <CAJuCfpGkdAy58nR02_PSVXc4=R3faRUL-7Hack3R_aWmAgk5HA@mail.gmail.com>
Subject: Re: [PATCH v3 05/35] mm: introduce slabobj_ext to support slab object extensions
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:14=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 12, 2024 at 01:38:51PM -0800, Suren Baghdasaryan wrote:
> > Currently slab pages can store only vectors of obj_cgroup pointers in
> > page->memcg_data. Introduce slabobj_ext structure to allow more data
> > to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
> > to support current functionality while allowing to extend slabobj_ext
> > in the future.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> It looks like this doesn't change which buckets GFP_KERNEL_ACCOUNT comes
> out of, is that correct? I'd love it if we didn't have separate buckets
> so GFP_KERNEL and GFP_KERNEL_ACCOUNT came from the same pools (so that
> the randomized pools would cover GFP_KERNEL_ACCOUNT ...)

This should not affect KMEM accounting in any way. We are simply
changing the vector of obj_cgroup objects to hold complex objects
which can contain more fields in addition to the original obj_cgroup
(in our case it's the codetag reference).
Unless I misunderstood your question?

>
> Regardless:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

