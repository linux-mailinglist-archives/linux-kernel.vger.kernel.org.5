Return-Path: <linux-kernel+bounces-143654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D3C8A3BF5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7601F21E79
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D05F31A94;
	Sat, 13 Apr 2024 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asjzzgpX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D78E3E474;
	Sat, 13 Apr 2024 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713000798; cv=none; b=q227cb/NkMAjuyHUoHeHy8FNPjgvv9B/0DrSUYMSZfGq6v1T5lsFq4OOrT/lIt4L9tgGMP56bVVySzDeHU8wh3R1YaJsyIuPLFfbOVkDE3eLvEZTedCNuJvF9XXWUWckT1OyElol/A9vMT2k/I40Q+pX+OdsZ7AiOwjM3ZAK8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713000798; c=relaxed/simple;
	bh=OvMv3asuhExZTAVwKzsT7vF0MOuPx/aZkjJ1VZfVZ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezjE8dqWc0MkvvJIJ+KEBm4W1neu8GBN0NwbE3LY1e9AAXeVLYjzumm7j4fAwPFt2X622uvtp66dskoyvqNXRsNZrwk0J9F37LXoA6xmBhD2gzLaOuVVVtuvyuyhEiSl+WUBSKa8LA1OQO1t73bn1i3WzHvMDZBl+0Vpvf1n4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asjzzgpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E00DC113CD;
	Sat, 13 Apr 2024 09:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713000797;
	bh=OvMv3asuhExZTAVwKzsT7vF0MOuPx/aZkjJ1VZfVZ0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=asjzzgpX6t8hrg7GDgvrzk7/Y81VpfIy1nt+4lRz5x3HoSlRr9aywX/HK2hQ6SC7D
	 wOBCCAZf/8qWGhmqtjIjlQRbIKlCtv+h3qjp62Q36fNGzVJdMvEujRtYT3YB/cqdxm
	 yjD8HI3ARA1ORZeekBOTYyvSNvGpTbB5Z4xF3fVZIiiF9bTXrPgJavC2RhG5+HKRG/
	 +VHDofOcoYZM7wR/Pyg8jqI5+H8AbqnqQLMde2Cwr3LzVwyGGGgvSFQhWZJAr9Al2R
	 faE77ahJxt5v5ViyMfnoK+761xXrYPWyuDjA4pgxvALnSWZngJm94Bt8trO2QMg/Cf
	 JTKxvGCkAdkSQ==
Date: Sat, 13 Apr 2024 10:33:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Cc: joel@jms.id.au, bsp-development.geo@leica-geosystems.com, Eddie James
 <eajames@linux.ibm.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: pressure: dps310: introduce consistent
 error handling
Message-ID: <20240413103305.39a9aaad@jic23-huawei>
In-Reply-To: <20240410103604.992989-3-thomas.haemmerle@leica-geosystems.com>
References: <20240327084937.3801125-1-thomas.haemmerle@leica-geosystems.com>
	<20240410103604.992989-1-thomas.haemmerle@leica-geosystems.com>
	<20240410103604.992989-3-thomas.haemmerle@leica-geosystems.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 12:36:02 +0200
Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com> wrote:

> Align error handling with `dps310_calculate_temp`, where it's not
> possible to differentiate between errors and valid calculations by
> checking if the returned value is negative.
> 
> Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Other than the reported locking issue the rest of this series now looks
fine to me.  So hopefully that should be easy to resolve and I'll pick
up v3.  Given we are some way into the cycle and the negative value bug
has been there quite a while I'll probably just queue the whole series
for the next merge window rather than going through the dance of taking
the fix patch separately and having to wait before merging the rest.

Thanks,


Jonathan

