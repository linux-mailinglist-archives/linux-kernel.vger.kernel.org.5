Return-Path: <linux-kernel+bounces-31300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C25832C20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EA7B248B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE82054730;
	Fri, 19 Jan 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LXft/6ZH"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6073C5466A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677022; cv=none; b=ljxupW+me8IrsP6YrwJ+YEbkA+mnyoBJVmCtcXVvgTgswPGk3qnUkdZyJ9DgoJKYJJX+x8aW/1TBByKBuqBnhkyAm6sFGkAEzuCR5HamWZWxnM493i60WnmrXZEtCzMjc5DEEAZxJsmshaUa8xNrRzhdPQCdf1Eks7XYUpbx9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677022; c=relaxed/simple;
	bh=7MUkDZsHgwNDnmmxGzFk8wUe9pgxXX+3mpEqjtQaIu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntSaG4VsFbT3C9939B8k7P71x7dihcWEOLtFtMxaf12mOXzpwAbxl++wZeby/USLpvbW+HS5+fHWNHGIdghIMWIEiEFd3nevS9dD5T3nAUm9v70IeSVbkfs/t4L0F08kVxD+w5sSW5KWvuY/IVrR4k0dc36bsVupdr8jX9QEaS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LXft/6ZH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e67e37661so1214404e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705677018; x=1706281818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KtXKclPdzFutX/py/9VWqEzsyGEubd1dSvWraP5dpU=;
        b=LXft/6ZHlabR5Cxes4IBoQyPmA7blnUX06hV2jjq+2TbaaAsyS8gvzzhPj7eoi9zZQ
         xbkH1gbISlM+Ekqf485/1Cg9EeANQnhlzhTEr5DLl5P7VlZ5tcuAmPyOlobSljgQm/bP
         ZDzlJxT1oAnYSU1XY+77DAAinoHz/fQrg+g3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705677018; x=1706281818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KtXKclPdzFutX/py/9VWqEzsyGEubd1dSvWraP5dpU=;
        b=IkKDzqT8+aERAd2LcvaiSw8mN+m77FHymT13oLgrkoHbkF2NuRmliX0ZCyr/AoaMcj
         fDzB8p7HKFvUuTRLDiW2Chym0q1sEaSWug6pGNEuSr+hB64mvXZT6xIpMbVqYIzrwODE
         X0paFnkt/l/xeyuX/sDx1C6F4CMf1ONFZTOGfmpOFhOp5fS19YNzMGLJNHdQeK/OTWQp
         4j8MLYGc1RXhcXgFiNCbvboGCFLEXm4e8jMqBtZHc5vCDGxVLDKr73V5dPkqSihMdYoF
         xdE9QQoY8zjc9M77wDG4zzLKp76eMwSIb467xiz0R5CjmQX1dvLlLOnitKURrEbIWmro
         fLxA==
X-Gm-Message-State: AOJu0YzNEzQfdV1sMWiF0+iohnDMHXCmTczY7MZBK5Vt5OHZHUlh54Ea
	0kvMS5dbgxX54dEgIdi5bu8OGnI8jJUIWAiOKru+NEzskn+lhT3TUfUtsd7tcITZztvS8vegdSA
	YuvsFusvSpEWn1klpCgs+R8/C8UUH5VJjs9rg
X-Google-Smtp-Source: AGHT+IGHoVueohCobselWkMQ9tajk8Uz7EDlsy1pIY4C0yIXEnIImxB/Ha4lJgDyLcxSHgiO/+wGE0IJJ8+3/YqLzNU=
X-Received: by 2002:a05:651c:605:b0:2cd:d5a:7977 with SMTP id
 k5-20020a05651c060500b002cd0d5a7977mr1416924lje.17.1705677018434; Fri, 19 Jan
 2024 07:10:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119084328.3135503-1-lma@chromium.org> <d2329494-2c57-41bb-a9ea-2c9903500d1e@roeck-us.net>
 <CAE5UKNrU9YHoCQr8HLFf9-T4-NobQ4jWtryVqq9okFz8nVezgQ@mail.gmail.com>
 <b65b46a7-c65d-49bc-a5ce-5085da2fc112@roeck-us.net> <CAE5UKNqM6t+nzY-68pVBFxT-_TCjMjDUE-GwRgXp9ny3vqP-1A@mail.gmail.com>
In-Reply-To: <CAE5UKNqM6t+nzY-68pVBFxT-_TCjMjDUE-GwRgXp9ny3vqP-1A@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Fri, 19 Jan 2024 16:10:06 +0100
Message-ID: <CAE5UKNomjYeS-GHEedfHyvAh3jAgPUaD8DkYuJ-Cv0xS6pr7pg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Introduce EC-based watchdog
To: Guenter Roeck <linux@roeck-us.net>
Cc: Gwendal Grignou <gwendal@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Radoslaw Biernacki <biernacki@google.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ohhh, I get it now. Gunter please send reviewed-by to V3 whenever you
feel appropriate.

Best regards,
Lukasz

On Fri, Jan 19, 2024 at 3:50=E2=80=AFPM =C5=81ukasz Majczak <lma@chromium.o=
rg> wrote:
>
> Gunter,
>
> I'm sorry for the confusion, I've just forgotten to add "received-by"
> and there are no other changes besides mentioned in the cover letter
> changelog.
> Thank you for mentioning the process, now I understand why it is so impor=
tant.
>
> I will send V4 for the sake of following the process.
>
> Best regards,
> Lukasz
>
> On Fri, Jan 19, 2024 at 3:43=E2=80=AFPM Guenter Roeck <linux@roeck-us.net=
> wrote:
> >
> > On 1/19/24 06:10, =C5=81ukasz Majczak wrote:
> > > On Fri, Jan 19, 2024 at 1:50=E2=80=AFPM Guenter Roeck <linux@roeck-us=
net> wrote:
> > >>
> > >> On 1/19/24 00:43, Lukasz Majczak wrote:
> > >>> Chromeos devices are equipped with the embedded controller (EC)
> > >>> that can be used as a watchdog. The following patches
> > >>> updates the structures and definitions required to
> > >>> communicate with EC-based watchdog and implements the
> > >>> driver itself.
> > >>>
> > >>> The previous version of this patch was sent here:
> > >>> https://patchwork.kernel.org/project/linux-watchdog/list/?series=3D=
817925
> > >>>
> > >>> Changelog
> > >>> V2->V3:
> > >>> * drop "-drv" from driver name
> > >>> * use format #define<space>NAME<tab>value
> > >>>
> > >>
> > >> I am a bit lost here. You dropped my Reviewed-by: tags, even though
> > >> I specifically said that they applied with those changes made.
> > >> Also, according to the above patch 1/3 was not changed at all.
> > >>
> > >> What else did you change that warrants dropping the tags ?
> > >>
> > >> Guenter
> > >>
> > > The "-drv" change was related to patch 2 and 3, and I have used
> > > "format #define<space>NAME<tab>value" only in patch 3 (as
> > > ec_commands.h is mixing those)
> > > Sorry for dropping your "Reviewed-by" tag :( I've assumed (wrong) tha=
t
> > > I cannot take it for granted sending V3.
> >
> >  From Documentation/process/submitting-patches.rst:
> >
> > Both Tested-by and Reviewed-by tags, once received on mailing list from=
 tester
> > or reviewer, should be added by author to the applicable patches when s=
ending
> > next versions.  However if the patch has changed substantially in follo=
wing
> > version, these tags might not be applicable anymore and thus should be =
removed.
> > Usually removal of someone's Tested-by or Reviewed-by tags should be me=
ntioned
> > in the patch changelog (after the '---' separator).
> >
> > > Alos in such a case if there are changes in patch 2 and 3 and 1
> > > remains untouched shall I send only 2 and 3 in the next version ?
> > >
> >
> > Again, from Documentation/process/submitting-patches.rst:
> >
> > ... the patch (series) and its description should be self-contained.
> > This benefits both the maintainers and reviewers.  Some reviewers
> > probably didn't even receive earlier versions of the patch.
> >
> > Note that the same document also says:
> >
> > Wait for a minimum of one week before resubmitting or pinging reviewers
> > - possibly longer during busy times like merge windows.
> >
> > I could just send another series of Reviewed-by: tags, but quite frankl=
y
> > by now I am wary that you might drop those again, so I guess I'll wait
> > a while to see if there is another version of the series.
> >
> > Guenter
> >

