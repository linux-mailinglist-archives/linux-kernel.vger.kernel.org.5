Return-Path: <linux-kernel+bounces-159142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE198B29DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49607285677
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5656152DED;
	Thu, 25 Apr 2024 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPBq9nQa"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289C5B699;
	Thu, 25 Apr 2024 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077080; cv=none; b=GRDjPqykNwgpkD4IoL5obkwwG3zkQdgAQmYViJ4iDPFpoU1ibdU+wFruEHX2HjZ+XDSwgOzV1/S1IP2ZhjesOt7wlmoyHaBNcFKJ9GTfpEaVjeLmOzqRPtoY4avxKxyaaomgm7tRFROMViy/5WuxtIvANs+YmMuW800CWkMr9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077080; c=relaxed/simple;
	bh=zyZPxOpHl158U6ts8jALBsekAk+1ybCyoOuIqC2LHk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7PfgdDNnk24MeBaeBnXPImyVEquXQkFw2oVtX5uZYBv86neP0ffmacodO7oqruX0vd5908gmVV2q3i+OWEd2UcqzKSdwrCjSc/SHGMyYIxTPlGwSddFS1Tnwn3In0b53v8QnVsOdlQYSWHKPtneYnyPcMaZ5ja1nDoW6IN2qfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPBq9nQa; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61b4cbb8834so15453767b3.0;
        Thu, 25 Apr 2024 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714077078; x=1714681878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyZPxOpHl158U6ts8jALBsekAk+1ybCyoOuIqC2LHk4=;
        b=CPBq9nQawqKpqQfKxRUjxWa6lXCJQWHDr5iXMGiKkh/0JUlYr4wXXBH2Vx2OyaE0cm
         sbgaSJx3TAd+VxdVEFylIcC+e7nreVAQICoqS2V43P0wTo8aWXluK9yC6bD35Zh5yr+K
         RrUHp5q8xA5EEIUbUCGjm+sbjIYNoAS2t0jmykADqpTF9qhN4S5p1ZUaU9OgWHbMeJ6k
         b/TFYfdD3ztBIobCD5l8LM9CjZpdViJ/CrrCeePNDqEov8PIdr8pyaLVY7XYi+QRMaJg
         +LLcEZ8YitC9+MhCZMs1kBDLw9OzrGVyklo3F/OYmGxQIEvERFT5yxlJKfHP9NrEh0w3
         ByVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077078; x=1714681878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyZPxOpHl158U6ts8jALBsekAk+1ybCyoOuIqC2LHk4=;
        b=GRXiIbtFLR6iLuOOV64/7GeQ2YU1pFTA29vs5KrkkLv1MJTk+U7PWjzYQKS8THpNUa
         zMmcZjQUzCwgZfhWRXaYCsmMh4aUiipubJpjpc6uUvsGlu+xf13UPpQNpcGK+arYzamu
         v+Z4fUEggdCK6QWbnNjhuX0TydDO5A/2XJ3/6sy4E5c8uIm8+Fts8DRoylu+J8vfDPMc
         4dI5ngtPA/mYEPBZ4WRhXpTPA4yfdOG+i9knwYJMkuVrp1ogQMsd/noxtdedl0BbhmZh
         y0I31bnzjGcl7hjK6GZV912od/b9+7ycLleexsVoLz5BO0H2vsOBxvji/rahWYd5dh0Z
         uPRw==
X-Forwarded-Encrypted: i=1; AJvYcCUvX0A8kq5mexgItTrHdn4LhoSUqs4JOBAB74i7u387RuKa0xFmkAAO2/iOdoxtX+cCGRaKQCk01DFzwr3v0MhYPX/CK3yuq/sLcNs5Voi6oqC8RscaPNLq33Gq6H8L8A5Lq90mmLgT
X-Gm-Message-State: AOJu0Yxxq6J9YXs6ADFRtpm+F8vHHe0KDTZfUyo2tR+mSeb/iFbKBnme
	dkUSX/UUJbHxH4BPYQKCo9aWZDb5rq9FWY56BKtdZciz3n9gcqvmE1lfLCuxWNl6vkw8A6xXQEo
	EXjuY2qxqfWddBH6cq5/3yD9pUj4=
X-Google-Smtp-Source: AGHT+IEjJgjO65+XDMa+hfWXfBTq9pXj6Abb1ra168h/A9VCLxkvdSnu6imAcY/Le2FePqf60bjw+2v86H6KtKDzKug=
X-Received: by 2002:a25:1542:0:b0:dc6:d808:cf75 with SMTP id
 63-20020a251542000000b00dc6d808cf75mr764701ybv.20.1714077077472; Thu, 25 Apr
 2024 13:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jz0X=CKR1POvF41oEumrq1z=MVWPdF2ECbzV6-rhht8-g@mail.gmail.com>
 <ZiGYbJezGZg6tGgq@dread.disaster.area> <CAJg=8jycPX=fQskUb=48g=AS7-uUNAVKZyZ+tyAC5uGYwfpabg@mail.gmail.com>
 <ZiWl2MG5f0wAp7mM@dread.disaster.area> <CAJg=8jyZuxsUX+oNU6O_L4LNOVs21xVKTDi8ywPfDbj+cAxegA@mail.gmail.com>
 <20240424034232.GD360940@frogsfrogsfrogs>
In-Reply-To: <20240424034232.GD360940@frogsfrogsfrogs>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Thu, 25 Apr 2024 13:31:06 -0700
Message-ID: <CACzhbgSdDBzTyqc3ci17U2DG8GKo=Fq=H3c+eTM7J5u_Xh2QmA@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in xlog_cil_commit
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Marius Fleischer <fleischermarius@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	harrisonmichaelgreen@gmail.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marius,

Thanks for the bug report. If you can reliably reproduce this issue
and can provide a patch which fixes it, I can add that patch to the
next set of 5.15 backports. I am a bit limited for time at the moment
though and trying to work on the backlog of backports into 6.1.y as
well, so I am not sure what the exact timeline would look for a 5.15.y
set yet.

- Leah


On Tue, Apr 23, 2024 at 8:42=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Apr 23, 2024 at 08:05:22AM -0700, Marius Fleischer wrote:
> > Hi Dave,
> >
> > Thank you so much for your detailed explanations!
> >
> > > > Do you think it would make sense to backport that patch to 5.15.156=
 (the
> > > > LTS kernel)?
> > >
> > > That's up to the 5.15 LTS maintainers to decide. They also need to
> > > weigh up the fact that xlog_cil_kvmalloc() doesn't exist anymore in
> > > the upstream code base. i.e. we found other places that had the same
> > > kvmalloc() performance problems, and so lifted that code up further
> > > and used it in other places in XFS....
> > >
> >
> > Understood. Please allow me one last follow-up question. Did I add the =
correct
> > maintainers/mailing lists to reach the 5.15 LTS maintainers? If not,
> > how do I find
> > the correct addresses? I used scripts/get_maintainer.pl as suggested he=
re
> > (https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.ht=
ml)
> > to locate maintainers/mailing lists.
>
> You got it correct -- Leah is the 5.15 maintainer of record.
>
> --D
>
> > Wishing you a lovely week!
> >
> > Best,
> > Marius

