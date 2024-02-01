Return-Path: <linux-kernel+bounces-48915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D882846326
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2383B25C86
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48FA3FE24;
	Thu,  1 Feb 2024 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5A+sGbn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C893FB04;
	Thu,  1 Feb 2024 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825337; cv=none; b=sGJv/a3YHo5o+8ji0zCq3c/9gQl3yNGzLbNRiqBzqrAFnp/xg6+zg6/2zdc0ZjP1xjg7R2JZ2Zo5AGjkc41roM3oOHYlaj7GrMH8p9DJiqXwuhcogA1bpv3Fq6QdFXsF+yuMJUTZbxqnK5gcewhkwPwaNIjXuuA6gd9uup8IBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825337; c=relaxed/simple;
	bh=iV3KjpkcbMu1j2TsrqeOlRj9zSxIctyG0myc+z6mDpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0MJ7QWj7yRUBor8lH1/SrWQ2R9ZzK8duUk6zXU6DNsIY0+N4NZ793F8Tg7Ldd/K7QuAUQaAt6R2r2ht0rE/HKZrE1eAKpqhxzh5Q/2mMWJKrmeDFuLfzHv84URm3ad+j2p0k0TsLJxQdohRqmJ99dDi2602j0XJEZbXiW8gtCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5A+sGbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE09C433C7;
	Thu,  1 Feb 2024 22:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706825336;
	bh=iV3KjpkcbMu1j2TsrqeOlRj9zSxIctyG0myc+z6mDpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5A+sGbn3gCifVerFEU+iZKak4tSKAUnolMChaJ0RkBrOUD/4KXiyjQhavKJFabnp
	 OXbGNcWyOJDB0oQOUl7jpXdPrWICHR9CU0qQdLs/QEHoXIS/lPm215viqn1O2kdKQV
	 vA3968AM4loaEeu4wgqesQ6TRs2LcqOO33Eixu2y4VlqtKQ7oohXTkHSeO3nJvahtU
	 5gHMUdzwCvgq7Gy+gO9EPZ+5/8IIR6wg6tqUBLsfOO1ki4xVYXhpH560ywJTITzzSQ
	 84UlHknB4RmvXAzgJjrRT48hYFO4zvgA78Ovsxc2rCD5QiXKwI7q5u5xQ/j/xu9YTY
	 7gxjvMB5Hpq7Q==
Date: Thu, 1 Feb 2024 15:08:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Mike Isely <isely@pobox.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] media: pci: sta2x11: Fix Wcast-function-type-strict
 warnings
Message-ID: <20240201220853.GA2240065@dev-arch.thelio-3990X>
References: <20240128-fix-clang-warnings-v1-0-1d946013a421@chromium.org>
 <20240128-fix-clang-warnings-v1-1-1d946013a421@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128-fix-clang-warnings-v1-1-1d946013a421@chromium.org>

On Sun, Jan 28, 2024 at 02:12:20AM +0000, Ricardo Ribalda wrote:
> Building with LLVM=1 throws the following warning:
> drivers/media/pci/sta2x11/sta2x11_vip.c:1057:6: warning: cast from 'irqreturn_t (*)(int, struct sta2x11_vip *)' (aka 'enum irqreturn (*)(int, struct sta2x11_vip *)') to 'irq_handler_t' (aka 'enum irqreturn (*)(int, void *)') converts to incompatible function type [-Wcast-function-type-strict]
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I wonder if the media tree cares about reverse Christmas tree order for
variables?

> ---
>  drivers/media/pci/sta2x11/sta2x11_vip.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/sta2x11/sta2x11_vip.c
> index e4cf9d63e926..0a3827575753 100644
> --- a/drivers/media/pci/sta2x11/sta2x11_vip.c
> +++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
> @@ -757,7 +757,7 @@ static const struct video_device video_dev_template = {
>  /**
>   * vip_irq - interrupt routine
>   * @irq: Number of interrupt ( not used, correct number is assumed )
> - * @vip: local data structure containing all information
> + * @data: local data structure containing all information
>   *
>   * check for both frame interrupts set ( top and bottom ).
>   * check FIFO overflow, but limit number of log messages after open.
> @@ -767,9 +767,10 @@ static const struct video_device video_dev_template = {
>   *
>   * IRQ_HANDLED, interrupt done.
>   */
> -static irqreturn_t vip_irq(int irq, struct sta2x11_vip *vip)
> +static irqreturn_t vip_irq(int irq, void *data)
>  {
>  	unsigned int status;
> +	struct sta2x11_vip *vip = data;
>  
>  	status = reg_read(vip, DVP_ITS);
>  
> 
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

