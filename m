Return-Path: <linux-kernel+bounces-143650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4B8A3BEA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5BC1F21C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3E2C6B3;
	Sat, 13 Apr 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9Hn57IX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68218B14;
	Sat, 13 Apr 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713000451; cv=none; b=cigDI8fwjEBY+ENRke5uvxvC7zWcTs7SjYhry4uhx6dfamSAKH1AN/04xbl7LTrD9rlI+3PoGvxE+tazrTBreaxhPHgmoqBsOtiGyeNcwkUJJlkUbK/dOxQ8opMKCGQ7ususN6U0K12qbTMZWE01rSKZ79bxbRK5qoPkCB1yYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713000451; c=relaxed/simple;
	bh=8FmkxRB0I6lztwgCbDGCSRZG9dB3qR5SIonDflggVww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thiaVFUBXXckpyVDIFarEFCDpKkleFsaR1P35cwOFqiXZEFp1HZMC+8uYvi9x3jBAWhgosqi26Ke2PM7DtIEHDRL8cdcfZ2ZB/OLDIXosEOpdyej2osgHWs7+0W38qsWHxJMb5Cv2ADjuGI0ettx/ZTnUMIVC5iK0uUl3w/vOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9Hn57IX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB09C113CD;
	Sat, 13 Apr 2024 09:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713000450;
	bh=8FmkxRB0I6lztwgCbDGCSRZG9dB3qR5SIonDflggVww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b9Hn57IX/VvTNUy9obuO8zlFnX+pRlFGrpvIqioTwwuScVCBVb5ogzv9pvoWuvVgg
	 CdEXKW5u345k2qQWe01PwyguqSgOt41OMYFyGmYKAxuo1rGXj4rZaNOPMgpq0Czysc
	 wTg+hO8PZMXlaWPGA/ObXguuOdsf/PB08UOazC6pKcfIVrkzggdYDZajDaqUyKHqLg
	 A2EtU63HpGI7phjtOvR2FFPJWHpuUocLhSy9+Ik/2KFPO7rfW/RbCGrl3dhZRTJslp
	 NENuo2+7vFLdbaAkEkqOIkNXZQTBGmTt9NVuNZQBGNnAiT18MveFHS938SosRb7dJL
	 rHDrVDzwbTasw==
Date: Sat, 13 Apr 2024 10:27:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Cc: joel@jms.id.au, bsp-development.geo@leica-geosystems.com, Eddie James
 <eajames@linux.ibm.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: pressure: dps310: support negative
 temperature values
Message-ID: <20240413102717.1ad05f7e@jic23-huawei>
In-Reply-To: <20240410103604.992989-1-thomas.haemmerle@leica-geosystems.com>
References: <20240327084937.3801125-1-thomas.haemmerle@leica-geosystems.com>
	<20240410103604.992989-1-thomas.haemmerle@leica-geosystems.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 12:36:00 +0200
Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com> wrote:

> This patch set fixes the reading of negative temperatures (returned in
> millidegree celsius). As this requires a change of the error handling
> other functions are aligned with this.
> In addition a small code simplification for reading the scale factors
> for temperature and pressure is included.
One quick process thing.
For IIO (and probably most of the rest of the kernel) we strongly discourage
sending new versions in reply to a previous version.

The only real result is that in a typical email client the threads become
confused and the new version may be missed entirely.

Just sent a fresh thread - the naming makes it easy to connect new
versions to older ones and tools like b4 deal with this automatically.

Jonathan
> 
> ---
> Changes in v2:
>  - include fixes tag
>  - Split up patch
>  - introduce variables for intermediate results in functions
>  - simplify scale factor reading
> 
> Thomas Haemmerle (4):
>   iio: pressure: dps310: support negative temperature values
>   iio: pressure: dps310: introduce consistent error handling
>   iio: pressure: dps310: consistently check return value of
>     `regmap_read`
>   iio: pressure: dps310: simplify scale factor reading
> 
>  drivers/iio/pressure/dps310.c | 138 +++++++++++++++++++---------------
>  1 file changed, 77 insertions(+), 61 deletions(-)
> 
> 
> base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702


