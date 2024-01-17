Return-Path: <linux-kernel+bounces-29426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F6830E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF18D28357F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FC2250EF;
	Wed, 17 Jan 2024 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j+XBGsN2"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EED250EA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523746; cv=none; b=XD2U3OZ8/49ZuFs0pgF5EhQrLyDJvOpaHfweRbITi5qVBZZWU7XJknJdziM0ggvwaSJxhfRX8shECuZmWqBH9GNvsPIhfnu4cibP5LxTZA0Obl7KqvHNQYO7cFbiWLCd55TDaBjtYyJazBqs5PJ2hkXarWpxi+Ii2B+9BjHBHq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523746; c=relaxed/simple;
	bh=y80k3jEI2jUrrgv1S97EjSMTB/Tm8rDIE+8TZZV8vDk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=rBbsfePLuTWFAW/WYLSdvJ6QUHrDc3XhB/7pHtq+BbfstfLSLXbqXZzGfoAA6BqCyfkjAWXHwoGaHW7MfWP190sbAvep9A1NX2yFA2EtWSTg6ZVIgK0hoMWMsyuX5rXuEdRa8ardUMWJzYnz2jQ+Z54vl/6DaTWP9d/7tvTLdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j+XBGsN2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e835800adso13036114e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705523741; x=1706128541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H34ysvL6GHeCyXKHhC6fgd3ArjBS9lz3Dbeq0+BNUM=;
        b=j+XBGsN2ozDi9opI2LCqn2H3otCiNO7rrLVSgcyy27kKO4N5R2U+jqIHFUHT9V5QGz
         Zw4qzt8vXK2Jcb2eh/UMW7QG9lhssCJwgqbhCwGvG346Ao9VWPch4iMeEWLyBpxHfJ5Y
         PaP5WGKCJv+OdMHGRyGUG3iiJFVkmyHS9GKic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705523741; x=1706128541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0H34ysvL6GHeCyXKHhC6fgd3ArjBS9lz3Dbeq0+BNUM=;
        b=PB+fASN2Yw8WLkDztg9QCoL0wgCKBGBx51PWMwSPKVgO5nc2I0maUkSK61z785P5tI
         sLrbLfowTY1QxAM7RJ2sCDp0n+SaUd50iHiQ/iiqA+BbtxrUUtJp5ocUWBnYkgB2Yp/W
         X6vFvlXbP6Ye+CwSYC/dJDDOtP+YL+QhRJTfMwL1SrCpdJwDx4jy/QpBP6LKEP++dDlz
         +ZRfziXOQyQVF7suEXdiDgk05VRgdsE6xhzL7QTUWpcTfh24sRHys64ywPlr4VhhtHzd
         4Q6LTSw44ya4F1fqN/bCGjVxJZg8TEWTO68EZMuNDyf3Z7YYx2Co2E6KTjIsSQY8ZiTE
         OTUA==
X-Gm-Message-State: AOJu0YxiRTvNwg2pwgSmI0XtPosusZ8/YJRtE7lv2RAMr7cor4/S76Jr
	OW00HYew0UM3bQOp6rS/MsRVL+DP+GGjFlkwB4sRHn1K8D6V3Wo=
X-Google-Smtp-Source: AGHT+IFclSFUQHWeLMNGpvmdAwh50YJ007a2FHd+XTBFpJCmQS+gvhN8diDBdOwwbPYpsoQSuYVWDg==
X-Received: by 2002:a05:6512:39d5:b0:50e:902d:b44 with SMTP id k21-20020a05651239d500b0050e902d0b44mr4075666lfu.8.1705523741013;
        Wed, 17 Jan 2024 12:35:41 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id o24-20020a056512053800b0050e7bbda528sm358536lfc.274.2024.01.17.12.35.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:35:40 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eaf2f00d1so3848e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:35:40 -0800 (PST)
X-Received: by 2002:a05:6512:4008:b0:50e:a70c:d0da with SMTP id
 br8-20020a056512400800b0050ea70cd0damr143487lfb.0.1705523739612; Wed, 17 Jan
 2024 12:35:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115045054.1170294-1-kai.heng.feng@canonical.com>
In-Reply-To: <20240115045054.1170294-1-kai.heng.feng@canonical.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 17 Jan 2024 12:35:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VCoB_uBontRk3WVn-nqzZnutSMCHBpdBqNOFwrYv=8xw@mail.gmail.com>
Message-ID: <CAD=FV=VCoB_uBontRk3WVn-nqzZnutSMCHBpdBqNOFwrYv=8xw@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Skip SET_POWER SLEEP for Cirque touchpad
 on system suspend
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, 
	Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 14, 2024 at 8:51=E2=80=AFPM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> There's a Cirque touchpad that wakes system up without anything touched
> the touchpad. The input report is empty when this happens.
> The reason is stated in HID over I2C spec, 7.2.8.2:
> "If the DEVICE wishes to wake the HOST from its low power state, it can
> issue a wake by asserting the interrupt."
>
> This is fine if OS can put system back to suspend by identifying input
> wakeup count stays the same on resume, like Chrome OS Dark Resume [0].
> But for regular distro such policy is lacking.
>
> Though the change doesn't bring any impact on power consumption for
> touchpad is minimal, other i2c-hid device may depends on SLEEP control
> power. So use a quirk to limit the change scope.
>
> [0] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/power_m=
anager/docs/dark_resume.md
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Use quirk instead of applying the change universally.
>
>  drivers/hid/hid-ids.h              | 3 +++
>  drivers/hid/i2c-hid/i2c-hid-core.c | 6 +++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)

This seems OK to me. As per my repy to v1, it doesn't feel fully
explained what's going on. Why does it only wake the system without
touches if you put it to sleep first? Is it truly a hardware quirk
with the Cirque touchpad or is it a bug on the board you have it
hooked up to? In any case, perhaps it doesn't matter since you said
you measured power here and, on this touchpad it doesn't seem to save
significant extra power to go into sleep mode. ...so I guess I'd be OK
w/

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/20240115045054.1170294-1-kai.heng.feng@canoni=
cal.com

