Return-Path: <linux-kernel+bounces-134900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2806E89B864
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFD8283C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF1B2561D;
	Mon,  8 Apr 2024 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwonCKgu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55F23A8;
	Mon,  8 Apr 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561272; cv=none; b=ag8nx3AI4tSVDxeqLI6DtaseG4TtxAQiZfbQpvkVFCQ7JTBHrabfKHWke+8f/11a1iRSYynDvobPOsXaMwr5/6WSMDogWBdSWd64MiAqPWRY/84aYpEhEKqRqUQbw3Ec4yTa436geHrd4Hroo+oJeyQvqOQItrmeOa2y9V4U/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561272; c=relaxed/simple;
	bh=Cbtn6smWWKHguoUqrvDzEVxp21alRHdEffFw0eAnkII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD6QR+aZkEhwoXFEkxyJpQA8gYNn0DAKuaHoMcOa9nfAwC4XDnGOWcYKUaQsCdPR+Sg6CqqpXV6V5QAKe4F9w7qCLvlp/+cVbBg7m0POs5+U5ekkgOJJogwx08salKJ0q/CJLOl2GnkLOMYdtJQKrGSMX9VthXFaTjQBxxB3oZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwonCKgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF07C433C7;
	Mon,  8 Apr 2024 07:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712561271;
	bh=Cbtn6smWWKHguoUqrvDzEVxp21alRHdEffFw0eAnkII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwonCKguouYcMyi8r9RJXdu2ywc3drewzhnRdlqXQSN+Ml80saFF0LentyUw0GLXh
	 DkMHPfuOdVU+dAVx5G1u8k5fUbM6Tj/QD3c5GwTfCY43uDe/+0mKd31hSU1n2VVTSc
	 LpC2PuV6ZdQ0S5Oe6tHcHQJl3XI3lb96H/X8YEwM84EylpXzxyrVlFndhw/TW2ZSx8
	 6DUiwv0g0+zACGYbNAgxeFwfSX8wRvl0ZmHGBAyi62FrnqvxgBHGSCoMBpSzFZSe6a
	 ivMZxaoOz/w/1pG9I3d5OeW9OPcH+7xLKh/xIlz47a+NvqJTMgcGARMACJ/2tUdV/T
	 tn8uLmw5rBoeg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rtjPs-000000000Cb-3ihr;
	Mon, 08 Apr 2024 09:27:45 +0200
Date: Mon, 8 Apr 2024 09:27:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Lukasz Majczak <lma@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
Message-ID: <ZhOccGFkTFkUkRUI@hovoldconsulting.com>
References: <20240405102436.3479210-1-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405102436.3479210-1-lma@chromium.org>

On Fri, Apr 05, 2024 at 10:24:36AM +0000, Lukasz Majczak wrote:
> This patch extends the early bailout for probing procedure introduced in
> commit b3a81b6c4fc6 ("HID: i2c-hid: check if device is there before
> really probing"), in order to cover devices
> based on STM microcontrollers. For touchpads based on STM uC,
> the probe sequence needs to take into account the increased response time
> for i2c transaction if the device already entered a deep power state.
> STM specify the wakeup time as 400us between positive strobe of
> the clock line. Deep sleep is controlled by Touchpad FW,
> though some devices enter it pretty early to conserve power
> in case of lack of activity on the i2c bus.
> Failing to follow this requirement will result in touchpad device not being
> detected due initial transaction being dropped by STM i2c slave controller.
> By adding additional try, first transaction will wake up the touchpad
> STM controller, and the second will produce proper detection response.

Can you please explain why this would not a problem for all future
transactions as well?

If it is, then it sounds like this needs to be addressed in the i2c
driver. If not, then perhaps the problem is really that you just need a
delay after enabling the power supplies? 
 
> v1->v2:
> * Updated commit message with short sha of a base commit and proper tags
> * Rearranged while loop to perform check only once
> * Loosened sleeping range
> 
> Co-developed-by: Radoslaw Biernacki <rad@chromium.org>
> Signed-off-by: Radoslaw Biernacki <rad@chromium.org>
> Signed-off-by: Lukasz Majczak <lma@chromium.org>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 2df1ab3c31cc..ece1a5815e0b 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -1013,9 +1013,17 @@ static int __i2c_hid_core_probe(struct i2c_hid *ihid)
>  	struct i2c_client *client = ihid->client;
>  	struct hid_device *hid = ihid->hid;
>  	int ret;
> +	int tries = 2;

Nit: move above the 'ret' declaration to maintain reverse xmas style
ordering.

Johan

