Return-Path: <linux-kernel+bounces-156001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3F78AFC8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086782843AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B6741C92;
	Tue, 23 Apr 2024 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2BuQeT8N"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC38638DDD;
	Tue, 23 Apr 2024 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914791; cv=none; b=khCMgQbiosIWpT3YKVHYSmH9bdaKxL0kYb0+82k2Q/O/yBK2f+cT0SPI6iWYQRRZYVeiDZA/80wTaPXhOsSc/2MEAlfA66WkWwasGqgSCwl3q4LLL/NAqW78fWYx7AhjPSzwHmxk0XYSzLrXsOdTAUbClqEOdm0IsccFoJLiT1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914791; c=relaxed/simple;
	bh=vgtPT8kZmuUIwEgKnTpoONPjgJw4cySOe+Vlw9DBD7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUSLvUhlnUiIdTyLfpEO9fe+boIqInzwujl3SaUxGUSVNLFWaAZYlnDKrNF6V6PfxYFBmdJrl2kCFiVBPbDDl+ZxW0pJEyIkVRv8T4AGN+HEMP7YTF4i0cujbnsqWb/f8mxoy/jpMfHpZJbhJmR6aMTbuR/VXT4IrITdh5VBjwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2BuQeT8N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EIgP/ChupM/MVY7fcGEjq87hzDUCAn6wjlf+IrXBvOM=; b=2BuQeT8NKR3EHOI/umX9Wk6VgE
	vp30CDPxrZuaUQ6074Vj/KAzuVH9/UyKaiO6290uj0JpJ+NFUnxIVDecZwPU/cgmo9UgsAaWpeT9E
	Rzm+KMub61vMGVooVrxoFIuFYOJbM5Un7Fb6rsd1vS1WfGDeDCX3U4EtFfA10JoN0L64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzPWj-00Dl3u-Ne; Wed, 24 Apr 2024 01:26:17 +0200
Date: Wed, 24 Apr 2024 01:26:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 04/12] net: ethernet: oa_tc6: implement
 software reset
Message-ID: <1083000b-55db-4fea-843a-6d1db802242d@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-5-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-5-Parthiban.Veerasooran@microchip.com>

> +static int oa_tc6_read_status0(struct oa_tc6 *tc6)
> +{
> +	u32 regval;
> +	int ret;
> +
> +	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &regval);
> +	if (ret)
> +		return 0;

If there is an error, your throw the error code away?

It is a bit messy, since you are using this inside
readx_poll_timeout(). I would probably do a netdev_warn() or similar,
since it should not happen, and then return 0? I _think_ this is
probably the first bus transaction we do, so if it fails, knowing the
error code will help figuring out what is wrong with the SPI bus
configuration.

	Andrew

