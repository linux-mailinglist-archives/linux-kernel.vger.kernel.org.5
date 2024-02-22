Return-Path: <linux-kernel+bounces-76196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB57E85F410
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD941F24E83
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70688376E6;
	Thu, 22 Feb 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MHGrapzX"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A836AED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593275; cv=none; b=sW63XbQLw8zlPOmADEPQsho7gyyujLKB8Lho1zmuzheLToDSvPqW1vAwJiG4I5CvMMx97wMWTbbfbUxHy/YL7bj18KMTW/7DyNKhUSrJHQ+wzNvgFmqZoDF+CYScPtRtIZh6/o0mYzmq89qHup1S5aqZGIL1XZaD49+oykiZTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593275; c=relaxed/simple;
	bh=uUWc5RNTkFfpyT5Z/DVXQaEG0/4OqVb6v3u3ZqsaAqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8CtS/Z02EffgCAQwBLXfSmUqd61xJ4j5Xf98w+TM51ynknM7zL9V5Qttg9FUXd2fmP4ynHp2t9yCyT2GgkVGDhM23UmPGFR9X6jsscHDZzaYAgqfuPJWa33mltaheMYja9t7UHvlKb0cGSJRZC1QWV5EUfjMoS7NQ2wA/lEwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MHGrapzX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so2243524a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708593271; x=1709198071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc5x5ZGyO9TbIPJPv7CPAQCydXuBeN2qMipJ6fk1Xss=;
        b=MHGrapzXNv6OEvLADjXsEF9bA1TSt3eg4xjXEcj7B4na49MVlX67c1ur67BLNo81jT
         AoEa6XNuI3P2MHTI8uvwrkWvX6fostIAwOzB7mtG10/Q3MV4wBB1C3Uph1CitugzbIiP
         ZmglV9Pzqeav8U1sR6L55D5YOodQ9NUdFmynw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708593271; x=1709198071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xc5x5ZGyO9TbIPJPv7CPAQCydXuBeN2qMipJ6fk1Xss=;
        b=gAtEwcC/ceIHyu1BMQyXFMhtoyJzDVrXoVuFYmXMdz1gkmH7FNbTz0yfG3FHmzuUEr
         Np1B+Vji+EqCCbKCpHeFr9mjAV2Y2DgaYqhcAbboewrnpc6gb185n/Y9be+5l7B8rM7w
         qZTdkv02D25Ht94QFoy7HqN5RtWrjed7sI6mL2WFNQfT3eAhHc8r4VuYUAAOLIhcWSJz
         aY4M1NvEJcKuFajHmeIft7YOrIaIaIOWQxQL1JPlVWVIJb9o2AkW6ha113cC8T0modcZ
         7HTsFeAae4Rh0/giNZNiyV7JG+dn0OTi9opTXtW+boSHXhnO94vVkqrKCXvIGNVqH3wp
         wUhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOWAoWqFnyEN0o8sdoKvBeDZFb7nh93EuKO+XlIYPL+aRLB8XEDgdwpijtTJCxhpcTniowl/mFDBaxGabkVknoRUZptIrm3tkZA0MS
X-Gm-Message-State: AOJu0YwvFCKpT9g6eFJs2AXYROmY5zS7QknjWKTHqjNZAeIhrU7jIZEC
	+L+/zHzCOEVhENSXMfXMWJvks6GLAs+2ypKXE1YwaVcMBHeStUjOGii57qKKKrv5ENLfYZE8bxd
	QPqW+rjzJqT11yy1SN+e/yyIb3e2ZRWZBD7OAnw==
X-Google-Smtp-Source: AGHT+IE9m7eSBXIsG0RYQV1/BmpISngFJzXpbBr8sSfB1MyQJIhhTzUnde3eNlafKq+TqpYf5GXCHV/9hf/7NgCkKqU=
X-Received: by 2002:a17:906:1cd3:b0:a3e:e04c:45c with SMTP id
 i19-20020a1709061cd300b00a3ee04c045cmr5495887ejh.14.1708593271453; Thu, 22
 Feb 2024 01:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com> <20240221210811.GA1161565@perftesting>
In-Reply-To: <20240221210811.GA1161565@perftesting>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Feb 2024 10:14:20 +0100
Message-ID: <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
Subject: Re: [LSF TOPIC] statx extensions for subvol/snapshot filesystems & more
To: Josef Bacik <josef@toxicpanda.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 22:08, Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Wed, Feb 21, 2024 at 04:06:34PM +0100, Miklos Szeredi wrote:
> > On Wed, 21 Feb 2024 at 01:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >
> > > Recently we had a pretty long discussion on statx extensions, which
> > > eventually got a bit offtopic but nevertheless hashed out all the major
> > > issues.
> > >
> > > To summarize:
> > >  - guaranteeing inode number uniqueness is becoming increasingly
> > >    infeasible, we need a bit to tell userspace "inode number is not
> > >    unique, use filehandle instead"
> >
> > This is a tough one.   POSIX says "The st_ino and st_dev fields taken
> > together uniquely identify the file within the system."
> >
>
> Which is what btrfs has done forever, and we've gotten yelled at forever for
> doing it.  We have a compromise and a way forward, but it's not a widely held
> view that changing st_dev to give uniqueness is an acceptable solution.  It may
> have been for overlayfs because you guys are already doing something special,
> but it's not an option that is afforded the rest of us.

Overlayfs tries hard not to use st_dev to give uniqueness and instead
partitions the 64bit st_ino space within the same st_dev.  There are
various fallback cases, some involve switching st_dev and some using
non-persistent st_ino.

What overlayfs does may or may not be applicable to btrfs/bcachefs,
but that's not my point.  My point is that adding a flag to statx does
not solve anything.   You can't just say that from now on btrfs
doesn't have use unique st_ino/st_dev because we've just indicated
that in statx and everything is fine.   That will trigger the
no-regressions rule and then it's game over.  At least I would expect
that to happen.

What we can do instead is introduce a new API that is better, and
thankfully we already have one in the form of file handles.  The
problem I see is that you think you can get away with then reverting
back st_dev to be uniform across subvolumes.  But you can't.  I see
two options:

 a) do some hacks, like overlayfs does

 b) introduce a new "st_dev_v2" that will do the right thing and
applications can move over.

Thanks,
Miklos

