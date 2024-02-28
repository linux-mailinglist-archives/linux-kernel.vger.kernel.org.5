Return-Path: <linux-kernel+bounces-85420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E786B5A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EAB1C24402
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD73FBB4;
	Wed, 28 Feb 2024 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6bBKFRXx"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB743FB82;
	Wed, 28 Feb 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140411; cv=none; b=ClO0myvsuqZgmVc0u9gsqCFTxvXgm6nyTXdfGDpfSWq7CBGiHOCUQVUoihDjbZcfhrH7+4AjcyqhAI9qXBn6t1wjXAwOxcQkrRm90iGlTyKZOMaovCc6XjmqZ9woxX6P82aDakCwnZEbxxiqAGfPEF2YBpbEWJ3eDi2DsvZTKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140411; c=relaxed/simple;
	bh=PJaF6gSLkw7fAhbaAIUur5cxQrm9SOr3pOGCt3bL4vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOpqoAF6MdU+NSxl8ClOhjqKCSBfzUR5XMKddZ20U4SToiw26UuJsQ8CHUooZu/lVK3/BqTY9XJX2JkiCARWxqiNCUxv+FcWuwhimxuDF8zcx8sl0DneeIqYh4vaiHybYWfn4EghbZjimghR76dImM3JgcTBNWag1SVpj8/OJJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6bBKFRXx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ATTunrxx8mfo9iaJ9GmqVqGlssdQqFA0a4Hs7ZDBupc=; b=6bBKFRXxjEiCu7kcsw3VMRPN5n
	xBvNiwuUbparGW7+QR0EnlnbjdfeSvIY7RXmz5ZF1zYydM3MkMiLIAYQLj7wubDb/40GYy9HhrX6N
	GAj9YPafFbxysI0XV15P7X77QF3HnM+y0QJPIF3DPxeGQIKALSykkYFEcOO500d9fQAA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfNUS-008yBO-7q; Wed, 28 Feb 2024 18:13:08 +0100
Date: Wed, 28 Feb 2024 18:13:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: hsr: Provide RedBox support
Message-ID: <608850a9-966e-420b-8d16-1ab6baa65025@lunn.ch>
References: <20240228150735.3647892-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228150735.3647892-1-lukma@denx.de>

>  void hsr_debugfs_rename(struct net_device *dev)
>  {
> @@ -95,6 +114,19 @@ void hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev)
>  		priv->node_tbl_root = NULL;
>  		return;
>  	}
> +
> +	if (!priv->redbox)
> +		return;
> +
> +	de = debugfs_create_file("proxy_node_table", S_IFREG | 0444,
> +				 priv->node_tbl_root, priv,
> +				 &hsr_proxy_node_table_fops);
> +	if (IS_ERR(de)) {
> +		pr_err("Cannot create hsr proxy node_table file\n");
> +		debugfs_remove(priv->node_tbl_root);
> +		priv->node_tbl_root = NULL;
> +		return;

You should not be checking return values from debugfs and not printing
error messages etc. debugfs is totally option, so you should just keep
going. The debugfs API should not explode because of a previous
failure.

> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -142,30 +142,32 @@ static int hsr_dev_open(struct net_device *dev)
>  {
>  	struct hsr_priv *hsr;
>  	struct hsr_port *port;
> -	char designation;
> +	char *designation = NULL;

Revere christmas tree place. When you go from RFC to a real
submission, issues like this need fixing. For an RFC its not so bad.

>  	hsr = netdev_priv(dev);
> -	designation = '\0';
>  
>  	hsr_for_each_port(hsr, port) {
>  		if (port->type == HSR_PT_MASTER)
>  			continue;
>  		switch (port->type) {
>  		case HSR_PT_SLAVE_A:
> -			designation = 'A';
> +			designation = "Slave A";
>  			break;
>  		case HSR_PT_SLAVE_B:
> -			designation = 'B';
> +			designation = "Slave B";
> +			break;
> +		case HSR_PT_INTERLINK:
> +			designation = "Interlink";
>  			break;
>  		default:
> -			designation = '?';
> +			designation = "Unknown";
>  		}
>  		if (!is_slave_up(port->dev))
> -			netdev_warn(dev, "Slave %c (%s) is not up; please bring it up to get a fully working HSR network\n",
> +			netdev_warn(dev, "%s (%s) is not up; please bring it up to get a fully working HSR network\n",
>  				    designation, port->dev->name);
>  	}
>  
> -	if (designation == '\0')
> +	if (designation == NULL)
>  		netdev_warn(dev, "No slave devices configured\n");

It would be good to split this into multiple patches. Do the A to
Slave A, B to Slave B, etc as one patch. Then add Interlink.

Ideally you want lots of simple patches which are obviously correct,
each with a good commit message explaining why the change is being
made.

	Andrew

