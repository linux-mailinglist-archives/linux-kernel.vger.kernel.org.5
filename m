Return-Path: <linux-kernel+bounces-49861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9139984709C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D591F2C24F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512AE1FAB;
	Fri,  2 Feb 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ibtDvv3k"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E631217D5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878061; cv=none; b=jfKU8EIZtWQ+kF4VCaqcK9xZ7/3Fe/fPenyA9Fjwsq2+WQjteSEhwfIdt2oFHa8TdYkKz0XVp5v/pFexKUURU+3weH6p5sVa5KuBsosQnmmxG4LX4MqICNaFUSb3pxSGbn1+j80bYoTQExvX77MrrkKYf+oUH7dXtYp8YotJrMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878061; c=relaxed/simple;
	bh=1wyJXQnKtxG5KcQLBuLXfN9nPIzxAbbDUplVjEvd6Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVYGlGSw+B5oL4Crv0+cZEiXSPVY7LSBQN29sXSRCV8fqmI5OJBd20Vt+tzCwBUvJ5MRC0DHK9WlWp/xVCchmrfVXrh0G/R23+VN2ju8e85zlXEhuG+PXrejuy+7f8upc/rKhC8yEyBVGEqQlcb6XsF3YM1klWZeYG0JlGxQGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ibtDvv3k; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51124d43943so3243058e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706878058; x=1707482858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOWIy2zvMPH1XH46d4jTRJkw9n61PEb1vxh49lVP0XQ=;
        b=ibtDvv3kKv7bpvYjDP7xxV4KkpaoyLjUalNr32bFbuVwIdiNdCk3czM4qlrcrZOCIU
         HjPAp98Qi8+EP6winpZGr9AdZv9qumuoA8fdxMVZYQBE5kufoAb1DPHzGDj7POrIYxs2
         3eaXIkMZtfIQVGvh36ss6NlI/QGt+iH/JEcmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878058; x=1707482858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOWIy2zvMPH1XH46d4jTRJkw9n61PEb1vxh49lVP0XQ=;
        b=RQeLLTAHoTqHp7l291VrOZlw31jzgAVaYoWazOI+FtCYUJc+akYs0/+Hm4LpdLtA/+
         +tNtNk1NAw7iTMVB3FX4qTR9akYRXmOSmutivMGDHbQy3YWiozpiEgjVvUHsTqyXbWsg
         n40tObBUWVnfS8fnSwGKFmI3CkSQR1TgnYkegl1arZpkb3HivaNExxo8JPelK3D6tFGK
         H3uGnWTAQXlHsQA712TruWx4T+0XhrThmvJbSemNmwclS0ZvBOIO5tIROjyBtWKflVHJ
         wDC/c2TjjSFxjLaT/3m27cdB3Zxo6ppOdqStlCSOUMtnVEJimVO+5fu37IO6C14ihnWr
         HFTg==
X-Gm-Message-State: AOJu0YwoNOmOQHcUugBPSgCk1Fe5WLpyX/NqDGPjLpXD3GbX27pvpLIc
	n8S3Oyc8jsJpKUGsLP3Ei0YBMaJbVGD+97XhsNWRsVAvdcrcPqs2ysFZb1jkHS4+zjS4Cct6Icv
	XfzuQCbwQoxtM+KkATGQ9E4zht59wZGbS45t2
X-Google-Smtp-Source: AGHT+IF0s/5ZKFtzhTR4j6QPvRkkJqWsYRXpAF/+v59PGjiQFmrY1yExMhIMTdn4RO+aKhe4pUPeTW5cDnEklfQlqh8=
X-Received: by 2002:a2e:bc08:0:b0:2d0:7572:458c with SMTP id
 b8-20020a2ebc08000000b002d07572458cmr1827253ljf.1.1706878057840; Fri, 02 Feb
 2024 04:47:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126095721.782782-1-lma@chromium.org> <20240201130605.GA1379817@google.com>
In-Reply-To: <20240201130605.GA1379817@google.com>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Fri, 2 Feb 2024 13:47:26 +0100
Message-ID: <CAE5UKNqNR7869EqjNRdn_osnxLLtJma=eMmsYBE1fvzA0g_ybg@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable branch between MFD, CROS and Watchdog due
 for the v6.9 merge window
To: Lee Jones <lee@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Radoslaw Biernacki <biernacki@google.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 2:06=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> Good afternoon,
>
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd3=
3d:
>
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-cros-w=
atchdog-v6.9
>
> for you to fetch changes up to 843dac4d3687f7628ba4f76e1481ee3838b27a35:
>
>   watchdog: Add ChromeOS EC-based watchdog driver (2024-02-01 11:49:30 +0=
000)
>
> ----------------------------------------------------------------
> Immutable branch between MFD, CROS and Watchdog due for the v6.9 merge wi=
ndow
>
> ----------------------------------------------------------------
> Lukasz Majczak (2):
>       platform/chrome: Update binary interface for EC-based watchdog
>       watchdog: Add ChromeOS EC-based watchdog driver
>
>  MAINTAINERS                                    |   6 +
>  drivers/watchdog/Kconfig                       |  11 ++
>  drivers/watchdog/Makefile                      |   1 +
>  drivers/watchdog/cros_ec_wdt.c                 | 204 +++++++++++++++++++=
++++++
>  include/linux/platform_data/cros_ec_commands.h |  78 +++++-----
>  5 files changed, 257 insertions(+), 43 deletions(-)
>  create mode 100644 drivers/watchdog/cros_ec_wdt.c
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

Hi Lee,

I'm about to sent V5 of patches:
* watchdog: Add ChromeOS EC-based watchdog driver
* platform/chrome: Update binary interface for EC-based watchdog
but I'm not sure how I should proceed - can I base those on the master
branch or shall I rebase on top of  ib-mfd-cros-watchdog-v6.9?

Best regards,
Lukasz

