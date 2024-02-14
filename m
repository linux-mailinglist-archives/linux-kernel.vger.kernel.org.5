Return-Path: <linux-kernel+bounces-65789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89D18551DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D09C1F293E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AAF12C819;
	Wed, 14 Feb 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PSU0UOPZ"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F28527F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934329; cv=none; b=bNE+sTfJ9sqgmiltbU9nnNBoMwoJrLHT3ELbBEiHErByn5y5+zzKBy+KhiGu2KNfSRtwgVBKOt1EYCCakUWXJMGuH5rRrUWbmvmI/00pPUja90dFPPMxfUKfW4hdJK20qPsL1O3pnMAnYxG639fuasBAax6HjvYka74MnZYPrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934329; c=relaxed/simple;
	bh=OE9ONYhRtt1RT9UxYhOGWQZAzy9csxc4vRQdMTFcZmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sV/3uyMoIuNU6pDVgPcVOJgduuQMXAUYaxlzvDTKVdF+MgiQbms5/owF59OSS5uuQDiJp0wiTyn5PB1hWWUgjpuhTRECvJESRRQDC+vYJ6n6HX0XMxP2D4ZOPegrvuB2oxL4SXKenOr9GarhE0x/kI+4hN7EXHy2rBvqfMZq/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PSU0UOPZ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68c431c6c91so506176d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707934325; x=1708539125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OE9ONYhRtt1RT9UxYhOGWQZAzy9csxc4vRQdMTFcZmE=;
        b=PSU0UOPZ9NlWZVaWaV04SwNGPWr91c8VwQpPIbQYsFzhvQSd0XngDiCSSn54Ab1LU2
         36U06+osPCMF799tHgtOPeHi9Jus2qgofT2kNlGvWu5i0iFGT8o0Yk8p/pmBhRD0dahw
         vEmPwKcgBj5fHXRxX9KCnCMdnukJKllrnemoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707934325; x=1708539125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OE9ONYhRtt1RT9UxYhOGWQZAzy9csxc4vRQdMTFcZmE=;
        b=TQrk1rLeE0RzaMikVFlopS6CjvV3blz+HxVbcgtzJ6Oa4jwiSHciNzCQdxI9/vhWCb
         dbKhSxwKOygy9pPpjEHBayeAfL/ABFKiu4awgs54Ve4ihJ7dtEphjaWmFxC1CSIBdM8f
         uyAsIY43qRToQuLoza63mVGnjIrz5+wY5kO1v5cU2aIAkiGVQyLFE3BWw/w3tp/0pZc3
         37WnO3lxQ6whhcIukeyhk2ca+c1FfVbgu0Nc1pY0t0BYguU4ERULsucN8C9wjFbRmu0n
         38cikOpLnejFdOnhCgurehLBt1vCbCkrfrJONbV5fX29TTOStHKAAONcpXcn8464hDEr
         Yabw==
X-Forwarded-Encrypted: i=1; AJvYcCV3gIV2J4XUa4WZQVlYJcpX751IjRGgWVvQqFtwJP8g1eIJeYu2iT51btd/OLTRK4Vv2XwYXjtros2OGSj7UwBrOtz7L/5NrevuozIQ
X-Gm-Message-State: AOJu0Yz+vOWaLIFFFDOBRD3JIStUiUISXtuoW7DVoMmIGEzUcHFIW6vx
	ewVrMkJUwRDJMO9SKkTCh0E8oDePIzrm5NWE7Y/uqWwf6fdGXhfYhr9+u96nPUagB+W+3ru2abT
	bqknrXwlyoHg1Rtn19A8rXfHY6yZGqWFGTHpK
X-Google-Smtp-Source: AGHT+IEgrWvxXcraQzc1baiUPwiEzauqEskx3AucYV5QX8er4b9bpYzTMRyz2B2QxRzh4QRdmPCoEcLyLXCe6Vd4YFM=
X-Received: by 2002:a05:6214:e82:b0:68c:da0a:10ef with SMTP id
 hf2-20020a0562140e8200b0068cda0a10efmr4022290qvb.57.1707934325206; Wed, 14
 Feb 2024 10:12:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213130018.3029991-1-heikki.krogerus@linux.intel.com>
 <20240213130018.3029991-3-heikki.krogerus@linux.intel.com>
 <CACeCKadLKg89c8s68QD6VsqiKBMms6765O7mFFihqtET30pUyQ@mail.gmail.com>
 <ZcyUblecufzeso17@kuha.fi.intel.com> <CAAuZZi9h=d2_CM4tU4-H9wJfhLZbw99X2dGSddiCeDFDdb+kjw@mail.gmail.com>
 <ZcyrCosNDXxGZh9O@kuha.fi.intel.com>
In-Reply-To: <ZcyrCosNDXxGZh9O@kuha.fi.intel.com>
From: Prashant Malani <pmalani@chromium.org>
Date: Wed, 14 Feb 2024 10:11:53 -0800
Message-ID: <CACeCKacOFLKGCBTuFTVj+=W9C+rC++7DfzkG=M23i0Qh4qTOxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Make sure the USB
 role switch has PLD
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Emilie Roberts <hadrosaur@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Guenter Roeck <groeck@chromium.org>, "Nyman, Mathias" <mathias.nyman@intel.com>, 
	"Regupathy, Rajaram" <rajaram.regupathy@intel.com>, 
	"Radjacoumar, Shyam Sundar" <ssradjacoumar@google.com>, Samuel Jacob <samjaco@google.com>, 
	Uday Bhat <uday.m.bhat@intel.com>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heikki,

On Wed, Feb 14, 2024 at 3:59=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Emilie,
>
> On Wed, Feb 14, 2024 at 12:04:22PM +0100, Emilie Roberts wrote:
> > My understanding is that this is related to the wiring spec and not
> > ChromeOS specific. It seems possible that OEMs making non-ChromeOS devi=
ces
> > may have this same issue. Or are we certain that only Chromebooks will =
ever
> > see this?
>
> Non-ChromeOS platforms do not have this issue.
>
> The issue is with the ACPI tables - the USB role switch ACPI device
> nodes don't have the _PLD object on these systems. Ideally this could
> be fixed there by simply adding the _PLD to those ACPI device objects,
> but I understood that that is not an option.
>
> But maybe I misunderstood... Can the ACPI tables on these platforms
> still be updated?

Since it's just a _PLD update to, it should be possible to do a "light" fir=
mware
update on the relevant boards. Shyam/Emilie/Won, how practical is this?

I'd much prefer this to be fixed properly in the ACPI table than relying
on this quirk.

IAC, if we absolutely *have* to use this quirk:
Acked-by: Prashant Malani <pmalani@chromium.org>

Thanks,

