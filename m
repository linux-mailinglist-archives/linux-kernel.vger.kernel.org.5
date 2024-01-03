Return-Path: <linux-kernel+bounces-15393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B3B822B64
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C971F2412E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C7418C1B;
	Wed,  3 Jan 2024 10:28:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0D18C01;
	Wed,  3 Jan 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-594cabe74f8so342938eaf.0;
        Wed, 03 Jan 2024 02:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704277712; x=1704882512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O71FlOOiGk/7AmpyQ57yDmpDlt8Ip4jkuT5waQGee/E=;
        b=HEcomYPki1NYzWwzTIIX60PuKgJSgEC62nMJEEWif52l6M9LRhsPB42OsghBhY6qgD
         mZetX1e7n7zV+sTmObo3KIOW1eILHJx/c/LAMQ3tZAWZvyzek3dMxSyqhm+syAWDJlqq
         Uj3AkWUdnv/gbNwtGBCRWL6NeWYGfQcaZBaI+0rMLEQrCJdOnjQTdxqo4BfZbeOeNzmV
         XMZ+I3MarQA60be1u4f4hGGWJAhHG0ZUBd9xcsrh/6Y9ZGOx+bZm+6nDcQDczfb+3eXX
         oENYT8yHaAXUZ6NwbQg2ubTcipIdt28qd+Ykg4o5mL/UJIE8x0/vT6s0famVPdMnURuf
         Rrag==
X-Gm-Message-State: AOJu0YxLQJGhRNqQCMCYLI0l+k4y3oHPWQR0+bb1bWmzKm8SEjXUO6IT
	8ivDxFzHdG22QsQvbBltzRuw44Il3/BPABZDHQ8=
X-Google-Smtp-Source: AGHT+IHDHVKD4l2m03lvzGargJCfCc+oBOr/CtCjvbAuwmyIHLrwhTBUjyn0GdqiZNPKDkqkraHM2sMA1muQHmOBBks=
X-Received: by 2002:a4a:e096:0:b0:595:6028:d8cb with SMTP id
 w22-20020a4ae096000000b005956028d8cbmr6936937oos.0.1704277712127; Wed, 03 Jan
 2024 02:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <2023122701-mortify-deed-4e66@gregkh> <5754861.DvuYhMxLoT@kreacher>
 <6019796.lOV4Wx5bFT@kreacher> <CAJZ5v0j6vspzj00ZH66eHtcDP8_fUcaR+KNoaTA8qG1r0hkrVQ@mail.gmail.com>
 <ZZTk9dRlueSuZuAy@perf>
In-Reply-To: <ZZTk9dRlueSuZuAy@perf>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 11:28:21 +0100
Message-ID: <CAJZ5v0j=7ePbEhW0+9WBGqgGhafGazyM-APr-ZRsweWDAQ76Vw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] PM: sleep: Fix possible device suspend-resume deadlocks
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, d7271.choe@samsung.com, 
	janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, hs.gil@samsung.com, 
	yulgon.kim@samsung.com, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 5:39=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung.c=
om> wrote:
>
> On Tue, Jan 02, 2024 at 02:18:43PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Dec 27, 2023 at 9:41=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysock=
i.net> wrote:
> > >
> > > Hi Everyone,
> > >
> > > As reported here
> > >
> > > https://lore.kernel.org/linux-pm/ZYvjiqX6EsL15moe@perf/
> > >
> > > the device suspend-resume code running during system-wide PM transiti=
ons
> > > deadlock on low memory, because it attempts to acquire a mutex that's
> > > already held by it in those cases.
> > >
> > > This series addresses the issue by changing the resume code behavior
> > > to directly run the device PM functions synchronously if they cannot
> > > be scheduled for asynchronous executions (patch [3/3]).
> > >
> > > For this purpose, the async code is rearranged (patch [1/3]) and a
> > > new variant of async_schedule_dev() is introduced (patch [2/3]).
> >
> > Given the lack of negative feedback, I've queued up this series for 6.8=
-rc1.
> >
> > Please let me know if there are any issues with that.
> >
> > Thanks!
> >
> Hi Rafael
>
> We haven't seen any regression issue under our stress test.
>
> So, feel free to add
>
> Tested-by: Youngmin Nam <youngmin.nam@samsung.com>

Thank you!

