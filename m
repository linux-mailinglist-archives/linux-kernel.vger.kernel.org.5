Return-Path: <linux-kernel+bounces-133017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C056899D7C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12101C22CDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AAA16D9AA;
	Fri,  5 Apr 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="khGNRPgf"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950041DFE4;
	Fri,  5 Apr 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321183; cv=none; b=pzS/XanQ6h2ZiovWPmLv/+DiKN28HGfgGolSakBJP44NzEidmMlhYRY1uDVG+73aqf6B/Py6VAqK6elB6kVNtUg/GZkOkExho1zxrFOYFPRQegmpgjvzKsq9FH1bfBEawsEpjbLfxTY3JmAq++hrj8rlzWuWEp+3Y4QT4TTMMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321183; c=relaxed/simple;
	bh=gm0ZJ3hwWUPJSzIsX7xtwKJ3HDC6N44kCFLO3Q8AZ3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1MGjHZAxpeAHMOMcSH2nbficdGBkkVRnBqkYHbN3Y4XepUpJ5udUDCRQEzBb0Oo483Zay/XPpcb+om+x40xXusizqFgSoQPSUa4w8UX3C81sQoD7VPWPh+cjxTiZkAOTbUgucjrdWfTGZ+O7P2CRlRDzcSulAKz4kKI7krk714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=khGNRPgf; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CD2D1BF204;
	Fri,  5 Apr 2024 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712321173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OUOa/kTh8B0RL5iA3hoktsTuc89NZRmjaTGyaKO7ms=;
	b=khGNRPgfkfab4s0WpxceQWjVswJWN1p3fTr9/B782mJDB9zHhj7Oh/yRnz3m3ObrWRzZWx
	JlA1g/ufkJWxeivTMWrxbvwL/uaf87kjHovIZVJkveEixn2Z4d9JLI9Ni4PuDWNLCRUawu
	evDuOwS4ZRh6ATwKde5525oL3H4qklDrcKkE4nyWBKnKBTTp+Qv0tx69lY/8RzWQe27vOT
	zC+gk2coDZIqQV2mhVzjIZIT6x9z58f1R5F4Q8FytTyslaxbAeHYBMyTnttMrpuetc8unt
	eNNpNqJhxJgz1VjCGGvopAJmANMLKpRMmaSSQjr2ZU19e9YHGxwEt5qiYsRP3g==
Date: Fri, 5 Apr 2024 14:46:11 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 1/1] serial: 8250_of: Add clock_notifier
Message-ID: <20240405144611.4b741c63@bootlin.com>
In-Reply-To: <20240405120552.35991-1-bastien.curutchet@bootlin.com>
References: <20240405120552.35991-1-bastien.curutchet@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Bastien,

On Fri,  5 Apr 2024 14:05:52 +0200
Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:

> The UART's input clock rate can change at runtime but this is not
> handled by the driver.
> 
> Add a clock_notifier callback that updates the divisors when the input
> clock is updated. The serial8250_update_uartclk() is used to do so.
> PRE_RATE_CHANGE and ABORT_RATE_CHANGE notifications are ignored, only
> the POST_RATE_CHANGE is used. Not using PRE_RATE_CHANGE notification can
> result in a few corrupted bytes during frequency transitions but, IMHO,
> it can be acceptable in many use cases.
> 
> It has been tested on a DAVINCI/OMAP-L138 processor.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

