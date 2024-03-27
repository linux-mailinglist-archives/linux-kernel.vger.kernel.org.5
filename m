Return-Path: <linux-kernel+bounces-121609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD57F88EACA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722EB28DA02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1581327F5;
	Wed, 27 Mar 2024 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvW5xy9N"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7B12C552;
	Wed, 27 Mar 2024 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555672; cv=none; b=eghX7mgOmk4+X1rtVv8jn9724T3XdOFGfrnyhS9+KaILVV4XfSsCYGv52STa5Q0bpDL9cWrD4l3RHPtVbuXMjSRjh4aM1kYA8g/Lhh8qBW6K7N92SDFnk10PQDWTm4Gz1v7KLTM+0gKq5kxKN+XWz62Eb/FCE6EaZBb73QjuKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555672; c=relaxed/simple;
	bh=qd8XkIwmxLisWezHTIfyREA/lnHyigma5+JJYJQKENI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMQ8YfQMZ/NpFi2VWWmS7kocVOiyZ9Y5bqepGGqKTldL7S7mkUmhHTvBDm5VaMD2bO+3VyVveFuIyHK9ObYsQMBV5eK2rrMbvOEUeakzr/X5sfh5bXcvw5eGhs4cyWGi8qRj6HrwhQaYW3D5TjDkOMlPp3To2IBoij8dJAj4v8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvW5xy9N; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41493e0fbf2so6148495e9.1;
        Wed, 27 Mar 2024 09:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555668; x=1712160468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aoTSdMd/YSVHtvQI+80zrqseLyOiRVNHBsZL+C3hws=;
        b=RvW5xy9NC8Vd+SXtveFS5UO2zwpzrbBPqenj5P0PgIEIiMWYXpYaUED8mTVhTKS0Tv
         TR4g56/6UgyVHR+DrQs06hHd0+WrJ227wC330BhkuBXGVVapwUEPfe4NFbkAiHC/HH9B
         9prXYrEGGlv98eCuwOU95W7eLRhy9R4jezsCUSMFTenJo61kIEoP2GkYNwQWmi6oB9eO
         yQpoigzKA5ddnfC8nOP9RtZJEbhYBcQl6x02/Kzg1OtSjOzf03LSHn+JLs1vjtKXqQjQ
         97gMZEaj9p1Tt13U+nlU8AeszjLBZD9KtLmovnvcijBmeO7NjOXbBjx6JkmSTqfDuefL
         0KqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555668; x=1712160468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aoTSdMd/YSVHtvQI+80zrqseLyOiRVNHBsZL+C3hws=;
        b=USIb7sb4u0BJtBhMPZLrxzhWNYIarFr7FdspwGcRd7ZQSS6sEdYT56Nr8zmMLrggKI
         mVLk2hPlGz3AxPjEdeZc9B6tqdLiy0kWWlQtHiRg/aRF1JdpXdggHcMJlYodtqGLgm44
         6ykPskbBHuivYka3XAcgZDW6nJOEnOw2ZMj+C3pSx9AA01ueQ+OVF1cOecrpUhxGc1g3
         OhNJmmL7R8FMR/cmPmdneDNClDRiwiPWMJt6xgcseg7KvzrQOwykJk4QGdFa92rxhzBL
         +fUFsRoCHDkenDE3JAUOiai/t3f4Fw0qdft9NfUhVt65O42tMqFTmKxRZLHCUaLcbCiB
         mxoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrdVkIsAVf4XoBPKUDzUW4QrWsA9hMYDBRiI0pF6yZ7GitHZW7o1e3wTGsC1cJsOWKU6S45v7p9ZpbI/qg6D02CLpmHtlSvS+hMTqJxLVKiNI+FGoJ5v5gwbl3wC4G+KUbAdSw/MUieynDhnyDdtXMjl9jIO1R805Z6NfFgKrL9qp5NP8NKKwh
X-Gm-Message-State: AOJu0YxTe3Rup9plxdlWsvSEBXB1Ky1YFFUe3Ey75Ob7Pspf8g6eStbB
	5CaytFRjNS5IJCAXN+NyIMUm/vUu4R0732YFhBKAX2uUErI0B5BOSuSM6GyMU7wlJsYtlbZVp0y
	JDdTHe4Bjuep3f7JjkVzYPwKQFZw=
X-Google-Smtp-Source: AGHT+IH7/Jqj90OxYt8pWZTIjiz20FfICzxEflsOFI82rOwXB5yBQWTi+VkGbyeoop7QhohLovTBy7V1DlPYZuwJH3E=
X-Received: by 2002:a05:600c:1c01:b0:413:ff06:83cd with SMTP id
 j1-20020a05600c1c0100b00413ff0683cdmr344618wms.3.1711555668321; Wed, 27 Mar
 2024 09:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327085330.3281697-1-peteryin.openbmc@gmail.com>
 <20240327085330.3281697-5-peteryin.openbmc@gmail.com> <f0b03c0b-eb54-420e-a4f7-8286e20b9df6@roeck-us.net>
In-Reply-To: <f0b03c0b-eb54-420e-a4f7-8286e20b9df6@roeck-us.net>
From: Chia Hsing Yin <peteryin.openbmc@gmail.com>
Date: Thu, 28 Mar 2024 00:07:37 +0800
Message-ID: <CAPSyxFQ8Dpks6c17XpF-fw9ppgoKfYfvYADvqVw2PYHNFptWTQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] drivers: watchdog: ast2500 and ast2600 support bootstatus
To: Guenter Roeck <linux@roeck-us.net>
Cc: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 11:47=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On 3/27/24 01:53, Peter Yin wrote:
> > Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600
> >
> > Regarding the AST2600 specification, the WDTn Timeout Status Register
> > (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> > on ast2500 if the boot was from the second boot source.
> > It does not indicate that the most recent reset was triggered by
> > the watchdog. The code should just be changed to set WDIOF_CARDRESET
> > if bit 0 of the status register is set.
> >
> > Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
> > ast2500 SCU3C when bit1 is set.
> >
> > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> > ---
> >   drivers/watchdog/aspeed_wdt.c | 60 +++++++++++++++++++++++++---------=
-
> >   1 file changed, 44 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wd=
t.c
> > index b4773a6aaf8c..29e9afdee619 100644
> > --- a/drivers/watchdog/aspeed_wdt.c
> > +++ b/drivers/watchdog/aspeed_wdt.c
> > @@ -11,10 +11,12 @@
> >   #include <linux/io.h>
> >   #include <linux/kernel.h>
> >   #include <linux/kstrtox.h>
> > +#include <linux/mfd/syscon.h>
> >   #include <linux/module.h>
> >   #include <linux/of.h>
> >   #include <linux/of_irq.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> >   #include <linux/watchdog.h>
> >
> >   static bool nowayout =3D WATCHDOG_NOWAYOUT;
> > @@ -65,23 +67,32 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
> >   #define WDT_RELOAD_VALUE    0x04
> >   #define WDT_RESTART         0x08
> >   #define WDT_CTRL            0x0C
> > -#define   WDT_CTRL_BOOT_SECONDARY    BIT(7)
> > -#define   WDT_CTRL_RESET_MODE_SOC    (0x00 << 5)
> > -#define   WDT_CTRL_RESET_MODE_FULL_CHIP      (0x01 << 5)
> > -#define   WDT_CTRL_RESET_MODE_ARM_CPU        (0x10 << 5)
> > -#define   WDT_CTRL_1MHZ_CLK          BIT(4)
> > -#define   WDT_CTRL_WDT_EXT           BIT(3)
> > -#define   WDT_CTRL_WDT_INTR          BIT(2)
> > -#define   WDT_CTRL_RESET_SYSTEM              BIT(1)
> > -#define   WDT_CTRL_ENABLE            BIT(0)
> > +#define WDT_CTRL_BOOT_SECONDARY      BIT(7)
> > +#define WDT_CTRL_RESET_MODE_SOC      (0x00 << 5)
> > +#define WDT_CTRL_RESET_MODE_FULL_CHIP        (0x01 << 5)
> > +#define WDT_CTRL_RESET_MODE_ARM_CPU  (0x10 << 5)
> > +#define WDT_CTRL_1MHZ_CLK            BIT(4)
> > +#define WDT_CTRL_WDT_EXT             BIT(3)
> > +#define WDT_CTRL_WDT_INTR            BIT(2)
> > +#define WDT_CTRL_RESET_SYSTEM                BIT(1)
> > +#define WDT_CTRL_ENABLE              BIT(0)
> >   #define WDT_TIMEOUT_STATUS  0x10
> > -#define   WDT_TIMEOUT_STATUS_IRQ             BIT(2)
> > -#define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY  BIT(1)
> > +#define WDT_TIMEOUT_STATUS_IRQ               BIT(2)
> > +#define WDT_TIMEOUT_STATUS_BOOT_SECONDARY    BIT(1)
> > +#define WDT_TIMEOUT_STATUS_EVENT             BIT(0)
> >   #define WDT_CLEAR_TIMEOUT_STATUS    0x14
> > -#define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION  BIT(0)
> > +#define WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION    BIT(0)
> >   #define WDT_RESET_MASK1             0x1c
> >   #define WDT_RESET_MASK2             0x20
> >
>
> The above bit value defines were indented to show what is
> registers and what is register bit values. Why are you
> changing that other than for personal preference ?
>
> Guenter
>
Oh! I'm sorry, I didn't realize this was a rule. I thought it was just
an alignment issue. I will revert it in the next version. Thank you
for explaining.

