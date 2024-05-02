Return-Path: <linux-kernel+bounces-167032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F18BA3A9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFF1282393
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5BA1CD16;
	Thu,  2 May 2024 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bCYv6QEZ"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FA1C683
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691007; cv=none; b=VHmIwe/mKYKVq+39i2UVo9QTIM0fs6K3fXqm9STQWOdacBqQHf88nnX1AkAyiPJlno55cEfyKfwbzxiHqX/UmsDGXq++kQEoIqoea0uSzG8ovkdBNDQZ+8BpVQqXgBu7rUdgHhUVEdzjI7dnAJvrxrcLviaJ1SETBrqmJvEuWSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691007; c=relaxed/simple;
	bh=7UC0ZZLULS68YLtbitTAvikIsTdjDiGgT/XDM6ZThpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRVeWx8Mhx79ZBoGABvihXpfjMJaqYskUNojZLklCQ22quVHxxAuX+mVlsdQiNL2C4T3cKddPMtsJDF4JJj0ndO64aq2cXLmCHk78j8XeFfRedlo2zO/1FeAUgDfZdNajAKwR8NVzcTRwjentuPF927hbaNWDmR6aXdHb2TyeoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bCYv6QEZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b27c660174so2747038a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714691005; x=1715295805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I4RW3z/Zjpo6qwpklLmujf0x6xZ5b4UXLeUz+5BU7aE=;
        b=bCYv6QEZR4K8pT3YYHNyKEL8tICIe8BNi04eAHT8+BoAEmrnQjxMDoSpEu16DQqGsV
         tekRkOz6/0+gJYt4A+jDLaoRzVFz5DAGb1MC2sQ3yPao8ICpa5OIYv9XD8/2KCRnnEJ4
         5RWDN5W2C5CUru3MKpM8OMNOAmyR4vwQCTwzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714691005; x=1715295805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4RW3z/Zjpo6qwpklLmujf0x6xZ5b4UXLeUz+5BU7aE=;
        b=nUxT1uM2rFzdDVbfDMs74kotnNvchZxp8uxHRvkK+xIzd9EM9l1rKwumfN5OPB8QCG
         Pb41YdCTQTugWFZl5bA6ZiROEISMOgyO1SJAVPeJbFvZZ+HKgVMCfOd5585bfWpDVaNP
         5CSLv2OMxKD1jJ0BfYzw3ot2ypOHqn/3iUjPsPDSYUyhY1MdYjQ//JjDeiEnmWYa0rWp
         OMQbIIh08yuWVtrsDODxpQeN+tOOgYslSm7IxPZn7RWAbcWGCvkiXUaHJzYSD2KgfBQa
         XJUBSgHIfXecgkIQfMSez6jNgOtnVNlfTNBDG3Ew4dQYMaTv5hWSKczhIfm4hJDyfoib
         6AKw==
X-Forwarded-Encrypted: i=1; AJvYcCUYIMnkNlJHCXfeagStd6pNDpO2awwxA6FPv8K1ofwy1+UDTTAXyRyqUmSH5Gai4lplu3/rNTbijR3rPR8WdzkwE3cSKVtrrAVpEznw
X-Gm-Message-State: AOJu0YwXFnUFyx8RIAciDCeQUewF9rvWHlDQy0YkN49CE3zWyjaUlkkf
	Cbzuz+SFuS917l2zesABG0cwVnIWlqd7a7lqndrEsGY+TK1Q6smLkTOTnKn9Tw==
X-Google-Smtp-Source: AGHT+IFN1ghcNnx1vVRkm1yx/61qx4Z1G+3b7jaqkQpPQe3ATJr7d5YMS5BN39H3i6ElpFem8xw9lw==
X-Received: by 2002:a17:90a:c70a:b0:2b2:7e94:c5fa with SMTP id o10-20020a17090ac70a00b002b27e94c5famr1292136pjt.5.1714691005284;
        Thu, 02 May 2024 16:03:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gn23-20020a17090ac79700b002b2b608c10esm1807658pjb.56.2024.05.02.16.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 16:03:24 -0700 (PDT)
Date: Thu, 2 May 2024 16:03:24 -0700
From: Kees Cook <keescook@chromium.org>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/5] fs: Do not allow get_file() to resurrect 0 f_count
Message-ID: <202405021600.F5C68084D@keescook>
References: <20240502222252.work.690-kees@kernel.org>
 <20240502223341.1835070-1-keescook@chromium.org>
 <CAG48ez0d81xbOHqTUbWcBFWx5WY=RM8MM++ug79wXe0O-NKLig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0d81xbOHqTUbWcBFWx5WY=RM8MM++ug79wXe0O-NKLig@mail.gmail.com>

On Fri, May 03, 2024 at 12:53:56AM +0200, Jann Horn wrote:
> On Fri, May 3, 2024 at 12:34 AM Kees Cook <keescook@chromium.org> wrote:
> > If f_count reaches 0, calling get_file() should be a failure. Adjust to
> > use atomic_long_inc_not_zero() and return NULL on failure. In the future
> > get_file() can be annotated with __must_check, though that is not
> > currently possible.
> [...]
> >  static inline struct file *get_file(struct file *f)
> >  {
> > -       atomic_long_inc(&f->f_count);
> > +       if (unlikely(!atomic_long_inc_not_zero(&f->f_count)))
> > +               return NULL;
> >         return f;
> >  }
> 
> Oh, I really don't like this...
> 
> In most code, if you call get_file() on a file and see refcount zero,
> that basically means you're in a UAF write situation, or that you
> could be in such a situation if you had raced differently. It's
> basically just like refcount_inc() in that regard.

Shouldn't the system attempt to not make things worse if it encounters
an inc-from-0 condition? Yes, we've already lost the race for a UaF
condition, but maybe don't continue on.

> And get_file() has semantics just like refcount_inc(): The caller
> guarantees that it is already holding a reference to the file; and if

Yes, but if that guarantee is violated, we should do something about it.

> the caller is wrong about that, their subsequent attempt to clean up
> the reference that they think they were already holding will likely
> lead to UAF too. If get_file() sees a zero refcount, there is no safe
> way to continue. And all existing callers of get_file() expect the
> return value to be the same as the non-NULL pointer they passed in, so
> they'll either ignore the result of this check and barrel on, or oops
> with a NULL deref.
> 
> For callers that want to actually try incrementing file refcounts that
> could be zero, which is only possible under specific circumstances, we
> have helpers like get_file_rcu() and get_file_active().

So what's going on in here:
https://lore.kernel.org/linux-hardening/20240502223341.1835070-2-keescook@chromium.org/

> Can't you throw a CHECK_DATA_CORRUPTION() or something like that in
> there instead?

I'm open to suggestions, but given what's happening with struct dma_buf
above, it seems like this is a state worth checking for?

-- 
Kees Cook

