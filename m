Return-Path: <linux-kernel+bounces-30695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48D832324
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160201F21F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940E346AF;
	Fri, 19 Jan 2024 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0ABaQ6R"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995E4691
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629057; cv=none; b=Sz1/BbL7sjpcOCB0IlmYXWaPrZWaj6N1J8GOKZeh6cDOJdbBQbCusFOqH2dbdhBk4xnIvbTIv5lY5DwDBgS5SghOv4Hzl521AehncJ5f3aZBsnNeumXXhPXES6ijNRUZHQZO2lN3VYfRpwES3xPSew6Hjt/AskbfwkOFuNjKDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629057; c=relaxed/simple;
	bh=38huTxU0pXTsIWTOQp4P0tI0mktk6V47LUM1nr2Z7hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tizXnjunmYa0fJk9sf1ugg6BZ2w109O0m3GxNQtRnRyHMmb0biCdCwe7JOEyb7bNnQYD7wGSL9fwW+N27r+8PC6rZbzl5WYbqvAIHsUzrSa/0WhfbjBBIOgF7kQZq8ewlf+fpvbWRJqrWHoCC6zAl4o18q+7uSawhUUrCd07nUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0ABaQ6R; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a070af87eso162110a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705629054; x=1706233854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38huTxU0pXTsIWTOQp4P0tI0mktk6V47LUM1nr2Z7hc=;
        b=Z0ABaQ6Rh07v5h1+4NlW9q0d8DN6z8RcAICxkLEwBw6ydRvwDrJXA3q2UeAZCxzksA
         UYTTkOQ6ZsEmaO3G1OQlJFRlIMXp5rnSHz+gVAxhRIOFmi4/45hXWZCdtVzz6kdj0av/
         m22aJD7tyFgh2t6TTtio7+7DA7GsehhWUVFvIMaDn0+Tc/rlEvoiGtRNzPOaq7QWfzT/
         xzWjZRv+7L4RX3icPgkDnujuQU/iNUytCiIeqaGyxLnzBcfnOH9A1V0WEqg8gCBqAmjU
         fcbLLspovmZAAkPIrNOT8cDIkKzaXGpqJqtHqHPJu1Cpu/lPweQZaFYTQj6T0sUXIdWz
         8Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705629054; x=1706233854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38huTxU0pXTsIWTOQp4P0tI0mktk6V47LUM1nr2Z7hc=;
        b=VDBWm4JnGNF3BmezPoNoFtXIuqtcE6LmHqy3BJB1cNRysgqESPYOMNQgUhTR/RP/Ua
         0XUhTS0anFuSf/yL+CCmXu9dR+htQQgBiRdHJnwk+F31JtR+yr5DVr4xBSYT11hD1owI
         wyz3XV4BgZKAGWI13AclAeV6UZffZV6FNvMY+8VQlhSxM89U6gmiy/WmEcpQCcQnuZdq
         V2LE+prjiiGC6sNgsUKNVXrk+Dt/P3jia23Qk7IgL9G0El9gcKGL3RX9+cPQqYsWzZkD
         CtQwi7pDZfLHOw79XDrEbtRZjHhUGFxcMwTgpIep9uVmEQI8IgeyRZjcFwK44sLsOcD+
         hLwQ==
X-Gm-Message-State: AOJu0YywGEbEgQwbFn+ygQfKcohuq4ok8ahfR1qpePbz4aw+VkUm9gA4
	gqAJs35XGPpUiGSwIsx/PW1HL1lZ4gTiyU4NVYVYWybvV25P6jHzx/4q0pMldlO1JmXRa+IsqI1
	qseiDZ9Oa17LW2TdIia1zws4uasw=
X-Google-Smtp-Source: AGHT+IHwbTFcn66Vs6N9m1zO2oQ7Y90pxTA6pv2kCP0lCxfAYuG+Gn/uItpKxpiZf3L4CwRFmNgtehqNnZBm5PF/Hs8=
X-Received: by 2002:a05:6402:d43:b0:557:188b:eccb with SMTP id
 ec3-20020a0564020d4300b00557188beccbmr957829edb.84.1705629054596; Thu, 18 Jan
 2024 17:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
 <20240117031212.1104034-2-nunes.erico@gmail.com> <CAKGbVbsydzXyKuhN8VyW9zYwuOMWzvz192WKKReHVX1XCnuXGQ@mail.gmail.com>
 <CAK4VdL2PnWTZ+M2eQqF22+VuF-YGKb_WjG=168BcuBDqD8+9kA@mail.gmail.com>
In-Reply-To: <CAK4VdL2PnWTZ+M2eQqF22+VuF-YGKb_WjG=168BcuBDqD8+9kA@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Fri, 19 Jan 2024 09:50:42 +0800
Message-ID: <CAKGbVbvWAM64T+a6_VRL99araN_2dubu4vO=mqzCoC1p2m_X-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] drm/lima: fix devfreq refcount imbalance for job timeouts
To: Erico Nunes <nunes.erico@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	anarsoul@gmail.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 7:14=E2=80=AFPM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
>
> On Thu, Jan 18, 2024 at 2:36=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wrote=
:
> >
> > So this is caused by same job trigger both done and timeout handling?
> > I think a better way to solve this is to make sure only one handler
> > (done or timeout) process the job instead of just making lima_pm_idle()
> > unique.
>
> It's not very clear to me how to best ensure that, with the drm_sched
> software timeout and the irq happening potentially at the same time.
This could be done by stopping scheduler run more job and disable
GP/PP interrupt. Then after sync irq, there should be no more new
irq gets in when we handling timeout.

> I think patch 4 in this series describes and covers the most common
> case that this would be hit. So maybe now this patch could be dropped
> in favour of just that one.
Yes.

> But since this was a bit hard to reproduce and I'm not sure the issue
> is entirely covered by that, I just decided to keep this small change
> as it prevented all the stack trace reproducers I was able to come up
> with.
>
> Erico

