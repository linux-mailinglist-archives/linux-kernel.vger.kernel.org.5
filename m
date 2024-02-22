Return-Path: <linux-kernel+bounces-76562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D685F933
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB3C285331
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B06133284;
	Thu, 22 Feb 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Yc3SpNAl"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94AE12EBCC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607455; cv=none; b=ufjn4d9glDiXbvW7eXBtssZUFubifE+2ynIxPC45CEjzEXo/cRIJOEvGbu5+padhn9onfpOtya3uuA8uX86mSb0naBYWfX8vJ8Ep8LaENadDHICd4mjoYFKq9MtOEqHViU94pRu0cKBxZqXH2PH1T4BigamHucytxVAcAEColIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607455; c=relaxed/simple;
	bh=SGQVs5xxceT8/USGNqqeQ6uWxE7eZGHnoNAkPYvICYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxJ4ObfgRKzOqVVVYh1+C0iMqpHn8jTDTqYv91pq2KJ8yatjCo4k9WZISXPiT2Hn0lSsh0a0MaxlWELcFS9+DZEJE60qzg74fMZtM0DBjuE+UazI+WwuBRg+xN9vi160pfpTra3y6lPR38yhZj5Ppi+Vy2TZ6x+mrC+953PqQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Yc3SpNAl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e75e30d36so150483666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708607452; x=1709212252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=se6gwk0fwHmTpR5MGtDkHZ8SwA4LJ2DR5cRZWhWZG0c=;
        b=Yc3SpNAlrmTHJGX0w2qrDJv0r3ScLH1awPDKhzSWU7MZNWrAhrj8hI/Z7Zu3msbQCX
         JEXO5xYeavatsIIlwbLwxXorZFZhWkvpqpP3jUAmj5PNp5OXAg4xwXWzkAD3fC+TtbuJ
         TA61CmzecgsmGHK1eldjxeT1t2Xwt9W2mo0oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708607452; x=1709212252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=se6gwk0fwHmTpR5MGtDkHZ8SwA4LJ2DR5cRZWhWZG0c=;
        b=XfX51xIWbzTaWNqPCtpK4IX85NnJTI3EPBQg+45RxjJ9KmSfMwZWU7dXYZoVtFvyaI
         cHemFAiK3hUKUheCoObnKG5dA6A6EgwLZTkI9ZaW1wFFf4nSsecgl5hoJUMpxq/seRZ2
         NcclH+r3sx3QF3ArBzM2J4jdRWL0mYNsjUQrW35FbKF2YH2fzv/ddFQEVL1AuVBvtlaZ
         jgrV7js62VcSTZjc1o4NkY+D9Vbzp7tAfxeC1BzjQHxHbYDWmRmJPzRvoFDsdiyF6QTl
         QlLvCb2qFmGSW9z2Bw3xYDKlTG+Cc53uJ7cckmxIdFDwMTsox7cIbVglCHGlx6iqMaBJ
         4pBA==
X-Forwarded-Encrypted: i=1; AJvYcCXkTLrlKsrCy0JPjYxfp7mFwdmE6bwEjl7wuPqq8Q3UzQxStry6/Dc0jy+T+iGacCkSHP631dZXs+s8eum3xBGFx6lGXqLeTFRHIYlR
X-Gm-Message-State: AOJu0Yw/h59oHh4RkPl3U1SnImklFvLH/g0t774NqSxJ6fNxZPv83V1k
	LIuUx3d31M+Ao9JJBbdzFtD0TDrzmNUSVurVWjdTzrofYiBbYukRhhgBr6xCLQzEQv2GdXI5upi
	EALwqKNpHwd5vtcc/KhKdIX+mDn3fVieJal3hLw==
X-Google-Smtp-Source: AGHT+IEKz+crKs+wjRqOw0ZOK6TJKCGag7XXciDUGUNsfdyRPPgjaSMU2GrS1sJv9HgRuG8BjodWUuYih63QgGNfnfk=
X-Received: by 2002:a17:907:76f7:b0:a3e:b57f:2b8a with SMTP id
 kg23-20020a17090776f700b00a3eb57f2b8amr2222160ejc.10.1708607452084; Thu, 22
 Feb 2024 05:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting> <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
 <20240222110138.ckai4sxiin3a74ku@quack3> <u4btyvpsohnf77r5rm43tz426u3advjc4goea4obt2wtv6xyog@7bukhgoyumed>
 <20240222114417.wpcdkgsed7wklv3h@quack3> <2tsfxaf2blhcxlkfcagfavz3mnuga3qsjgpytbstvykmcq2prj@icc7vub55i3p>
In-Reply-To: <2tsfxaf2blhcxlkfcagfavz3mnuga3qsjgpytbstvykmcq2prj@icc7vub55i3p>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Feb 2024 14:10:40 +0100
Message-ID: <CAJfpegsinKngjHmZPxXvGULusEw359FhBkVh4A9O_+pqccjUzw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] statx extensions for subvol/snapshot
 filesystems & more
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 12:55, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Thu, Feb 22, 2024 at 12:44:17PM +0100, Jan Kara wrote:
> > On Thu 22-02-24 06:27:14, Kent Overstreet wrote:

> > > My intent is to make a real effort towards getting better interfaces
> > > going, prod those maintainers, _then_ look at adding those hacks (that
> > > will necessarily be short term solutions since 64 bits is already
> > > looking cramped).
> >
> > OK, fine by me :) So one thing is still not quite clear to me - how do you
> > expect the INO_NOT_UNIQUE flag to be used by these apps? Do you expect them
> > to use st_dev + st_ino by default and fall back to fsid + fhandle only when
> > INO_NOT_UNIQUE is set?
>
> Shouldn't matter. If they care about performance and they're in some
> strange situation where the syscal overhead matters,

If it's expensive, then just make the overhead smaller (by adding fh
and uuid to statx(2), for example).

Using st_ino is also racy in some filesystems, due to the fact that
the ino can be reused.  If userspace is converted, it should be
converted properly, there's just no excuse to add conditional code
like that, which makes things more complex and less reliable.

Thanks,
Miklos

