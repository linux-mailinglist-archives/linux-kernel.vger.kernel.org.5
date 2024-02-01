Return-Path: <linux-kernel+bounces-48163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B414845821
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A79C1F28CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D78C5336E;
	Thu,  1 Feb 2024 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5mIdJ2D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103A86645;
	Thu,  1 Feb 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791888; cv=none; b=YaJnhVeZAG2OydCyxKYXGZR/q0D9f2vpSFdzYmb4OsM4FnfwDS8F9EeWPc/hRt0WdFKHVBe2lhgc4RF5aeB899/ap+qMefO5ZglGLBr/Ynt8z0qD0nhlrLegx/QWzxNQFUIkcHLa+GkR+lI5nZoxw7zoKDBEMbeABIcNSOjdxk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791888; c=relaxed/simple;
	bh=b3tY4mt/lB4gO7ArhC4Qq2/scszVusvI4m/x+JRTHtc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UnbKGh/Y6Np5xfFQwi3LjbyJwHSjnWPCqM72jK5C93TsthxNQHDWdHaSblcMCnKDeVNfAchk3zkDXCVtmzGL/CABOi3I6S28FNsSTQYEZj5THxwSRQC0afXgv71n2zsAXSUg3m/sHnsDHkwKsW/ZgQIP/IWfRIUHtyQjkZjvBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5mIdJ2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6465C433C7;
	Thu,  1 Feb 2024 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706791887;
	bh=b3tY4mt/lB4gO7ArhC4Qq2/scszVusvI4m/x+JRTHtc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=S5mIdJ2DTmRcdefesWcvtN0+XhsW1YFimKKjIJJ6As9JxWh3H0PlhU35SQlnfASvW
	 b5EOGpLIxpy5YHO0k+gcNFM3rwzV5LFO/YFsm2arMPtcBzC4KGYE35Gvolv7sDUlFG
	 lCGAk3XH+llnyzNpopP8O2gCcXk60ABFvZ5ZkR5suoui7872r1f9pts3iPJDlAzl36
	 E8zVGIiqEJCoXwAjJOAgJDMD6qvIO78Bnx8+m2B5N2O8AKptsEeo9Fd1dW4afQq4yY
	 RnCxGt0wQzYFSY7AWK5DHv8YaGeaWiN3jLo2UBv52abGp8BUo7SYY93RSIqGdwttPn
	 5gOExDJchKS0A==
From: Kalle Valo <kvalo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,  Toke =?utf-8?Q?H=C3=B8iland?=
 =?utf-8?Q?-J=C3=B8rgensen?=
 <toke@toke.dk>,  Arend van Spriel <aspriel@gmail.com>,  Franky Lin
 <franky.lin@broadcom.com>,  Hante Meuleman <hante.meuleman@broadcom.com>,
  Arnd Bergmann <arnd@arndb.de>,  Lee Jones <lee@kernel.org>,  Brian Norris
 <briannorris@chromium.org>,  Srinivasan Raju <srini.raju@purelifi.com>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 1/6] wifi: ath9k: Obtain system GPIOS from descriptors
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
	<20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
	<ZbuDF2-m8oJofpyl@smile.fi.intel.com>
Date: Thu, 01 Feb 2024 14:51:23 +0200
In-Reply-To: <ZbuDF2-m8oJofpyl@smile.fi.intel.com> (Andy Shevchenko's message
	of "Thu, 1 Feb 2024 13:40:07 +0200")
Message-ID: <878r44uz3o.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Wed, Jan 31, 2024 at 11:37:20PM +0100, Linus Walleij wrote:
>
>> The ath9k has an odd use of system-wide GPIOs: if the chip
>> does not have internal GPIO capability, it will try to obtain a
>> GPIO line from the system GPIO controller:
>> 
>>   if (BIT(gpio) & ah->caps.gpio_mask)
>>         ath9k_hw_gpio_cfg_wmac(...);
>>   else if (AR_SREV_SOC(ah))
>>         ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);
>> 
>> Where ath9k_hw_gpio_cfg_soc() will attempt to issue
>> gpio_request_one() passing the local GPIO number of the controller
>> (0..31) to gpio_request_one().
>> 
>> This is somewhat peculiar and possibly even dangerous: there is
>> nowadays no guarantee of the numbering of these system-wide
>> GPIOs, and assuming that GPIO 0..31 as used by ath9k would
>> correspond to GPIOs 0..31 on the system as a whole seems a bit
>> wild.
>> 
>> My best guess is that everyone actually using this driver has
>> support for the local (custom) GPIO API and the bit in
>> h->caps.gpio_mask is always set for any GPIO the driver may
>> try to obtain, so this facility to use system-wide GPIOs is
>> actually unused and could be deleted.
>> 
>> Anyway: I cannot know if this is really the case, so implement
>> a fallback handling using GPIO descriptors obtained from the
>> ah->dev device indexed 0..31. These can for example be passed
>> in the device tree, ACPI or through board files. I doubt that
>> anyone will use them, but this makes it possible to obtain a
>> system-wide GPIO for any of the 0..31 GPIOs potentially
>> requested by the driver.
>
> ...
>
>> +	/* Obtains a system specific GPIO descriptor from another GPIO controller */
>> +	gpiod = devm_gpiod_get_index(ah->dev, NULL, gpio, flags);
>
>> +
>
> Unnecessary blank line, please don't add it.

I can fix that in the pending branch, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

