Return-Path: <linux-kernel+bounces-166184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D26A8B974B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9013A1C21657
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E252F92;
	Thu,  2 May 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hl9WobmC"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845953362
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641126; cv=none; b=mo5eI9QSUpcIYqbGNGMSSqO5df9LK9FXbudS8QhZFdJoFNU6W3ymvjGzlIR2RAROXbsCx2Szyz8p5eSzqsWiYQOsTzI56jt6ABtvk6KK9qCDJn0DN07vj3bfnd/iqbWRJHflbL7UpfhFfYg0Xmm8BqSfguhoZ97E7wiQ5gyqKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641126; c=relaxed/simple;
	bh=QQDvn6Q8TkCbmjMUDI4cHKI+ospj5DHXLnkdPbN4GLU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyRxbi0ww6iSGsMt0P7VytkUruBsyyb8em4ooP+vKThnmk+sy4Q4cSJJsroZgtAgsFkt/NEfqEVrE85QskAN9H2C1v6buVYxIH5BgpLHWfXxNmrtXkdObvtfCF9hHg37s8B5dFix6nqWNEl32bm032/X4LjpdbX021mpYrcn/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hl9WobmC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58772187d8so898233566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714641123; x=1715245923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKBISEz5hivbFgsL9sOrWIy+M0J+RrEQV3Dl9y05i9U=;
        b=Hl9WobmCJjmT63XPi8Rvic4HP5QhuB+fDVcGezn8lySClSevvmwl4pm1uz0CXYhdzg
         gnYheJ2ua+kxAngBZOqyXsPXxqmMtNbX9ND9IsR09C3Od4WTzQNCN4v5HhgNDPMYdh/2
         CWCVH/tvbsk6Am86OEhXcsiZkVRHemNPg6Fgbz4Z5p0jy1flwof4Py1B2ic35vnKbl5q
         RRVTUz4cDXlG957Cta+czzr8h9Uodw0AAvTdlZbCciuod3BqoQ8URap7rYgutkBm+A7u
         GRQeH6H3ieW3j7L1ZPiHsi5R+oZkEk3XoD7kyMIk/AARjoeRMHWUnmZENU7E7BsFHEjR
         uatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714641123; x=1715245923;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKBISEz5hivbFgsL9sOrWIy+M0J+RrEQV3Dl9y05i9U=;
        b=UO5wNGdhJGuwzor4IdrV14d3aOqx/Xs64Zms8QUAXcBLLyrc+LadpEQD7sqMuZTO2f
         oyeIsj8TE4NutnZ28/1S/0dNiywfMqkIapDL/edvdVzYF+c6WvE6K1PBKCR3fmaK65fl
         mcttxNJtRChY7aiHbqiP3+3y4OGfpQJhK7ceSTBOTWlM/lfVXt9BlxObQS0Zz147bhmn
         8OXSOO3ShzAPYmdXUuCRtRELELERQEOUXBCJk/Hfsi3osopkAeETQfTnT1iQqhgzl/5h
         S0yxQJIwuH6Syftv5Kyz8Ygutyu6LKSe/eaWolgJCpvOyxEudB4DFRgpJE5hhqsyxA9R
         Pkgw==
X-Forwarded-Encrypted: i=1; AJvYcCUae7b6KVEO9hZlj7OG/BZsGi0exYbFrff/jubRfWeQBTWHWAYBj26PX23YIfEtPZtnhUfWgpAlAu5w6s8u+9m9h5zxNa+9sDBN6/ep
X-Gm-Message-State: AOJu0YyixSgeDhdZbEsGz3HD4um2sN33OqGuxKSr6zhJnkoYcpt6HPtY
	gDAfOUh3NvgTVqvipRgpWXwANh46dOQ1BUxXkpbjHzSbzKo/c/w5q4vjMm11wOA=
X-Google-Smtp-Source: AGHT+IHQ6L475JtRROpjybMx/lyDKdF98v0PWXkxGP7wEay+2VSkVed/s8BZXiNF9X43dqxWFA0H2w==
X-Received: by 2002:a17:906:79c3:b0:a58:9707:685b with SMTP id m3-20020a17090679c300b00a589707685bmr1128611ejo.16.1714641122948;
        Thu, 02 May 2024 02:12:02 -0700 (PDT)
Received: from localhost (host-87-1-234-99.retail.telecomitalia.it. [87.1.234.99])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709060e9600b00a5887833da8sm315074ejf.81.2024.05.02.02.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:12:02 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 2 May 2024 11:12:06 +0200
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 0/6] Add support for BCM2712 SD card controller
Message-ID: <ZjNY5qY4ABOB3lv2@apocalypse>
Mail-Followup-To: Stefan Wahren <wahrenst@gmx.net>,
	Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <fd77cfa2-9bd8-4393-95bd-eced676bf6d2@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd77cfa2-9bd8-4393-95bd-eced676bf6d2@gmx.net>

On 12:07 Sun 14 Apr     , Stefan Wahren wrote:
> Hi Andrea,
> 
> Am 14.04.24 um 00:14 schrieb Andrea della Porta:
> > Hi,
> > 
> > This patchset adds support for the SDHCI controller on Broadcom BCM2712
> > SoC in order to make it possible to boot (particularly) Raspberry Pi 5
> > from SD card. This work is heavily based on downstream contributions.
> since your goal is minimal Raspberry Pi 5 support, i suggest to use this
> as the subject for this patch.
> > Patch #1 and 2: introduce the dt binding definitions for, respectively,
> > the new pin cfg/mux controller and the SD host controller as a preparatory
> > step for the upcoming dts.
> > 
> > Patch #3: add a somewhat reasonable (*almost* bare-minimum) dts to be used
> > to boot Rpi5 boards. Since till now there was no support at all for any
> > 2712 based chipset, both the SoC and board dts plus definitions for the
> > new Pin and SD host controller have been added.
> The patch still seems to contain a lot unnecessary stuff (Wifi, BT,
> SPI), please try to remove as much as possible for the minimal support
> (just boot via debug UART & SD card) in order to make review easier. Btw
> this patch must be after pinctrl & SDHCI support.
> > Patch #4: the driver supporting the pin controller. Based on [1] and
> > successive fix commits.
> > 
> > Patch #5: add SDHCI support. Based on [2] and the next 2 fix commits.
> > Drop the SD Express implementation for now, that will be added by patch
> > #6.
> > 
> > Patch #6: this patch offers SD Express support and can be considered totally
> > optional. The callback plumbing is slightly different w.r.t. the downstream
> > approach (see [3]), as explained in the patch comment. Not sure what is the best,
> > any comment is highly appreciated.
> I don't think this should be necessary for minimal Raspberry Pi 5
> support. Maybe this should be addressed later.

Thanks for all the feedback. Just a quick note to let you know that
I'm working on V2 patchset that will fix all coding-style and dts/binding
issues. The new patchset will be significantly smaller and I managed
to remove everything that is not strictly needed in order to be able to
boot an rpi5 from sd card.

Best regards,
Andrea

