Return-Path: <linux-kernel+bounces-152283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850838ABBDB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34EAB20FB5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4524429CE6;
	Sat, 20 Apr 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdLv+alO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8415220326;
	Sat, 20 Apr 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713621253; cv=none; b=O5S2MmhDcHHQx5rqb5x1ziVUaibd5ew4hpRtfquNbz4MWVTOUX1kmgxrL/nJPXjuxN1zVC6nhJdHcbTNoLB0Wal3DHO6b+NLeeRlEhMnn626NSAY5Floa7L9AopxrA5Z0S4RZBoqNx9nEuHm2AhnjkB8uSzMWpACx6zn4/dSJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713621253; c=relaxed/simple;
	bh=16q168MlSLTeQaQ+4PyfDNW73mGocL4Qi8jMsgDul3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mv7MXaLKzhk4rZWDjZ7RsJncAn6h4o+7q8YLz3+xUc21PUaJvkmPgktMCr+k3qA81vQkTNWZdqPahRZtxmVNNHPUDCdyM34rbxHxdvC5RgCMCtTJxwqJ0Sh0EsxpVC9+3erPy/1HUwirQyz/TJjFIAroGsyxrQ/xZWOchGtkG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdLv+alO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008E4C072AA;
	Sat, 20 Apr 2024 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713621253;
	bh=16q168MlSLTeQaQ+4PyfDNW73mGocL4Qi8jMsgDul3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FdLv+alOWl2XlQEJPcxOC/1KT+pXMyZgrbyD1h3wjyoC303QAeB3gKYHfpT6jIzKe
	 zrYLy5h3gff0d3bjYMdN9rXWRNcyzG/0RTiffoKZwchGkjfx5qRSYWAbJ3L5eYsLNZ
	 5zh7YtA07YvYxu4Kk9hhOpizgodPGVVFWKyMFLwccuCoa1Zlqe4XAuUvSXoUNgIFph
	 Y3QRnVK3KGRpq6tA0RepqImEGrsC0690GkwYOUqZpBgdaQNNZE0BunY4sF/Pley9Vu
	 Sil2dPzzTQntd1a0BTBkijaVlJ7j45pSzGIbsMQQN4uKUOMvzsjJynx2p5Gj8DJuZH
	 l6dt8A2yoQVAA==
Date: Sat, 20 Apr 2024 14:54:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Cc: bsp-development.geo@leica-geosystems.com, Eddie James
 <eajames@linux.ibm.com>, Lars-Peter Clausen <lars@metafoo.de>, Joel Stanley
 <joel@jms.id.au>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: pressure: dps310: support negative
 temperature values
Message-ID: <20240420145400.03793961@jic23-huawei>
In-Reply-To: <20240415105030.1161770-1-thomas.haemmerle@leica-geosystems.com>
References: <20240415105030.1161770-1-thomas.haemmerle@leica-geosystems.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 12:50:26 +0200
Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com> wrote:

> This patch set fixes the reading of negative temperatures (returned in
> millidegree celsius). As this requires a change of the error handling
> other functions are aligned with this.
> In addition a small code simplification for reading the scale factors
> for temperature and pressure is included.
Series applied to the togreg branch of iio.git.
Note I'll first push it out as testing to let the autobuilders see
if they can find any problems before I make a mess of linux-next.

Thanks,

Jonathan

> 
> ---
> Changes in v2:
>  - include fixes tag
>  - Split up patch
>  - introduce variables for intermediate results in functions
>  - simplify scale factor reading
> 
> Changes in v3:
>  - fix locking issues reported in https://lore.kernel.org/all/cbdafb33-fd3b-47ad-a678-83fa92475278@moroto.mountain/
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
> base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
> --
> 2.34.1


