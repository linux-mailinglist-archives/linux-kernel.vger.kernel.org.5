Return-Path: <linux-kernel+bounces-52797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9211849CBF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481CB1F25E24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544F32D047;
	Mon,  5 Feb 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JEMCT+2a"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8E2D03D;
	Mon,  5 Feb 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142439; cv=none; b=JWhcPeEsjslhLhadyrVcxNHgm7uwZYYfXeKf4L0NdPuYPrhnfL5g395rCz0fdTPcFwleZIy5FDUkT6qXma4KIrZP1xp5A7Y8B4Q3ltfPn23QqDfec2PCpRfULLK/xbvkaRzurP1GibmJAcN7aRI+yl8CDL3ic2mHOUBhufPPx+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142439; c=relaxed/simple;
	bh=/AH4OnHyKTveDUxBUINyS6rrfqLk5MnGENRs0ofWJ6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7wLfczrw518+GRK9A51vkXIiVJwVVdSuEVISTrL1TQk9GgJZaHKtbgMzsTwT4JaEd84WfMKIG89uoWxOKbsmyy5E5/XWHhGGgGlZ57m5uvEi4yCAdRrx9lXgdaIh17ULipPvCulwGPTd68ahc9CjY+lu4yKGWIyb2cJ5fu/hlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JEMCT+2a; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707142436;
	bh=/AH4OnHyKTveDUxBUINyS6rrfqLk5MnGENRs0ofWJ6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEMCT+2aqsh1QA9Qn2nP/8qvretn4TMikTx9EOmrCveJIo5KSemxXUgChD6uwe8T6
	 Lb3G8cd+eNQtaDMdFsYVPTfz99Hb2JdDPJ0HLVK0bmNJvexh85F5ELgfzoT/vet21Q
	 DflQkkDiBJtIdaMe9TR9W4gT23Wl0jj84dqJo3oSXrtzGvYH9jVVJrmH98+Tvoxo/S
	 E/UrRq6LfgkGT5/IIXCKQUx0KK7mKswn68zwMgd8ikgaR8ZtI6yRjrbPUwpexl+qV4
	 lSX2+GAlRgOKtNXuTqV2dxMVqP00nj9GpgB0eaLEuAskJaeNQH36YgV8Zc41QlI+bm
	 3nKXXUtah8yUg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 954A6378143B;
	Mon,  5 Feb 2024 14:13:53 +0000 (UTC)
Date: Mon, 5 Feb 2024 09:13:51 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel@collabora.com, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] firmware: coreboot: Generate modalias uevent for
 devices
Message-ID: <2a2736e5-8788-4643-8d19-a79b9a9ec776@notapiano>
References: <20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com>
 <20240117-coreboot-mod-defconfig-v3-1-049565a27bba@collabora.com>
 <ZcA72dyYd9ZR8k_J@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcA72dyYd9ZR8k_J@google.com>

On Mon, Feb 05, 2024 at 09:37:29AM +0800, Tzung-Bi Shih wrote:
> On Wed, Jan 17, 2024 at 04:03:22PM -0300, Nícolas F. R. A. Prado wrote:
> > Generate a modalias uevent for devices in the coreboot bus to allow
> > userspace to automatically load the corresponding modules.
> >
> > [...]
> 
> Applied, thanks!
> 
> [1/4] firmware: coreboot: Generate modalias uevent for devices
>       commit: c6b0a4ceb7c9d8bb014d2967c97c8c7cbf60b006

Hi Tzung-Bi,

I was going to send a v4 with tag changed into 64 bit long as suggested by Greg:
https://lore.kernel.org/all/2024020105-dash-antiquity-a56b@gregkh

And that includes this commit, as the modalias field would need to be 16 hex
long.

But since you already merged this, would you prefer a change on top of this
making it 64 bit long, or do you want to keep it 32 bits?

Thanks,
Nícolas

