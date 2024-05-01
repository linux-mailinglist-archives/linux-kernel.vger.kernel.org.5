Return-Path: <linux-kernel+bounces-165785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364A48B918C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9379428575F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529D165FD7;
	Wed,  1 May 2024 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWzhgUUw"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F7165FAA;
	Wed,  1 May 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714601296; cv=none; b=dx8aIwckSMupTM3H9HUq+ywWD8Itdzxgz5NsYQ/QFkw/OCF5HavSPpYhumWTiUB+mFD5WAsnBvvVeN9DCqmdRYXRXQ2/9gCrzfQzf7nBwEZeAq4+tW562Uw5L4af0n+cluTuQjUqW0+mWd0d8yfnLsNRystyjfvvO/NVMWhbotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714601296; c=relaxed/simple;
	bh=Fzok5aJqa4+7oGLlWSOjZLQFV+oy3BXKUkmid8inYTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmmRvrRGusRFg51jS5f/ox7BzOmtLgMvrj34K8mJteMYyWzELd8XEu4QSYpwnzSvY4ylmcb3xoQSHwSrRJ1JLidbJKJyjJI4TBGSwXdMiZGVUlhneiIssCthF41VEu+SdtW+p0/uAyXWqgOonzWvhO5Hrhfrr8BWOZ0fp05OLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWzhgUUw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a526803fccso4872411a91.1;
        Wed, 01 May 2024 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714601294; x=1715206094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzok5aJqa4+7oGLlWSOjZLQFV+oy3BXKUkmid8inYTA=;
        b=FWzhgUUwf9BvLzXNxmjNHTYlTqQSPvIaovYdhbhZgPPY0rm0K8FKetLmIHK7pmt/pB
         TRKheL/AKcUpY9s6ephsn5xMDm2HAprRSqd/8qPgVrHeOZUAOfumB2au0CEgPQLe40BC
         lg4B9L3ocw0JoKBCLJ8bvfx2jmZkaE5m6osQjgdkJ60GkWLL18XtPKIlvksukRFIq1sT
         kvXZGAfHsEU5DpX/s74wQPxyC/z1i3OtdcgXaPtYE3kdXHUeyBvdkrB9Q/ObKCmtA6c3
         apJvWa6+GtKn6S124YKP/J1AZQ1Vd+LPonBqwOzgVAMgiqidqcRSfm2EZQv51dQdSSHU
         ZmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714601294; x=1715206094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzok5aJqa4+7oGLlWSOjZLQFV+oy3BXKUkmid8inYTA=;
        b=gvI7E5gNTKm4BSiK9syW3RcRM23hvPaxVYDAIYPYDb6RfKDEZF866cW5sFwtG6TUHj
         9mixi3x/VQSkf764nFwD04pWiCX1JHWbpukvh6+tu7IwvF1T5lVq1kmZXdSNb0hei8rW
         BiVzZn+ubQK3Y56XW9ReYDxvNS/i07244R3Iq4WyQ/WVJP6g7jcFu9ue6MTzGqZ0UzEb
         j47nBnnhOsQSuWAJv72YUcrNlBFuQSvVmpS4lZjbJGycHnWP0G0N9Zuncl/1M9fZKdpI
         XP0kv5mvRDqfPKEQCxBRfcCE/opu1hxM3I2WgP22JHqD3AVHDK9jLpZSEYbcN0Mldntr
         +SUw==
X-Forwarded-Encrypted: i=1; AJvYcCWPvjnJh2HxBwoLwEEByeHTQoHceM1Z0GNY6gk8CjkG/85qmU0AXyDcUwr6DWI1soP9OorxpTnfttRXlQ7h/37E09djKa4fw5E3i2MVoNWovBpjv/LKj+frdMziLxFgqNvYbLr2zg7L3FBHh8k=
X-Gm-Message-State: AOJu0YzbVmghV6BvyQz2QFJnU7pd8J24u5Mf1RJMg0GO4ljR/UiIKvMq
	rV1jQn0BgcdjuKDw5wLiNDmRViGwvfl3G6qqwuONEPTDKEKfqx7qx0p8xbf1b+SyCZXbBScmb16
	r8ofJ5BwGPUwQJgFP95v76j54/mM=
X-Google-Smtp-Source: AGHT+IGVV48XRtpNQ9/4wKjJtS7cTSF5aA0dcNMF5dGvaXLHjGojpjfQteWjzWdxyzR3mWNJlAsihyloF0y5iS07LWY=
X-Received: by 2002:a17:90a:b389:b0:2b1:1c9d:fa8d with SMTP id
 e9-20020a17090ab38900b002b11c9dfa8dmr3595697pjr.28.1714601294400; Wed, 01 May
 2024 15:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328013603.206764-1-wedsonaf@gmail.com> <20240408094738.00005e59.zhiw@nvidia.com>
In-Reply-To: <20240408094738.00005e59.zhiw@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 2 May 2024 00:06:57 +0200
Message-ID: <CANiq72nrMpg_dk4eM2Ve+aOi7QF4U-SCvLpx9PMD6o=6sdzOYQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
To: Zhi Wang <zhiw@nvidia.com>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>, John Hubbard <jhubbard@nvidia.com>, Neo Jia <cjia@nvidia.com>, 
	Andy Currid <acurrid@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 8:48=E2=80=AFAM Zhi Wang <zhiw@nvidia.com> wrote:
>
> IMO, It seems the allocation flag here means GFP flags according to
> Patch 5 and I understand the benefit of introducing the flags.
>
> I am interested in the future plan. With this change, will Vec and Box
> stick to kernel memory application APIs with GFP flags in the future?
> e.g. GUP, kmalloc, those mostly allocates continuous memory for small
> objects. Is that the future for Vec and Box in kernel?
>
> Is there any plan for having vmalloc() in rust kernel? Currently, if I
> push a large object into a Vec, kernel MM will complain for sure. And
> literally Vec/Box themselves don't imply to the user that they allocate
> memory with limitations.
>
> Kernel uses different MM alloc APIs for different usages. For rust,
> should we have a different kind of "Vec/Box" or having a Vec/Box with
> different set of allocation flags that covers both GFP MM APIs and
> vmalloc()? I am curious about the plan.

Sorry Zhi, Danilo brought this message to my attention today (thanks!).

We have been trying to find the best way forward to support fallible
allocations, per-call-site flags, other kernel allocators and so on
for a long time, including discussions with upstream Rust.

At this point, after these years, I think the ideal path is to try our
best to avoid re-enabling `allocator_api` and to have perhaps our own
custom APIs/types as needed (possibly several depending on the use
case) -- please also see my reply at
https://lore.kernel.org/rust-for-linux/CANiq72=3D0BNw-KiURBjosLqfuUEPpjZPbR=
g1XMFZyobOzBt7aMA@mail.gmail.com/

Regarding this patch series, we mainly wanted to make progress on
(finally) allowing at least to use the GFP flags and also,
importantly, dropping `alloc` since we want to start supporting
several compiler versions soon.

Thank you for your feedback on this. It would be nice to hear what you
think about Danilo's approach in the other series and other possible
approaches that may not rely on `allocator_api`.

Cheers,
Miguel

