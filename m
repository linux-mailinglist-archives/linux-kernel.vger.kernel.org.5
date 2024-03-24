Return-Path: <linux-kernel+bounces-112651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A892F887C92
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5531C2090C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DD717991;
	Sun, 24 Mar 2024 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4Pu0sFd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF928E7;
	Sun, 24 Mar 2024 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711280611; cv=none; b=jSMRBUtCHRNF3rAe5D/4jmeXHpzdrcx7+EoyjAtHFYd8YmWPf531swau4roBnGIRSaFET3LtqQ9mPFSKTgM6q+/s+65VOucczzcSIYp61YBaHa9v1eZnWa5lrTRH34GGtbZn5o4c+IV3CcQav8l6f28E62lx9+vr6N6F10yITr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711280611; c=relaxed/simple;
	bh=I/NgdRgrmfOu8lyvLzMrgCyS9pAJxb+fLcFX7Ruhzcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koVG386YEhyTXTNEDega5JfGP0X28IMAGTBbjmbvNv/7yE4vkPyaAr8pUdFopJaAimDweGDQtgyCqhjJwFLs12vm/xNjtIP3C5XZdiNFhxxJRGQuvEkCOWp0lfvEpuL4yEY0OqGiKRNJ2BZ+wmxIjPWye5fdyK/8w9aTvTAaZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4Pu0sFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29374C433C7;
	Sun, 24 Mar 2024 11:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711280611;
	bh=I/NgdRgrmfOu8lyvLzMrgCyS9pAJxb+fLcFX7Ruhzcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p4Pu0sFd/bozjma4BaKw4n8ma3hz+pAnIoRK16RvfYhmRLcrmIg4dXT9a2H7Kunw/
	 q/4MTx2cV7KF8bJuPAOrPagzw5TOO1jjYO04WPnSzioM7RtUweSSH044xWPyQcXMQv
	 N5NIDdoFF4/1Cu8Ji3lnlukkbJQS/8EpcjoRAWeLm3USNSH/r6Kj8p2mf2sv9VxOxj
	 tfe7lTXV6DNKQdBDxbGXrXfQA1onA212X7HlS471aKMvW/QKOJU6QaQDEqUuHfaTBp
	 z5VRV8Nkp4HPishImI2FIwDfGSTHeicuvNgoWjP0kb5tRh/ko/79+v3aS0vRdb52ZI
	 gbjwYKIXACaOw==
Date: Sun, 24 Mar 2024 11:43:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <20240324114314.4f70490a@jic23-huawei>
In-Reply-To: <20240319002925.2121016-6-vassilisamir@gmail.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
	<20240319002925.2121016-6-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 01:29:24 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The scan mask for the BME280 supports humidity measurement and
> needs to be distinguished from the rest in order for the timestamp
> to be able to work.

This needs a rewrite.  I read that as the measurement needed to be
distinguished from other measurements, not the device needs to be
distinguished from other devices.

It's also unusual to update the scan masks to add timestamps or
scan_index / scan_type before they are actually used.

Hence this first patch should just split the definitions but
not add the additional elements until the next patch that adds
buffered support (where these get used).

So resulting code is fine, but the patch breakup can be improved
so all the bits we need to look at for a given feature are
in a single patch (but not the refactoring).

Jonathan


