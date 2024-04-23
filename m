Return-Path: <linux-kernel+bounces-155592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D98AF48D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558AF2867FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C4D13D537;
	Tue, 23 Apr 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW//JClN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DB13BAFE;
	Tue, 23 Apr 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890783; cv=none; b=kkBhFmw9sPV7PhTB8wRCr8mtsOKSByE+qSy0b4jrHz8zB0EYFRO69wRztm0PgSm17oyOw0G2htudPCqwPuaf+q4wLdH7wgbcrjZJH31je/4IvSbQfVLJE46yJmYCWFrdLzTBv3b69/8cRd8k80HQ0qPZNM6FhmgzsJZ6BgMuelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890783; c=relaxed/simple;
	bh=d6fUPT7FccaSpbhAaWt+3bXIMJB6KRIJ6QO0yTnP038=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1wdi2Q7BalRVecUMmUqZ0fkaVp1/OvjomuiH/g+dOYkcbI6WTPr+nWkdhzVbTfp2bjlTKiYxnQ9eXQr2XpcIsvcCJUaBRt949AyVZ4o0+xlID64kVfn+18Mn6Uh9vI2rqxcZAsU3Wsmxe79N9qEcWo5bH357BMDMzU8r1ci+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW//JClN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17428C116B1;
	Tue, 23 Apr 2024 16:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713890782;
	bh=d6fUPT7FccaSpbhAaWt+3bXIMJB6KRIJ6QO0yTnP038=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VW//JClNLBdywVje2WU6TgzA/sd6UIAiscV0HlVXGhCD19BwZG5atbmQRH/qm/nMf
	 RwrIAGS3M9LGnI0rin3JJ9NWKsj6cnXpz1Pz6mCvIt1DfZWVCuV4g6M1TIEm9QS5UY
	 Kp5tywStDs1+ph8qr4NtIaXuGZt4Qvunna7FwICtBvvawtEhce117pR7iPrGZEJDz/
	 xQJ9brNKx+1Vwo3iL/HXTIqx4ZwvlxHevJ99ais6v96nvBgiE9C3kEgMc04ESDP1Gl
	 3fuxPXMiS4FqJGZ1mBIwyG8yLUzHSfVVXhZDlQ0PC6HHb9TWpRUM1M6bFdqhdZpvRp
	 KXWAIDcrJkWPw==
Date: Tue, 23 Apr 2024 17:46:16 +0100
From: Simon Horman <horms@kernel.org>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Subject: Re: [PATCH 2/4] can: mcp251xfd: mcp251xfd_regmap_crc_write():
 workaround for errata 5
Message-ID: <20240423164616.GX42092@kernel.org>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-2-bc0c61fd0c80@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-2-bc0c61fd0c80@ew.tq-group.com>

On Wed, Apr 17, 2024 at 03:43:55PM +0200, Gregor Herburger wrote:
> According to Errata DS80000789E 5 writing IOCON register using one SPI
> write command clears LAT0/LAT1.
> 
> Errata Fix/Work Around suggests to write registers with single byte write
> instructions. However, it seems that every write to the second byte
> causes the overrite of LAT0/LAT1.

nit: overwrite

Flagged by ./scripts/checkpatch.pl --codespell

> 
> Never write byte 2 of IOCON register to avoid clearing of LAT0/LAT1.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>

..

