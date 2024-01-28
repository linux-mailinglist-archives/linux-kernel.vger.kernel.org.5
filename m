Return-Path: <linux-kernel+bounces-41955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A573583F9FE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325A31F21E8C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828D33C463;
	Sun, 28 Jan 2024 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OKZid2V6"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D93BB3E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706476157; cv=none; b=TNQPllM4yxV2iWRtBHok32lkQvJYtBfEwMaD2OzEe6ZDeySnqBh8FhAN01y/q9+B2AUVfjAmHw74IpADZ0aFI2IwiQcx9W98d9f8/vL73dplklfqGu8/J2zvF0cbIjIatGPNFdp1rcwmeS9CIZAEiMrQfxEUfCy5CIJkEMJkweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706476157; c=relaxed/simple;
	bh=o4RRkX5gCxLFuN2ynOpDSrsGXRB6T46LcRbk3K1Vsoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihOxunrBtIVnPel9MChihjInrSmMyPGllCF0yHX0HBgk6VaeeAbUNYxavxzfBQLHvtmKHNaEtloJ7f1kLP4N22M9PEA92HIgxDQDOG90eDS8+D9x63BOTE9SgWO3HMDzIY2Z2v/uMNFbjIIDeFnlEqG38ImYRS3b+woiT40zoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OKZid2V6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf588c4dbcso13081101fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706476154; x=1707080954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8d+KpAUb3yjw2hNji3XL+yeN/4QOnDBQuqnD1AB0yzU=;
        b=OKZid2V6t1WLFcNCHYyJyGYnEW6Sldt4Y7lhIvqbRFunQ3qAoVAZJK1YgR+vEUqCpI
         I5yG4un9ziFrkGEY9pC1Csjn+9lbsZ+AaTe6e8P1yXMJA3YCtdjVNwRLsit2tVEBvUoF
         fFbduUKtUNtoEHc6OHrUpc7XLStKeeX+s9774=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706476154; x=1707080954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8d+KpAUb3yjw2hNji3XL+yeN/4QOnDBQuqnD1AB0yzU=;
        b=dpJf/HuZSRljEH9R7DPP+TCWW2fivY4PRGmv4siXK5Lf7k/OBn0dHBxXBvcZKbpnOd
         VfQ42QRwVdh/lQdQDOfuOlbQUnYyLCc3WqVfqbkHrSbq6VJMP3vKc5LzcxGGmcH0g0kX
         XoROdIjGMmJHNX9SxRiijiKpO4sfPZJi8eB6XSThaspwJip/a2iyP3mOt3UDg4cf5hZn
         FGqBFwE4nYxMIn4ue3DigL4x14dxny8ZFWocdz/bNf69byAHQAjvrBJNElD6PmjErQZ3
         m+ZP8f/F7WMGUoSIWFjnnuAwnwJxfGGMcr8RkgIB0k4kyViqy0l3dt6U2VWwiF1RJEGg
         cOVA==
X-Gm-Message-State: AOJu0YzEM8r6ZreiHUJfPHWik4IT0uW1Uf4h3FwbI3XtBOyGHfj//6Xo
	JyEmddumi9R7pJ60MCfbDSISqiN1uqD4EEAQgzG/Hy3AX/ig+cwUEHL3EGjzuNR9eFdOQ9eiSwL
	YzBM=
X-Google-Smtp-Source: AGHT+IG4oSXcVGnYRshLBW7O9T1FTCgHDMwIszkg8tF5+DX8dNYKGpK3QD4vvXcwk4QDv6EdMzRcAQ==
X-Received: by 2002:ac2:482d:0:b0:510:2582:5592 with SMTP id 13-20020ac2482d000000b0051025825592mr3288919lft.38.1706476153942;
        Sun, 28 Jan 2024 13:09:13 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v23-20020a197417000000b0051023975059sm891896lfe.61.2024.01.28.13.09.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 13:09:13 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf59559b2fso7579681fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:09:12 -0800 (PST)
X-Received: by 2002:a2e:b254:0:b0:2ce:926:f651 with SMTP id
 n20-20020a2eb254000000b002ce0926f651mr3165518ljm.1.1706476152131; Sun, 28 Jan
 2024 13:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
 <20240128151542.6efa2118@rorschach.local.home> <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
In-Reply-To: <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 13:08:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWo9Ern_MKkWJ-6MEh6fUtBtwU3avQRm=N51VsHevzQg@mail.gmail.com>
Message-ID: <CAHk-=wiWo9Ern_MKkWJ-6MEh6fUtBtwU3avQRm=N51VsHevzQg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 12:53, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, the RCU delay may be needed if the lookup of said structure
> happens under RCU, but no, saying "I use SRCU to make sure the
> lifetime is at least X" is just broken.

Put another way, the only reason for any RCU should be that you don't
use locking at lookup, and the normal lookup routine should follow a
pattern something like this:

    rcu_read_lock();
    entry = find_entry(...);
    if (entry && !atomic_inc_not_zero(&entry->refcount))
        entry = NULL;
    rcu_read_unlock();

and the freeing should basically follow a pattern like

    if (atomic_dec_and_test(&entry->refcount))
        rcu_free(entry);

IOW, the *lifetime* is entirely about the refcount. No "I have killed
this entry" stuff. The RCU is purely about "look, we have to look up
the entry while it's being torn down, so I can fundamentally race with
the teardown, and so I need to be able to see that zero refcount".

Of course, the "remove it from whatever hash lists or other data
structures that can reach it" happens before the freeing,

*One* such thing would be the "->d_release()" of a dentry that has a
ref to it in d_fsdata, but presumably there are then other
subsystem-specific hash tables etc that have their own refcounts.

And a side note - I personally happen to believe that if you think you
need SRCU rather than regular RCU, you've already done something
wrong.

And the reason for that is possibly because you've mixed up the
refcount logic with some other subsystem locking logic, so you're
using sleeping locks to protect a refcount. That's a mistake of its
own. The refcounts are generally better just done using atomics (maybe
krefs).

               Linus

