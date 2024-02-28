Return-Path: <linux-kernel+bounces-85103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF6986B072
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188E5283302
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F7714DFD6;
	Wed, 28 Feb 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cIKQPuKh"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812514AD07;
	Wed, 28 Feb 2024 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127421; cv=none; b=O60+CFl5mDqrcRywgkKvVlTSnE/PW2hrTDj/mkblJbekIdRCaL8HOk0frzgYYEYz4pXtcYTZFZs6N465hHKJKjpNqfpWd5GyWF7k5wR+Z6essi4OjW7SxxdcCR0v5pGMqdy9Fml+ebiYM424Ly5nqbkbjzLSw52zcaLAzX3hr20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127421; c=relaxed/simple;
	bh=FRzdGDtaDY/ZsN9Pb8CwRvCedMB6DK1NWK7UMLZPETo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqJlx8b+ELyMm2R2wEBqKRE2w0DzIztZGeSExnvSvJIry5RCf2YYbJEQpQK3zS/Scthc3aFrvplRhV4gEVbLY8t3zgbQwbDe6NipvmMkUdBCs8fZL63LWjMY51W4uMWvcP5EpnNjz4fpyqY020wCbV7Ca6oUSKR+33WSzlDp7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cIKQPuKh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eL1crjPm6iVPDiUZKWfVlS+WUK+mGo0FrxLXMhoPKK4=; b=cIKQPuKhhzqJBAMQRvIpdRG070
	IvXQiqXjXBMVpNDs9YN5HY9PYMQpkVZHgmD3L4L5SojetMWTZjbtr8kvIqco69/Bs4t9XwiUejmZL
	MHPi0Bjp+p+vxedZ5DD0PxlnxmN1lUVPg6tmoKBeCCVO4i20vrGsXOypdMAQVDOy9Kho=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfK7D-008x1J-G2; Wed, 28 Feb 2024 14:36:55 +0100
Date: Wed, 28 Feb 2024 14:36:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, rogerq@kernel.org,
	vladimir.oltean@nxp.com, hkallweit1@gmail.com,
	dan.carpenter@linaro.org, horms@kernel.org, yuehaibing@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
Message-ID: <10287788-614a-4eef-9c9c-a0ef4039b78f@lunn.ch>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
 <Zd3YHQRMnv-ZvSWs@nanopsycho>
 <7d1496da-100a-4336-b744-33e843eba930@ti.com>
 <Zd7taFB2nEvtZh8E@nanopsycho>
 <49e531f7-9465-40ea-b604-22a3a7f13d62@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49e531f7-9465-40ea-b604-22a3a7f13d62@ti.com>

> What if there is no kernel behavior associated with it? How can it be mimicked
> then?

Simple. Implement the feature in software in the kernel for
everybody. Then offload it to your hardware.

Your hardware is an accelerator. You use it to accelerate what linux
can already do. If Linux does not have the feature your accelerator
has, that accelerator feature goes unused.

> Please consider the following:
> Untagged packets sent from Software via the corresponding VLAN interfaces will
> be tagged which is the expected behavior. However, if this is offloaded, it will
> imply that even untagged packets that are simply forwarded in the Ethernet
> Switch and never get to software will also have to be tagged by the Ethernet
> Switch. This is not allowing the choice of leaving untagged packets as-is on the
> Ethernet Switch's forwarding path. This patch attempts to allow configuring
> something quite similar to this, where it is possible to *choose* whether or not
> to tag packets being forwarded.

So step back. Forget about your accelerator. Use just a Linux software
bridge. Describe what you want the Linux software bridge to do.

	Andrew

