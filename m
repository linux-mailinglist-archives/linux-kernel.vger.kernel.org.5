Return-Path: <linux-kernel+bounces-87593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37C86D64A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7551C21D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC896D50F;
	Thu, 29 Feb 2024 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zrosst/R"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515516FF2B;
	Thu, 29 Feb 2024 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242991; cv=none; b=EYato30pkr9uLRJe7l8bkTyyyK16edtshz+QsJ9RJo4TGLmQsOxkAB7bGeghCUDfG4KZ188oOSMTdZWGR/+bMBzE634B695tOK7CD1GlWQon6mr8kdfQe4hmm0vMWp3vtZ1nHBi3hYmi77wj7O4pXEvX8S5dn4OGik1kcC1YDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242991; c=relaxed/simple;
	bh=TN7ukpRAnvDh6NBrd7p6obmiLiecfrTl5mJrQ0iRthU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc/sbd2s7VeFFtHcriTDd3eQUUyJ1nlH/kGuVpa0zodMEhXUH3XwbWEX1rOMiUYYNzZBNx7WMFQDP2yw/9UQOYRl/fLTDS1FQNyVbvOnrD9DhexXzlpB5slFB1bVn8KkRsHUy4Ppe17DtLj/9lGgKNYDdzo81kFtusAe/MkV1HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zrosst/R; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EBF260005;
	Thu, 29 Feb 2024 21:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709242987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OShvIFfEdMeWCoFCfPRr8zGu3Ce+ntI0blKGZdKOKZ4=;
	b=Zrosst/RLgBz/8e6Xq91zLKNnC8Qh301tjNQ6ZiiwD9MKqHD9opx0D6D250TBV3ZYqcdvb
	XVtHoP03RdGKqgfvKd4/Sp6gEjyzzFjYER0Fq+5D8vjvVSs4yQ6darMI8IBWk88VEXbuU1
	dAcEIL1lTHxtDTtB3lofzYVAp7gZt1rSooGgp5eINeby3pAWycP2P5GdkoL93mqoWOoTMO
	dTrXwxVthwa+H9MJXWgppI9HV+49u3L7c/ZB5LRXuJsqaqfd35EM/pwjBNqaOeS8gFbV4B
	RNRiVNCZRJvGfBMCRU7uVDKd1xgldhKLqESdPtEgNNWdETprmoeF7/ALG8pWdw==
Date: Thu, 29 Feb 2024 22:43:06 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH] rtc: max31335: fix interrupt status reg
Message-ID: <170924288521.1876058.17039410988641228858.b4-ty@bootlin.com>
References: <20240219091616.24480-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219091616.24480-1-antoniu.miclaus@analog.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 19 Feb 2024 11:16:15 +0200, Antoniu Miclaus wrote:
> Fix the register value comparison in the `max31335_volatile_reg`
> function for the interrupt status register.
> 
> MAX31335_STATUS1 macro definition corresponds to the actual
> interrupt status register.
> 
> 
> [...]

I hope you realize that this is exactly what Guenter was referring to
when he said:

"It seems to be quite common for automotive chips, though, that they are held
tightly under wrap, making it all but impossible to properly review their drivers.
I have observed several times now that information not available to reviewers
resulted in bad or buggy drivers."


Applied

[1/1] rtc: max31335: fix interrupt status reg
      https://git.kernel.org/abelloni/c/c12e67e076cb

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

