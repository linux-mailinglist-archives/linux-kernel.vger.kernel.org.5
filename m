Return-Path: <linux-kernel+bounces-112685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C73887CF4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047EF1C20AAF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C2417C96;
	Sun, 24 Mar 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY39n9/2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458401A38DA;
	Sun, 24 Mar 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711288283; cv=none; b=m6Vtv97N/3FpasyS/qXSjQ+gj2MMpnRbiVhdWvouQ+ICOn8Wp3ZAVxJK0oIDN9Zx1f2qSd4b9b8+TQRrBDjEEjfRQjL8WE2Oljef0NCBrA0mG926sb95pomVRVEuFZB2pGCV/UpjwZJdE3QebVUDTRINdRNn1aGZIKx936WooH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711288283; c=relaxed/simple;
	bh=Q1qsaNc4Xf1RFSr+vL9gGoT1ITWqAgeVcD4vzkh8OOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/KLuJso9tM53Wzy9UtwymKb0wEQgh8E7J/rwNj9coVIrinNVXLtWWCZ0KDKxFye9cwypg05EHDmQTFrfy6UylWijetpCTawvNoh6AaA0xRco3g/f+UAGOZ7pt0/OQADXyskj9Wzvc9VzADRXRJu+vD+cdTRe5maX5rlMaDuZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY39n9/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC09FC433F1;
	Sun, 24 Mar 2024 13:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711288282;
	bh=Q1qsaNc4Xf1RFSr+vL9gGoT1ITWqAgeVcD4vzkh8OOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EY39n9/2Iz9Dw5jZ6/LFN/6DfJYpsBVf8aF1plriJ8crGr/BSN4Xpb+MXOlnj98a7
	 TUaddxR9bi3Pao2Vg9lCO+XWPB11WobJTJY+Ms8JdLAtM8kqaJh/PYkJRR6ytyEnfb
	 0Rd7jp4FS+6DQiwGeaTBtYCFMiyQu0A5epbtn1+kq4URa+0kJaHsLF2IiDC5/esIjB
	 k4OBXz7PxLKid0bb0jF1OzNsjqNdAPf3Y3P2RAoaSwLf2Jzl4u/tONSM16OuKZePDl
	 SCeHhZxD1l54+YUunXtspAgqWgWvmfUnH+JVrHv+DqPvdexbxS+gUXpQfZb+eIZ2ah
	 7Qy3c1rY16pwA==
Date: Sun, 24 Mar 2024 13:51:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: hsc030pa: Use spi_read()
Message-ID: <20240324135110.1e71572d@jic23-huawei>
In-Reply-To: <8327ac591d244ac85aa83c01e559076159c7ba12.1711283728.git.christophe.jaillet@wanadoo.fr>
References: <8327ac591d244ac85aa83c01e559076159c7ba12.1711283728.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Mar 2024 13:36:16 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Use spi_read() instead of hand-writing it.
> It is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied to the togreg-normal branch of iio.git.

Thanks,

Jonathan

> ---
> Compile test only
> ---
>  drivers/iio/pressure/hsc030pa_spi.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
> index 818fa6303454..337eecc577d2 100644
> --- a/drivers/iio/pressure/hsc030pa_spi.c
> +++ b/drivers/iio/pressure/hsc030pa_spi.c
> @@ -23,14 +23,9 @@
>  static int hsc_spi_recv(struct hsc_data *data)
>  {
>  	struct spi_device *spi = to_spi_device(data->dev);
> -	struct spi_transfer xfer = {
> -		.tx_buf = NULL,
> -		.rx_buf = data->buffer,
> -		.len = HSC_REG_MEASUREMENT_RD_SIZE,
> -	};
>  
>  	msleep_interruptible(HSC_RESP_TIME_MS);
> -	return spi_sync_transfer(spi, &xfer, 1);
> +	return spi_read(spi, data->buffer, HSC_REG_MEASUREMENT_RD_SIZE);
>  }
>  
>  static int hsc_spi_probe(struct spi_device *spi)


