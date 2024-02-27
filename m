Return-Path: <linux-kernel+bounces-82545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505C1868630
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089AD28CA87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290646FC6;
	Tue, 27 Feb 2024 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U4z2eUb6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278F536E;
	Tue, 27 Feb 2024 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998156; cv=none; b=uS4pFRbyW9QYd/BCvgojZH59nrRTokcyU7q+xSybQY2GbpY9NRL4ybuvrJGjEsA529krTCGSKpUihOKgpClvtYeaIwp5Hzitcg7FU5fojQqJ/f+4xTLEvDXvE4FXZQ7bKbH0QiP8WZ9LvYw5QeAUvSfzCDglqd5PPmzSDjmYNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998156; c=relaxed/simple;
	bh=/1ew7tmZIVKjvRdFEt6qMZ92mgaBAbKgFISsFb2vq0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPNbRthQ193mzu8OHBBdioKKDij7FJpINIdFVIml9yuUSRohsApcASXl83kPLU9YaRKYeyiD4OkHxUX05zPsyYfUFl/7VCsxtLUiul6Hq5OlIr6FSKFvaf0xb582/YHJOlXxW4MUr1i2sZpSvgNtF0D82ctCylh/9m7ul+qWdcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U4z2eUb6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qw0yA8AB1ummj4Z4Qu+H/YpCQpOBSVd/ACh6125f55E=; b=U4z2eUb65Z9Q8KpnS6cV+y9ipF
	uV9cSHW8EbEnpbDNNkGMnomzCTaNnUWbd/kZzMY8ROa0OmGlZNJn+PYdbdpX74wRmxoL5EKcJlMJC
	0BKBkzQUxovgIQ3LDPwzyVn5JtMSeClOffVCWcQ6Y4AI/y8wHqPTk2dL8J1auTt6HLqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1remUa-008mvg-84; Tue, 27 Feb 2024 02:42:48 +0100
Date: Tue, 27 Feb 2024 02:42:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
	bryan.whitehead@microchip.com, richardcochran@gmail.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net 2/3] net: lan743x: support WOL in MAC even when PHY
 does not
Message-ID: <e4507108-4c02-4c8d-8810-081f6b34d11d@lunn.ch>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-3-Raju.Lakkaraju@microchip.com>
 <20240226082840.qbofj764s35zo352@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226082840.qbofj764s35zo352@DEN-DL-M31836.microchip.com>

> > +		if (ret == -EOPNOTSUPP)
> > +			netif_info(adapter, drv, adapter->netdev,
> > +				   "phy does not support WOL\n");

netdev_dbg(). We don't really care who is doing WoL, if its the MAC,
the PHY, or a bit of both. So there is no need to spam the log with
this.


