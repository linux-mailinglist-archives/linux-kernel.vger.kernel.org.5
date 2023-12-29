Return-Path: <linux-kernel+bounces-13258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A9B82021A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337D41C22551
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FB114A9E;
	Fri, 29 Dec 2023 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IJINq1l8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F514A85;
	Fri, 29 Dec 2023 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=etdFH97WvsBkR0owkaKZOdN2H9+dmGLc93dDrGAaQ8k=; b=IJINq1l82c3AlsqY20wG3Yfg7z
	F0hhcAz2m7wj/um2f59YtmF95WIY2pkXCporZ7LBiM3dI1EB+XwvexNmONlHulPVBaaGlUehjIPf0
	zNfCqq1OuKNsLlzItOAl43Sq2BbhBjjGvH1mMvu/I9+YimhfAHVYyrpwgAXyNc8cdpYY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rJKpu-003vNa-1x; Fri, 29 Dec 2023 22:56:10 +0100
Date: Fri, 29 Dec 2023 22:56:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, huziji@marvell.com,
	ulf.hansson@linaro.org, catalin.marinas@arm.com, will@kernel.org,
	adrian.hunter@intel.com, thunder.leizhen@huawei.com, bhe@redhat.com,
	akpm@linux-foundation.org, yajun.deng@linux.dev,
	chris.zjh@huawei.com, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, cyuval@marvell.com
Subject: Re: [PATCH 0/4] mmc: xenon: add AC5 support
Message-ID: <cfbbe706-5953-488c-9bff-f72f6d00b44f@lunn.ch>
References: <20231227123257.1170590-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227123257.1170590-1-enachman@marvell.com>

On Wed, Dec 27, 2023 at 02:32:53PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> This patch series adds support for the Marvell AC5/X/IM series of SOCs.
> The main hurdles in supporting these SOCs are the following limitations:
> 1. DDR starts at offset 0x2_0000_0000
> 2. mmc controller has only 31-bit path on the crossbar to the DDR.
> 
> Point number one is solved by the first patch, which targets the
> arm64 subsystem, by taking into account the DDR start address when
> calculating the DMA and DMA32 zones.
> 
> This yields the correct split between DMA, DMA32 and NORMAL zones
> according to the device tree CPU address limitations.
> 
> Point number two is solved in the mmc xenon driver by detecting the memory
> size, and when it is more than 2GB, disable ADMA and 64-bit DMA, which
> effectively enables SDMA with a bounce buffer.
> DMA mask is then set manually to 34 bit to account for the DDR starting
> at offset 0x2_0000_0000 .

You probably need to split this patchset up since the first patch will
get merged via the arm64 core maintainers, the MMC driver change via
the MMC maintainers, and maybe the DT changes for the
ac5-98dx25xx.dtsi via the mvebu maintainers, or the MMC maintainer?

	Andrew

