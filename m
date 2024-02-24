Return-Path: <linux-kernel+bounces-79771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B9F862676
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D96E2827D4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A176481B3;
	Sat, 24 Feb 2024 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz6jY75F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85E4F5EC;
	Sat, 24 Feb 2024 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708796580; cv=none; b=kkqAdD3PXdBeQ62ZufDsGRPxZ/zNB1XT/i0Lp4b5pOkHGzycpvsdwA/zl5UmcsNFhJTar4s/aNX7OiKmvCF1vSqu/o/5SPAGoNof5KtdSJXRwJuk8EwFbTalkhXLwXlg25qh8shSYVZc1Got4fbFg3T+e6TwjHYvZZoimG4CxTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708796580; c=relaxed/simple;
	bh=OZAL44ygaFGSxZTGS7WKbyRSLev5JfDvm3Pr5EIKOqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3eCsNZtL5b4wOUL8me73s8moQD0b7h304L2Kslucde2hc/a4JqO8JzHjjuSvpNKOMCNxbtkffXTCrZHtN58YZyiOtTZy9nUKP+X62zClp/Owl1sg3HSWltQeJzt9Zz3Wrn8EReKS36ZX8dX56sLpBur7qC+qQh/vKGCSz+rrQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz6jY75F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09396C433C7;
	Sat, 24 Feb 2024 17:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708796580;
	bh=OZAL44ygaFGSxZTGS7WKbyRSLev5JfDvm3Pr5EIKOqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cz6jY75Fly44nw1hFDyfw4gCVerWm1jgiOGz8JkvWYsktVMrDeHSZS3/IS30DqEMb
	 4Du3oJPA/QLL1ISaZVvZWcXrJ8v2nISuoLJW8xLTV+hpn2ar3m//beo1nVyHtU7tIP
	 Vv6fYMLjI8V6fZ1n1bwj8KxLk6+EeAH+BbVULZsTvRwSPOsnXz9QEQhru7dPiZWDmR
	 1JLNOzAoOK11Nsjy07lnePG4tgtVxIB4j+4rn11eOjRtKBcokuXloClDbu+sRyMPpq
	 g/2KXGnJtwCi3wFvGKAi7mKJJ4dEcLSuWCcJ0aqWpey7Pn0jH3fFaRVMv3aTn0GrKJ
	 EY/W1x8wOxSNw==
Date: Sat, 24 Feb 2024 17:42:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ceclan Dumitru
 <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v5 3/5] iio: amplifiers: hmc425a: move conversion logic
Message-ID: <20240224174246.63598681@jic23-huawei>
In-Reply-To: <20240220153553.2432-2-mitrutzceclan@gmail.com>
References: <20240220153553.2432-1-mitrutzceclan@gmail.com>
	<20240220153553.2432-2-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 17:34:49 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> Move gain-dB<->code conversion logic from read_raw and write_raw to
> chip_info callbacks.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

I've made a small tweak whilst applying this one.

> @@ -100,36 +155,15 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
>  			     int val2, long mask)
>  {

>  	mutex_lock(&st->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = gain_dB_to_code(st, val, val2, &code);
> +		if (ret)
> +			break;
>  		st->gain = code;
> -
Check your patches for unrelated white space changes.
They make things a little less reviewable and they create
noise in the history etc.

If you want to tidy up whitespace, a single patch just doing that
is the way to go.

>  		ret = hmc425a_write(indio_dev, st->gain);
>  		break;
>  	default:
> @@ -189,6 +223,8 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
>  		.gain_min = -31500,
>  		.gain_max = 0,
>  		.default_gain = -0x40, /* set default gain -31.5db*/

