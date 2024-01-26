Return-Path: <linux-kernel+bounces-40624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF90C83E356
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DD01F268FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909F522F12;
	Fri, 26 Jan 2024 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JAlkxanp"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0776208BE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300727; cv=none; b=sRwlgY5ZJeWXwJ3i4ikQTaApAW+eSTZjXxG5tURid+Z+ke6G6aJ+UYu4Kc9M6PjmrL9oYDGxL/81DRHH5Gsq/+l3Pgd/uqy245V1RIhAyY7w/IWgJdUUi3wRTBC6p/EOpZyAs3cDaGO862HakYu7e/jRAA4cFyDuTuU4jSFGNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300727; c=relaxed/simple;
	bh=9+OPO3V3SP3LRuHvDOl2Rmxreo2UCuuZVrw9wtlT3Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhUXvZqIP4s5EM70BU16hhcYDNHVDXcT3w6dzsaVLzaCdsBEm8YIFRZBlk8ZVqBY22xUiF4sm/b+7RvLhZY0jBTI8GtC7w2s+M0OZpqRm9ZT5+PNv+p1hYPgAZSDYuYWSEdly1ujvnSrQvqSpHi97k+sKhzSoil6J2CI6LGdJiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JAlkxanp; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso9024181fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706300723; x=1706905523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ANDDmreLZfT1WX/HwjJ1bWT4NTPKcyNOAiea0NIAPr0=;
        b=JAlkxanpoLQwav1GPCk1OY/JE/f2A0UcBuMd5FJMTGjZufCYqLY0kgTKrRextqe8Px
         1lExEqpaL6Y1zKiS/teMgBHCkft+atkQX6mvQu0YVwOfkPEvl6H82IBIwNR2vq+Eyozz
         79IDKYQSnFSYGAZDKcoJOPEG13nU1hxIbJrXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300723; x=1706905523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANDDmreLZfT1WX/HwjJ1bWT4NTPKcyNOAiea0NIAPr0=;
        b=q9Tc7B+NJsojoFBzE1C+e2xnEuRU2lv3nMdiZ5aNvRwhVbAWLm/R4c3TL4aqfTNrXp
         NnDnGhA1OdH54MkQR1LpoMixQKA7yLevTf3LY45gevYVuPSFTPY1cLJXnbH+8+HdLaZD
         rFXze7plV9T7c58vuC/j9/00BNTBqesQoTBnJRiT27e3Or3SZeGsfaCpd/+OcBLdPHn5
         utavCeejaaUwH8eynIglRJ750D+ya7CA+t8DiU97eV90Vs3Xp3IkHkaWZRReeBvSNjc5
         nOxRu5n9eDjwnEsN9BJM/nxPZF13V19g0inSzlCuOedyDtrf+tI4mJ9Q9XHiFbN6YRMQ
         E6yw==
X-Gm-Message-State: AOJu0YzoDAJrvVQjLnoCAC2ACWFSgLRhLrAMfS5QdbrePLR+rxmXFxtz
	qBcIL72LX6CiGvc8Q91BcNjytQHD3eOE6QTg078H5ZKe4jknxakrvz0LedtoT5SJMUb58djL2Se
	96EWCKQ==
X-Google-Smtp-Source: AGHT+IEkF6YCqFRZft+fFb50qCDD/sjbDF90Mu/stpW9swdSOwg1qlK5kwXGgo8J5TgehM7CziAp0A==
X-Received: by 2002:a2e:a984:0:b0:2cf:1920:97 with SMTP id x4-20020a2ea984000000b002cf19200097mr582608ljq.12.1706300723271;
        Fri, 26 Jan 2024 12:25:23 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z14-20020a2e964e000000b002cd35d8b018sm251139ljh.113.2024.01.26.12.25.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 12:25:22 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf161b5eadso8126981fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:25:22 -0800 (PST)
X-Received: by 2002:a05:651c:107b:b0:2cf:4170:d181 with SMTP id
 y27-20020a05651c107b00b002cf4170d181mr392047ljm.7.1706300722280; Fri, 26 Jan
 2024 12:25:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home>
In-Reply-To: <20240126150209.367ff402@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 12:25:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
Message-ID: <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Steven,
 stop making things more complicated than they need to be.

And dammit, STOP COPYING VFS LAYER FUNCTIONS.

It was a bad idea last time, it's a horribly bad idea this time too.

I'm not taking this kind of crap.

The whole "get_next_ino()" should be "atomic64_add_return()". End of story.

You arent' special. If the VFS functions don't work for you, you don't
use them, but dammit, you also don't then steal them without
understanding what they do, and why they were necessary.

The reason get_next_ino() is critical is because it's used by things
like pipes and sockets etc that get created at high rates, the the
inode numbers most definitely do not get cached.

You copied that function without understanding why it does what it
does, and as a result your code IS GARBAGE.

AGAIN.

Honestly, kill this thing with fire. It was a bad idea. I'm putting my
foot down, and you are *NOT* doing unique regular file inode numbers
uintil somebody points to a real problem.

Because this whole "I make up problems, and then I write overly
complicated crap code to solve them" has to stop,.

No more. This stops here.

I don't want to see a single eventfs patch that doesn't have a real
bug report associated with it. And the next time I see you copying VFS
functions (or any other core functions) without udnerstanding what the
f*ck they do, and why they do it, I'm going to put you in my
spam-filter for a week.

I'm done. I'm really *really* tired of having to look at eventfs garbage.

              Linus

