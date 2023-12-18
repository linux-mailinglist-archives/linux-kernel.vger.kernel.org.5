Return-Path: <linux-kernel+bounces-4101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8938177ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDAC1F21D35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929C498A8;
	Mon, 18 Dec 2023 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S5I3NQIF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763C1D148
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e2168ab09so3927615e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702918401; x=1703523201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nM0rc7/LDh8NwvQblcAD/SfzUIDE9JpJzu1fXo/7n0Y=;
        b=S5I3NQIF0tv4DlQny6DDnjgV47VIlda/Cc9tRRCORfB1YEqbspvUZXqLu/kam2tG36
         QA1kOWrqQpAJVsIAg6kKm/C869/o8fDayqIQ2U+GfR7BLSUlXQLfbC9CFJKc/WufWmkx
         wD6176nz8XEnZEbnm/YqxKAYKnaOF74/z9gqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702918401; x=1703523201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nM0rc7/LDh8NwvQblcAD/SfzUIDE9JpJzu1fXo/7n0Y=;
        b=rQl0VOYy51toS0/w8DyXWNnL3vwGi/5J7spGhVysMCs5FVWjBzvjVqXAE5XMGrNhoP
         abthg6HJ4cqyPMV/s8aT+vjWSdxhAcjndEOq9Z43HCWyfK5UwVW8WAq4RlfUkOSm/+HD
         z/AFb5FYd/5n5V6zBMpcY3joFVcdmtxoLGtitL7hIRQ5G0TxQzF8pABFCmDv11S+mRla
         AZT2Ph/FUcL4gQV08nB8xzNQP5qtknGPK0esMk7Xoj8Z+ZBLDVeGAy6ppGeNHyVRuJWE
         HJd50UdoKck6iOk/I24UBryuCMWg0wwMLDfKZd/2MYa9Jo7nglAFoMizqerbrrLuZO2g
         CaFA==
X-Gm-Message-State: AOJu0Yw9fInHOGj4axbIw2udMJN6J0GUb2l7h9zdU3YNLq6iOXfqbCZJ
	QPL04R560uPPlGc6gJyr3sHfwpO4z3mSTlLOeZU2yYU+
X-Google-Smtp-Source: AGHT+IH2to9SuWtr71IiB/jOCnsc/DY7lUmnm9Zz5go8799sH0UWp2G4+dtIGyxOB4LdAtBScwe3BQ==
X-Received: by 2002:a05:6512:2206:b0:50e:356b:f6b8 with SMTP id h6-20020a056512220600b0050e356bf6b8mr1868019lfu.123.1702918401414;
        Mon, 18 Dec 2023 08:53:21 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id br29-20020a056512401d00b0050e03392a0bsm2010801lfb.171.2023.12.18.08.53.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:53:21 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e1f1086fcso6039e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:53:21 -0800 (PST)
X-Received: by 2002:a05:600c:3b03:b0:40d:174c:9295 with SMTP id
 m3-20020a05600c3b0300b0040d174c9295mr213133wms.3.1702918048764; Mon, 18 Dec
 2023 08:47:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
In-Reply-To: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Dec 2023 08:47:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VtGN-qU-jqHsD0XpPc5uJwm2xd_rO+ueR_PqK-VJcukQ@mail.gmail.com>
Message-ID: <CAD=FV=VtGN-qU-jqHsD0XpPc5uJwm2xd_rO+ueR_PqK-VJcukQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/bridge: parade-ps8640: Never store more than
 msg->size bytes in AUX xfer
To: dri-devel@lists.freedesktop.org
Cc: Guenter Roeck <groeck@chromium.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philip Chen <philipchen@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Boyd <swboyd@chromium.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 14, 2023 at 12:38=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> While testing, I happened to notice a random crash that looked like:
>
>   Kernel panic - not syncing: stack-protector:
>   Kernel stack is corrupted in: drm_dp_dpcd_probe+0x120/0x120
>
> Analysis of drm_dp_dpcd_probe() shows that we pass in a 1-byte buffer
> (allocated on the stack) to the aux->transfer() function. Presumably
> if the aux->transfer() writes more than one byte to this buffer then
> we're in a bad shape.
>
> Dropping into kgdb, I noticed that "aux->transfer" pointed at
> ps8640_aux_transfer().
>
> Reading through ps8640_aux_transfer(), I can see that there are cases
> where it could write more bytes to msg->buffer than were specified by
> msg->size. This could happen if the hardware reported back something
> bogus to us. Let's fix this so we never write more than msg->size
> bytes. We'll still read all the bytes from the hardware just in case
> the hardware requires it since the aux transfer data comes through an
> auto-incrementing register.
>
> NOTE: I have no actual way to reproduce this issue but it seems likely
> this is what was happening in the crash I looked at.
>
> Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX chan=
nel")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Since the patch fixes a crash, has two Reviews (even if they're both
from @chromium), and doesn't seem controversial, I didn't want a full
week and just landed it in drm-misc-fixes. If anyone is upset by this
then please shout and we can revert or I can post a followup patch.

3164c8a70073 drm/bridge: parade-ps8640: Never store more than
msg->size bytes in AUX xfer

