Return-Path: <linux-kernel+bounces-41388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA3F83EFF0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A54E9B232CA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487A42E832;
	Sat, 27 Jan 2024 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxezkgEh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A82E632
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706386283; cv=none; b=dxujjgArxytepfQk/jkQ+fvp096OC2dvA38onfaFL8uRFEaqiuKvwdDsgEeb9ZNH57gIMECKKZ9DXRvMSfAukOMzWVDBjfnkX0u1EpepxbWScYC/Ux3ylRapGKyyi2FDQb/6j24q9XR9+y2v1IbMvu77KC+rGDC2eyYcUvDvpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706386283; c=relaxed/simple;
	bh=sJ9tgEx/4vCHI7sx+ldFQbW4TAUPdYxPct5X6gZ9CBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTmz+OP4hukdlvXV+H+E5N25cCFeSienGvVdycNZmvdeS3VJ9Sdga4T1pThSqtutPqkfK+QawjTmv74ENS3N0vEVrdKBmhbP3hcDyfqqoXBAungnGdtP8SPJAA9d3X81eQwmTtKzDG9jR5hBOnHCEPoT8ycH859IfmZZVdR8Myk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxezkgEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6A5C433B2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 20:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706386283;
	bh=sJ9tgEx/4vCHI7sx+ldFQbW4TAUPdYxPct5X6gZ9CBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bxezkgEhriSMgNo0yNPHHLoWx4LU0Lk5qXWlnQdW11Ne00KcgZCK4QtRpNvJDAv8x
	 alc8idCqxuWYUMDku49533/NIVTufuYgE4jQ1v+ssHpQdHXQrOni80813BcspOE/GE
	 yTIUdp+WJ6qVtVdVXJIZbqslfXYj7v3wzAY9QQCz+GU+LbsWMpLSD1ps9Zrml/HR94
	 LBh0mP2cDibEniijYevyN31NO3DUFvHFZIDXZt0j04MajRXIefg3vVZjvjQg0sYv3E
	 mwENMf8cMZ9DnP/sYDY0a9WwmpIlbmHOw2O+0xUNu6xZy30zID7f6U4udgGUOgkanm
	 qaQrUmS40tnFQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55eb1f9d1f0so1182360a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 12:11:23 -0800 (PST)
X-Gm-Message-State: AOJu0YxX5l72jrnP5R1bA5vxU1Ui8Yy0gBqog4S6TYPWmsMx0zP4moCt
	G2ZF1z7kSZHQJJQkOTlPVS0nnAGgLwxGEgXBcCMdZHDd9o46VohWBP9KuQdngwEjRn4XWitikMx
	29lqQ9cA3SPQa6O7UdO7zZu3eSbfsREvc+7X3Qg==
X-Google-Smtp-Source: AGHT+IEL7hwutcuJBMl+D+WwSuxDS/pjkssE+ku6P7gX/z4KapuHsOqcACKLloQ+3pbFR1f3+jrtPlK2sndRj9dNn3w=
X-Received: by 2002:a17:906:5587:b0:a35:4331:8971 with SMTP id
 y7-20020a170906558700b00a3543318971mr1555326ejp.31.1706386281470; Sat, 27 Jan
 2024 12:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122100726.16993-1-quic_priyjain@quicinc.com>
 <548e2f24-a51e-4593-9463-09506488c70e@linaro.org> <f415a8cd-4cae-d7c3-60fc-674b3e660f6b@quicinc.com>
 <aeae2e69-8407-4d90-9d16-27798e2f3248@linaro.org> <be69e0a6-fdc8-c24b-9beb-adaac4a97776@quicinc.com>
In-Reply-To: <be69e0a6-fdc8-c24b-9beb-adaac4a97776@quicinc.com>
From: Amit Kucheria <amitk@kernel.org>
Date: Sun, 28 Jan 2024 01:41:10 +0530
X-Gmail-Original-Message-ID: <CAHLCerNx4KxzmQF8HmTTFr+W7xn5vubA=Jcg4Kwyk=cCJ4w+Wg@mail.gmail.com>
Message-ID: <CAHLCerNx4KxzmQF8HmTTFr+W7xn5vubA=Jcg4Kwyk=cCJ4w+Wg@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/tsens: Add suspend to RAM support for tsens
To: Priyansh Jain <quic_priyjain@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 8:55=E2=80=AFPM Priyansh Jain <quic_priyjain@quicin=
c.com> wrote:
>
>
>
> On 1/24/2024 6:04 PM, Konrad Dybcio wrote:
> >
> >
> > On 1/24/24 11:42, Priyansh Jain wrote:

> >>
> >> As part of suspend to RAM, tsens hardware will be turned off and it
> >> cannot generate any interrupt.Also system doesn't want to abort
> >> suspend to RAM due to tsens interrupts since system is already going
> >> into lowest
> >> power state. Hence disabling tsens interrupt during suspend to RAM
> >> callback.
> >
> > Is that a hardware limitation, or a software design choice? I'm not
> > sure I want my phone to have thermal notifications disabled when
> > it's suspended.
>
> > Konrad
>
> As part of suspend to RAM , entire SOC will be off, this mode (suspend
> to RAM) is not intended for Mobile product. Tsens interrupts are not
> disabled as part of suspend to idle(suspend mode for mobile).

You should hide the callbacks behind the CONFIG_SUSPEND Kconfig option
so that it only gets enabled when S2R is enabled.

