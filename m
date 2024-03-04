Return-Path: <linux-kernel+bounces-90727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C371587040A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A967281C28
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7C847A67;
	Mon,  4 Mar 2024 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h2FcZ3z0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16444778C;
	Mon,  4 Mar 2024 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562294; cv=none; b=WGVwbNTkCNqfLqVSiwV8wE3N9sTng0e7mDTWARx2XY4nqeUQKSLm25YsONR+FomJ+J7ek4dH/iALeFJum3vUB63f/eHiA/6BCjRG25nv2pODGgBiCyjARB6KATOKJ1t8WhVC7FlZFED0z6ZOcovDCslK52SJURf3xKkch+IEJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562294; c=relaxed/simple;
	bh=h/9zy1KugOLjtiNSUOCUhZpas7KS/U8qnts/rcA91wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYGUjbQQMQxCpUizVkAfBzWdTwEmf0YjL4ePStpkkSbw/rtb3Vpy3AyqihLoFoQr0E695TN5JZLhmAsbvpL6f5hM5W/kMwTq+tC0wgUzLytf3UPXPPKFadUdfxGG+tOzpREfD5YUPC4tD1LcKyqxc0x5yMgqS4LjepHZKwBBrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h2FcZ3z0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WvR0p5GSCXE5oGgnR+uiY4hoWKU9F5AvnkOVWd0PDnE=; b=h2FcZ3z0dUPVTukYzDQK/5txj1
	19hQ59T/ECG2s3P3MlPRQQSgzylJDpuMJuj48E4CztOahuz9sBniUwzVGPk3igqASPjUqyyqnxDqm
	mImJyChKkzqDec2PlT7cyWd0NaK7yU6D1fxDBbEZ1Zbn12pylBGaBHRZjzLBMm+d3hV0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rh9FP-009Kbn-AK; Mon, 04 Mar 2024 15:24:55 +0100
Date: Mon, 4 Mar 2024 15:24:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hsr: Use full string description when opening HSR
 network device
Message-ID: <3f2fc5cb-8c79-4e8a-b72e-edcbbc78971e@lunn.ch>
References: <20240304093220.4183179-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304093220.4183179-1-lukma@denx.de>

On Mon, Mar 04, 2024 at 10:32:20AM +0100, Lukasz Majewski wrote:
> Up till now only single character ('A' or 'B') was used to provide
> information of HSR slave network device status.
> 
> As it is also possible and valid, that Interlink network device may
> be supported as well, the description must be more verbose. As a result
> the full string description is now used.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  net/hsr/hsr_device.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 9d71b66183da..9a60489fba96 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -142,30 +142,29 @@ static int hsr_dev_open(struct net_device *dev)
>  {
>  	struct hsr_priv *hsr;
>  	struct hsr_port *port;
> -	char designation;
> +	char *designation = NULL;

Thanks for splitting this into a patch.

Reverse Christmas tree. I know it is broken already, but we should not
make it worse.

I guess you can also add a const, since "Slave A" is probably const.

	Andrew

