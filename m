Return-Path: <linux-kernel+bounces-45968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4784387B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A1E1F252A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50C056B6C;
	Wed, 31 Jan 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJAh5F52"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A05677B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688372; cv=none; b=Nzwpz0VCWsGBr6/eElqkCwKrS5Uc8QOBldLmox4jrTNH5ZYSeUkmd5p3BrAfUgb6GxebhQFLV/bb2iiV1f+Er9shj7i8JRF5vazYS+vTH3BXGGsuoVDoxf6zVm4GpYSs/ZgJNX7LGg3dGlPF4FF9vw4yFcpdMSeBrj61RN2+V3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688372; c=relaxed/simple;
	bh=O3NcPrb8t7YnX3CjYpseCkmCegR+NfSEh06RZsASR0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3blo3CXRrRhWE1tf0iMPbiRH+fI//uKeqjqgNooN+GjLxPYkloGZDVRtU8KGYV2z0MHvO87gN4ZTaS5cZ56Vjrx8d/SLu4Me9e/R3JMcQbFj5ru3BQOIIl4YBNMNvjbZ8an/Brwqd5t7mQ1buAe5xZTsaQKnKUTytRRtd6XlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJAh5F52; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ff7a8b5e61so45511167b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706688369; x=1707293169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3NcPrb8t7YnX3CjYpseCkmCegR+NfSEh06RZsASR0w=;
        b=pJAh5F52+w8BuaEvqOPJj/qvAWUYhC1yUzub8gQICWfh0e8clZWrbiP/Pysh/iCOVN
         h9V3tbJnYGsbNKE9uJPYDm3svWk/rZI/mijG90rNipVbOFzydx7pVBSb0SOWM64CD1AV
         iowj5JCj8s4wRMHRlpSj5eR5sHswYPC3IelqVCx79qCAusOH5ffkAZIcLOWsKdpk8RaI
         bXUwOwnz45A7tMxYZ6qa7ympCzhNHn7Bz4OcPJliMxwRfB72vOjnFoBReZ5O/mzq3A5d
         PQWAqSMNrsCOzYmbDL2I2rLkBEnI8JdhUrkO3cbd430Ur1S6RQ1lzdoeA8H7w0EHY5q2
         s/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706688369; x=1707293169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3NcPrb8t7YnX3CjYpseCkmCegR+NfSEh06RZsASR0w=;
        b=sD7xykJAGlJ0xedKNWfJAHhLFuN5q8AaARO9S+BzFCqupK2eIGI5f+IHnLpz6uDZm5
         yT1v1W2nqCMM2yQ8AL4zFr4FXMaZR9sWMgC83f7UDNZ0jo79M7//zQEdt4cXy4WUknXf
         DGeKYbDkBDoQ5DM66kXkHp8MPultL3i5f5HtIYA64uDBB5SarJJzAG3Z+Nubk0lYntD+
         jQQv0c4BKMxveqaM++gaWDO2oLA4ghCXu4zEHAgNxfFV5YB8V19dQNcGkgfWoophMcqv
         NrWHIM3RxoRMgaE6OQvhpJCsFCNLvPeVXF6+g14+JfmRC/vBoHfH8HQiUVvWGqf1U4nL
         telA==
X-Gm-Message-State: AOJu0Yzd2yOl0dGYryQrdZ2nw8fRX7LccIhhhXTINdLobv8gWlvZATJI
	Mxm1NmR3eq/JY+tOYhkUkNw5Zi4qWaeomgX6e4C/Tt4lDTZ47HwdYfUJfJKIQFcd/Z6uaytL84Z
	Jj7J3RVMHIGOoxtNkXEoR8/t5+kzvBLaNv4gY4g==
X-Google-Smtp-Source: AGHT+IHwBZYKjdPkSD3Jf+XYtxk1vkFmihVDnoguJobWmbAAdRRE+yQJUmDl9KcK+DvSlc7YoXrqNhzXKL6xw0pFg2I=
X-Received: by 2002:a05:690c:954:b0:602:ce22:7079 with SMTP id
 cc20-20020a05690c095400b00602ce227079mr618106ywb.41.1706688368926; Wed, 31
 Jan 2024 00:06:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-j7200-pcie-s2r-v1-0-84e55da52400@bootlin.com> <20240102-j7200-pcie-s2r-v1-2-84e55da52400@bootlin.com>
In-Reply-To: <20240102-j7200-pcie-s2r-v1-2-84e55da52400@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 09:05:57 +0100
Message-ID: <CACRpkdZ8Yx_8MoV3eedm14GfyJCm2WVdY=nQ9sEQVeoeec+2ZQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] pinctrl: pinctrl-single: move suspend/resume to suspend_noirq/resume_noirq
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Vignesh R <vigneshr@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@axentia.se>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Tom Joseph <tjoseph@cadence.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, 
	gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
	thomas.petazzoni@bootlin.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 5:16=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:

> The goal is to extend the active period of pinctrl.
> Some devices may need active pinctrl after suspend and/or before resume.
> So move suspend/resume to suspend_noirq/resume_noirq to have active
> pinctrl until suspend_noirq (included), and from resume_noirq
> (included).
>
> The deprecated API has been removed to use the new one (dev_pm_ops struct=
).
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

This needs testing on OMAP and ACK from Tony before I can merge it.
Preferably Haojian should test it too, this is a pretty serious semantic
change.

Yours,
Linus Walleij

