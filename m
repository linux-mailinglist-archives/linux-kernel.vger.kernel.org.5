Return-Path: <linux-kernel+bounces-47926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EED8454BB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8612B28D4E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E7A15A4A1;
	Thu,  1 Feb 2024 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIKpjUVT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D094D9FE;
	Thu,  1 Feb 2024 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781782; cv=none; b=DB9BsDGy7PW8QDRn3+3jrS8Ydc0o+90iSbnDxir2I2tNvCGm5ZeUQ8dges+k4hKloAgNbtUd/HQXw5gTUYHhsUP3R0zljVcqqyN+xqe4QVmWn86UnjZ6KGc49c8fhuLahKND4lLLSmUFhc+PBpHS5EmxeEO0Tjdn+P1Hgw8HCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781782; c=relaxed/simple;
	bh=NkpX4SR0tWKjeMojKZD/2vUJKUhdE2cs8VKLouOlFuQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=O4gCrSxJop7JXrqCSo2jISJXLxK2Oc+sOfitAG4goCK3prZAXYY4UoWAHXxDcWFIhhmb1xxWyB4W6n7bgxXajsUMX1EUj/XvfE3oOFWOZAVciYBEngj4WzKwPbTX63LBIjSA/6Ld6fDF5Sfp85PnjX1oqAaGD3q4DMb6kt6NXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIKpjUVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD50C433F1;
	Thu,  1 Feb 2024 10:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706781781;
	bh=NkpX4SR0tWKjeMojKZD/2vUJKUhdE2cs8VKLouOlFuQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fIKpjUVTCmz01limyDF4sdEe7dgd8lLjkZXFDQh+rgYg/Xr0d682yVRR9Pdb4PLSG
	 VMAldDJz0aCxuh61jRfA1yy8htZF47ri6tZ56wJM8kUKTnewAZjK9C5J7JhoRQLKeD
	 qbwR8YWpLdNkPxJiXqfZLy8GmQstBVdL6uQCceuUWKB6UOgmL9BKhasvogHfUY7bNe
	 8DCtfL5akj/tZY/TOytQIsi15Ub6luYpcXAYwC9oMRGO58t2A7e3hxlovArya3gTKB
	 vLzgzezM8Ss3WRsEQzOG27ruxiQZf0PCJNk550FVBG0/VOjsSGQAfwFc4l1BoywDu1
	 lc25VVav3OBEw==
From: Kalle Valo <kvalo@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,  Arend van
 Spriel
 <aspriel@gmail.com>,  Franky Lin <franky.lin@broadcom.com>,  Hante
 Meuleman <hante.meuleman@broadcom.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Arnd Bergmann <arnd@arndb.de>,  Lee
 Jones <lee@kernel.org>,  Brian Norris <briannorris@chromium.org>,
  Srinivasan Raju <srini.raju@purelifi.com>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 6/6] wifi: cw1200: Convert to GPIO descriptors
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
	<20240131-descriptors-wireless-v1-6-e1c7c5d68746@linaro.org>
Date: Thu, 01 Feb 2024 12:02:56 +0200
In-Reply-To: <20240131-descriptors-wireless-v1-6-e1c7c5d68746@linaro.org>
	(Linus Walleij's message of "Wed, 31 Jan 2024 23:37:25 +0100")
Message-ID: <87h6isv6wf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Walleij <linus.walleij@linaro.org> writes:

> The CW1200 uses two GPIOs to control the powerup and reset
> pins, get these from GPIO descriptors instead of being passed
> as platform data from boardfiles.
>
> The RESET line will need to be marked as active low as we will
> let gpiolib handle the polarity inversion.
>
> The SDIO case is a bit special since the "card" need to be
> powered up before it gets detected on the SDIO bus and
> properly probed. Fix this by using board-specific GPIOs
> assigned to device "NULL".
>
> There are currently no in-tree users.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

[...]

> +/* Like the rest of the driver, this only supports one device per system */
> +static struct gpio_desc *cw1200_reset;
> +static struct gpio_desc *cw1200_powerup;

Side comment about cw1200 driver: it's pretty bad that the driver
supports only one device per system. As I haven't seen any real activity
for this driver a long time I thinking of just removing it in the near
future.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

