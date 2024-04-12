Return-Path: <linux-kernel+bounces-142225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B44A8A2922
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106F31F225B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A46E502A4;
	Fri, 12 Apr 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LJortwtJ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151BF1B81F;
	Fri, 12 Apr 2024 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910006; cv=none; b=sdHXO0dStF5f5fhQe5VSy2V8C7OFZQsL40DOeIUc0WCyDt6E7hpPs13Pp6ecLdwyV0WwXXvNUz35kS8kgJqvGo+voyoOLZzdYAPT/7AikFuYHjT5hxSRxM/0sJbyPQKPHFwklGvJeKWvx90uJ/Uw2r52hXhMB/a4axJdwJ5G8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910006; c=relaxed/simple;
	bh=rRzEB6dvQPHneXOyv9fiIxg3zpPLShbTpZi8aZw6UhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd+PkbwuQHZ5494peibpwYMygp0yMygG9g7MPFO99qTBWAuNZpvn30hfKISAvXRjOecEJHPPshe7qFjFral/gpw8TWNJdoC0ddPuAXTbGmTTA6TqL941O/Z4T+Tf3CtAbdKehXROp4CWHuZYsh/L62YSXLUCKfU1Jd32RTRFhls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LJortwtJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C23821C0006;
	Fri, 12 Apr 2024 08:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712910002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJUCIMn/rajlyaxnzTNwaSCWbhEzp97H4xnhV905vNo=;
	b=LJortwtJQGNY1eJbDqWKF0mbUu0wPY02T1X/U3Q6Sl9WboKySSj6lhd/4CFBa6jpmnUFoO
	zWfp8i0vng69W5sOjVS2xplF+bkHDIvCHxWpozMmDZ+HFy3D762e9WMqlxsv41MiZdS5N1
	7y0mmaZsQB0Zt8wkDnKPWQULtzNE9TValSAPnaJDn/2HoVCiBdGWyauOfGOsRVBDbWdbZy
	crwunf0rBpXtQUtVD6wKbSCw/4FzQsGrcfR9KZYT99cA6PW0+Vtc4TC99Qmmp0QzxsnsbG
	3uazTukszLfnq5yMb++rNTm4zXM8EWRg3LMXV5indkSuYoRtjzvQ2KaEBh+4XA==
Date: Fri, 12 Apr 2024 10:20:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: wefu@redhat.com
Cc: jszhang@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, guoren@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: rtc: Add optional property "prescaler"
 in APM X-Gene RTC Document
Message-ID: <20240412082000279430d0@mail.local>
References: <20240412080238.134191-1-wefu@redhat.com>
 <20240412080238.134191-3-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412080238.134191-3-wefu@redhat.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 12/04/2024 16:01:44+0800, wefu@redhat.com wrote:
> From: Wei Fu <wefu@redhat.com>
> 
> Add optional property "prescaler" for APM X-Gene RTC.
> The clock source on some platform to RTC is NOT 1HZ,
> so we need to prescale the clock to make the input clock become 1HZ,
> like (32K/prescaler) = 1HZ on the XuanTie TH1520 AP sub-system RTC.
> 
> Signed-off-by: Wei Fu <wefu@redhat.com>
> ---
>  .../devicetree/bindings/rtc/xgene-rtc.txt        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/xgene-rtc.txt b/Documentation/devicetree/bindings/rtc/xgene-rtc.txt
> index fd195c358446..25ba8cf0cc31 100644
> --- a/Documentation/devicetree/bindings/rtc/xgene-rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/xgene-rtc.txt
> @@ -10,6 +10,9 @@ Required properties:
>  - #clock-cells: Should be 1.
>  - clocks: Reference to the clock entry.
>  
> +Optional properties:
> +- prescaler: Reference to the Value of Counter Prescaler.

What about getting the input clock rate and calculate the needed
prescaler instead of having it in the device tree?

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

