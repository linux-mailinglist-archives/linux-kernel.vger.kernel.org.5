Return-Path: <linux-kernel+bounces-41219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9583C83ED8F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5096D2842CB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334C25779;
	Sat, 27 Jan 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyQ7r8hm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E892563F;
	Sat, 27 Jan 2024 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366470; cv=none; b=LvP+IgMZFCLqBkU8Vbnxnbyks/CKTKu7D07avHIcIidem66v5446yBeXm7HjsmUHzdEFGyDHeLQ7rpc4QwqijyiwOJv8S5nu1izXzr4ulikVbkxahQ6RxzmsT19E1SJy3nBIHdXeXBkXIt3/ODAkorXoLqyM2oOHzO14/k9Fqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366470; c=relaxed/simple;
	bh=dPSRqy8RtN+cIEqACSGMiHRGMly5SB33KCjhBJ4WK2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sky56SnaNP7A1l8kcd/oOQT4ACTVjQsGhLxBnSSiWuaG7sUCIn51tt35nSyDSU7fENXBQMN9mehpUS0DeOhswU9WiIna6bmV4DtdkDyd0iOGmg8crf9KayyJCrwzsUCB6RpfUA8rGJ/XwjgJM835p3BZi5n/HdKjWSnFfm+jhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyQ7r8hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E2DC433C7;
	Sat, 27 Jan 2024 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706366469;
	bh=dPSRqy8RtN+cIEqACSGMiHRGMly5SB33KCjhBJ4WK2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZyQ7r8hmvv4oTnTw0kKT99IJodOgF2Nq54MAy0XdPOko6gBBznC2BC5N57lmaMnti
	 UvT2AkH6rgnu9bOTMC2kgRDk6o8pVXT3JmXMlrxRZnkuxvAXiHwmF85hlVc9+1pBNe
	 Q0EibKr1Wemm+fh/fEcOc3uPzZ7CZMYADM8dSZw3K++BrqPDTxL6FtZmdKQxEwaiJ1
	 ilHdkPNqN+8bTPu31qTJQV56shF2/mw85VN1iz2tUbRhAavs5fIUVTblkq1OcEIa76
	 lXSUdK7tXkg1twQWVO29LOilODWj3nNqEzydPIbS5TG9yGlDygFPrpdy0uiN3NiITz
	 kOjKN3ANqyfsw==
Date: Sat, 27 Jan 2024 14:40:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Li peiyu <579lpy@gmail.com>, Lars-Peter
 Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: humidity: hdc3020: fix temperature offset
Message-ID: <20240127144055.2e46c77d@jic23-huawei>
In-Reply-To: <20240126135226.3977904-1-dima.fedrau@gmail.com>
References: <20240126135226.3977904-1-dima.fedrau@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 14:52:26 +0100
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> The temperature offset should be negative according to the datasheet.
> Adding a minus to the existing offset results in correct temperature
> calculations.
> 
> Fixes: <c9180b8e39be> ("iio: humidity: Add driver for ti HDC302x humidity sensors")

<> are not part of the fixes tag syntax.  I guess you saw the
one case of that which was in my tree earlier in the week and
I've now fixed up?

I've fixed it up here as well.

Applied to the fixes-togreg branch of iio.git.

Jonathan

> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
> Changes in V2:
> - Added Fixes: tag
> 
>  drivers/iio/humidity/hdc3020.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> index 4e3311170725..ed70415512f6 100644
> --- a/drivers/iio/humidity/hdc3020.c
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -322,7 +322,7 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
>  		if (chan->type != IIO_TEMP)
>  			return -EINVAL;
>  
> -		*val = 16852;
> +		*val = -16852;
>  		return IIO_VAL_INT;
>  
>  	default:


