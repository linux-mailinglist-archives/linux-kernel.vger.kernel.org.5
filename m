Return-Path: <linux-kernel+bounces-40796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A6983E5D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD80D1C21020
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2FB286B9;
	Fri, 26 Jan 2024 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MScHVDiX"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97124250F9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309347; cv=none; b=gWzlEfaiJZoclqsLmPy/d5KQ6OoRUA4WVu0e2kus0avM+QMoBC/5KCd6vbWdWwk7t/dI+qDZF9wLaM4emqWWgX+AV7MN92NXIp6HcBxY/RFjiphCZ6Elq4Rd3pBKXqishIWoEfPAg3I+hPCOlcOmoH1aeaprNTWkIrJjJudH8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309347; c=relaxed/simple;
	bh=ZC8lIw6nkj5AkxyuI4xf/CiVElrJVya/QfDBrLgEqn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoVRQies9nDKt/jzFu0AFrFXjeSXdtWfPt6ScZsKM+JHvXs3UiLjuuKXbXMCyiLa314qCfnWEoFYVvDoj3Rm4aTvQ09v0dl6UuIThIkSxJlGhzXJ9MIwsQYlrV/OsCdNTW1eBIf7il6D229L+nnHfL6WpQCFS3FwPjBlhYZ7HUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MScHVDiX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cddb2c2b54so8763841fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706309343; x=1706914143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xrhM++a5OFTukQjh6bVd0EodL17OqMY2SHvdwAgkV3I=;
        b=MScHVDiXM6oJ5JNU8P5D4csBM5lGEIPpPeJmXOcjVXbk+A/RrE7R9PFN9l8tR9Vx4B
         HVZFCO0Ui/Rf8VDrgg0Do+wsmppw6CtG0caw9sUdZwk8aQ4uoo3CxTxcGi/+1YEM7nK1
         Yjnpl1WWTrNMga7ZlyQPDjV0f7wiP0mJhMpAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706309343; x=1706914143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrhM++a5OFTukQjh6bVd0EodL17OqMY2SHvdwAgkV3I=;
        b=RwW/fb0N9Xrjnr7NvDe1yugbgRqtIPBsO/m9vQqFmvWMgflzSVmAnmgc8Avq5dhhGO
         V9VDf2Wp/75gayxQc02IfnvgJrvrIGJQRt8z3HmmF2/fxV2oglpkN2tMiPPCcEz4J++5
         hczmLN7bhCYG1zmj5tfAD6d8HDmVvg01/3BycbQVCZ+irM7sTU93fGmcbox3CX8l9dCe
         xYRaq79enorhlzyh2LF2TuXOIqPeLBAvRXZByavX7BpfEyEwkfBjn1dj+7KxkmYYJWGp
         lj/VKCIuQ4hscv3emRhZ3AJrpsKeY3tWknd142d4KwoJTkxjgXfQtOOcvhKkr45zYFTP
         /2hQ==
X-Gm-Message-State: AOJu0Yxluxgt+ueeaqJXs1tRb0uthJSjqquoqlyuOZ1d1Fj3CpmL6q/0
	dQKQls4b4puz9djbxbKdwB4zjdbn/Wame/C1E42qCONroEylo3eoirJ/94r/2tC170l0FBhiA1j
	uRK4VXA==
X-Google-Smtp-Source: AGHT+IHQHhL9FfKaT3yN5GdEvvi3sLTupJEv6HSDvcADRbkXVRyPhwZc7dU+wkM4flRMtbeJcesdWg==
X-Received: by 2002:a05:651c:1550:b0:2cf:2a3e:d1aa with SMTP id y16-20020a05651c155000b002cf2a3ed1aamr748835ljp.49.1706309343357;
        Fri, 26 Jan 2024 14:49:03 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id vi1-20020a170907d40100b00a35168a5cdesm558870ejc.108.2024.01.26.14.49.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:49:02 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a45a453eeso1674964a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:49:02 -0800 (PST)
X-Received: by 2002:a05:6402:2709:b0:55d:31f8:920a with SMTP id
 y9-20020a056402270900b0055d31f8920amr513622edd.27.1706309342198; Fri, 26 Jan
 2024 14:49:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com> <ZbQzXfqA5vK5JXZS@casper.infradead.org>
In-Reply-To: <ZbQzXfqA5vK5JXZS@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:48:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF0ATuuxJhwgm707izS=5q4xBUSh+06U2VwFEJj0FNRw@mail.gmail.com>
Message-ID: <CAHk-=wiF0ATuuxJhwgm707izS=5q4xBUSh+06U2VwFEJj0FNRw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Matthew Wilcox <willy@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 14:34, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jan 26, 2024 at 05:14:12PM -0500, Mathieu Desnoyers wrote:
> > I would suggest this straightforward solution to this:
> >
> > a) define a EVENTFS_MAX_INODES (e.g. 4096 * 8),
> >
> > b) keep track of inode allocation in a bitmap (within a single page),
> >
> > c) disallow allocating more than "EVENTFS_MAX_INODES" in eventfs.
>
> ... reinventing the IDA?

Guysm, this is a random number that is *so* interesting that I
seriously think we shouldn't have it at all.

End result: nobody should care. Even the general VFS layer doesn't care.

It literally avoids inode number zero, not because it would be a bad
inode number, but simply because of some random historical oddity.

In fact, I don't think we even have a reason for it. We have a commit
2adc376c5519 ("vfs: avoid creation of inode number 0 in get_next_ino")
and that one calls out glibc for not deleting them. That makes no
sense to me, but whatever.

But note how the generic function does *not* try to make them unique,
for example. They are just "unique enough".

The generic function *does* care about being scalable in an SMP
environment. To a disturbing degree. Oh well.

                Linus

