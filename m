Return-Path: <linux-kernel+bounces-23392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC482AC2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF75C1C224E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F357C14AB9;
	Thu, 11 Jan 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVlwXkwb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A5EAC0;
	Thu, 11 Jan 2024 10:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DA9C433C7;
	Thu, 11 Jan 2024 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704969673;
	bh=fNe+aOY4b9Ohw/Yu8Wsl7DvNtIa37fXz9HgdmlqWUYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nVlwXkwbcdzpDiLb0a4le3m+lK/cqZngojxbhtq4kaGnXTrZRUL/gWPZKZT8g8Vct
	 FCVUxw4zpFA0wY652ZeEoeJ2t07hvd6wn7tf+VIciV3MaH8psqSnz4ehHiTxfD7lNw
	 8dJkxH6EymvAhBHt+XchKxOTeOQxxrb7mTGoGHZQ3BeqpjFtjDESAlnBKsMp0jr2Jy
	 k2Mua/Kxr0zdca1ZNgtTLiVi9PPk9DuPliXXde5OuwgFaDFx7d9bP49ADO5a2b8wMO
	 uJwJaiQbwaW1Qlx77d9DeOZAaQjzqGVSIc4/FliZUyCPwsaWg32hrMs7x4gSIQrrz4
	 PGuhMxYqRJjJA==
Date: Thu, 11 Jan 2024 10:41:09 +0000
From: Lee Jones <lee@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-leds@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
	cocci@inria.fr
Subject: Re: [PATCH] leds: trigger: oneshot: One function call less in
 pattern_init() after error detection
Message-ID: <20240111104109.GB1665043@google.com>
References: <c73761c5-7150-4f20-9b3e-1da680400250@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c73761c5-7150-4f20-9b3e-1da680400250@web.de>

On Tue, 26 Dec 2023, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 26 Dec 2023 22:02:08 +0100
> 
> The kfree() function was called in one case by
> the pattern_init() function during error handling
> even if the passed variable contained a null pointer.

It's totally valid to call kfree() on a NULL pointer:

  * If @object is NULL, no operation is performed.

Why do we care all that much?

> This issue was detected by using the Coccinelle software.
> 
> Thus use another label.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/leds/trigger/ledtrig-oneshot.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-oneshot.c b/drivers/leds/trigger/ledtrig-oneshot.c
> index bee3bd452abf..31061ec0afe6 100644
> --- a/drivers/leds/trigger/ledtrig-oneshot.c
> +++ b/drivers/leds/trigger/ledtrig-oneshot.c
> @@ -134,7 +134,7 @@ static void pattern_init(struct led_classdev *led_cdev)
> 
>  	pattern = led_get_default_pattern(led_cdev, &size);
>  	if (!pattern)
> -		goto out_default;
> +		goto out_settings;
> 
>  	if (size != 2) {
>  		dev_warn(led_cdev->dev,
> @@ -151,6 +151,7 @@ static void pattern_init(struct led_classdev *led_cdev)
> 
>  out_default:
>  	kfree(pattern);
> +out_settings:
>  	led_cdev->blink_delay_on = DEFAULT_DELAY;
>  	led_cdev->blink_delay_off = DEFAULT_DELAY;
>  }
> --
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

