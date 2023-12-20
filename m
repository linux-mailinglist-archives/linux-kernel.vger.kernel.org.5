Return-Path: <linux-kernel+bounces-6969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C7E819FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA751F22EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCFB34571;
	Wed, 20 Dec 2023 13:37:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712436AED;
	Wed, 20 Dec 2023 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-590a21e977aso149511eaf.1;
        Wed, 20 Dec 2023 05:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703079451; x=1703684251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zi2/E2JPV+E9OtEb+OM3gBdNSO0WpJsVMVo8MT1752Q=;
        b=XYJGNkpURqgyWzOqZIQhyj9nWiIgxi+/VN3Ib+Kiu9sUvsjDhRwrkLpVwu8l68nqwP
         YgnrB5OUqoI4p8qHXLTzSS4NEHWCdAbuRonBOfiDhpXB4eVNow9YJ8XBD8JNncqMZ8Cu
         gCs+9Ono9T+Lmb28MCNuCLF0UXROIAQ9pP1tJSIOkMKq/zCbThu4fKd0rqhcPC8h4V0n
         wAPhqLjqHNnCe80p6XuiYdyTF07i5evaTmfvVMs21QMnZEFoV2FnCE7CaM1cfW3JkfRd
         +9q2JNN83XNCWKQLta6S0ZSBx3Fht98YeMj8n30+ZUmQkxESFS5cWs7lTnmLp8Y70i0P
         cFOA==
X-Gm-Message-State: AOJu0YzFhjA3yyqGFGhxSM30Gtki9cTqLpNxL2qNs9RCMCxmfr6lcmAi
	d1CB1DPJ+xffGKTtVf3MKxa+/p6OOZesRmNMYhU=
X-Google-Smtp-Source: AGHT+IFPWD1e7bEmPP17/BQHTxvMpnKN6yH0aErwTtDPwWdlJLiDHeAP8Hb82e1l2JF/FiGR8wGIdFVB4I83HJ1p0Lg=
X-Received: by 2002:a05:6820:258a:b0:593:e53b:2df1 with SMTP id
 cs10-20020a056820258a00b00593e53b2df1mr4441366oob.1.1703079450842; Wed, 20
 Dec 2023 05:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212134844.1213381-1-lukasz.luba@arm.com> <b2f9db3f-96a4-4e1e-9be0-32f19948c489@arm.com>
In-Reply-To: <b2f9db3f-96a4-4e1e-9be0-32f19948c489@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 14:37:19 +0100
Message-ID: <CAJZ5v0jx=Nm0zrKeGuDkkiskCT_LOF77fVFWt-mATkf3X9qUDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add callback for cooling list update to speed-up IPA
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: daniel.lezcano@linaro.org, rafael@kernel.org, linux-pm@vger.kernel.org, 
	rui.zhang@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:53=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Daniel, Rafael,
>
> On 12/12/23 13:48, Lukasz Luba wrote:
> > Hi all,
> >
> > The patch set a new callback for thermal governors and implementation f=
or
> > Intelligent Power Allocator.
> >
> > The goal is to move some heavy operarions like the memory allocations a=
nd heavy
> > computations (multiplications) out of throttle() callback hot path.
> >
> > The new callback is generic enough to handle other imporants update eve=
nts.
> > It re-uses existing thermal_notify_event definitions.
> >
> > In addition there are some small clean-ups for IPA code.
> >
> > changes:
> > v2:
> > - change callback name to update_tz() and add parameter (Rafael)
> > - added new event to trigger this callback - instance 'weight' update
> >
> > Regards,
> > Lukasz
> >
> > Lukasz Luba (8):
> >    thermal: core: Add governor callback for thermal zone change
> >    thermal: gov_power_allocator: Refactor check_power_actors()
> >    thermal: gov_power_allocator: Move memory allocation out of throttle=
()
> >    thermal: gov_power_allocator: Simplify checks for valid power actor
> >    thermal: gov_power_allocator: Refactor checks in divvy_up_power()
> >    thermal/sysfs: Update instance->weight under tz lock
> >    thermal/sysfs: Update governors when the 'weight' has changed
> >    thermal: gov_power_allocator: Support new update callback of weights
> >
> >   drivers/thermal/gov_power_allocator.c | 216 ++++++++++++++++++-------=
-
> >   drivers/thermal/thermal_core.c        |  13 ++
> >   drivers/thermal/thermal_sysfs.c       |  15 ++
> >   include/linux/thermal.h               |   6 +
> >   4 files changed, 182 insertions(+), 68 deletions(-)
> >
>
> I know it's a bit late in time period...
> You probably missed that patch set in your mailbox.
> This patch set can probably just wait to the next window, or
> should I resend it later in 2024?

Not really, I was about to comment one the first patch.

I'll do that shortly.

