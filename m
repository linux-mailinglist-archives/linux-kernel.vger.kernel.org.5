Return-Path: <linux-kernel+bounces-42009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E88D183FAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646B4B20F76
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AAF45943;
	Sun, 28 Jan 2024 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="II43344E"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF94446C7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484272; cv=none; b=tTWXB8d+w0xklVqRZx1Yv+imlRnpNnFu5bS0AUhDKrQF4SFelzid1n2gxCqawZwexsKFhOMFaWxfz47RQ/RPWMhgK0RJCLX3m+MZ2ezH8XxPWB/w5RS8um3HIPXHIgmmoZGp1EjPs1kjCHA+Y41Ed3z2jzBV/SYM0C8gFz8I1oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484272; c=relaxed/simple;
	bh=9/r5pGc0syXMlG1sSpc6aC3inL799ywZ/tGalu+3l60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4jypEkM9yeREd8TWmkKQHeWtKzbTZ7PmfLUOHqYz7bZNAxW4bv+0K+VBS9F+OiFjxkxXoZu0vvOxfep/hCLiVGQiQIbdb7gJ5G+9fSPHvWWKUdamtQoW5lZ8B7rTVG8Sa6tIxLr5LwjhjhL4M7EXuVi8qF5JD9RDM19F81/0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=II43344E; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d04fb2f36bso352791fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 15:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706484268; x=1707089068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8xYcjk2qCrA+lcOwLQA0ixbhMQnVA5kQAe6loZvmX60=;
        b=II43344EzuRtLxWRYIYQ1ku2EyINcHsK3HSfV2nWQpeHJcA0w3GTuYug9tzJd6/5XH
         yxZn9cJkOKMRRtausXDKfEyRuGiQvnB9H9s5281jE1h1r3V/YfzBnu2j1CcL3z9s8lwp
         Pv6FUmB2pCp3Y3tF8huGtvE3LYdO6+uKWAwz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706484268; x=1707089068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xYcjk2qCrA+lcOwLQA0ixbhMQnVA5kQAe6loZvmX60=;
        b=k2ndEfpyFBuP4ZD14N/i1HUY4dJkThu5WUhjx+kfxtuaTZJJyz76yCsREQ3DRB4oX0
         p0BvVKNxWcqQlrqPzW6Pbwl4ZqYtiV9geTISwQ68Z2rp0hOnYKcwoOYqqMPJy1GaDCQq
         KT4B/fuOUFG8rgB63T3KOeSw8JgkXS4dE9XiEJ4oUSNf5KLJc7VKTyB7ljBV0/xMOSrD
         /9IaPVUmy5TTrSwE1XkXW9euPTOC9Mi1MRX22Ql6EGdvRdhspf30n9F/eP/4FBcsKhMH
         Go+a+iWD03Wz90r3ST341xHMsnoVhNIhw9W2IJLlSy24kgMngGbOh/MOvgNc7X5US0ew
         R2YA==
X-Gm-Message-State: AOJu0YyU8t+OiVwOdw+9u8c9fk6iee9IR7iKZfEpXEDKDh6HNlWBht9M
	OL4J+WT4IYXaq/896BnVRTigxq1MfiW2X02ZQj9OrVjo3Ci4Qk2xwGJgyWFqroAQLuEtiemK/SY
	ARjr3AQ==
X-Google-Smtp-Source: AGHT+IFqU0BQeelzd9jNakf3WbpD7T9AE4CqFB5L+ydF6XadPLR9/gi/lTn3YThRlsRFCyeBsFDTFw==
X-Received: by 2002:a2e:a36d:0:b0:2cf:2ef2:87f7 with SMTP id i13-20020a2ea36d000000b002cf2ef287f7mr2998031ljn.53.1706484268201;
        Sun, 28 Jan 2024 15:24:28 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id x7-20020a2e7c07000000b002cf2966f94csm947564ljc.43.2024.01.28.15.24.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 15:24:27 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso24643831fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 15:24:27 -0800 (PST)
X-Received: by 2002:a2e:a4bc:0:b0:2d0:4e84:b278 with SMTP id
 g28-20020a2ea4bc000000b002d04e84b278mr160192ljm.7.1706484266774; Sun, 28 Jan
 2024 15:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com> <20240128175111.69f8b973@rorschach.local.home>
In-Reply-To: <20240128175111.69f8b973@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 15:24:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
Message-ID: <CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 14:51, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I was working on getting rid of ei->dentry, but then I hit:
>
> void eventfs_remove_dir(struct eventfs_inode *ei)
> { [..]
>
> Where it deletes the all the existing dentries in a tree. Is this a
> valid place to keep ei->dentry?

No, when you remove the directory, just leave the child dentries
alone. Remember: they are purely caches, and you either have

 - somebody is still using it (you can 'rmdir()' a directory that some
other process has as its cwd, for example), which keeps it alive and
active anyway

 - when the last user is done, the dcache code will just free the
dentries anyway

so there's no reason to remove any of the dentries by hand - and in
fact simple_recursive_removal() never did that anyway for anything
that was still busy.

For a pure cached set of dentries (that have no users), doing the last
"dput()" on a directory will free that directory dentry, but it will
also automatically free all the unreachable children recursively.

Sure, simple_recursive_removal() does other things (sets inode flags
to S_DEAD, does fsnotify etc), but none of those should actually
matter.

I think that whole logic is simply left-over from when the dentries
weren't a filesystem cache, but were the *actual* filesystem. So it
actually became actively wrong when you started doing your own backing
store, but it just didn't hurt (except for code legibility).

Of course, eventfs is slightly odd and special in that this isn't a
normal "rmdir()", so it can happen with files still populated. And
those children will stick around  and be useless baggage until they
are shrunk under memory pressure.

But I don't think it should *semantically* matter, exactly because
they always could stay around anyway due to having users.

There are some cacheability knobs like

        .d_delete = always_delete_dentry,

which probably makes sense for any virtual filesystem (it limits
caching of dentries with no more users - normally the dcache will
happily keep caching dentries for the *next* user, but that may or may
not make sense for virtual filesystems)

So there is tuning that can be done, but in general, I think you
should actively think of the dcache as just "it's just a cache, leave
stale stuff alone"

                  Linus

