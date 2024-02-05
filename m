Return-Path: <linux-kernel+bounces-51976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99ED84922F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9394028200B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D8BB64A;
	Mon,  5 Feb 2024 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgQKpgtQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACEAD32;
	Mon,  5 Feb 2024 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707097054; cv=none; b=QCySqZPQE1srqTRTdQmiUr9ZM+LvT975PZR6oP+zf1nCwPBxwRNp/P18P0opdoPIwa9M2ngfAZKA3aPy3JNpihaqevosB07dpXi5zH0Tfmb6n4oE+k66PZqohKmld4Mf7gzv8bgpYzWGtNHUfvEMcNGUoL3SsMJzkJoIhEkNJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707097054; c=relaxed/simple;
	bh=y5fb4fdKXzCizeh4IpPLpAMu7d9RCi3/NNJgnS3ed9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKxeumwB9Ps5BGqORmYM6nbSlIctAoKmKtVLHSlZUpiKkflgTVEZC2wKDtBTf14lhLpcqOG+sf/FKDZqPnKCtaqSscdX83Dg5FEVHXYk4nlser4iEFAIUyF76OQ44G86c2M+Cpwco8UWt0hTzuiFnXcNsUFuC4N9oxZY8nKk6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgQKpgtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8719DC433C7;
	Mon,  5 Feb 2024 01:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707097053;
	bh=y5fb4fdKXzCizeh4IpPLpAMu7d9RCi3/NNJgnS3ed9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgQKpgtQtQGauONCp9aTXR5YL0jOVTAe16WJyGzuiX+nXFc0IFnoErHOygVSgG+ku
	 DoMOJvFG2vchmi8imbD4BQo8wfwYfIRjdS3B7xozo9QqGVFYRt0M6gwiU0HXt6jZHr
	 LdNQIei8DuQpVy6QUlP9eaZH/xY74ijhO22hdOOjI1QH4ON/UFdlKR2Xw2T4dQtn7u
	 fs5UtkNofUIxM9UrZE+1NtmfLDOIEtW9uWg9jHO3JC0WykLu1GjXYTyZTLA2AyiEPw
	 I0zO9BlHIqoqRHm5g+SICwUrQRF77T7tfvR5V03mvvUJgZSag1kArokygq7Uaitm3I
	 3gUodGRCCuh8w==
Date: Mon, 5 Feb 2024 09:37:29 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
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
Message-ID: <ZcA72dyYd9ZR8k_J@google.com>
References: <20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com>
 <20240117-coreboot-mod-defconfig-v3-1-049565a27bba@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117-coreboot-mod-defconfig-v3-1-049565a27bba@collabora.com>

On Wed, Jan 17, 2024 at 04:03:22PM -0300, Nícolas F. R. A. Prado wrote:
> Generate a modalias uevent for devices in the coreboot bus to allow
> userspace to automatically load the corresponding modules.
>
> [...]

Applied, thanks!

[1/4] firmware: coreboot: Generate modalias uevent for devices
      commit: c6b0a4ceb7c9d8bb014d2967c97c8c7cbf60b006

