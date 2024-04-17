Return-Path: <linux-kernel+bounces-148852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF7B8A8825
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2CF281C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EB5148302;
	Wed, 17 Apr 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la1Xq6Pi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584E14882F;
	Wed, 17 Apr 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369097; cv=none; b=T6dMxNBVYceqtQ2hcN2aXDtzVZ47Osw02JvkTAoi8WQ4mEijAcMpZNqbJxtNjE4AbFgOEtmpozdwTbY9qQoJ2sUHmGaWzRyMMUhTFVyKFbtqbqL5LBIsX4G2Y0nF3ONsljvhqep67uytgIl4LR2h99ZQdAwDcEPt9x/JmJjiUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369097; c=relaxed/simple;
	bh=K0x7L/06vkfwKXBCfS3RzYSZiOVgVkJmMjJYt+VEDN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grQ50qXl5LUk7u9eTl04CbgU6eu8L7n9/OrZrjd1xp/WcoyVDBjhJjjoo7A8ApmvlNu1bBkGgeouOLRgP8aUXdE0lU48pnIzkORy5xP0j+wfpLfcWFLaWHy3Q02ggiIpW0doJf19BMXVt9sJOuK1/jjZPv9zVhqk/WQZtENL5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la1Xq6Pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C05C2BD11;
	Wed, 17 Apr 2024 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713369097;
	bh=K0x7L/06vkfwKXBCfS3RzYSZiOVgVkJmMjJYt+VEDN0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=la1Xq6Pin9fKa7O9mMyd2/wJH1d2JHoyBvj4ebI+9QEP/KzYqhhCD9BKPFc7CLW7B
	 wwwpjEG6bjHm44RX4GMREtYWyDwip9Ze1KHIU8xRY7vtm5jMvm6HJkIljcc/MehVRD
	 bMa8PnhlY851+Ardj+KA18dJvERsl0nwGPd4szWHUlAXUu4YCPwRqOuXqc40SfuZSN
	 9lDpPLOYWV9qOuHvgxdInpiWQY8bD4PAG8p89vL9ipTcEIkGO17+DAW+LiYAat/4Om
	 fhJs7gput3zOaKo9qELmm0msvbYsZ6qg2HjY51DLTuuqLgKX92vbhlguJqRX7miQLM
	 K/QzqM3HGWqyA==
Message-ID: <15cbf6f1-0eb5-4f26-80e3-2f9fc9b30e4f@kernel.org>
Date: Wed, 17 Apr 2024 18:51:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: cleanup DMA
 Channels before using them
To: Siddharth Vadapalli <s-vadapalli@ti.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dan.carpenter@linaro.org, robh@kernel.org, jpanis@baylibre.com,
 u.kleine-koenig@pengutronix.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, spatton@ti.com, srk@ti.com
References: <20240417095425.2253876-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240417095425.2253876-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 12:54, Siddharth Vadapalli wrote:
> The TX and RX DMA Channels used by the driver to exchange data with CPSW
> are not guaranteed to be in a clean state during driver initialization.
> The Bootloader could have used the same DMA Channels without cleaning them
> up in the event of failure. Thus, reset and disable the DMA Channels to
> ensure that they are in a clean state before using them.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Reported-by: Schuyler Patton <spatton@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

