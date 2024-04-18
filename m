Return-Path: <linux-kernel+bounces-150693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 589668AA31F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA0A8B2583A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C826018133F;
	Thu, 18 Apr 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ra6OSZtY"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0118131D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469402; cv=none; b=oVm9SMWM3c+nUc2N0S48PY7TG/QPRIo3TmQYiaOZFqsNzS5tfGpmNQ/vPP5yOxgRz4DrH27Rmx9YDtW5sCQ9mcmri6qVYjF3RSoyDNny96cUyLugRF0TO8mUv2mSIVpnHCDH4Z8A+nTTjEe80P1lFipEr+DLidotJZC8SCXC7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469402; c=relaxed/simple;
	bh=VbIGz95YZH3XYNg7XInkIfak5ZfhCtKIPtLRE4aQudg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5UezGKfmLUlsTdDDWMUU8Ys7nlrTOJUANCoXC7Ex5Up1+MDw+kbJPXQSh4ma36M+tXEkUH0qaTVafeYRgQOmtJmlNoZYkBH2E7VsIEgkn6QH+VS/GcEYGztEjQAFr9OkmbF8n64cJvymFedsyAzCQO7DNf9QeKv9+y7l4ODmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ra6OSZtY; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-479e57ff63bso433607137.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713469399; x=1714074199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YpGkUZCBQa/pLyWOb8XDuhl5v0v9yjefjo0KD4tR0lQ=;
        b=Ra6OSZtYCimdkymXprSN7VMvRz5dMtNTwbO58pKWFa8hH2RpgPH6Lg2MVmZ3Mdeucr
         3HWsgS97nRuge6qAojGMYcgap24wN0D/P7JYP1l5r/sWRVvQV2p7AF/P8WH1H207zkwm
         NecLT+NwTAI3CsFXE31djYuFBECejWr2HpE4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469399; x=1714074199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpGkUZCBQa/pLyWOb8XDuhl5v0v9yjefjo0KD4tR0lQ=;
        b=SQXe0dM6cfJM6UbPg5Zc2RQMxU7USH4l1KB30fHVm4HrxJxjZ3I/r9SKM0ScXrbJSD
         31GpbY5BRBDLUamBcqgX6qBxrTSguO5chGV21t3QFkQyj5hEJFGvUBn7vplF5Wt16me8
         GZp7xd3PDBd7zKdh70pMv79dOg6E1ehaWvfq0QtHs6QOwnv53DgjwEDbIn/4vQyzmfbB
         NEN5+/FMtdAL6n1xA76RhUMrQz8sljTRXG03Wh5y5XLlErAEfvm/Uq5KqE1B4q9mSD3r
         pKkp1xVUwi2VthL4jDn1e8Xi9uS5GDqBhds+b+m+mTWbE8lL1qb9+SXyYfop2REVpz9V
         WOUw==
X-Forwarded-Encrypted: i=1; AJvYcCVpRT2ZdLZ/okeS0+Kxn5auODYMcGxvRRcX+yrFX7TxFIksTLFTbCSMWzcDddJLzcEN4MbyXsTE6+Iw6k5a6K0rj05gZOX57GjdXSaY
X-Gm-Message-State: AOJu0YwoJYiwfrSLNEMMyduC2tCmmPYcWBD6OL0Z5Wlobsoa+noxRoA6
	tJA6HDAOM5DPIQMsPczARK1TM4Dm9BV3PDHvNpEIsGQl0bSjc44jCUxq3Q0FlHKZb6trIieHRWB
	+RLJWT+nDNndSKRFCoeITRTEFABtFif1sl74+
X-Google-Smtp-Source: AGHT+IECjWKB6YH4nmd2JutpjqRG2yKbFCZooTJpITrlEUsuTUJk/P5FN2jEfGiO3NADYx74ECyoS12q0xh1/WFROLI=
X-Received: by 2002:a05:6102:3ed4:b0:47b:b405:e479 with SMTP id
 n20-20020a0561023ed400b0047bb405e479mr5002750vsv.22.1713469398922; Thu, 18
 Apr 2024 12:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118060002.GV2543524@black.fi.intel.com> <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com> <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com> <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com> <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com> <20240416050353.GI112498@black.fi.intel.com>
In-Reply-To: <20240416050353.GI112498@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Thu, 18 Apr 2024 15:43:08 -0400
Message-ID: <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

Thank you for your response! It is very much appreciated.

On the Tiger Lake device I was testing on, the usb4-host-interface
value is NOT listed in its ACPI.

I then decided to query the ACPI values collected from devices in my
office, to see if this issue is limited to my device.
Ice Lake - 4 devices, none had "usb4-host-interface"
Tiger Lake - 31 devices, none have "usb4-host-interface"
Alder Lake - 32 devices, I see that 15 of them have
"usb4-host-interface" in their ACPI
Raptor Lake - 1 device, does not have "usb4-host-interface"

It looks like only Alder Lake has usb4-host-interface  listed in its
ACPI for whatever reason.

It seems like I cannot use usb4-host-interface as a determinant
whether the CPU has Thunderbolt capabilities (thus not needing a
discrete Thunderbolt chip).
ExternalFacingPort is listed in devices that don't have CPUs with
Thunderbolts, so that can't be a determinant.

Am I missing something?

