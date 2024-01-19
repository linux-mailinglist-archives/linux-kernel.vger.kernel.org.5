Return-Path: <linux-kernel+bounces-31246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCBE832B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F42288876
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F0F53E17;
	Fri, 19 Jan 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4boDJ505"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4D1E48F;
	Fri, 19 Jan 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673540; cv=none; b=q/gQWuHeZyMj4Qwc3NYwzSwcnbAjPd2BzN4MDkfyZ5VdGxVDgG7Zolc8oqyyN6KZoWdVu3Vq7A1iuyY639dXyVxP8LdfFWHyIbFREXugG63N3zhC6+byqmJ7YBTVN/GkkMjId3mfLpwXxOP+pGcRWAswh0SXEstMr53gX4/ONSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673540; c=relaxed/simple;
	bh=R1cCBfGuHtRMJTEbk6UezSmivgGdDfEMg/WSpgn7yi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN8+1+hJkbZJntRFlI1t64To3ly1CmG/W7nhoqfVxWMeCJczVGSOnMxhszyglyVgiK12i5Z/s0nigLruDxCk4iy48yKKOMy0BbrdhvE+VA52o+DbS9fs0fNAqLoKoBj6+JMwySCHmgun89i7ccQc9jLQI6bs2gvHg5dFtqadaik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4boDJ505; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ibvaW/bhHnntVlSpsKG+O9CWPoUcwFPpB7wnzwEi2DM=; b=4boDJ505weNws9tgnxqgIu4/Hy
	M+GkH001Ys5qxjwa/DdE7zBUJsnblTdj1FRlG4KqfCcM4S+wAbtGFN7KyKdr42nuZOA6vfZQTYEjS
	0+ub3FLvnW/XaLExRxgr7Bt5n3bOt6UfnajwnioNFe0Z77wrlOSrQ9/W7Egr9b0fJZsY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQpbI-005Z2f-68; Fri, 19 Jan 2024 15:12:04 +0100
Date: Fri, 19 Jan 2024 15:12:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [RFC PATCH v2 2/3] net: ti: icssg-switch: Add switchdev based
 driver for ethernet switch support
Message-ID: <3ea8934e-c41f-4366-a0c4-1894ed4e3d7e@lunn.ch>
References: <20240118071005.1514498-1-danishanwar@ti.com>
 <20240118071005.1514498-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118071005.1514498-3-danishanwar@ti.com>

> +static int prueth_switchdev_stp_state_set(struct prueth_emac *emac,
> +					  u8 state)
> +{
> +	enum icssg_port_state_cmd emac_state;
> +	int ret = 0;
> +
> +	switch (state) {
> +	case BR_STATE_FORWARDING:
> +		emac_state = ICSSG_EMAC_PORT_FORWARD;
> +		break;
> +	case BR_STATE_DISABLED:
> +		emac_state = ICSSG_EMAC_PORT_DISABLE;
> +		break;
> +	case BR_STATE_LEARNING:
> +	case BR_STATE_LISTENING:
> +	case BR_STATE_BLOCKING:
> +		emac_state = ICSSG_EMAC_PORT_BLOCK;
> +		break;

That is unusual. Does it still learn while in BLOCK? It might be you
need to flush the FDB for this port when it changes from BLOCKING to
LISTENING or LEARNING?

> +static void prueth_switchdev_event_work(struct work_struct *work)
> +{
> +	struct prueth_switchdev_event_work *switchdev_work =
> +		container_of(work, struct prueth_switchdev_event_work, work);
> +	struct prueth_emac *emac = switchdev_work->emac;
> +	struct switchdev_notifier_fdb_info *fdb;
> +	int port_id = emac->port_id;
> +	int ret;
> +
> +	rtnl_lock();
> +	switch (switchdev_work->event) {
> +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> +		fdb = &switchdev_work->fdb_info;
> +
> +		netdev_dbg(emac->ndev, "prueth_fdb_add: MACID = %pM vid = %u flags = %u %u -- port %d\n",
> +			   fdb->addr, fdb->vid, fdb->added_by_user,
> +			   fdb->offloaded, port_id);
> +
> +		if (!fdb->added_by_user)
> +			break;
> +		if (memcmp(emac->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
> +			break;

ether_addr_equal(). Please review all the code and use these helpers
when possible.

So you don't add an FDB for the interfaces own MAC address? Does the
switch know the interfaces MAC address?

       Andrew

