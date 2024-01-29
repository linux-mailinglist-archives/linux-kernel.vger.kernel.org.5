Return-Path: <linux-kernel+bounces-42786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E798406C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B925CB21511
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E38063108;
	Mon, 29 Jan 2024 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUQSmhLp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9B62A03
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534662; cv=none; b=ks/KJt5dnzhFPSo2Fvscn2TvEBF4UXVsbzfN8/FWQzr10P6vSrIcnARwybAHn4LS/TCql10H48oeWAZE5jP9MmkN0Bdr2Hf+QhZeGFfSC2Gob1NkbZ8mVb3HUqhWD6G89KEYDWUZPdxL97NWILIuudedePr/zk8uCxnUUFTmnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534662; c=relaxed/simple;
	bh=6i2dbAfD9PBonlVoQuQ5LLhHF3/c2cTgJ1Up88UEt/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XcU8Nepw3dBVJuX9Hz85RQx17PD0kNZdC/bihXfSztse3BHkSAimg9+cQcPEnelmkSzzQuY3fuwhCIKrvpL5BEwzZCoqb4H4wJn+QC+EvrqvSqGOfAoQxa4gCEG/S6EeW3aK2fe538kgiGrijel5u2V2WW2OvJpz4cHop7g9F+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUQSmhLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84AAC433F1;
	Mon, 29 Jan 2024 13:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706534662;
	bh=6i2dbAfD9PBonlVoQuQ5LLhHF3/c2cTgJ1Up88UEt/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iUQSmhLpkiefjqCXgafJuu+YYxz/VQxDFLDMiPR1ntBW61Ta/jCTlsnHJd6uRuuLd
	 OuD6nAH0EIIn/I1JGCP8IWv+Z2fqz4MIF4GKoD+TeTDoJGMAFGQbadnoCM1dQFDQAn
	 LQAFaIWZOVhY7BXqg5lSVIgaFy07Ue6u+KefD1opnTjdXWW5R8NIRIRh62ZwZcPHth
	 UlhiMyQJE2MStmnl8CGvTWymAchrFDE0WVp29necz7HXuyIMBc5wDoyr9VuYXLxYs/
	 +Y0Aa3IXzGnYxWKBrKVSn7+IQtxxbI3yCs7VQMEh1j1W5RGAhg0V+ENg1SG7EYoHBs
	 BR9KqbrVmzZFw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org,  michael@walle.cc,  miquel.raynal@bootlin.com,
  richard@nod.at,  jaimeliao@mxic.com.tw,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mtd: spi-nor: sysfs: hide the flash name if not set
In-Reply-To: <20231215082138.16063-4-tudor.ambarus@linaro.org> (Tudor
	Ambarus's message of "Fri, 15 Dec 2023 10:21:37 +0200")
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
	<20231215082138.16063-4-tudor.ambarus@linaro.org>
Date: Mon, 29 Jan 2024 14:24:19 +0100
Message-ID: <mafs034ugtgqk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 15 2023, Tudor Ambarus wrote:

> From: JaimeLiao <jaimeliao@mxic.com.tw>
>
> The flash name is not reliable as we saw flash ID collisions.
> Hide the flash name if not set.
>
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> [ta: update commit subject and description]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor | 3 +++
>  drivers/mtd/spi-nor/sysfs.c                             | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
> index c800621eff95..6d7be97bf7d1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
> +++ b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
> @@ -25,6 +25,9 @@ KernelVersion:	5.14
>  Contact:	linux-mtd@lists.infradead.org
>  Description:	(RO) Part name of the SPI NOR flash.
>  
> +		The attribute is not present if the jedec_id founded in
> +		ID table but flash name didn't include in it.

Nitpick: strange sentence construction makes it a bit confusing.
Perhaps:

    The attribute is not present if the JEDEC ID table for the flash
    does not include its name.

> +
>  
>  What:		/sys/bus/spi/devices/.../spi-nor/sfdp
>  Date:		April 2021
> diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
> index 2dfdc555a69f..96064e4babf0 100644
> --- a/drivers/mtd/spi-nor/sysfs.c
> +++ b/drivers/mtd/spi-nor/sysfs.c
> @@ -78,6 +78,8 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
>  
>  	if (attr == &dev_attr_manufacturer.attr && !nor->manufacturer)
>  		return 0;
> +	if (attr == &dev_attr_partname.attr && !nor->info->name)
> +		return 0;

Do you want to show the name for the "spi-nor-generic" flash? If not
then perhaps drop its name as well?

>  	if (attr == &dev_attr_jedec_id.attr && !nor->info->id && !nor->id)
>  		return 0;

-- 
Regards,
Pratyush Yadav

