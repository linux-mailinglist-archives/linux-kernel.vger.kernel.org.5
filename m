Return-Path: <linux-kernel+bounces-45399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7CC842FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31A41C23DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C778661;
	Tue, 30 Jan 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Po/F5nmz"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948F7BB01
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653861; cv=none; b=hwoEgMXUFfj0bVDdL13T3vKEWIoWpx5pF7xTb8uPCMMGgcZp+7zyycUOaR+VO5Xhdvh5j4v5YSQha6upbJFW7fz1IN+OCs+8BA58i2WZ9EWtcdh3GGVTdZaz1kuvlAhj2oY+ovKbvkhT7K4gOsPWSGf5IZYBaBcF0dfD9Fuir5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653861; c=relaxed/simple;
	bh=5HmmswglN9pKy7g/0osHBxBGg837xJKysUQuN28gYCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhUHxCPWm8QqJDh4fAp08oAd0qycicLenSLWGGcZr89DxWsl7PFrZ9uOos0CSv/dlKjFW4TfyZd2UONsaNA4ZF3RMs79+VV0wylce6URSin3AjmS+09QKTEaUCOpxB8S/hXruHd94of3ArBba21G257DY7fPUokamaDKPN8EFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Po/F5nmz; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc226bad48cso3944396276.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706653859; x=1707258659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHsI7G6NUmy3rPPwHz9CEuB456j8VcvU1g80bBBdmy4=;
        b=Po/F5nmzXFvpYSgc3N8xcqQCr64afyVWlKhdEXHpxsEx6HIQadDbOn1QpC/lKAwyIo
         i+B+PcFZJko7gfD94/o6DWj9lDuOYhLpy00jVQ7AXSLBJGA0Ovm+f2FQDq9ro9tVQq6M
         dnW6OEebcGPsKEtVr1m/s3TNZrA5aEGmwCgQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706653859; x=1707258659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHsI7G6NUmy3rPPwHz9CEuB456j8VcvU1g80bBBdmy4=;
        b=YD8aS5MX1oeJwk5MCyNhPwQcG8nUgM+T0nGmxY4FxhiSRdgiJ5VR9Hs0M2+F6if/VJ
         AsjpBSJdVahQOkGWuo3IYjhN+JboyxU+u+ii/ZLVmQAX2FMCmzMNzQiqfledZLj3LX9B
         CVChdup62G/Iey9gOyfvdCbZrNy/eBI/hB4YALlwkbZPyn/Y34s2Hhi1bRpi4sACTjue
         lWY/IrOvUHJ6C03eYaaWHyHr7WRWgCf5CuyG6Q+zK+USs8bHf1W2/H2fewIP7MRiVxH6
         w0iToBHvFLGbKxPQI9TscYp6QXkSvOKIeC3JY2Yyfz61Fvaovd18rymLEcwx54eKjenu
         TJcw==
X-Gm-Message-State: AOJu0YwkhobDrIGGman0Es23iOTEkQYD1IYfiXov8XBfHPOeTp5V8YaE
	QvrOoC38mc/p2j/vmmqFM3us6BjqxXkE3jq6kYVL/Ji5kbYkqvLRidiyGA9igbux+yDiRCU7DgL
	vmWInoeGvZ5cQuepDyMKSsOVu34DE0wzZ4bZb
X-Google-Smtp-Source: AGHT+IHMScdK7mGPuwHixhxjRCDpmBCo5GXuOWgJu/vIpXO032ijbHWpSLsxWPzpaIR1UM/1sJfFdkxClOeiOaSYPlM=
X-Received: by 2002:a81:eb0e:0:b0:5ff:6084:421e with SMTP id
 n14-20020a81eb0e000000b005ff6084421emr6945261ywm.32.1706653858789; Tue, 30
 Jan 2024 14:30:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126183930.1170845-1-abhishekpandit@chromium.org> <8cf38c26-c8ec-401e-8aab-527ef811af90@amd.com>
In-Reply-To: <8cf38c26-c8ec-401e-8aab-527ef811af90@amd.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Tue, 30 Jan 2024 14:30:47 -0800
Message-ID: <CANFp7mV-DiHq_aZZNF0E4e=-aQUupxg+ECwj5dsaG-n4epa4CA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] usb: typec: ucsi: Adding support for UCSI 3.0
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, jthies@google.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashanth K <quic_prashk@quicinc.com>, 
	Rajaram Regupathy <rajaram.regupathy@intel.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 8:06=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 1/26/2024 12:39, Abhishek Pandit-Subedi wrote:
> >
> > Hi Heikki,
> >
> > This series starts the work adding UCSI 3.0 support to the UCSI driver.
> >
> > There's a couple of pieces to start here:
> > * Add version checks and limit read size on 1.2.
> > * Update Connector Status and Connector Capability structures.
> > * Expose Partner PD revision from Capability data.
> >
> > These were tested against on a 6.6 kernel running a usermode PPM agains=
t
> > a Realtek Evaluation board.
> >
> > One additional note: there are a lot more unaligned fields in UCSI now
> > and the struct definitions are getting a bit out of hand. We can discus=
s
> > alternate mechanisms for defining these structs in the patch that
> > changes these structures.
>
> On the Windows side I notice that Microsoft explicitly checks the UCSI
> version to decide what data structures to use.
>
> https://learn.microsoft.com/en-us/windows-hardware/drivers/usbcon/ucsi#uc=
m-ucsi-acpi-device-for-ucsi-20-and-greater
>
> Perhaps doing something similar makes sense in Linux?

That probably belongs in `ucsi_acpi` and would be good to add there. I
don't have a Windows device reporting a UCSI version 2.0 but wanting
1.2 so I can't add or test this patch.

>
> >
> > Thanks,
> > Abhishek
> >
> > Changes in v3:
> >    - Change include to asm/unaligned.h and reorder include.
> >
> > Changes in v2:
> >    - Changed log message to DEBUG
> >    - Formatting changes and update macro to use brackets.
> >    - Fix incorrect guard condition when checking connector capability.
> >
> > Abhishek Pandit-Subedi (3):
> >    usb: typec: ucsi: Limit read size on v1.2
> >    usb: typec: ucsi: Update connector cap and status
> >    usb: typec: ucsi: Get PD revision for partner
> >
> >   drivers/usb/typec/ucsi/ucsi.c | 49 +++++++++++++++++++++++++--
> >   drivers/usb/typec/ucsi/ucsi.h | 64 ++++++++++++++++++++++++++++++++--=
-
> >   2 files changed, 107 insertions(+), 6 deletions(-)
> >
>

