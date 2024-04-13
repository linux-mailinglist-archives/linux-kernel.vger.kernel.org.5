Return-Path: <linux-kernel+bounces-143816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCC88A3DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A46282150
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBD945941;
	Sat, 13 Apr 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp396N8j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15940BE7;
	Sat, 13 Apr 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713027390; cv=none; b=ifrpWJ846l3PCz1UCOoQcVw/PR1/FNoUOxcOV/1xYdDSZInk7GRCRg7p1yF3YYND0c9Qb4B6szMaDHvRBE/ChLb7vWuIO74ObOS8nndpWmOVT3/LRG919dsbnp3Tn34oKtobaKyqkEAT8a5OinJePMYDL2Gx2yL01hF7JIJMj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713027390; c=relaxed/simple;
	bh=qzvK0Qurx8h2LspWlfqXLUZ91F02Tbnhx9bl1BVWd6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8Uhh1rgt4kCRa5rCtSHQ1mSjzwu4q07aaxMkDYp2evbHXTxD2AuTDqZS1GSFq4SoZo2I/Cjuo4XPd1XzP75q3o3+ldi+PPHfZHdtuXp+YqxtJszswE5DsZKUV+Hnzm8CmNmxvVQxXyLkRQm/29R9G96FhRdjSmgX/kzMoR66xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp396N8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7B5C113CD;
	Sat, 13 Apr 2024 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713027390;
	bh=qzvK0Qurx8h2LspWlfqXLUZ91F02Tbnhx9bl1BVWd6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cp396N8jBULseNyax/L6pcWQidvMyQeO6KRmcJUJuC8rzJt22Nzyo04bV9G00dnJt
	 Vem2Ur6h3WvAinYb8GPoboknsnwVoMy8jb/BXM6lFjztbNvjYnqVMjubY7oBgrmdFw
	 ur2eplJzzdFdQ7jssEoRPPYaX3996/nLR1LZpAYkCmUUg1FsRXviwQxO8zsMg2+n9q
	 567cZbZ+pmfUKE5F9dT47Z7KOu7ioVCoDqWq08ZibpMEtgR1IL+zfZ5JGXEr48072F
	 Ih2M2yMA/QMhoLMVdY15opD/wJhgJnq3/jIOAXCpbR0tkLZM7PIVkqybZgTHufF031
	 MkySW50pe1dRw==
Date: Sat, 13 Apr 2024 17:56:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 u.kleine-koenig@pengutronix.de, biju.das.jz@bp.renesas.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 2/6] iio: pressure: bmp280: Refactorize reading
 functions
Message-ID: <20240413175612.5b117573@jic23-huawei>
In-Reply-To: <20240407172920.264282-3-vassilisamir@gmail.com>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
	<20240407172920.264282-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Apr 2024 19:29:16 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> For BMP18x, BMP28x, BME280, BMP38x the reading of the pressure
> value requires an update of the t_fine variable which happens
> through reading the temperature value.
> 
> So all the bmpxxx_read_press() functions of the above sensors
> are internally calling the equivalent bmpxxx_read_temp() function
> in order to update the t_fine value. By just looking at the code
> this functionality is a bit hidden and is not easy to understand
> why those channels are not independent.
> 
> This commit tries to clear these things a bit by splitting the
> bmpxxx_{read/compensate}_{temp/press/humid}() to the following:
> 
> i. bmpxxx_read_{temp/press/humid}_adc(): read the raw value from
> the sensor.
> 
> ii. bmpxx_calc_t_fine(): calculate the t_fine variable.
> 
> iii. bmpxxx_get_t_fine(): get the t_fine variable.
> 
> iv. bmpxxx_compensate_{temp/press/humid}(): compensate the adc
> values and return the calculated value.
> 
> v. bmpxxx_read_{temp/press/humid}(): combine calls of the
> aforementioned functions to return the requested value.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Looks good to me. Thanks for tidying this up.


