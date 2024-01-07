Return-Path: <linux-kernel+bounces-18910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B19C2826505
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E3D1F22EBD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F2413AE3;
	Sun,  7 Jan 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSyoz73S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B013AD7;
	Sun,  7 Jan 2024 16:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45396C433C8;
	Sun,  7 Jan 2024 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704644132;
	bh=Wf6eDvpDPRtyWdVAPf7HspHXkbuiVLW+r7ivHe1tA6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oSyoz73S+7PGDNDs7wkI1Y65vcK1rqqXt9g3YjMfz6VIJQOu7gyfy7Zynkf6I/hE1
	 BmrYRRtr+eRKGS22FUaWaWq8FTH2F6ybUDCZielg5Z7hLZpQWBQbAntKTRpwrQUs6n
	 zjo3oHVwwrgsN7vgykCXQTqEjNmAVvj+pIvNrmizGuZM7AcoEiabybv2P0TOHsmXfN
	 qTyOKXbF53YXhJP645pHFIQHhIumTVRCQ/iqkbCN11OU/rdvGEGRBxPv4vmWGB19lR
	 jYrEj4dK57fIe4F5bsybSur5Qw4mMWmCU8R5xgKE4oYp2/3Fd5NQ2sQs+e6gVsGW0t
	 d1PUhQ6sp7mUw==
Date: Sun, 7 Jan 2024 16:15:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mohammed Billoo <mab.kernel@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Marek Vasut <marex@denx.de>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Biju Das
 <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1015: Use correct pga upper bound
Message-ID: <20240107161524.7dc72a3f@jic23-huawei>
In-Reply-To: <20240106174836.1086714-1-mab.kernel@gmail.com>
References: <20240106174836.1086714-1-mab.kernel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jan 2024 12:48:35 -0500
Mohammed Billoo <mab.kernel@gmail.com> wrote:

> The devicetree binding and datasheets (for both the ADS1015 and
> ADS1115) show that the PGA index should have a maximum value of 5,
> and not 6.
> 
> Signed-off-by: Mohammed Billoo <mab.kernel@gmail.com>

Hi Mohammed,

Seems correct, but I'm curious - did you see an actual problem with
setting the value to 6?  From my reading of the ads1115 datasheet
6 and 7 should be functionally identical to 5.

Anyhow, good to clean it up anyway so applied to the togreg branch of
iio.git but that tree will be rebased on rc1 once available so for
now I'll just push it as testing for 0-day to get started on testing it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads1015.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 6799ea49dbc7..6ae967e4d8fa 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -925,7 +925,7 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
>  
>  		if (!fwnode_property_read_u32(node, "ti,gain", &pval)) {
>  			pga = pval;
> -			if (pga > 6) {
> +			if (pga > 5) {
>  				dev_err(dev, "invalid gain on %pfw\n", node);
>  				fwnode_handle_put(node);
>  				return -EINVAL;


