Return-Path: <linux-kernel+bounces-82411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D2F8683D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021E01C2419D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948BE1350E1;
	Mon, 26 Feb 2024 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="URxK7Ovq"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D31350E6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987071; cv=none; b=eN5O9XCMIFywlYGFtWixscLpp/nhVsUFlk36djG0PRmlRwb1GP7ri20PEpzEaHspgd6rX1nzNRPt3g9ur/QK2TEx2mu9INWM3rlhko2jph4o2RaFeoIchFQ/MIv6q1aU4Ifc3RG9rK6cKmCLla3hFeMUe3+EQxqjQ1NS0Lvz2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987071; c=relaxed/simple;
	bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZitWuD/AdFnfu+wtV0KS33mxGTkHynVKLZKgUhC1LoWb/RXigQ8VKP+28fvYzl9RecjTwPDsAF9PX8seZuOylkCG5RJk9xJN8yP07mAsLv7XxG60YSTEa8AD6p9NCIRlYJ1Y9Z6+fD2gn3cmC0A9kR4VGDKFrz1HgueeYH2yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=URxK7Ovq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so3825262a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708987066; x=1709591866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
        b=URxK7Ovq6mgCNT0pAEqBb/3M/wjnmM/LSxXpmCakoJ1ePWBWfexAdkcuSxDKu8qmrw
         wnZfWZ5v8j38ev4wD9Zz2QxRZsrZveUstPE5T2J+pr21rnoxIcx01LeSJWlF8Wyq8amw
         5pNEpFVJPmJG9/uQTS6blToY7w/7Uk2TQ949U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708987066; x=1709591866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
        b=DMZsNQ1LyJwrta75+FLTv0nJquXprwr95+rrcLR3WOZHOteMzqywvbT++INQsnJ3Hq
         GMqEk/h3BoLW2WklhOG4nJrY8uZTLCop0M4iHxeScoTp9RSnsary88JR/fOdxrP0OK03
         XayPznuxvE2BIk1ly8zq+Riuur5l6edPhP84SdQkYvpu37rHwEEz3rkaD1GvhHVqg/Ns
         K7awn3isnyMq4osPNIsfnJh/ObJg4DKryFY6FjMbnEjUoWf802GBG2HbA/oOFtPMQARn
         YRhZfNYZiCgXc9l+LcZT+EYs+eYbkLwQj4nQzHaQSbkT+acHqFlV8gNaib/bK+a1tEVH
         L7vg==
X-Forwarded-Encrypted: i=1; AJvYcCXID4HPgGotsnehG76nKX+yD/MyYN63G2vYbKiy8YWQF4vPjYPvEirmgnhTyF/MZz3C5bwRWLebeed30TlR2n4jVNlIYlPUknp5Dwpy
X-Gm-Message-State: AOJu0YyUPXiIQmzS4r6SdnV7wXJdsLJ+OChvpgAy7Kno6V3NiGPn5krY
	suzZO5qOq/MmmhoUtu1zBBix1URl28FlxJr+bAwMKhK2a1vWs5BXPLtJ+Z38FNHZewjVtgw2EO9
	FY7xE
X-Google-Smtp-Source: AGHT+IEirlZMBCdksBvSp3s1NaqrTBmbD6165jDuITQqgiVHwoPjqI0NWqUu1e68DckVwBwIJOTpOg==
X-Received: by 2002:a05:6402:b19:b0:566:16f4:23b with SMTP id bm25-20020a0564020b1900b0056616f4023bmr512434edb.39.1708987066440;
        Mon, 26 Feb 2024 14:37:46 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id 12-20020a0564021f4c00b005653ec140d3sm164107edz.79.2024.02.26.14.37.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 14:37:45 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so5285e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:37:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhHSYoMVEC1Z/FvSTWx8Ilauh0edscrA4bYtaaPbIudggwaL3LogrZXD/oDhAMwQznvq1USIwgR6hUWb/7Bgq914sUXPqHGyxUNQHL
X-Received: by 2002:a05:600c:1d8b:b0:412:a80e:a5cc with SMTP id
 p11-20020a05600c1d8b00b00412a80ea5ccmr30242wms.1.1708987065108; Mon, 26 Feb
 2024 14:37:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook> <202402261123.B2A1D0DE@keescook> <1405e4-65dd1180-3-7a785380@32026879>
In-Reply-To: <1405e4-65dd1180-3-7a785380@32026879>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 14:37:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>
Message-ID: <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Kees Cook <keescook@chromium.org>, jannh@google.com, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, 
	Guenter Roeck <groeck@chromium.org>, Mike Frysinger <vapier@chromium.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 2:33=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> > > [...]
> > > +config SECURITY_PROC_MEM_RESTRICT_WRITES
> >
> > Instead of a build-time CONFIG, I'd prefer a boot-time config (or a
> > sysctl, but that's be harder given the perms). That this is selectable
> > by distro users, etc, and they don't need to rebuild their kernel to
> > benefit from it.
>
> Ack, I'll implement a cmdline arg in v2.

Any objections to doing both? Have a CONFIG option for a default and a
cmdline to override it? This way if a distro wants to restrict writes
by default then don't need to jam more stuff into the kernel command
line.

-Doug

