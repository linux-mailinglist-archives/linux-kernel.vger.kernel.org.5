Return-Path: <linux-kernel+bounces-30345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F8831D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB9A286AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA192C1B1;
	Thu, 18 Jan 2024 16:16:16 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3F2C18E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594575; cv=none; b=WufS03Gkl+gWgdGJN+bHUp8MGurV4oZ3c9a9+FBpc3dTmXiC85i3pdy1OOFR2eH/JUn18eNuDqt/kA6+YuNgjUqzYWfGynv4Lxalok8CRC17tlS52twzdenKEC/yxy7zLSlND6jzapM739TONXvmoHzW2fw8g4uOMp40m+6G74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594575; c=relaxed/simple;
	bh=uKYABitkPHkMBYpYoEDTqJexD8KYr1iUJcOLrzvoYoA=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=O2VFIa4wCya+HGNaT2W124JJILVLOT2UiQdq4g9t225iSviCiidPB2+WwsPXt8V5ce9uNLsUyHp/VzQvhwrLYNOpsu7zPXAgnIIwqXP9cezut6p1Cfzanc61WY55b/7ZrrAaZfVQFOlERJzHTr+TTmJzRlOAK/zzIjkcPg0yWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id e194e5ee-b61c-11ee-abf4-005056bdd08f;
	Thu, 18 Jan 2024 18:16:06 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Thu, 18 Jan 2024 18:16:05 +0200
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Message-ID: <ZalOxVZhPkOPvkJ-@surfacebook.localdomain>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-2-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804104602.395892-2-ckeepax@opensource.cirrus.com>

Fri, Aug 04, 2023 at 11:45:57AM +0100, Charles Keepax kirjoitti:
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> 
> Currently the in-band alerts for SoundWire peripherals can only
> be communicated to the driver through the interrupt_callback
> function. This however is slightly inconvenient for devices that wish
> to share IRQ handling code between SoundWire and I2C/SPI, the later
> would normally register an IRQ handler with the IRQ subsystem. However
> there is no reason the SoundWire in-band IRQs can not also be
> communicated as an actual IRQ to the driver.
> 
> Add support for SoundWire peripherals to register a normal IRQ
> handler to receive SoundWire in-band alerts, allowing code to be
> shared across control buses. Note that we allow users to use both the
> interrupt_callback and the IRQ handler, this is useful for devices
> which must clear additional chip specific SoundWire registers that are
> not a part of the normal IRQ flow, or the SoundWire specification.

..

> +#include <linux/irqdomain.h>

Added code doesn't use anythitg from above. 
It can be fulfilled with a forward declaration.

-- 
With Best Regards,
Andy Shevchenko



