Return-Path: <linux-kernel+bounces-77312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB36C86039D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4A01C23E84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F8F6E5F4;
	Thu, 22 Feb 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPQUVRXh"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A514B81E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633415; cv=none; b=PozKwQIWs0AZVxY+pnW164nqvjdwwqXxbciMIg8F4h9a6l7Zdxb4Kk+4lVa8eWkc9VGPCUUe/1eOftspf0mFlX5yzZwsGJXStEoYAds103xp9yMI2ui0qnk2w1TBFv86ytURkCPKkd87MEnOK0e14ALv0+OO2z7GizgNsP9y6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633415; c=relaxed/simple;
	bh=4fRBgKaN3slJsS+si0oakQ81lVv2fxpNPglrqvJUjmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXLc/xtrhCVD68U3opmswPsh9KZTDaR2HfhYYIMgGsqOiR4C8/DN1QeBTg3upBtYPM4PiFky8+dm22WUXtKRGKMw8/WHjQkdlVWBhmY5JYxcX8tLJ5qP4/XEOmCB69bLW+sMoS9mjUurRFbz5HwP3Y1x97cHIxUUQkx1edfqhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPQUVRXh; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-299a2456948so192430a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708633413; x=1709238213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4zRRdKL9lsMMNiFrqHRK+mlIK8Wb18NpLnVMWick6o=;
        b=OPQUVRXhjKjTnYTK2k/nV44Obfd/oHhReRXA/1mOUsqDyfrAhdD/9tE5N05A1azN+D
         N43pP2LJJR51xu4Csg9GSzPYVxy6Z9cfoji2n5m5SPBNv6QQ0bNzptQ6toTor1mk4CQO
         KW5g2D5F3Vn7zF3pgaIZ/RpJrrc+QO7lt2kVe8toT5IRpG6XznSAjjgmJptCnMRppPmL
         PPrwhyfj4khFQR+breOkhlZcwG+0AW3eDX+p8+iyYosBFg1oC6oHAqkLu6EH+e7VFIBb
         JBt1niv7UKxrV5WdDcZTQP1P29ncGVQMYnH5hT98DD1857QJJK5hJRhkro6c4/EMDz1c
         nVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633413; x=1709238213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4zRRdKL9lsMMNiFrqHRK+mlIK8Wb18NpLnVMWick6o=;
        b=iSbs77uo1OzSe80AkLpeMp46ZuxkNdZyfOZDejbXHGu3IaUMZTsubBd4292BbSv8s6
         qYPd5d0IoU0b78PDeDHKocmMtvpr04z3kPbBg+8bKXZVsXqgFEsYiReLApHyzgaY6V+P
         eZ2VwN0JbnIH7N3yZaokabQXUWWAEozrmpuLZHZS9NbEFhi54unUofsXQGYDgJ1NjMrr
         XmNTdOVGLl3fXB0AFfDbHAdPyJ2RD5FoEfVsYG4hHRnp41thpXhPSiCKSCNvlBzIp/Ev
         bf8p7wea08x4NHTmbDDd/S5PNvjdbWNYWfWZv9yUyPlMK0Qve67sLrYo1ihYzoIHx1Aq
         e8xg==
X-Forwarded-Encrypted: i=1; AJvYcCVtVVz6Te1Z15wp4z1e85ytZapZsdrwhX1wu9+yvhX9ilz9eO+e9mXUZOEH7cIciRpFJ57zpue8Z2Q6dCBshOg9al248TNWFHGLNYOZ
X-Gm-Message-State: AOJu0YwFNsxonG5dU91YJ+BQtTgw7QsbjDGMSh+TYqKETLX1K7A1xW2k
	yqysDsNB+6a6fCB18KhHOSYQwh63IOhLP3ZQ2kkkgXjNRfri8I0YjmPRy7dW3/gRAvHINdamgBm
	zJKV3CjNh+4zZ2OMf+OKpTXJ+92I=
X-Google-Smtp-Source: AGHT+IEYlyvmciMoWJ2MEC+vVPayK8seyKA+JhIYdvSeWsSf/2H2RqRaxwur2uqaxKGel2jPOVp8zUj+CrLX0nG0JUU=
X-Received: by 2002:a17:90b:b01:b0:29a:4300:e2c with SMTP id
 bf1-20020a17090b0b0100b0029a43000e2cmr3476015pjb.34.1708633413413; Thu, 22
 Feb 2024 12:23:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
 <CAK1f24nk19eciysFqvTd=rqpiKePhstDWEEQ_mvT89WCDNrWNQ@mail.gmail.com>
In-Reply-To: <CAK1f24nk19eciysFqvTd=rqpiKePhstDWEEQ_mvT89WCDNrWNQ@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 22 Feb 2024 12:23:21 -0800
Message-ID: <CAHbLzkoNFn6UE4Hn0gXTm2pLHD7pK4gYUe1zVh3247m30A5u2g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:51=E2=80=AFPM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> Hey,
>
> On an Intel Core i5 CPU, the time taken by
> khugepaged to scan the address space of
> the process, which has been set with the
> MMF_DISABLE_THP flag after being added
> to the mm_slots list, is as follows (shorter is better):
>
> VMA Count |   Old   |   New   |  Change
> ---------------------------------------
>     50     |   23us  |    9us  |  -60.9%
>    100     |   32us  |    9us  |  -71.9%
>    200     |   44us  |    9us  |  -79.5%
>    400     |   75us  |    9us  |  -88.0%
>    800     |   98us  |    9us  |  -90.8%
>
> IIUC, once the count of VMAs for the process
> exceeds page_to_scan, khugepaged needs to
> wait for scan_sleep_millisecs ms before scanning
> the next process. IMO, unnecessary scans could
> actually be skipped with a very inexpensive
> mm->flags check in this case.

Thanks for following up on this, can you please capture all the
information in the commit log?

>
> Best,
> Lance
>
> On Wed, Jan 31, 2024 at 5:30=E2=80=AFPM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > Updating the change log.
> [...]
>
> > On Mon, Jan 29, 2024 at 1:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com=
> wrote:
> > >
> > > khugepaged scans the entire address space in the
> > > background for each given mm, looking for
> > > opportunities to merge sequences of basic pages
> > > into huge pages. However, when an mm is inserted
> > > to the mm_slots list, and the MMF_DISABLE_THP flag
> > > is set later, this scanning process becomes
> > > unnecessary for that mm and can be skipped to avoid
> > > redundant operations, especially in scenarios with
> > > a large address space.
> [...]
> > > Signed-off-by: Lance Yang <ioworker0@gmail.com>

