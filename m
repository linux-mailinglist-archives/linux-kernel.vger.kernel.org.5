Return-Path: <linux-kernel+bounces-71973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2887F85AD46
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA11F283EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E8A52F98;
	Mon, 19 Feb 2024 20:38:53 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5746B9F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375133; cv=none; b=hJf/2fL2jWhQsggkDAZuihmKKdU+o02ECgEnngr2U5NbzV05eR0ATg/j7/ieq92ha9sSn63pCf6gSPhwqpnoieWS5KIEw5TBgOZwuUCCHmpwfcfqcKJsvQnMwNs2lZPoVXqq1JMWXgceTyKWMRBO7rdgPVeQLjrs8ePTJ0gvP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375133; c=relaxed/simple;
	bh=82r9TO8c5dIxa0Cxd/xkQJ+Q/ndiSntYWwZ4IKipPAQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ6MPTgq8TMqqdI1rJGWpIyI7A6uNO4cpatP9+Ig7pjW99eOX7ljgANGSUHG6qplBWmyC0AX4htz6M/urtzviul/+PsjXgk7YGuSzElBsZGx3bNQGLOb3Malbsd1qzF9efTh1Q0A5CSBdGo9XKyh6WMLnELtJNDtcE1gD0G7jVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id b80b1d33-cf66-11ee-abf4-005056bdd08f;
	Mon, 19 Feb 2024 22:37:40 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Mon, 19 Feb 2024 22:37:37 +0200
To: Dylan Hung <dylan_hung@aspeedtech.com>
Cc: alexandre.belloni@bootlin.com, jk@codeconstruct.com.au, joel@jms.id.au,
	u.kleine-koenig@pengutronix.de, gustavoars@kernel.org,
	krzysztof.kozlowski@linaro.org, zenghuchen@google.com,
	matt@codeconstruct.com.au, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH] i3c: dw: Disable IBI IRQ depends on hot-join and SIR
 enabling
Message-ID: <ZdO8EST8yJ377jXL@surfacebook.localdomain>
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

Fri, Jan 19, 2024 at 01:45:47PM +0800, Dylan Hung kirjoitti:
> Disable IBI IRQ signal and status only when hot-join and SIR enabling of
> all target devices attached to the bus are disabled.

> Fixes: e389b1d72a62 ("i3c: dw: Add support for in-band interrupts")
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>

Tag block is not supposed to have blank lines.

..

> @@ -1163,8 +1163,10 @@ static void dw_i3c_master_set_sir_enabled(struct dw_i3c_master *master,
>  		global = reg == 0xffffffff;
>  		reg &= ~BIT(idx);
>  	} else {
> -		global = reg == 0;
> +		bool hj_rejected = !!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_HOT_JOIN_NACK);

'!!()' is redundant.

> +
>  		reg |= BIT(idx);
> +		global = (reg == 0xffffffff) && hj_rejected;
>  	}

Moreover, you can refactor a bit both branches, like

	bool hj_rejected = true;
	...
	if (...) {
		...
	} else {
		hj_rejected = readl(master->regs + DEVICE_CTRL) & DEV_CTRL_HOT_JOIN_NACK;
		...
	}
	global = (reg == 0xffffffff) && hj_rejected;


-- 
With Best Regards,
Andy Shevchenko



