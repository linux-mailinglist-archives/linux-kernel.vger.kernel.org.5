Return-Path: <linux-kernel+bounces-95592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AF4874FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE1B1F21B74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8600C12CD80;
	Thu,  7 Mar 2024 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nblXYr5c"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069C12C7EA;
	Thu,  7 Mar 2024 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817857; cv=none; b=gNQnk/BInLVg/u/Rp1rNw8AEm+fMj83XR3wf/6Dr/eDCSJWz+DvaDXI35sU3XHsWDHk1PRx5obCHgkCfZwkUvMdR+D8ny5R6Yu+LGszyN+lEbaqE8K1ubD4M+MHDMT1gsReOB9GhTsOOtKCO3Z/jsb5OQ7YyBHjN9cKMuT98M90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817857; c=relaxed/simple;
	bh=K5VjnAhLqgcIrKuBmbdYdluHgmQTNkIbBXmGWTbBaDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1rOXdkZaWdR54teLRsHV3Z2zLdpBF3kg+RAhRlaQeG1vs1A65tgij8R9lzGxtv8/GXMQRBDvLC1EKnULBMyVnTxLZ0t0s28eOtz5QZHtcknp35XZdG2w4I2cwdkrjNJGJSCPsRUfCPxd7a1NbxpVMfF76FZKL7NHjT8o/3v04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nblXYr5c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pUbIJXM5q/s25N6bZHP6NwQ+8ibrrNHeuJIIUXveGVM=; b=nblXYr5cqdijK1j9uYJ8V5aytH
	Wm8KwgVeGS2NgSlv9HDNnpu701KVqvKW30l9Ctoz2sT2ZjU5zut5XIMreSzf24xTXuZADDCOjTcQG
	mfsKOJJjDqtq0vksRCI7PmUsD9Jw7yQBtm2J+KwabRrrjrwDVBkPwOgC0qSQiQzsxpjc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riDjg-009aVk-T9; Thu, 07 Mar 2024 14:24:36 +0100
Date: Thu, 7 Mar 2024 14:24:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 04/12] net: ethernet: oa_tc6: implement
 software reset
Message-ID: <31a09423-276a-415b-a7b8-4aab04021a82@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-5-Parthiban.Veerasooran@microchip.com>
 <4e56f5c2-3d5c-4dda-8a37-01c1dbce27d7@lunn.ch>
 <bff71d0b-49d0-4a4c-98c1-7df7056c4268@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff71d0b-49d0-4a4c-98c1-7df7056c4268@microchip.com>

> >> +static int oa_tc6_read_sw_reset_status(struct oa_tc6 *tc6)
> >> +{
> >> +     u32 regval;
> >> +     int ret;
> >> +
> >> +     ret = oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &regval);
> >> +     if (ret)
> >> +             return 0;
> >> +
> >> +     return regval;
> > 
> > The function name does not really fit what the function does. The
> > function returns OA_TC6_REG_STATUS0. I assume it has more bits in it
> > than just STATUS0_RESETC. So either this function should be called
> > oa_tc6_read_status0, or you should mask regval with STATUS0_RESETC, so
> > that it does actually return the sw reset status.
> Ok, as we do the masking in the calling function readx_poll_timeout, as 
> you suggested I will change the function name as oa_tc6_read_status0 in 
> the next version.

O.K. And i think some of the later patches can them make use of this
generic function.

	Andrew

