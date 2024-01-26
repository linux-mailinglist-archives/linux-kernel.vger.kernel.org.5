Return-Path: <linux-kernel+bounces-39546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A6B83D29A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977781C24635
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6854BA4B;
	Fri, 26 Jan 2024 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwuiCkj7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36690B677;
	Fri, 26 Jan 2024 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236601; cv=none; b=AGIr4Gx9QYfZE2AeR9L2K7S2VBvHCi9hkeJsvQu1O4DuxlEPGZQ3PjIn3Nt8Iu6jEObyxMQm+w7pmS4KOJhzyxpmpx/JnECR9if2YzVoxME0SHnnHCnL+pbelXcsWyXRiIClTXR3+h9Qmk1UHs0X7s3iq/ksyVdHvySabzLcNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236601; c=relaxed/simple;
	bh=9JmEDAsvy+hNUeumaRRwP1gpp1KNTxdoEupeK85sMt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A034WGsKssXLfg7yScGMt80HtFOJMRVl/poRKsKbpjphkCTfzJmDFZ/hucSDY+OhPk52LPLBGxQJovMQSlt+JNLiNTolPDFTzWI0YRpStYnH30Rq2TYgQddtsOraCpyp0GfrRYpPxMogfLp0sq5gnRYMt83CNsDvV2cXozpJa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwuiCkj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EA7C433F1;
	Fri, 26 Jan 2024 02:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706236600;
	bh=9JmEDAsvy+hNUeumaRRwP1gpp1KNTxdoEupeK85sMt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uwuiCkj7aR4vC0Kr7RXMjB6HNaaJwRRhn/NNfpLuCvbrw5syLSnOkCuDG415qJcdc
	 0ivua+kNgH6gO8vCdc2APei5TRmWdz/ik/vaXl9l/YdltJGfOg5VHi57juU+6hGfIJ
	 EvaJ8FPJxpiFcUD6Yoyz+nzsjKjLsstxhI4tdqq/JspzqK9UUyXckidIwQlAJbyUPM
	 5AjHyWbOS34hFERiaySogOLyugdmNcA1lsr3bpDF4ArYXwrUcpnKqZCGU9wwoowGqM
	 saLs2OghXHNNuCfTlK/lTUC5bE3/KwoHvsIidjZP8eoZVhbCW7BABltQPcNU5FE/ro
	 ak/fwFlvKVAhw==
Date: Thu, 25 Jan 2024 18:36:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Lino Sanfilippo
 <LinoSanfilippo@gmx.de>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 01/14 next] qca_spi: Improve SPI thread creation
Message-ID: <20240125183639.585ec73f@kernel.org>
In-Reply-To: <20240124223211.4687-2-wahrenst@gmx.net>
References: <20240124223211.4687-1-wahrenst@gmx.net>
	<20240124223211.4687-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 23:31:58 +0100 Stefan Wahren wrote:
> The qca_spi driver create/stop the SPI kernel thread in case
> of netdev_open/close. This isn't optimal because there is no
> need for such an expensive operation.
> 
> So improve this by moving create/stop of the SPI kernel into
> the init/uninit ops. The open/close ops could just
> 'park/unpark' the SPI kernel thread.

What's the concern? I don't think that creating a thread is all
expensive. And we shouldn't have a thread sitting around when
the interface isn't use. I mean - if you ask me what's better
a small chance that the creation will fail at open or having
a parked and unused thread when device is down - I'd pick
the former.. But I may well be missing the point.

> @@ -825,6 +813,7 @@ static int
>  qcaspi_netdev_init(struct net_device *dev)
>  {
>  	struct qcaspi *qca = netdev_priv(dev);
> +	struct task_struct *thread;
> 
>  	dev->mtu = QCAFRM_MAX_MTU;
>  	dev->type = ARPHRD_ETHER;
> @@ -848,6 +837,15 @@ qcaspi_netdev_init(struct net_device *dev)
>  		return -ENOBUFS;
>  	}
> 
> +	thread = kthread_create(qcaspi_spi_thread, qca, "%s", dev->name);
> +	if (IS_ERR(thread)) {
> +		netdev_err(dev, "%s: unable to start kernel thread.\n",
> +			   QCASPI_DRV_NAME);
> +		return PTR_ERR(thread);

I'm 90% sure this leaks resources on failure, too.

Rest of the series LGTM!

