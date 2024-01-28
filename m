Return-Path: <linux-kernel+bounces-41972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF683FA2A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8011C21196
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F53C47B;
	Sun, 28 Jan 2024 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fn/yMGWH"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12693C082
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706478207; cv=none; b=K+WgL8GJ3aNnRfeS2P0biDpE9v2kl4pRPKOzZvk+O8OJ/fmi6yiqxiIaXlCNMBjWjgf22MZLul1k2QApfonWbsDTYwuG+njLMhmEihxVIpkD94+Gqn2vIYBHCmqLPv7vIoZRGoQF0+TsiAFcYbo0sbhQtNH0VZNKZf/GBaZ3Ke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706478207; c=relaxed/simple;
	bh=63lBANGbYbeRuMlZZjypCZRBzn7lv4lWgbJyEC8XTag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddmyyckJZCnhn0Wy7GG6mT7Cral+53qFNuj/qcSX4QXs6ClIZiuRlu/EbAcgnApLAgfvtJsJiTzJ19g5v+SClbmgEzxHtoX4zQEtwE93QwtnJv4T1UOtRY31tZ4MgcPs7YknAY9EjVRHs/FQLD911F8cb5dkiDD0J5rvbCETk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fn/yMGWH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so210220566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706478203; x=1707083003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vlOP1NBhYVtNXOiXGs9r7VySXF9k7GylPcxJ5w9F55s=;
        b=fn/yMGWH1GOsY02VJXSGeQf8z8HyWWJ48lO6635iEveAer9Rrn353DXPBxlaDAEwsW
         c60/fCQ+JsKkJjn4FIL6q5O8/wdTzCZJ1AJnUfb+rlIv7G8gWA/K97PAZ4uxs9vn9m/Q
         Ue3XiRlUsjB6QwXHDYJO2PTUTOPwleIbRtvUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706478203; x=1707083003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlOP1NBhYVtNXOiXGs9r7VySXF9k7GylPcxJ5w9F55s=;
        b=WcsAtTyAcidesdHpbd96FSSp5TyXDyqHUq1nNUw9hbv24mqHHGlm1HszWf13drEWeq
         hF2vbfe8SGx4UjiwknetubV9FUNi/x1KC0xnfA98ckw730htLOgmslPWopWg3OgVRmOz
         +D/7D4XYomv/sGGgwNIHIfrFKgYSR+cINZcU9NrsovxxhOm1/skh3sYl9vSg/hU8g/s4
         ItVoQjmUg3ao8GYNqckMjAnaYY+DgrbmZQ2Xq3jQb7pkciwk/nT+Lgs7eoAKNf6iuN0Q
         vhkZh/mTte2yf7MTROmqNsbppVOnQo3q9vwKuG0Tq0MsVnLwmw4DxwqeiyVrhpokXv2j
         OjjQ==
X-Gm-Message-State: AOJu0YyPCG5xq2OPiGpJbbV9BISgld+cjjbXiHiTQMKwLyiwQlMVhni/
	lEE4n9NlvYNxSVSaYzCEs2WDLFjKePZnZhMwvCarOBOV0x0B5mWTDUSj6AWGy/iONINEEb6BiIK
	aUwA=
X-Google-Smtp-Source: AGHT+IEG8foGsf8yL/sG68PMrsdvNr163yhyQBbl3aVLMonP6SvIL2yLBJayFWAxm0r4+CasgakngA==
X-Received: by 2002:a17:906:1844:b0:a31:7f7b:275f with SMTP id w4-20020a170906184400b00a317f7b275fmr2791464eje.48.1706478203664;
        Sun, 28 Jan 2024 13:43:23 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id hu21-20020a170907a09500b00a359e072fe0sm830661ejc.145.2024.01.28.13.43.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 13:43:23 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55eedf5a284so577117a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:43:23 -0800 (PST)
X-Received: by 2002:aa7:d95a:0:b0:558:252c:2776 with SMTP id
 l26-20020aa7d95a000000b00558252c2776mr2608270eds.16.1706478202684; Sun, 28
 Jan 2024 13:43:22 -0800 (PST)
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
 <20240128161935.417d36b3@rorschach.local.home>
In-Reply-To: <20240128161935.417d36b3@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 13:43:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYOKXjrv_zMZ10=JjrPewwc81Y3AXg+uA5g1GXFBHabg@mail.gmail.com>
Message-ID: <CAHk-=whYOKXjrv_zMZ10=JjrPewwc81Y3AXg+uA5g1GXFBHabg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 13:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The deleting of the ei is done outside the VFS logic.

No.

You're fundamentally doing it wrong.

What you call "deletion" is just "remove from my hashes" or whatever.

The lifetime of the object remains entirely unrelated to that. It is
not free'd - removing it from the hashes should just be a reference
counter decrement.

> I use SRCU to synchronize looking at the ei children in the lookup.

That's just wrong.

Either you look things up under your own locks, in which case the SRCU
dance is unnecessary and pointless.

Or you use refcounts.

In which case SRCU is also unnecessary and pointless.

> On deletion, I
> grab the eventfs_mutex, set ei->is_freed and then wait for SRCU to
> finish before freeing.

Again, bogus.

Sure, you could do is "set ei->is_freed" to let any other users know
(if they even care - why would they?). You'd use *locking* to
serialize that.

btu that has *NOTHING* to do with actually freing the data structure,
and it has nothing to do with S$RCU - even if the locking might be
blocking.

Because *after* you have changed your data structures, and prefereably
after you have already dropped your locks (to not hold them
unnecessarily over any memory management) then you just do the normal
"free the reference count", because you've removed the ref from your
own data structures.

You don't use "use SRCU before freeing". You use the pattern I showed:

    if (atomic_dec_and_test(&entry->refcount))
        rcu_free(entry);

in a "put_entry()" function, and EVERYBODY uses that function when
they are done with it.

In fact, the "rcu_free()" is likely entirely unnecessary, since I
don't see that you ever look anything up under RCU.

If all your lookups are done under the eventfs_mutex lock you have, just do

    if (atomic_dec_and_test(&entry->refcount))
        kfree(entry);

and you're done. By definition, once the refcount goes down to zero,
there are no users, and if all your own data structures are maintained
with a lock, there is never ever any reason to use a RCU delay.

Sure, you'll have things like "dentry->d_fsdata" accesses that happen
before you even take the lock, but that's fine - the d_fsdata pointer
has a ref to it, so there's no locking needed for that lookup. It's
just a direct pointer dereference, and it's protected by the refcount.

No special cases. The user that sets "is_freed" is not special. Never
will be. It's just one reference among many others, and YOU DO NOT
CONTROL THE OTHER REFERENCES.

If you've given a ref to dentry->d_fsdata, it's no longer yours to
mess around with. All you can do is wait for the dentry to go away, at
which point you do the same "put_dentry()" because exactly like your
own data structures, it's JUST ANOTHER REFERENCE.

See what I'm saying?

                Linus

