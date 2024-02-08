Return-Path: <linux-kernel+bounces-58071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8597884E0DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413B52861B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0B1762DB;
	Thu,  8 Feb 2024 12:43:28 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998E76EB44;
	Thu,  8 Feb 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396208; cv=none; b=RBzo25ryOwsp38moGZ/pXJETkl1qrq4UFBskoq1d2v+giKJWi2R3NjIwXcmJ56ZZ5gTvv4makFYt0JXVDUcbDRZpWRD1P4P/eRaomHcrlg6jdCreB3Wzx0Y1IlVZDIXpYLsgfcG0VA5k0lUo0BwrSWTPy4dBgDvZKlaFtCmY4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396208; c=relaxed/simple;
	bh=UsM4BcpfcImsSZDujcIlDhvQpBCwADaptLL3/9Qq0Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPikdd9KGS31zXkL67gMpPTel2xAVMv6TXBJVIyKlgWl1LQDhjM3yqWQvP5JdoHSkZmtGz3PRTu/xCvrlDho7+kP6aNahgtadfts8CmSpmNOPa2NpWaUOTHf5eNdJOpUKLwFaFAWDzDIkdOG3o6Yrvsi6RrtPc32gIImvVtkl+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rY3Mr-00032B-00; Thu, 08 Feb 2024 13:19:01 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 72F0AC0267; Thu,  8 Feb 2024 13:18:27 +0100 (CET)
Date: Thu, 8 Feb 2024 13:18:27 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 00/14] Add support for the Mobileye EyeQ5 SoC
Message-ID: <ZcTGk/iJO2wZlRxT@alpha.franken.de>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205153503.574468-1-gregory.clement@bootlin.com>

On Mon, Feb 05, 2024 at 04:34:46PM +0100, Gregory CLEMENT wrote:
> Hello,
> 
> The EyeQ5 SoC from Mobileye is based on the MIPS I6500 architecture
> and features multiple controllers such as the classic UART, I2C, SPI,
> as well as CAN-FD, PCIe, Octal/Quad SPI Flash interface, Gigabit
> Ethernet, MIPI CSI-2, and eMMC 5.1. It also includes a Hardware
> Security Module, Functional Safety Hardware, and MJPEG encoder.
> 
> One peculiarity of this SoC is that the physical address of the DDDR
> exceeds 32 bits. Given that the architecture is 64 bits, this is not
> an issue, but it requires some changes in how the mips64 is currently
> managed during boot.
> 
> In this seventh version, I removed the OLB related part as it is not
> used yet. I have left it to Théo to handle in his series. Another
> notable change is the Kconfig modification to remove the selection of
> unused configurations.
> [..]

thank you for your work on this patch set. I've commented on the
two patches, where is see need for changes. Other than that it's
looking good.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

