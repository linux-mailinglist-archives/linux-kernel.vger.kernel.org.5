Return-Path: <linux-kernel+bounces-48174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6184583D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493E11F23D08
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44415D47D;
	Thu,  1 Feb 2024 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXcpROzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2D3A8D2;
	Thu,  1 Feb 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792003; cv=none; b=ZTAOjsNGs5bhoLWplAS78msKqgq2i8WZIVFoBz6WvozEGTA3DwyuJtQ7ada6czTuJpWxeyW9r/K+/+Z/pyauqnjkVGiZhZRN6tOTrNxc/guSw0S38QM6WgTfICLdHxb/hxEHkAoy2aQ788/bcdbuS+M7i7izrbgqEwNb+ntc7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792003; c=relaxed/simple;
	bh=m24lBTyUtO514F3RlBvmhK0NobQndwRBoeE3EG8UpAI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Evo8K/uvs2HUuzFpPQs9lAqHUiuSgf4wa7jWU4J57nRBhpfOb0dl+1Isacgtex35WwRqsunbw4BNPfrkQ5MbxHlhcj5GPBGPWUl2trmpvu91biLqOLMTXLaO5DmQEpN66bo3YTelBdxxOxUXi+dlX/ccPBC7dKGQMxA6i9oqDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXcpROzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01802C43394;
	Thu,  1 Feb 2024 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706792002;
	bh=m24lBTyUtO514F3RlBvmhK0NobQndwRBoeE3EG8UpAI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=oXcpROzpeZwNLawLFjNcX4K1LX3lPVn2h9Bmf5PEjkMkD22FPlvIjzw/4wE1eiav1
	 ZmVXv3Ke/tOPplUo2O45LVx3DkU2t+UO+gHm4RDFweFA85wAXFN188vMD0f3dLi5VP
	 gcFMPdq6ox7zG+jJRdOT3ewMDMDXARVaNSMb/vchaQX29FohZfxodALjj7FSPQhKrK
	 tRKyTvpISHebqRPxBSq1sKYSpas1oEf1UilaUj0/EO8biGNJoH9SIsUCx68fFFhp97
	 qU1Nhx3wyq/lqUfh7YbNIhGFV+njscM4wHssk0mrQfvhrltcTAAQvFy9CSYzfMPuR1
	 3M0Ht50nCP5gA==
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
Subject: Re: [PATCH 0/6] Convert some wireless drivers to use GPIO descriptors
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
	<ZbuDqwDUaSIaOI2w@smile.fi.intel.com>
Date: Thu, 01 Feb 2024 14:53:18 +0200
In-Reply-To: <ZbuDqwDUaSIaOI2w@smile.fi.intel.com> (Andy Shevchenko's message
	of "Thu, 1 Feb 2024 13:42:35 +0200")
Message-ID: <874jesuz0h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Wed, Jan 31, 2024 at 11:37:19PM +0100, Linus Walleij wrote:
>> This converts some Wireless network drivers to use GPIO descriptors,
>> and some just have unused header inclusions.
>> 
>> The Intersil PL54 driver is intentionally untouched because Arnd
>> is cleaning it up fully.
>
> Thanks for doing this! We pretty much want to get rid of gpio.h along with
> of_gpio.h ASAP, that's why I expect this series to be applied in a fastest
> possible manner.

This is for -next, right?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

