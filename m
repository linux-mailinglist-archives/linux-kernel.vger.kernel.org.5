Return-Path: <linux-kernel+bounces-133980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4294F89ABB0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B3F7B218D9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90DE3A1CA;
	Sat,  6 Apr 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtR9QAY1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADF826AC2;
	Sat,  6 Apr 2024 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712417982; cv=none; b=XfUBBaSsjO9qKw1n0up24Z6i+D7mwD2MZZ+iub732DnETokdiLV5kGeEVMdmmn9buKtbBJp9rR2X+EPsI3Pvu6Wtu1NpwnYMp+gbO1wfFewFjgFuE748f9zVc5uT0D/KTZTMtTOM/y1M/tmjTitANf03MttPg9CI21PucpL01mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712417982; c=relaxed/simple;
	bh=ZS1O5rlPBLfEcou8rXXarcrf4dxatgQV4muJCx/cFFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ref69XZjIYYbHqfqpC1nwLn0NZcp+DOe0WRvJQHgSsyEUIFED4gTpEd5JeNJha8VA1RqK2xEu5pkDxHwTtwHU7tZPfhXnnYL9QO4QJbgoR0VqUWFpSKdlTibiyD8ydmixlSD4/rZkYe8Y3Oz0saIuFGTM2/OkugISghHSk7g0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtR9QAY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC1BC433F1;
	Sat,  6 Apr 2024 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712417981;
	bh=ZS1O5rlPBLfEcou8rXXarcrf4dxatgQV4muJCx/cFFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qtR9QAY1JXq6fhIlfvdEkVE/7MG3waliLEaScKgd5DOMhCU8VLLPqN1qToUl5k27g
	 QRRGLU441wYKZR80Avbi0cDAno3NarLeXbRoyPTRHrx1FGn6JmmkV/AJ6aHsxiQdCC
	 4ZnsiLnDu0x+fcGTIrGN/lmUMmOUi8vpKQfsLaM0vF36j2GVfFyV1jlTK6xKXZMwqC
	 5tlS5FuRUV2+bnKNpHfn8iWyREwnCCKLGEvdkn+e++O8ta4TMYwG9t0FozlUgGzLT5
	 SOQ20FKCllzrkGpkbrnItlsY6VNXUcZpo/ezjf8rUY4Y2G4r/T2k7rCr5GmCOf+QvI
	 YyfSp7NaJSztg==
Date: Sat, 6 Apr 2024 16:39:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/1] iio:imu: adis16475: Fix sync mode setting
Message-ID: <20240406163928.1ea36f04@jic23-huawei>
In-Reply-To: <20240403111357.1074511-2-ramona.gradinariu@analog.com>
References: <20240403111357.1074511-1-ramona.gradinariu@analog.com>
	<20240403111357.1074511-2-ramona.gradinariu@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 14:13:57 +0300
Ramona Gradinariu <ramona.gradinariu@analog.com> wrote:

> Fix sync mode setting by applying the necessary shift bits.
> 
> Fixes: fff7352bf7a3 ("iio: imu: Add support for adis16475")
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> ---
>  drivers/iio/imu/adis16475.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 01f55cc902fa..bd30c3469d9a 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1351,7 +1351,8 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
>  	 * in chip_info.
>  	 */
>  	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> -				 ADIS16475_SYNC_MODE_MASK, sync->sync_mode);
> +				 ADIS16475_SYNC_MODE_MASK,
> +				 ADIS16475_SYNC_MODE(sync->sync_mode));
As per the build bots, this is triggering a check on the size the last variable.
See definition of adis_update_bits()
There is even a comment in there to 'beware' of what you hit here.

Easiest is probably to force that with 
 (u16)ADIS16475_SYNC_MODE(sync->sync_mode));
or a local variable.


>  	if (ret)
>  		return ret;
>  


