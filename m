Return-Path: <linux-kernel+bounces-18011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72255825703
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BBD284288
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA102E822;
	Fri,  5 Jan 2024 15:48:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945702E630;
	Fri,  5 Jan 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59614694ca2so309681eaf.1;
        Fri, 05 Jan 2024 07:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704469691; x=1705074491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/qrearbi2N1WOWMlmfnsHMuDJpk95L3sc3xvqWje7E=;
        b=GZwahsYwaI/nwFmN09a+rY30UjdTJZfy7tMj2ffAmfD0OxFTeLoCekz9KRnOqd641m
         zYjJgWpir6dG4FI/LA5SesQrjF7iTuDndQ8BoTX/lEXZmoKm8XS+wZKcaNHuVh6htwP+
         2UnI1jeucabyp39Vxnzri5kbiq9VkgP807GdjhhixIafvXAsQltmM/t8nXeIkfyqbfDS
         VoA6Hzs8WdUon02YEvv3ZEgJf9slnRPiWP8HY0GPYw9mG85h1ua8bKwKEJ9Bt54p99br
         gENpP1V+0m87e0rg1t+PY2LPN9s+5s4ikiru2nmQ2VpNlSgnFe+4tqk2x2xdG7Flfewc
         c2OA==
X-Gm-Message-State: AOJu0YwvrTYCbe6tuTs0GULlYq1uRpTw2YD07gowC7UXvIA/rgVPJ+jV
	C7+yM05fVGTrokTi+Jhy2GPRqUJ+E6hzxNJ1/0A=
X-Google-Smtp-Source: AGHT+IF5cX6v51Fw/lLGxvXPKNgB8lTznqXVRKIBimBsPVIQFFHLkpDyxDN+kOwIHgvQC2kwlw37I7eq13ntSlLvE7c=
X-Received: by 2002:a4a:da09:0:b0:596:2965:be22 with SMTP id
 e9-20020a4ada09000000b005962965be22mr3971201oou.1.1704469691528; Fri, 05 Jan
 2024 07:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a3658efad8f6247ed8c477717dc2820b72319d0.1704462287.git.christophe.jaillet@wanadoo.fr>
 <CAJZ5v0hqaJ79BUj_hWDmErCVvJdBJ8o9fcHxcZDyP4+C4iDVxQ@mail.gmail.com> <a821c56b-2153-4464-8323-66ba62348f59@wanadoo.fr>
In-Reply-To: <a821c56b-2153-4464-8323-66ba62348f59@wanadoo.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Jan 2024 16:48:00 +0100
Message-ID: <CAJZ5v0iLe9nCk0xtfAdfEYqvUiWESvDoQi_RWJ6LK1T6h4CqKg@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Save a few bytes of memory when
 registering a cooling device
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, alexis.lothore@bootlin.com, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 3:55=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 05/01/2024 =C3=A0 14:50, Rafael J. Wysocki a =C3=A9crit :
> > On Fri, Jan 5, 2024 at 2:45=E2=80=AFPM Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> >>
> >> Some *thermal_cooling_device_register() calls pass a string literal as=
 the
> >> 'type' parameter.
> >>
> >> So kstrdup_const() can be used instead of kfree() to avoid a memory
> >
> > I guess you mean kstrdup()?
>
> Sure.
> Stupid cut'n'paste typo. Thx for catching it.
>
> Should I resend, or can it be fixed if/when the patch is applied?

I can fix it up.

