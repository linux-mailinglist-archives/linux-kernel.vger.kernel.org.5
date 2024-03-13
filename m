Return-Path: <linux-kernel+bounces-102246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B9887AFC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1142528AB39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57197E0F1;
	Wed, 13 Mar 2024 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E14v5X+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D67D3FA;
	Wed, 13 Mar 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350102; cv=none; b=JNUYaPWG5HwnNJGAafcbFRQ21X2fj/Q96I1AhfSt1g2dcmmiAx/FTJqzEN1Ft15NvlkM/HyfqW6zDWjsUS2XCbgyPza5RZrYRViIhuyDk8+Tbpj4neWMMhRlxKm8yH7zjDVp96WjSg6gEmOPbTzD8UjhA7CRmLv0Vdu4uJxzql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350102; c=relaxed/simple;
	bh=Sq41bGnsArB+oqY0Vaks8WTm1oPv+4GYhpODJO3UZFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3ZSVpCtlYN4IUlMY+zt1xGkZTU19GO+klb4FidC3zTJ5SjLQBHTeHyGhM7yGt3AQemL7ESn8h8061cUfzi00q6vjxYkDOZtgFflyxSdqp7zmNtTnz53wOc/06RRWfevV1MGvRoNlQV+ArSd9ahkgFf2vr1vs99ojX/9UmTt//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E14v5X+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43443C433F1;
	Wed, 13 Mar 2024 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710350101;
	bh=Sq41bGnsArB+oqY0Vaks8WTm1oPv+4GYhpODJO3UZFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E14v5X+Tm66BatPOqoGRr8GrD22zbnVSAr88Bws7vW81dsvo2iYcjED3uatQcClOw
	 172aJSO/LVLQyGVqgcCvGV8rpafalE8QOsalqLHEdMpNsVW7OnNonV/9XTLhtToFZx
	 lrYXOv5cbsE6Zr/6aUEDSPrx9EmA+zp8tuYH58eYoDvBXW3TLVnhxklHgF2mS6UM9H
	 ZviBXD507Q5eLKLbLm9aF1+aF/b/yVD/+X0gfnXmdymfg8hMNHt5juJMXKyqyUIjWw
	 e5v/q4K0CV0se5hZyB6DPX8v4JThMC/M97Y0UWpwPnhFgKObW3g4XZ3o27kL4W7cHz
	 tzBDvDEBbkCUw==
Date: Wed, 13 Mar 2024 13:14:59 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Maxime Ripard <maxime@cerno.tech>,
	Robert Foss <robert.foss@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5.15 73/76] regmap: Add bulk read/write callbacks into
 regmap_config
Message-ID: <ZfHfEyb6XKrE2MBE@sashalap>
References: <20240313164223.615640-1-sashal@kernel.org>
 <20240313164223.615640-74-sashal@kernel.org>
 <8bcd85fb-401f-4a3b-b10e-633a0478c0da@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8bcd85fb-401f-4a3b-b10e-633a0478c0da@sirena.org.uk>

On Wed, Mar 13, 2024 at 04:46:56PM +0000, Mark Brown wrote:
>On Wed, Mar 13, 2024 at 12:42:20PM -0400, Sasha Levin wrote:
>> From: Marek Vasut <marex@denx.de>
>>
>> [ Upstream commit d77e745613680c54708470402e2b623dcd769681 ]
>>
>> Currently the regmap_config structure only allows the user to implement
>> single element register read/write using .reg_read/.reg_write callbacks.
>> The regmap_bus already implements bulk counterparts of both, and is being
>> misused as a workaround for the missing bulk read/write callbacks in
>> regmap_config by a couple of drivers. To stop this misuse, add the bulk
>> read/write callbacks to regmap_config and call them from the regmap core
>> code.
>
>This fairly clearly new functionality.

It is, but its needed for 3f42b142ea11 ("serial: max310x: fix IO data
corruption in batched operations") which uses this new functionality.

-- 
Thanks,
Sasha

