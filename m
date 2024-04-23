Return-Path: <linux-kernel+bounces-154995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C58AE41D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69573B232EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1C312F5AE;
	Tue, 23 Apr 2024 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C+acaH4q"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39712F585
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871955; cv=none; b=RFgdYPjprqdiOWCWeLkrIiHsPja2a+aUSUJbKDgmAIWvcZGXHogBO/EX6PuzMPQqlF9RjyB3Ff5GoUu4KU994KQnpsMPUTKrx5RmjVPP7Hm/YWFQXlkAiseC3hutoT72n/pWbjFUgeMgxeKVuiZP1s5aLzk5Cr94j8SCmG55VHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871955; c=relaxed/simple;
	bh=LdqZ/QWiaje++MLzUHTivAf9HQkerMZ5MNR1lT49cmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIwZ3Zr2xygdehVQNVsLc1AuoYSCP86zYR2dxId90gTaDLeczUcTm9IQN+RykN2x2Kcw4GySlJP2ciR1NOlWLzLEXQ5RC+io1zr3Oa6Wk5RCq5xejWOugUhMREtJWaeWSWJ394n1xKxK7LRtKO2U7UDgO85IB1ZKp+XwD0licRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C+acaH4q; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2da0f8f7b24so62417371fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713871952; x=1714476752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdqZ/QWiaje++MLzUHTivAf9HQkerMZ5MNR1lT49cmw=;
        b=C+acaH4qOUg9jybSC5MkIbc7e61DfUWCN0Zw0vxjfWACydLYvx2MKkuzR9xtpJ4bHj
         Ei5MZF4wb4tToYmDrOItQlvhltPeW5HxwhuzT53PFxGAW4q/rQdzDKFEaRjdKwM6SSGq
         2lmHu+MDS8AyBW8TsMPmQbaUV/3XxXU5qmZFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871952; x=1714476752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdqZ/QWiaje++MLzUHTivAf9HQkerMZ5MNR1lT49cmw=;
        b=kxXi2+J1dh8YFf1fRSp+jn7e0hX5uDWjmm+c7rpsQv2JmIcshSHu8eIWHzGLYFgBxR
         IrdTgm+O24yU6ta6rxSBBHvaxWr3bY48PT28mkPy94SvYfBIBPmZGxM+bZqEne2gAzpp
         qwlO44YAYqrmkA4v2z+8dP6wq5w9exxfD9Ku3jkik14AQS0mjaevasU0tATEoRV5pUeA
         miHBRidqEi4YpxZ24g6+hJjTiVP4UVndRhhWy3Do2qY9Q1mgARzAokYxl7MgLc8ApZsn
         N0KUxRKulgvAxjptTyJhab6pUn47RUQExy71UAoDPubvQqMsVkl+lxv6jhiKEPL+8rcP
         lPDw==
X-Forwarded-Encrypted: i=1; AJvYcCWXnDIm5CEZxADwvb+niGaoKHd5WAfttFaDf8B/sGSwf7fGK0dmVAhpQ2ufAHO9aSa+DuCYEwUlyHTLbbEegAqMuHGMtNDvkxb9Wyhw
X-Gm-Message-State: AOJu0Yx5JTf3LGDm2rQ5o5XJ/GBvKs10D1XxKDTm5ZDdO17cZz6QeJyo
	fWrmdHjAuZT7nYWpcOUDTbaKZ27qLrv4MdCuPpHILS2kF7IOVS9+cR+f786w2XpENSdwL3+sNhl
	MMFyoS2XedgpgbiEaAAPrwSBWkDAW/EzLJ6oz
X-Google-Smtp-Source: AGHT+IERajGx70v108Wf4eXuvycl6t3zVenYntzqbYq+/h/p6VvcDPumtQl29D9vFRK+LBHfWe/oUq0ddGwNxAxPMyU=
X-Received: by 2002:a2e:9cd7:0:b0:2dc:f188:9945 with SMTP id
 g23-20020a2e9cd7000000b002dcf1889945mr702989ljj.25.1713871952428; Tue, 23 Apr
 2024 04:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
 <81e1b870-37f9-4ef2-9a3d-87015f32546b@kl.wtf> <Zh0qKeI-YPDE-NVT@hovoldconsulting.com>
 <535f3756-80d9-4599-bf73-a8785d18c399@kl.wtf>
In-Reply-To: <535f3756-80d9-4599-bf73-a8785d18c399@kl.wtf>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Tue, 23 Apr 2024 13:32:21 +0200
Message-ID: <CAE5UKNqPA4SnnXyaB7Hwk0kcKMMQ_DUuxogDphnnvSGP8g1nAQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
To: Kenny Levinsen <kl@kl.wtf>
Cc: Johan Hovold <johan@kernel.org>, benjamin.tissoires@redhat.com, dianders@chromium.org, 
	dtor@chromium.org, hdegoede@redhat.com, jikos@kernel.org, 
	johan+linaro@kernel.org, kai.heng.feng@canonical.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mripard@kernel.org, 
	rad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 7:14=E2=80=AFPM Kenny Levinsen <kl@kl.wtf> wrote:
>
> On 4/15/24 3:22 PM, Johan Hovold wrote:
> > We also use it for devices that may not be populated (e.g. an optional
> > touchscreen) and in that case we should not print anything.
>
> I sent a patch series[0] that shows how the same can be achieved
> (gracefully handling missing device + retry to wake device) without any
> smbus probes, following the existing retry style in i2c_hid_set_power().
>
> Radoslaw and Lukasz, it somehow felt rude to tag and blame you for code
> you hadn't seen yet. If my patch ends up favored we should make sure to
> have the appropriate attribution tags added...
>
> [0]: https://lore.kernel.org/all/20240415170517.18780-1-kl@kl.wtf/
>
Hi Kenny,

Unfortunately, your fix doesn't help in our case as there is no sleep
before the second call to
i2c_hid_fetch_hid_descriptor().

Saying more, this STM exposes two i2c addresses (connected physically
to the same bus)
one is the HID interface and the other one gives an access to the base
firmware and is
served by cros_ec_i2c driver and actually thanks to this driver,
touchpad is woken up because
In the resume path cros_ec_i2c "starts talking" through the i2c bus
thus generating a wakeup
interrupt.

So we need to send a dummy (or any other) transaction that may fail to
wake up the controller after
a whole chromebook rebook and on the resume path.

Best regards,
Lukasz

