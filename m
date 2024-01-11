Return-Path: <linux-kernel+bounces-23435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFA582ACB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417B528313D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E514F70;
	Thu, 11 Jan 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvqQgHrB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82C14F65;
	Thu, 11 Jan 2024 10:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0806C433F1;
	Thu, 11 Jan 2024 10:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704970722;
	bh=ZPmFNbT3sULJipHfdwJsDJ+/K6p0fplCO6ZXJFDlwuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvqQgHrBFMIIOQ1F6qtZIzeAZyKo/xS3SbY9P4qoaMaFdOwPE+yiUPJUawBBeyaVu
	 VZAGYiUAEoDeN8OM0cv6+WEDT7xYD43oYJBA1IVOWbdHv1U34noLCI14kkc56YFaqk
	 Pp1gn+mp77YEZZY/wUgPKLdmIsNTgWfFbMG0Qh4V5o2ZN32ePqO7UPQZkFX4cfAGyR
	 I92JYRpWWxHQQoG1QG/wv5C0cF7+sGH6MOsRlfbvCiTiOiq05/dbYeKSq8eFeEpoRm
	 OX25eNa4eAC5cCYnhl5YG367u62MqqQ4VE91SUeqUnZfbjvsJqDgrTfPQl8x5XUsYs
	 l9TRiRoxE/RNw==
Date: Thu, 11 Jan 2024 10:58:38 +0000
From: Lee Jones <lee@kernel.org>
To: Joseph Strauss <jstrauss@mailbox.org>
Cc: pavel@ucw.cz, jansimon.moeller@gmx.de, conor@kernel.org,
	christophe.jaillet@wanadoo.fr, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Add multicolor support to BlinkM LED driver
Message-ID: <20240111105838.GB1678981@google.com>
References: <20240106172944.7593-1-jstrauss@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240106172944.7593-1-jstrauss@mailbox.org>

On Sat, 06 Jan 2024, Joseph Strauss wrote:

> Add multicolor support to the BlinkM driver, making it easier to control
> from userspace. The BlinkM LED is a programmable RGB LED. The driver
> currently supports only the regular LED sysfs class, resulting in the
> creation of three distinct classes, one for red, green, and blue. The
> user then has to input three values into the three seperate brightness
> files within those classes. The multicolor LED framework makes the
> device easier to control with the multi_intensity file: the user can
> input three values at once to form a color, while still controlling the
> lightness with the brightness file.
> 
> The main struct blinkm_led has changed slightly. The struct led_classdev
> for the regular sysfs classes remain. The blinkm_probe function checks
> CONFIG_LEDS_BLINKM_MULTICOLOR to decide whether to load the seperate
> sysfs classes or the single multicolor one, but never both. The
> blinkm_set_mc_brightness() function had to be added to calculate the
> three color components and then set the fields of the blinkm_data
> structure accordingly.
> 
> All of the feedback has been much appreciated. Thanks!
> 
> Signed-off-by: Joseph Strauss <jstrauss@mailbox.org>
> ---
> Changes in v2:
> - Replaced instances of the constant 3 with NUM_LEDS, where applicable
> - Fixed formatting errors
> - Replaced loop inside of blinkm_set_mc_brightness() with equivalent
>   statements
> - Changed id of multicolor class from 4 to 3
> - Replaced call to devm_kmalloc_array() with devm_kcalloc()
> Changes in v3:
> - Add CONFIG_LEDS_BLINKM_MULTICOLOR to check whether to use multicolor
>   funcitonality
> - Extend well-known-leds.txt to include standard names for RGB and indicator
>   LEDS
> - Change name of Blinkm sysfs class according to well-known-leds.txt
> - Simplify struct blinkm_led and struct blinkm_data
> - Remove magic numbers
> - Fix formatting errors
> - Remove unrelated changes
> Changes in v4:
> - Fix indentation
> - Add default case to switch statement
> 
>  Documentation/leds/leds-blinkm.rst     |  27 ++-
>  Documentation/leds/well-known-leds.txt |   8 +
>  drivers/leds/Kconfig                   |   8 +
>  drivers/leds/leds-blinkm.c             | 217 +++++++++++++++++--------
>  4 files changed, 185 insertions(+), 75 deletions(-)

FYI: I won't be reviewing this until all of the build-bots are happy.

-- 
Lee Jones [李琼斯]

