Return-Path: <linux-kernel+bounces-20875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CEB8286C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115181C242E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC75439AEB;
	Tue,  9 Jan 2024 13:02:58 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183CF39AE0;
	Tue,  9 Jan 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-204b216e4easo593571fac.1;
        Tue, 09 Jan 2024 05:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704805376; x=1705410176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWME94cXQ/3qVZMyQj3YnPKl2hXPE6WytxavIt7lCh0=;
        b=imbBs1oiI+Pn1L4XIqLytOCX7iYPTsjQkbASA2Jduys9MqOYJvSbOHso1UKMt92EkK
         pNKgD+x9iVTD+VCKxzyT9bWM2s1Bhfc0R0QgpUTYv7QoqL3qaWQrBkySR3bIKIsVeziB
         gBND03DoZaQvRRhdL+Vyz8UnR+eHOflXPpCLnb9Cc2KGHMGzVcTL5yxnrk8Y+dw1svI6
         jAr5I3Lnb956gV+VIeCT720SmGukCTgNBuV8HSw17mgzGHh0uqg+3c94kT+X59qYn2kg
         ZxP9wg29AbBTcfJtBSyHEKZD0TxoASKhdN2Ub43/d6BRXefE0zyoD6PslabAvy0iI5KX
         f3zg==
X-Gm-Message-State: AOJu0Yyb/iTK1FO5pileIOTftIpHLsbQORmaW8VTilGE3rXJQaJ5Nhut
	nTTjX7rA9AssPbv+PrncOSRslN2S2v5K1Hh3ilc=
X-Google-Smtp-Source: AGHT+IFryTIKHNahRMGT+oOV3hKW5nX7DZhG/prkg0H7s69ydmCbMN2o9hSeknDo7pXrIA7UzM0/bis5ZXEThVs0gQA=
X-Received: by 2002:a05:6870:c115:b0:204:9066:c34f with SMTP id
 f21-20020a056870c11500b002049066c34fmr10003149oad.5.1704805376024; Tue, 09
 Jan 2024 05:02:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109094112.2871346-1-daniel.lezcano@linaro.org> <20240109094112.2871346-2-daniel.lezcano@linaro.org>
In-Reply-To: <20240109094112.2871346-2-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 14:02:44 +0100
Message-ID: <CAJZ5v0iL9PhG5e8f9rAL05FHT6TnhSYx6=XOFdgnBtbC--ZZ9w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] thermal/debugfs: Add thermal debugfs information
 for mitigation episodes
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, lukasz.luba@arm.com, rui.zhang@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 10:41=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The mitigation episodes are recorded. A mitigation episode happens
> when the first trip point is crossed the way up and then the way
> down. During this episode other trip points can be crossed also and
> are accounted for this mitigation episode. The interesting information
> is the average temperature at the trip point, the undershot and the
> overshot. The standard deviation of the mitigated temperature will be
> added later.
>
> The thermal debugfs directory structure tries to stay consistent with
> the sysfs one but in a very simplified way:
>
> thermal/
>  `-- thermal_zones
>      |-- 0
>      |   `-- mitigations
>      `-- 1
>          `-- mitigations
>
> The content of the mitigations file has the following format:
>
> ,-Mitigation at 349988258us, duration=3D130136ms
> | trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  duration  |  avg(=
=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |
> |    0 |  passive |     65000 |      2000 |     130136 |     68227 |     =
62500 |     75625 |
> |    1 |  passive |     75000 |      2000 |     104209 |     74857 |     =
71666 |     77500 |
> ,-Mitigation at 272451637us, duration=3D75000ms
> | trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  duration  |  avg(=
=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |
> |    0 |  passive |     65000 |      2000 |      75000 |     68561 |     =
62500 |     75000 |
> |    1 |  passive |     75000 |      2000 |      60714 |     74820 |     =
70555 |     77500 |
> ,-Mitigation at 238184119us, duration=3D27316ms
> | trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  duration  |  avg(=
=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |
> |    0 |  passive |     65000 |      2000 |      27316 |     73377 |     =
62500 |     75000 |
> |    1 |  passive |     75000 |      2000 |      19468 |     75284 |     =
69444 |     77500 |
> ,-Mitigation at 39863713us, duration=3D136196ms
> | trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  duration  |  avg(=
=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |
> |    0 |  passive |     65000 |      2000 |     136196 |     73922 |     =
62500 |     75000 |
> |    1 |  passive |     75000 |      2000 |      91721 |     74386 |     =
69444 |     78125 |
>
> More information for a better understanding of the thermal behavior
> will be added after. The idea is to give detailed statistics
> information about the undershots and overshots, the temperature speed,
> etc... As all the information in a single file is too much, the idea
> would be to create a directory named with the mitigation timestamp
> where all data could be added.
>
> Please note this code is immune against trip ordering but not against
> a trip temperature change while a mitigation is happening. However,
> this situation should be extremely rare, perhaps not happening and we
> might question ourselves if something should be done in the core
> framework for other components first.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Both patches in the series look good to me now, so I'll queue them up
for 6.8-rc1.

Thanks!

