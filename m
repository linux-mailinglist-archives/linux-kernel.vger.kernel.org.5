Return-Path: <linux-kernel+bounces-41983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C80183FA4D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8021C218FB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CD33C48C;
	Sun, 28 Jan 2024 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gOoNi/ia"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB9C41C7A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706480284; cv=none; b=uBU64SbFyBJombXJarMAHiyMUDjT49q/kXR5uMjOkb4zmQ55I2V23KWBVKo3KI86XqtKVZiBirGWlljatUPzV93YurJiL2lzkq3jxxfEakn8BP8Z/mNqslSn2/mHJ6atd3Eh105sBS/mvUxPCdZ9y+jRMa6BPM0MIdfAx6Bh6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706480284; c=relaxed/simple;
	bh=ZAbeqFfkAVPYZBMTPGlMkmzAB7gy9KOSp2nArVSSt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VR26t0DLnQFGghJXSTC0L9Wz7VAUltTVy+naXSjReJt396l/JmOxTn2fOAmny1ClT1BNReUjIac4h96lTmT3V+KwAtM7lQCOJZjFJKJRWoGxlhQmvpP1bjFwXrjvcykLv75DUSMcEt5zF0n39X+agWXmevY7GAalLS2dSk9KLW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gOoNi/ia; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3571318164so90401866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706480281; x=1707085081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QdJFIrMlzo7zdWhHTFYeNBtmU9mUeMU8Dy6w+dT6xYA=;
        b=gOoNi/iaLala8FW8oQ5fSMfE33yecB93x3rkCHE65YDdFNnw3b8bIzyXD4j11vEXK+
         TxN72k9LGVYGi9S5zNOMB6fOtAIdDYgzcocShl00+hS9z76VNgmLM+xicmjfPUjIxYCe
         TGEEOmmqEvT3VyAhBQtvv/11ZmEKo6225Pt8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706480281; x=1707085081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdJFIrMlzo7zdWhHTFYeNBtmU9mUeMU8Dy6w+dT6xYA=;
        b=boHNUnZ6neIW6mijFuCTN4JkVkinZQsGASeiidpdhkNxOBuZvfPs8fGV19R6lBTvqE
         Y+Y5l0wTGdq5K5C7IPcOi6AKMqlAbeCW3hWZ8OLwQGnFMIAfvm2nknVvYRqSWb7SiiGB
         6ZGR6qlxQGmMsnep4od9MwKnxgpgicobVXpCTeqw0ZWLKrW5A9EXE3xaUFR3pC+um9MJ
         6bYKkG/fa+++BJ1xAoM0gNpDeVKUW20BYuzBJ7+Jvrq95rw85RPIo6Q9i23dL/lweF2Q
         1gAh8DLYtaxyP3Y9DrQWpWfx5ToWyiyemMMPVaM4/hnxTIgahgcuUlSLF1gULv4XYH+O
         SgRw==
X-Gm-Message-State: AOJu0YzoOfOBQtfdb7GAAwTENNwcF58X0vcqdPrjls+bQwaY80Hpnb+3
	FZm3o9LqJRJVNCrFM/AifkXM7LfIYZFBXIPyrCOEi8NXI6K277Np4bY8/pV1H0JApDqQri4CRNP
	1wYmFIw==
X-Google-Smtp-Source: AGHT+IEfvvlsLcB9ASKeZ8NTWYOOHPPEsvrOstkedwLx2KqgclKaqdKb0+wyoDLROGVMxU1j9o1iMw==
X-Received: by 2002:a17:906:7f8e:b0:a31:8c1e:5ced with SMTP id f14-20020a1709067f8e00b00a318c1e5cedmr3356274ejr.76.1706480280920;
        Sun, 28 Jan 2024 14:18:00 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id wn9-20020a170907068900b00a2c869c2fe8sm3220953ejb.161.2024.01.28.14.18.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 14:18:00 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so1739472a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:18:00 -0800 (PST)
X-Received: by 2002:aa7:d053:0:b0:55f:80a:3006 with SMTP id
 n19-20020aa7d053000000b0055f080a3006mr183783edo.2.1706480279842; Sun, 28 Jan
 2024 14:17:59 -0800 (PST)
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
 <CAHk-=wiWo9Ern_MKkWJ-6MEh6fUtBtwU3avQRm=N51VsHevzQg@mail.gmail.com> <20240128170125.7d51aa8f@rorschach.local.home>
In-Reply-To: <20240128170125.7d51aa8f@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 14:17:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0bfqL9Yn-KnamLTvTpw+zbAa=og_JRPjZHgJ5m9iCZA@mail.gmail.com>
Message-ID: <CAHk-=wg0bfqL9Yn-KnamLTvTpw+zbAa=og_JRPjZHgJ5m9iCZA@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 14:01, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Basically you are saying that when the ei is created, it should have a
> ref count of 1. If the lookup happens and does the
> atomic_inc_not_zero() it will only increment if the ref count is not 0
> (which is basically equivalent to is_freed).

Exactly.

That's what we do with almost all our data structures.

You can use the kref() infrastructure to give this a bit more
structure, and avoid doing the atomics by hand. So then "get a ref" is
literally

    kref_get(&ei->kref);

and releasing it is

    kref_put(&ei->kref, ei_release);

so you don't have the write out that "if (atomic_dec_and_test(..) kfree();".

And "ei_release()" looks just something like this:

    static void ei_release(struct kref *ref)
    {
        kfree(container_of(ref, struct eventfs_inode, kref);
    }

and that's literally all you need (ok, you need to add the 'kref' to
the eventfs_inode, and initialize it at allocation time, of course).

> And then we can have deletion of the object happen in both where the
> caller (kprobes) deletes the directory and in the final iput()
> reference (can I use iput and not the d_release()?), that it does the
> same as well.
>
> Where whatever sees the refcount of zero calls rcu_free?

Having looked more at your code, I actually don't see you even needing
rcu_free().

It's not that you don't need SRCU (which is *much* heavier than RCU) -
you don't even need the regular quick RCU at all.

As far as I can see, you do all the lookups under eventfs_mutex, so
there are actually no RCU users.

And the VFS code (that obviously uses RCU internally) has a ref to it
and just a direct pointer, so again, there's no real RCU involved.

You seem to have used SRCU as a "I don't want to do refcounts" thing.
I bet you'll notice that it clarifies things *enormously* to just use
refcounts.

                Linus

