Return-Path: <linux-kernel+bounces-91833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CF2871745
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B1F1C21017
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E227EEEB;
	Tue,  5 Mar 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V8yUo6Gy"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122F7E795
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624995; cv=none; b=Z5dXxRiWGhoQC1rb3VERUJcs7jNTWM0rqpsSr0LWcmRLK1jefuacBexfLXRbiG3RJO4m+MPTE1Ys06z5mebpb5MmHjp/OPJx+OkSHP4e0w1ReuMviegrcvpxSpHx3gEjtIePvwXxdDp0z5VGwkqKCu4La+1kAki2Y0ZlgvyDrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624995; c=relaxed/simple;
	bh=G0azDVyc+1/3hvXIMLTl3mAD63L6klmysjz8hmf4lZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTz9K0ZVvx8iAOXH4EtFPN0NnTksJi0ezqMcszykRnYJua9gHbs0nGQ2GbxlGvgZtfhPDaVfAoEq+6OyyPoGGsloevpvuo7m3tTjt0uTN8fMgJKfpJq17VXphKDH8woNuldI4Gcf2m5qssqf+4fSFTxC36tzpDvCGpuq+ONqn2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V8yUo6Gy; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d311081954so61302591fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 23:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709624990; x=1710229790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZTlwIT9w7Ye2oUDZ5aSGoTWx5DRZwVc6z6LT8pMQV8=;
        b=V8yUo6GyeNYTuy7rek+TyyQ9u3waEZkOIy8FgsloyomeRjSMEze/KqUOpaDYqfNkb3
         U+bUIl+z9RYFn6DB0rDEATjW+mhtOI3B1WJct59LucQ6VrmvAnE4E/zwDYvi69lJlXeZ
         2H/c3YCDwfZLEKJUbb79U8ijG6htURPPgpAP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709624990; x=1710229790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZTlwIT9w7Ye2oUDZ5aSGoTWx5DRZwVc6z6LT8pMQV8=;
        b=JwHBtdqI9xWDmaafW9K3luWYkt163MSOZbdxZ2srSkgN6nzfFW7AVpGWTD6kTD5xRX
         wrnaS/RaSu0kK4Jmdt+FUhwa1DQuKjAfXLLg5VlHuS6o/gctFMAQNyQt/3B0s9XWjIc+
         Oy/+/7Dxv6WV+BLBMmh8XCFskUz9CHX0/PokeNvWiWUn4hA+V+3dnBoJ4bEOa/mfht8g
         upiPeCCn5PFbhg+HCNPrbo7ubSzWf59mB6UdKNTT//tJvI78/oseCUbLZQ9xIvJlPaQW
         vscqmZvf5VwXrAuKSObDwS3n+Aj37VipYdwyRn1OEC/ZaAAIB923EdbBzAdGmrD/pj8d
         38ng==
X-Forwarded-Encrypted: i=1; AJvYcCWHKc24YLFGUtLxwGMawHoghLIFIAzF/ZwefAvjzny2Dhs0mnJnS/1IUXpB6ZSedj5C+0TozTgmDGnyE30SdjAe/Lwu+B6k5S4zVWiZ
X-Gm-Message-State: AOJu0YyiLTEDySv1ZR2cBK0GcHZ53E5+TLA4E07JdzBU/jVWA0Qx8s56
	s4rj9X5K8CnUCaU57IezkIQVLGLOMnjVenAjnV0BFHgroP3aETC5Sd3NmcgPo9lALHHfoik5XwY
	lXQ==
X-Google-Smtp-Source: AGHT+IHqQj3uKr6llTKd+iND7qDiUQxpMLHMDRmYxtbqEER4ADeupcJ6ZXxgqujcV8FoZc0RTRApRA==
X-Received: by 2002:a2e:a0cf:0:b0:2d3:ba52:f87e with SMTP id f15-20020a2ea0cf000000b002d3ba52f87emr727797ljm.0.1709624990345;
        Mon, 04 Mar 2024 23:49:50 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id q11-20020a056402040b00b005675882c8fdsm1785413edv.39.2024.03.04.23.49.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 23:49:49 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d2b354c72so4067907f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 23:49:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWT6Ijt9iFEyxWl1SHoIym05ouseu9ZYMqn1tIkry0Hnwrk/MbdYiu/CLL1rBjYUkK1Ry9QjqCwt6fYqVWj4KVJZFeYzkEJdA+bte/P
X-Received: by 2002:a5d:4903:0:b0:33d:f7d2:50e6 with SMTP id
 x3-20020a5d4903000000b0033df7d250e6mr8042962wrq.31.1709624989230; Mon, 04 Mar
 2024 23:49:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228060006.13274-1-tfiga@chromium.org> <c1025094-d9aa-4f4c-bb8f-a486f9953bec@infradead.org>
In-Reply-To: <c1025094-d9aa-4f4c-bb8f-a486f9953bec@infradead.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 5 Mar 2024 16:49:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AOvUtHOOU-OKQKJwyJGXSt6EopcMBsHWz83n_0XfnOjA@mail.gmail.com>
Message-ID: <CAAFQd5AOvUtHOOU-OKQKJwyJGXSt6EopcMBsHWz83n_0XfnOjA@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: menuconfig: Make hidden options show with
 different color
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kbuild@vger.kernel.org, Nicolas Schier <n.schier@avm.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	Jesse Taube <Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:40=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi,
>
> On 2/27/24 22:00, Tomasz Figa wrote:
> > When hidden options are toggled on (using 'z'), the number of options
> > on the screen can be overwhelming and may make it hard to distinguish
> > between available and hidden ones. Make them easier to distinguish by
> > displaying the hidden one with a different color (COLOR_YELLOW for colo=
r
> > themes and A_DIM for mono).
>
>
> > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > ---
> >  scripts/kconfig/lxdialog/dialog.h  |  5 +++++
> >  scripts/kconfig/lxdialog/menubox.c | 12 ++++++++----
> >  scripts/kconfig/lxdialog/util.c    | 19 +++++++++++++++++++
> >  scripts/kconfig/mconf.c            | 18 ++++++++++++++++++
> >  4 files changed, 50 insertions(+), 4 deletions(-)
>
>
> > Changes from v1:
> > (https://patchwork.kernel.org/project/linux-kbuild/patch/20231228054630=
3595093-1-tfiga@chromium.org/)
> >  * Replaced A_DIM for color themes with COLOR_YELLOW, because the forme=
r
> >    has no effect to black text on some commonly used terminals, e.g.
> >    gnome-terminal, foot. Reported by Masahiro Yamada and Nicolas Schier=
.
> >    I ended up with COLOR_YELLOW, as it seems to look comparatively dim
> >    with mutliple light and dark color themes in Chromium hterm and
> >    gnome-terminal.
>
> I guess COLOR_YELLOW is a relative thing, i.e., it depends on the term's
> current color scheme in my testing.

Yeah, it's kind of on the edge of being relatively neutral, i.e. not
standing out much more than the visible options, but I couldn't really
find anything that would work better for the standard 16-color mode.
An alternative would be to implement support for the 256-color mode,
but that would likely require quite a lot of changes in the existing
code (and I'm not very familiar with how to do it in ncurses...).

>
> With rxvt (with a beige/khaki background), I do see yellow.
>
> With xfce4-terminal (with amber/orange foreground on black background,
> i.e., my default from days of amber monochrome displays ;), the "yellow"
> comes out as a faded/washed out/dim orange. But still readable.
>
> Anyway, this looks useful to me.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks a lot!

Best regards,
Tomasz

