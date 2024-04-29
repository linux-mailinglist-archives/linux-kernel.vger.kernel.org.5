Return-Path: <linux-kernel+bounces-161900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CB98B52F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D551F21DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F8171C1;
	Mon, 29 Apr 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="UmPk4XYC"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20C15E86
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378783; cv=none; b=ptzQznP6J23iB2m+M2eoQ+s/rJrMN0u4xIflXeBpmWt+fMHox5KChpaSDCbdGI2eMV7zyEtkuNuy/5UEe3HaxFV7Nhy73oELgoIUXM2heXJwOeGfzyNh0cEyqT2e0O8J+dWBsMSkEMKSs1HAPSawrSCZaZCWLrppyh7386+uBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378783; c=relaxed/simple;
	bh=Po0tXE9Xskn5T/v0Ju783bkp3KwXGfxsxL0+wrC+g14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmX31MLwZ9uQWGvJgDk6Zqt6bzdtHe/lP7xZJhzb1scHFpeyk98zsW9Ip6/3l8wVDvl5ILirsqSAq01/U060DzsspRYPPjXuMge9SAkNPIl7U3Wi8xLcQZ6/zczxQR90tRnWHcfEs+YSq1Bi4S7oBGYUd395L7xOYI1wiLJAyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=UmPk4XYC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a564ca6f67so3698677a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1714378781; x=1714983581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJCrgcZhDrCnnlgKgbh0+Alkxqfdxg/GoVvgeTAkMbU=;
        b=UmPk4XYCz3rLX2OUD+1tUx6Feky0f+h3xL4GvwnO9OJeWHhM9CsNhRMuKV4x+LqcVJ
         GG/tsNe03aBiu83F2dSorLPDwL/EQWiXYIWT8UcX5g5lEKrWfqxiAzrmx9oVhlqHXcRF
         9cIE2NCDNzS2JsSSYvRjujr1bpBvLtD5smenUljj5nLPnqq84UiId2h4O/80+0OvisnP
         jNHY+KNF+VnTJMW/NS8XSFRz3xccFujvq+43gfUenR1Td9iHU0dHww8yEtUdUQNWJsT7
         nJv0sLnNnERY0xak1oZldefY/as+trK2hoidocPzWYUg2ShLRYLQAD1jC/pgvJ3ixPTS
         cNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714378781; x=1714983581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJCrgcZhDrCnnlgKgbh0+Alkxqfdxg/GoVvgeTAkMbU=;
        b=ESFlAxngMBDgduVGwd8bTADmEu0gAxkI4V4vNWgKtxOeBRvqcTkUol4+oYLYjmfrx+
         fWguEeTVqAhffEgOeGvi+XVGYwZeSwarQqRER5UxMfI+gjFnKinasL7w1Ohl8VFZcfoU
         tTZz5+8RTOPAjGfgUl3dXE1zsQx64yv/rUgxx8HxRSA60hwiol0RdhL06GVnXWDyynCz
         60EkRbXaz9bG1fe23J0bDm9sZqJb43/xmm5Pvqn+L3eMBJ8/BQzwYtAt3qDf8/+QJgw/
         4D/3Vw4ww7sYw2CwEnMQAcG0z7nN++/Z2RB5WOKO02qvU51Gj/VSNf5Gl2dT4k+HPyE4
         9ozw==
X-Forwarded-Encrypted: i=1; AJvYcCWS+UPlndGadJfOsD922iUndfWBo2wr24TduoVl6Dj1dpXYfPVqYow6L4cBnA1jtFfVWdex+zTGmycZ/toS7jB7HrI6aUTyR1FC/UEi
X-Gm-Message-State: AOJu0YxiEulcpHfNlCzn3J4hgOGTSbus/MDMg5pf63st867ToiIclfpA
	z+DhDi24nMsEzMdJ5+nt3SMiPPm4+9ItmU8+xIWpmNW6JKJHg1JIAlYmu/JUo7ZHDBjPCoqeUZn
	bMCQkshyXulLgaJH8otuaixO/AoxG9Ix3KJgmFiMYWt573hckv362Nw==
X-Google-Smtp-Source: AGHT+IEZwteBBB8yXUtpDrs8v6BWSN+dxFs8QO3VieMsFx61Slke5Fg8H3/5PejA8AbrcAGjpYhKnp10p/zhLDXhyiI=
X-Received: by 2002:a17:90a:d397:b0:2ac:86c6:fe with SMTP id
 q23-20020a17090ad39700b002ac86c600femr9473425pju.1.1714378781371; Mon, 29 Apr
 2024 01:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <65607114-89f8-4f48-83fc-b89d87fee247@roeck-us.net> <CABqG17jveAdxN+tCcPq4hNqWDy1YCJ1z0+kLpM+ect0XEyqBcA@mail.gmail.com>
 <116aeea1-c648-4abe-9ab2-693bf64000fc@roeck-us.net> <CABqG17jHYymH02hAH0z-uqk2HjemL_-aLr9EyOUNR=uQ7U_wtA@mail.gmail.com>
 <6d779d5b-b622-4e20-9449-64307b9b9582@roeck-us.net>
In-Reply-To: <6d779d5b-b622-4e20-9449-64307b9b9582@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Mon, 29 Apr 2024 13:49:30 +0530
Message-ID: <CABqG17inSB8stBf=ObaYKj4FREpXKWSy=7XXO9O3RhEx_v74vg@mail.gmail.com>
Subject: Re: [PATCH 1/4] hwmon (max6639): Use regmap
To: Guenter Roeck <linux@roeck-us.net>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de, 
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,


On Sun, 28 Apr 2024 at 22:48, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 4/25/24 02:50, Naresh Solanki wrote:
> ...
> > This driver has 27 regmap accesses. Except volatile registers, others are
> > cached by regmap.
> > Some function which only access volatile registers will not be able to take
> > advantage of caching. This is also the case in various other drivers for similar
> > devices.
> > Also regmap offers bit handling which makes the code much cleaner.
> >
>
> Maybe I need to make it explicit in documentation. I will not accept regmap
> conversions unless local caching is dropped. Yes, that means that volatile
> registers will not be cached. I consider that a positive.
I agree with you. Regmap conversion wouldn't make sense if local caching
is present.
Correct me if I'm wrong, but in this context, local caching points to the
various variables in max6639_data ?
i.e.,
    bool valid;     /* true if following fields are valid */
    unsigned long last_updated; /* In jiffies */

    /* Register values sampled regularly */
    u16 temp[2];        /* Temperature, in 1/8 C, 0..255 C */
    bool temp_fault[2]; /* Detected temperature diode failure */
    u8 fan[2];      /* Register value: TACH count for fans >=30 */
    u8 status;      /* Detected channel alarms and fan failures */

    /* Register values only written to */
    u8 pwm[2];      /* Register value: Duty cycle 0..120 */
    u8 temp_therm[2];   /* THERM Temperature, 0..255 C (->_max) */
    u8 temp_alert[2];   /* ALERT Temperature, 0..255 C (->_crit) */
    u8 temp_ot[2];      /* OT Temperature, 0..255 C (->_emergency) */

    /* Register values initialized only once */
    u8 ppr;         /* Pulses per rotation 0..3 for 1..4 ppr */
    u8 rpm_range;       /* Index in above rpm_ranges table */

Are you asking for removal of all these variables & each read sysfs
attribute read should access regmap cache directly ?

Regards,
Naresh
>
> Guenter
>

