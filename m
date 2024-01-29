Return-Path: <linux-kernel+bounces-42069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8046883FBE6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A2C1F21EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D35DF55;
	Mon, 29 Jan 2024 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EPoje+CC"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A34DDC7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492573; cv=none; b=qTEj+huiZZQEaAkkmkwnhImcfq+GDBGAI69GRZN2kXTAj/vcEtqeLCaf8gnOYvjfsgZ84yQykfRiDTqMsucj7P9OXk9j3YvSREt8hEHbJgYpPQC/ll4OZ3zOIn7PfjeefN7QOrG7eN859TSUDDn/HG80A68ksKLRF1sYuO6/B+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492573; c=relaxed/simple;
	bh=jWloI5phTfFMjDxmvM5fOgnQ0vyxnALm4mf/sCbpm20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn+Y7V6ziid4XNRwwJYBOUjqa4sS3XJRrZ/lc2I8jw3TSTYo8HVRsSIMygHuEb3U8Ic7MjytRiSVw9bxfb3ii3caDOfDSPqXe85SVSo9hyDWDc5427z0Mj1ED2DD6+xhAJG4ea0DRPPnuOjZpxZhuaxRGmhXj750DIOH5+vDPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EPoje+CC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso25411321fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 17:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706492569; x=1707097369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmwJigiCm1y/pWMgjrvap0eEiQZ4O/kCC0i78tTYfew=;
        b=EPoje+CCAclWIpjRXfnDgG3Nz6WnRC8FZSxgmqIW8oLuvFk+EL2fhnGYmcDKWsV/u9
         j93QXlJX/RY1WivxAJHmBGl9sJpY6s9dD0nYkITI45Uv7aQUJotzdrLn9RYZQ0R9MlzE
         Yt5wBhzMZUpdxTvQLImF0fnPd/gzDtDsBwUzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706492569; x=1707097369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmwJigiCm1y/pWMgjrvap0eEiQZ4O/kCC0i78tTYfew=;
        b=lYJyeQ+NDOFFOvKoKOriUEWLKNB3nLUN8hQ1xYK0Ae6o8G4Xqh+ETFHv88y/1IDmoL
         ovD1S49kXVyez8Jk211y2SLC1Xdd2cyyB7Wodez0ZFUzYWGSWCaKahlEVbvvEvdecuwK
         whB1DJbmUiGcq5HTM3nWRmO5OyJK5a/scslnWvxphrDyiubHl67hHc94t/6sZlooHn7N
         T9SqNHqGsPQJTZOdl0nCD/G60thz3tjuasSh5liWNtZMW6KeSaMpUf/HxSth8nyDau5d
         C1+sSGv+t2ru2Z9b8b2CS8MZ15xgdJ+3qEDRN5K0qmUzgq41SgHfbyk2JPuslZ52JH1n
         oj8g==
X-Gm-Message-State: AOJu0Yx9F9RWHfdBzGYpnV48NaiVfWZ4fDLPkSRX1gVkOxAqg14nH5dj
	DN48tc0UFYvsi9GZgpqBhExPXMfTN3vAzTLrgp9O/I/Cah9awVSAUSUDkcpZUgfVA/L04llD8mh
	vwdg=
X-Google-Smtp-Source: AGHT+IEhssYfCmHSam59b7Vp/3DXKRKTt1QEOO4oc4Ry7XXBnSZIiEVp7JZyKoGjXybj+rTLssacwA==
X-Received: by 2002:a05:651c:2209:b0:2cc:a66d:3356 with SMTP id y9-20020a05651c220900b002cca66d3356mr3926619ljq.11.1706492568783;
        Sun, 28 Jan 2024 17:42:48 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id c9-20020a509f89000000b0055eb53aae03sm2256123edf.94.2024.01.28.17.42.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 17:42:47 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f13b682d4so4282a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 17:42:47 -0800 (PST)
X-Received: by 2002:aa7:c70f:0:b0:55e:c2d9:3750 with SMTP id
 i15-20020aa7c70f000000b0055ec2d93750mr2555420edq.5.1706492567478; Sun, 28 Jan
 2024 17:42:47 -0800 (PST)
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
 <20240128175111.69f8b973@rorschach.local.home> <CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
 <20240128185943.6920388b@rorschach.local.home> <20240128192108.6875ecf4@rorschach.local.home>
 <CAHk-=wg7tML8L+27j=7fh8Etk4Wvo0Ay3mS5U7JOTEGxjy1viA@mail.gmail.com>
In-Reply-To: <CAHk-=wg7tML8L+27j=7fh8Etk4Wvo0Ay3mS5U7JOTEGxjy1viA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 17:42:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKagcAh5rHuNPMqp9hH18APjF4jW7LQ06pNQwZ1Qp0Eg@mail.gmail.com>
Message-ID: <CAHk-=wjKagcAh5rHuNPMqp9hH18APjF4jW7LQ06pNQwZ1Qp0Eg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 17:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>    mkdir dummy
>    cd dummy
>    echo "Hello" > hello
>    ( sleep 10; cat ) < hello &
>    rm hello
>    cd ..
>    rmdir dummy

Note that it's worth repeating that simple_recursive_removal()
wouldn't change any of the above. It only unhashes things and makes
them *look* gone, doing things like clearing i_nlink etc.

But those VFS data structures would still exist, and the files that
had them open would still continue to be open.

So if you thought that simple_recursive_removal() would make the above
kind of thing not able to happen, and that eventfs wouldn't have to
deal with dentries that point to event_inodes that are dead, you were
always wrong.

simple_recursive_removal() is mostly just lipstick on a pig. It does
cause the cached dentries that have no active use be removed earlier,
so it has that "memory pressure" kind of effect, but it has no real
fundamental semantic effect.

Of course, for a filesystem where the dentry tree *is* the underlying
data (ie the 'tmpfs' kind, but also things like debugfs or ipathfs,
for example), then things are different.

There the dentries are the primary thing, and not just a cache in
front of the backing store.

But you didn't want that, and those days are long gone as far as
tracefs is concerned.

              Linus

