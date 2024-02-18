Return-Path: <linux-kernel+bounces-70622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34715859A32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 00:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF5EB20C60
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F757318E;
	Sun, 18 Feb 2024 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LJkToLRM"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449AC568A
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708299193; cv=none; b=fdmXnKhMCYgfEhx9xI9pBwdkdXLjiV/WamP1XAgypj7TyIsvy8isTEvNRdjr7q7IpxNvUMyG97ApsncuUps0FtBpH5MWxjYXBpYDpjjAKHIxOefeVIrxnEoR+6JdhlWfckmx4EyWIpQ8XcIC73eCl5hwLiPOlqcED9ouovV8dfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708299193; c=relaxed/simple;
	bh=+A9nrD0SS3/cpYucASmSV/AQmZc/LmI+Nlb9RUyZPvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyG5xDNpDT3kEL7IOzbJBeehj4F9BM1yK9Dz7dOlC53pVB3P+QcrRd2pa5z2PgPxz5hij3DZ94irB2Dk+RVgT3SIc4YG/J/cbW8Qn1Zi+0FK9c1JOFGa8r0cuuNAGtCtxU+pasEzmz+9wdjT/2AGncurvxx8WrU4qPFKliCG5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LJkToLRM; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 851F01C0002;
	Sun, 18 Feb 2024 23:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708299181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+no/GNABth1l0cxT+LAZBU7GSVGx2JdSvGLYECdt/oc=;
	b=LJkToLRMsmXu/iAfv0cwBNopGZkv8ral52E1ilxtwB58ecLPgIjqm5j/33+l7oXcQR7/Iz
	goi5Mh70PwQTsFFIpbB0qc/GnOkDkdKannSDtdAA9oHcIeOaqiUCDDnbVsGGU8xpIPuc0s
	hzNPxyYVSYRJs3kA+MlDOe/8/WMKe8MEWSaOo/wl+moTNu7XGtTllPKtBmuQnhQpwehm/z
	ac3kmjVCfExSRWWHXyE6MiJhBCbDCZ7m15E2vpKRfya5wXxCzpCBwdf77uwI6jPTSLqDnZ
	uiWp7wve057vMuO4Q6GgmCUK2fMrAah12cndFsArogAz6xIEd/N4SKqLp9muBA==
Date: Mon, 19 Feb 2024 00:32:59 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: jk@codeconstruct.com.au, joel@jms.id.au, u.kleine-koenig@pengutronix.de,
	gustavoars@kernel.org, krzysztof.kozlowski@linaro.org,
	zenghuchen@google.com, matt@codeconstruct.com.au,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dylan Hung <dylan_hung@aspeedtech.com>
Cc: BMC-SW@aspeedtech.com
Subject: Re: [PATCH] i3c: dw: Disable IBI IRQ depends on hot-join and SIR
 enabling
Message-ID: <170829917129.1161351.6293000766390759805.b4-ty@bootlin.com>
References: <20240119054547.983693-1-dylan_hung@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119054547.983693-1-dylan_hung@aspeedtech.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Fri, 19 Jan 2024 13:45:47 +0800, Dylan Hung wrote:
> Disable IBI IRQ signal and status only when hot-join and SIR enabling of
> all target devices attached to the bus are disabled.
> 
> Fixes: e389b1d72a62 ("i3c: dw: Add support for in-band interrupts")
> 
> 

Applied, thanks!

[1/1] i3c: dw: Disable IBI IRQ depends on hot-join and SIR enabling
      https://git.kernel.org/abelloni/c/10201396ef64

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

