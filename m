Return-Path: <linux-kernel+bounces-8621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAE481BA4A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C78284C21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF34539E2;
	Thu, 21 Dec 2023 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwGUel50"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C460539E3;
	Thu, 21 Dec 2023 15:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15165C433C8;
	Thu, 21 Dec 2023 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703171478;
	bh=W1V9iuz27C48mcTlqdM84d1TvizSzj69f6WQ4WY/wVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwGUel50uL+FDdnJI4Nx7w8bbZ1gLxQiTAPJkXHQ7oQ9ckAb/J5ZNNvA8XSm/A1CM
	 1CqjVjgnR0WeQKhjKbY74jVKh3SvK6MQqlczBeAjY3D5oABn92wBdsOm6JJkniezlf
	 uvnX8vMWTNj7e+qCelDRXDDe69MGKkgK7y0zzWHvRSw5tZiPvVtPiO3pAFXd+R3G0g
	 yoEVPuqFhRkkq/DuHaHI+ObRKSHZZmG301GPzanBE8tBEC71m4rGnM2O0ucHiI6tyq
	 ugfIApkUhglx5DJ9uINOc4q4igWuKfzcyOWhQpWno/jH+klKRX4FPPDfUdc5XlARj/
	 H3pBTlqkQDGzA==
Date: Thu, 21 Dec 2023 15:11:11 +0000
From: Lee Jones <lee@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: andy.shevchenko@gmail.com, pavel@ucw.cz, vadimp@nvidia.com,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	hdegoede@redhat.com, mazziesaccount@gmail.com, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	boqun.feng@gmail.com, nikitos.tr@gmail.com,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
Subject: Re: [PATCH v4 00/10] devm_led_classdev_register() usage problem
Message-ID: <20231221151111.GJ10102@google.com>
References: <20231214173614.2820929-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214173614.2820929-1-gnstark@salutedevices.com>

On Thu, 14 Dec 2023, George Stark wrote:

> This patch series fixes the problem of devm_led_classdev_register misusing.
> 
> The basic problem is described in [1]. Shortly when devm_led_classdev_register()
> is used then led_classdev_unregister() called after driver's remove() callback.
> led_classdev_unregister() calls driver's brightness_set callback and that callback
> may use resources which were destroyed already in driver's remove().
> 
> After discussion with maintainers [2] [3] we decided:
> 1) don't touch led subsytem core code and don't remove led_set_brightness() from it
> but fix drivers
> 2) don't use devm_led_classdev_unregister
> 
> So the solution is to use devm wrappers for all resources
> driver's brightness_set() depends on. And introduce dedicated devm wrapper
> for mutex as it's often used resource.
> 
> [1] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/
> [2] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mc132b9b350fa51931b4fcfe14705d9f06e91421f
> [3] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mdbf572a85c33f869a553caf986b6228bb65c8383
> 
> Changelog:
> v1->v2:
> 	revise patch series completely
> 
> v2->v3:
> locking: add define if mutex_destroy() is not an empty function
> 	new patch, discussed here [8]
> 
> devm-helpers: introduce devm_mutex_init
> 	previous version [4]
> 	- revise code based on mutex_destroy define
> 	- update commit message
> 	- update devm_mutex_init()'s description
> 
> leds: aw2013: unlock mutex before destroying it
> 	previous version [5]
> 	- make this patch first in the series
> 	- add tags Fixes and RvB by Andy 
> 
> leds: aw2013: use devm API to cleanup module's resources
> 	previous version [6]
> 	- make aw2013_chip_disable_action()'s body oneline
> 	- don't shadow devm_mutex_init() return code
> 
> leds: aw200xx: use devm API to cleanup module's resources
> 	previous version [7]
> 	- make aw200xx_*_action()'s bodies oneline
> 	- don't shadow devm_mutex_init() return code
> 
> leds: lm3532: use devm API to cleanup module's resources
> leds: nic78bx: use devm API to cleanup module's resources
> leds: mlxreg: use devm_mutex_init for mutex initializtion
> leds: an30259a: use devm_mutext_init for mutext initialization
> leds: powernv: add LED_RETAIN_AT_SHUTDOWN flag for leds
> 	- those pathes were planned but not sent in the series #2 due to mail server
> 	problem on my side. I revised them according to the comments.
> 
> v3->v4:
> locking: introduce devm_mutex_init
> 	new patch
> 	- move devm_mutex_init implementation completely from devm-helpers.h to mutex.h
> 
> locking: add define if mutex_destroy() is not an empty function
> 	drop the patch [9]
> 
> devm-helpers: introduce devm_mutex_init
> 	drop the patch [10]
> 
> leds: aw2013: use devm API to cleanup module's resources
> 	- add tag Tested-by: Nikita Travkin <nikita@trvn.ru>
> 
> [4] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#mf500af0eda2a9ffc95594607dbe4cb64f2e3c9a8
> [5] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#mc92df4fb4f7d4187fb01cc1144acfa5fb5230dd2
> [6] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#m300df89710c43cc2ab598baa16c68dd0a0d7d681
> [7] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#m8e5c65e0c6b137c91fa00bb9320ad581164d1d0b
> [8] https://lore.kernel.org/lkml/377e4437-7051-4d88-ae68-1460bcd692e1@redhat.com/T/#m5f84a4a2f387d49678783e652b9e658e02c27450
> [9] https://lore.kernel.org/lkml/20231213223020.2713164-1-gnstark@salutedevices.com/T/#m19ad1fc04c560012c1e27418e3156d0c9306dd84
> [10] https://lore.kernel.org/lkml/20231213223020.2713164-1-gnstark@salutedevices.com/T/#m63126025f5d1bdcef69bcad50f2e58274d42e2d7
> 
> George Stark (10):
>   leds: aw2013: unlock mutex before destroying it
>   locking: introduce devm_mutex_init
>   leds: aw2013: use devm API to cleanup module's resources
>   leds: aw200xx: use devm API to cleanup module's resources
>   leds: lp3952: use devm API to cleanup module's resources
>   leds: lm3532: use devm API to cleanup module's resources
>   leds: nic78bx: use devm API to cleanup module's resources
>   leds: mlxreg: use devm_mutex_init for mutex initializtion
>   leds: an30259a: use devm_mutext_init for mutext initialization
>   leds: powernv: use LED_RETAIN_AT_SHUTDOWN flag for leds
> 
>  drivers/leds/leds-an30259a.c | 15 +++++----------
>  drivers/leds/leds-aw200xx.c  | 33 ++++++++++++++++++++++-----------
>  drivers/leds/leds-aw2013.c   | 27 +++++++++++++++------------
>  drivers/leds/leds-lm3532.c   | 30 ++++++++++++++++++------------
>  drivers/leds/leds-lp3952.c   | 21 +++++++++++----------
>  drivers/leds/leds-mlxreg.c   | 17 ++++++-----------
>  drivers/leds/leds-nic78bx.c  | 25 +++++++++++++------------
>  drivers/leds/leds-powernv.c  | 23 ++++++++---------------

FYI: I'll conduct my review once the locking side is settled.

>  include/linux/mutex.h        | 23 +++++++++++++++++++++++
>  kernel/locking/mutex-debug.c | 22 ++++++++++++++++++++++
>  10 files changed, 143 insertions(+), 93 deletions(-)
> 
> -- 
> 2.25.1
> 
> 

-- 
Lee Jones [李琼斯]

