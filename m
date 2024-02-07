Return-Path: <linux-kernel+bounces-57057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABA384D380
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A5D288A19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54345127B50;
	Wed,  7 Feb 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ljSFTzJ9"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049FC127B64
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340313; cv=none; b=hN55cMMYRRZwHQWLL0i0tnWj9AhUopEh1HenKXgVqVSN+t80wVAJDA9pQr7tPQglzUuhoMfetMev6FdzgqC/DqdAkLDQ3Uz99wgIqQcTNo6egPdFuY98UlUZkyAkLrN9e0Hxs8uU+GcpFk6UJO6vZsypGou+6zRX6dvCf6bz8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340313; c=relaxed/simple;
	bh=pW28iX6KIVBtvtjzICL/te0QeihY9cawvgUOGVCQrgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1PrzrqP7oVUfLofByfiakdu/wN1X8VXcdpaVkjd86VPsqfgpgUbB8A7JRpM1vovxNsKpU5eJ7w0Ww9mLU0F/qoCnszwkzxV5uiVvd8uYexYwaKPQ9P5Gk6MoWbG2G8jNTZZ4ebgmKbKS75t9B028geiYdaDDdxpw84f8iVnChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ljSFTzJ9; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a99dc9085so44641cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707340311; x=1707945111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW28iX6KIVBtvtjzICL/te0QeihY9cawvgUOGVCQrgc=;
        b=ljSFTzJ9btyq2arL5dnTtWO0oiqo+ehG7d8oshtnfGoR2dXB0q6TMX9tM+y3f4nUrv
         OncqqALO5YwZlkbizs2sia7Jn/k+iy71YLwVsbiT7mdltW9JYnrOktmLZ0q4LRoL4M1/
         Y9kAnHSXnpZkddZnMlUoE+LzOJwWCwxEn30cvzBrJHW/F2jfWrmKO9pGDhzDIhsakJ/v
         nZecCUDi3iUsliK9ky5URuL8FWPnfBIZ2eUFzatSvY32z9pB6sKCV3coAgvi5NS93MOf
         JywEL1lGJ3K2HR5RLuXW1H3bzlDIseDmJ0FhJMEwpuxbMtCbYIyWoK47GCO5eGChtbZZ
         WsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340311; x=1707945111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW28iX6KIVBtvtjzICL/te0QeihY9cawvgUOGVCQrgc=;
        b=cIylfwFWzvrRYzjgVesL/AhB+cQOhu4NoW+5EGkix3vOGB3vm+zmvff/K8GrWpJCtC
         qWZdcC/kY7LAMCORhf3XV6KzpTiF8Nhen7QmbyxbihAWWF1XuihALk8EVzULPCiFAMf8
         XH3k9cRi0hdUGTYHW9D0gejHeq7X2/+IVYhPmF//vkVPPfU6yVH3EQCo8xhCrZt7GTlA
         VWI0L17m+4bi9gOmYMlBhTpdJpMsfGf9DfFzElqTrqXnbN6y9fozVP1WoNTnea5nvAd3
         gK609Vp072Gkpi8b6XBFebnPkZ9SEsskKcGltmRG5EiKAHB1ltljZEjEcTO70Bv1qXr+
         MpDw==
X-Forwarded-Encrypted: i=1; AJvYcCWINEEl1H9ApJmlzIumIdj0RNu/+9BmyM+iAPgI/G1gR2vSyitNTjWBFVBzKBaORqe/juOP9atOt8U/5fWpaT8wecbW6Ww01j8qd7qN
X-Gm-Message-State: AOJu0YxEf4dRVWBaseDIjGLlkC4+Ib4sxZ/tB/6Qa/J+/Ekp5Nbd54CG
	GUjZTyK/1Q8JNrDWr2/rqnBMY3mzbATmKvwmrtmN0xpHkuIeOOLNe+yyh51t74JX5/BPEqOO/5w
	zMVhQ4OEENrceG6PK7DDrCkIqq6X9efVoGonG
X-Google-Smtp-Source: AGHT+IGjkQ4vwciNuicvZuMpXoICkkqK6RD7xqZv/i6SCSru8J2w2x3R+ElthRxkYJ7ULf9xIwKRFJEMFfdx31dRnTY=
X-Received: by 2002:a05:622a:1987:b0:42c:2706:bad4 with SMTP id
 u7-20020a05622a198700b0042c2706bad4mr251429qtc.27.1707340310654; Wed, 07 Feb
 2024 13:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201060437.861155-2-davidgow@google.com> <CA+GJov6Swgvc+wrCvW3Ujqh_UW1BSRDrp9ccHUX2CVRjWpe1dQ@mail.gmail.com>
 <878r3wcs7e.fsf@intel.com>
In-Reply-To: <878r3wcs7e.fsf@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 7 Feb 2024 16:11:38 -0500
Message-ID: <CA+GJov4zrcbiANMgJ5uSQs6Siv0+NAB5big0bec-WWgkhfFJ+Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: device: Unregister the kunit_bus on shutdown
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Maxime Ripard <mripard@kernel.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, 
	Chaitanya Kumar <chaitanya.kumar.borah@intel.com>, Jani <jani.saarinen@intel.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:36=E2=80=AFAM Jani Nikula <jani.nikula@linux.intel=
com> wrote:
>
> On Fri, 02 Feb 2024, Rae Moar <rmoar@google.com> wrote:
> > On Thu, Feb 1, 2024 at 1:06=E2=80=AFAM David Gow <davidgow@google.com> =
wrote:
> >>
> >> If KUnit is built as a module, and it's unloaded, the kunit_bus is not
> >> unregistered. This causes an error if it's then re-loaded later, as we
> >> try to re-register the bus.
> >>
> >> Unregister the bus and root_device on shutdown, if it looks valid.
> >>
> >> In addition, be more specific about the value of kunit_bus_device. It
> >> is:
> >> - a valid struct device* if the kunit_bus initialised correctly.
> >> - an ERR_PTR if it failed to initialise.
> >> - NULL before initialisation and after shutdown.
> >>
> >> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> >> Signed-off-by: David Gow <davidgow@google.com>
> >
> > Hello,
> >
> > I have tested this with modules and it looks good to me!
> >
> > Thanks!
> > -Rae
> >
> > Reviewed-by: Rae Moar <rmoar@google.com>
>
> Thanks for the patch and review!
>
> Is this on its way to some v6.8-rc's? The regression in -rc1 is hurting
> our CI.

Hello!

This patch has been accepted on the kselftest/kunit-fixes branch
(https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/=
commit/?h=3Dkunit-fixes&id=3D829388b725f8d266ccec32a2f446717d8693eaba)
and is heading towards a future v6.8-rc.

Thanks!
-Rae

>
>
> Thanks,
> Jani.
>
>
> --
> Jani Nikula, Intel

