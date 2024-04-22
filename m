Return-Path: <linux-kernel+bounces-153902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29A8AD4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D0E1C21341
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1F2155321;
	Mon, 22 Apr 2024 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QLOKgyHG"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE6415531E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813458; cv=none; b=Vmc+xFkgd9JH9mExN2ohO0nv+mXGTGfab2CJA7LqvccDWjylnXXsiPGOMomPyQdXPBFiky/EA6+A3U5UePq4eFQGgMJqNjqAp8xqF9D53awjeziWXhgVRzgOhZNh3veEBnmhXx1XjAvU0G3xEMh1kuYuix0wLM6aT/bV8BMOOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813458; c=relaxed/simple;
	bh=/x1SyMb4ASJVh4p8qtH5Zq8S4yTFQsv6VhQl0Ka60Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mpc/jbvCOkE1/T1iuuiG6K6bVoB+y3fwJga7wFG1ejH1Tk1bXzuM8prVGF1WFmXSuSJJ412rEq1GkYSuE1L1PhqjuBuHzXd9Jav2nSvb6kD1cuKkwn4vufPss/y6CQRThADF9BXbZJJX4MaBV8zjTfDME2IkJ8QV+jXzGqd1pko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QLOKgyHG; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-479e857876fso1773097137.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713813455; x=1714418255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/x1SyMb4ASJVh4p8qtH5Zq8S4yTFQsv6VhQl0Ka60Eg=;
        b=QLOKgyHG2qzS57PEqSlBYrgZIZCbBjbe9l2jhcKMbo6vnVFC0O51vGvqnNu4eGErGO
         ORgkk6PUzxyi8n+exYagdYoO1kv94wEzNZl6MWE1XPL5Xpu803pu0zfeXVv/7S9LRiRx
         7OnnOyd2ocl9GvyZy7j4kLeqVxAtbJD3IrC9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713813455; x=1714418255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/x1SyMb4ASJVh4p8qtH5Zq8S4yTFQsv6VhQl0Ka60Eg=;
        b=umr8twX5YlWvFpRaojdgTx8Ap9r1Tp95O8AIGesA7ZEseifloShlhlb1TipkOohNwX
         wWkBJ7Bb6Zn7my95hmSew53UcesKfoc0ROG8WN/Wzk8Pn+przsu9OI8Wg2OkaJpT5fvY
         NJqXDW8TfdwjyoXH0yqxMATZy/S3yjqn4kG2+xnJnavuh6FEC/tECqBEInD7scigmCO6
         wCbE4Uw+7l5Zi4cK/wA+uSJxuosnOvq/10knawqWvfk7zxZHaqpcjWm2eiVNX7HuG/Zb
         6iFiQGUHAgp8E39SZzurTOrqWPCubvnPmgTVHuX1inGt4aZ0v2G56pewxy3Zns+NtDZ9
         zLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0GxSfZo0ukIyAyynyIqcp+u+ebUrsh5cUBowom0o7hVbM7gdjIsTowcfVqnxC163XrHT3BkGJrT4Mp3d9cBWZFfENqA/i7QYbw60H
X-Gm-Message-State: AOJu0YzIAXndIVSIQCdawhu0C1AzhMVqBEfg5sIOSx5LwPAjlgzolY1o
	iITpa6bEEao86MDQW4CjSUMdqeuThtAhFtYhhA5UkosSIUD5teRONpz+qAO+MPy/0Aw9UrAr4IH
	6Ph7L3OQyhBYlDwj0DbYeQFFLgqti8uswtc369SazYh7tnExHGA==
X-Google-Smtp-Source: AGHT+IGat54NrGK6Mz3mBIecbfXww4A+FxvBErevCOh6Np31L1gqxAPJAiVFGy3UCYoqXZahijUsku6TR5cCluT6Wcc=
X-Received: by 2002:a67:ee16:0:b0:47b:f1ae:9c77 with SMTP id
 f22-20020a67ee16000000b0047bf1ae9c77mr3331254vsp.23.1713813455682; Mon, 22
 Apr 2024 12:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZalOCPrVA52wyFfv@google.com> <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com> <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com> <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com> <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
In-Reply-To: <20240419044945.GR112498@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Mon, 22 Apr 2024 15:17:24 -0400
Message-ID: <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

Thanks for the explanation! I still don't fully understand how that
would work for my use case.

Perhaps it would be better for me to describe the case I am trying to
protect against.

To rehash, this quirk was written for devices with discrete
Thunderbolt controllers.

For example,
CometLake_CPU -> AlpineRidge_Chip -> USB-C Port
This device has the ExternalFacingPort property in ACPI.
My quirk relabels the Alpine Ridge chip as "fixed" and
external-facing, so that devices attached to the USB-C port could be
labeled as "removable"

Let's say we have a TigerLake CPU, which has integrated
Thunderbolt/USB4 capabilities:

TigerLake_ThunderboltCPU -> USB-C Port
This device also has the ExternalFacingPort property in ACPI and lacks
the usb4-host-interface property in the ACPI.

My worry is that someone could take an Alpine Ridge Chip Thunderbolt
Dock and attach it to the TigerLake CPU

TigerLake_ThunderboltCPU -> USB-C Port -> AlpineRidge_Dock

If that were to happen, this quirk would incorrectly label the Alpine
Ridge Dock as "fixed" instead of "removable".

My thinking was that we could prevent this scenario from occurring if
we filtered this quirk not to apply on CPU's like Tiger Lake, with
integrated Thunderbolt/USB4 capabilities.

ExternalFacingPort is found both on the Comet Lake ACPI and also on
the Tiger Lake ACPI. So I can't use that to distinguish between CPUs
which don't have integrated Thunderbolt, like Comet Lake, and CPUs
with integrated Thunderbolt, like Tiger Lake.

I am looking for something that can tell me if the device's Root Port
has the Thunderbolt controller upstream to it or not.
Is there anything like that?
Or perhaps should I add a check which compares the name of the
device's CPU with a list of CPUs that this quirk can be applied to?
Or is there some way I can identify the Thunderbolt controller, then
determine if it's upstream or downstream from the root port?
Or are Alpine Ridge docks not something to worry about at all?

