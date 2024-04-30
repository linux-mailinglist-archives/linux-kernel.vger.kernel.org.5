Return-Path: <linux-kernel+bounces-163782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BDF8B7011
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FED1F21857
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2326512C494;
	Tue, 30 Apr 2024 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgBKBiQ6"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E642127B70
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473786; cv=none; b=hkMO6fL52LgOMvbsVNX1MfOD+0CPNnEeYMtYGDrt1biPBUcUnNchJjbJL0G+zTlU384fRYg1BmJ3bdiq5abOLl3qCNWRa7p1ptsaYJE4U43srAxD7atTKsfrcvzaIOceerzNAU3oRpFYv3t4FXNn5CWePD8wMDuVDkSEffg5xG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473786; c=relaxed/simple;
	bh=VDUiNpXWuWH30nxODfULOQvMKXg/IncYMLO1roSxJVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uc7kuxleK/1/30j5MhnF3Zl8QPoTxIxq6UUbFyBzoBU/T5BtPEUWnILA9ITGo+5yyv+GOenU0wR+l1rc1EWeMRyi3on3emXhts1O5vtitSaIyBFpGvRnQJwiEwzz+z/X9qN6i1L/H8ia5+Pqt08gQHVQwm4hHPfX7KQulKt1Hys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hgBKBiQ6; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ddda842c399so5617724276.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714473782; x=1715078582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VDUiNpXWuWH30nxODfULOQvMKXg/IncYMLO1roSxJVo=;
        b=hgBKBiQ6ow/n8OZW3ZLET/e5Hlhn3WXBEFfOMuu1LD0jKqcTeKe3DQnDHvMn5Ha+hv
         kohrmOw0JGz8VMneREkRy/YguN5KgTG5BfhxT0RYzH/R2d8Cx+xiwxzWMufE1KYQ2fs4
         YK6VE0k1jqzNPzu3fAt1rsh+Nlhw5eoVsQlYN3XTdGL2zoHHgSTguXVhMYvj6+D032VC
         C8wDw8OSbZe9H32zt3sChUM5a9BhFs15BI0yejCo2lreTk0MZm2P78lzt9Jq95pUxpMr
         E9oaNLyy7pYrc+/g3gRfwmyK7jrD5Jx4X9ApMrAUw2TiyVZ4bRPZHPti0FBUMVp1Wbkd
         ktHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714473782; x=1715078582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDUiNpXWuWH30nxODfULOQvMKXg/IncYMLO1roSxJVo=;
        b=C/6jkQEmkAKV3Y27BpTtYmmS9RxntJzNx2LstmrM9yWQVqlGrwhkXVtDkrUkJefK/0
         z5awyvT0errpcPwkQ1xv62xk86ntkyRHXW+nMcOEC7FFtnm6z+yAurBbYowJAktHhIIO
         zbi4U3MRsr7ye1pMJdagSUzUYzl2nM6zrfjsO6krm95lv3fZkozYLxDjaiY9WfdYFgFa
         SmhLreQXiqLgiKTD8L1K0v43Kd8Bvv2OWN/pZJANKon16bBx0epolI9QW0aWmLEnfVBp
         esuD8rLbtNyG2gmGNe55RfdgVzYOQI0S3WtI5YcZXywVv6RJ+EzISiA26yMW78Xpvj1/
         Y9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT2zR0TK4ntFQGZPTtajBrke+jT3JLiiD0SUM7zgup2hKC3CElH84+7LWRjKqOQEvzwcGN7KfNv5Ix+bPs0LXmwD+dybG3ftBicGGp
X-Gm-Message-State: AOJu0YyN/iMDpQMJbs7jI9wlzgIwSBVXdIS/Pg546Q2qvp36FDV8hYkS
	M2tyPAGUwrOsWokrGNVQvvNAyNmnomBaaoi4wHQPVBLoFtnLugbkPwRzbN+R8VXPZ7Mx6X2xNN4
	buqvio2rzj5GpKEP4SKANz9oNpflcFC8EG7cf+w==
X-Google-Smtp-Source: AGHT+IEPt6rtIomeocZoEOGlgzQPp8Y2RtRShUwpjfR7KXDzI2eA6BTyMW7lGrhOyto4UkFzMQ4YDQUwAAgGlkTl4hE=
X-Received: by 2002:a25:9347:0:b0:de0:deb0:c363 with SMTP id
 g7-20020a259347000000b00de0deb0c363mr14176771ybo.31.1714473782698; Tue, 30
 Apr 2024 03:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429140531.210576-1-ulf.hansson@linaro.org> <20240430094411.HyS2Gecw@linutronix.de>
In-Reply-To: <20240430094411.HyS2Gecw@linutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Apr 2024 12:42:26 +0200
Message-ID: <CAPDyKFpMga4DweVoLdW80mvfGr8vrQ5yNMcU_wgqWQuoLdo6+w@mail.gmail.com>
Subject: Re: [PATCH 0/6] pmdomain/cpuidle-psci: Support s2idle/s2ram on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 11:44, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-04-29 16:05:25 [+0200], Ulf Hansson wrote:
> > The hierarchical PM domain topology and the corresponding domain-idle-states
> > are currently disabled on a PREEMPT_RT based configuration. The main reason is
> > because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
> > genpd and runtime PM can't be use in the atomic idle-path when
> > selecting/entering an idle-state.
> >
> > For s2idle/s2ram this is an unnecessary limitation that this series intends to
> > address. Note that, the support for cpuhotplug is left to future improvements.
> > More information about this are available in the commit messages.
> >
> > I have tested this on a Dragonboard 410c.
>
> Have you tested this with PREEMPT_RT enabled and if so, which kernel?

Yes, of course. :-) I should have mentioned this in the cover-letter, sorry.

I have used the linux-rt-devel.git, which had a branch based upon
v6.8-rc7 a while ago, that I used when I did my tests.

The series needed a small rebase on top of my linux-pm tree [1],
before I could post it though. I also tested the rebased series, but
then of course then not with PREEMPT_RT, but to make sure there are no
regressions.

Kind regards
Uffe

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git next

