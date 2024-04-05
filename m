Return-Path: <linux-kernel+bounces-132481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18352899598
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497E91C20DAD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC42321A19;
	Fri,  5 Apr 2024 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="noxxfr5O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1714288;
	Fri,  5 Apr 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299072; cv=none; b=WuT87U2IKCo++f/P2f5PCvtIT11EY25iOqcnyHbpqfWhQAe/Yor4Juj4xwshJ7XCvEWLPCxdyKt3knsEM6tbNdR+edQ7p78k0Ae3UP63Ly87eZtR/9A3+1BqAPXxrMAi2U3cOclUufQ0p/Ol+xBhJQqDtKsE8spTL/BDAF2IIOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299072; c=relaxed/simple;
	bh=x+/Mq/rmeQx2+kJB0UUehFljzLSHxpKorqQ3wE9zZvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrVK/acO0kCrqYifc10rDg/w9lowxO7Vzho0kpZlPLJQEhgsUzh7mX9vggkuCkaC34vqPv/BNplnwA9RYUrAxeYC6wHt0KviRtJV0g+YgkO6uybuV+mZCBJ3LOhIpQjdHY5UXBq2tJrX+12r6kle4+1qjsM1BYcoeZmiXS140eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=noxxfr5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A48C433F1;
	Fri,  5 Apr 2024 06:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712299071;
	bh=x+/Mq/rmeQx2+kJB0UUehFljzLSHxpKorqQ3wE9zZvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=noxxfr5Od8JqZzA0S0c0eMEryFu92K1ivZ/Xu6hDxj5sgEOn55Ibt2/H9bEWMSsNl
	 0v3w7GVCpas6gpDmPjN2LTMa2G/NtwdXIB7mHbuhRSyZoPxXQarH6f3s6c8RbLtHyR
	 ZlQRSF+nth98pN3+OGq3rrmFlKlWmVQIgC67MuuA=
Date: Fri, 5 Apr 2024 08:37:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: quic_sridsn@quicinc.com, quic_mdalam@quicinc.com, ezra@easyb.ch,
	gch981213@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
	sashal@kernel.org, vigneshr@ti.com, kernel@salutedevices.com,
	rockosov@gmail.com, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
	stable@vger.kernel.org,
	Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: Re: [PATCH v1] mtd: spinand: Add support for 5-byte IDs
Message-ID: <2024040509-faceless-passerby-10ad@gregkh>
References: <20240404121532.14755-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404121532.14755-1-ddrokosov@salutedevices.com>

On Thu, Apr 04, 2024 at 03:15:21PM +0300, Dmitry Rokosov wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> [ Upstream commit 34a956739d295de6010cdaafeed698ccbba87ea4 ]

This commit is already in the following releases:
	6.6.24 6.7.12 6.8.3 6.9-rc1

> E.g. ESMT chips will return an identification code with a length of 5
> bytes. In order to prevent ambiguity, flash chips would actually need to
> return IDs that are up to 17 or more bytes long due to JEDEC's
> continuation scheme. I understand that if a manufacturer ID is located
> in bank N of JEDEC's database (there are currently 16 banks), N - 1
> continuation codes (7Fh) need to be added to the identification code
> (comprising of manufacturer ID and device ID). However, most flash chip
> manufacturers don't seem to implement this (correctly).
> 
> Cc: <stable@vger.kernel.org> # 6.6.23
> Cc: <stable@vger.kernel.org> # 6.7.11
> Cc: <stable@vger.kernel.org> # 6.8.2
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> Reviewed-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> Tested-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Link: https://lore.kernel.org/linux-mtd/20240125200108.24374-2-ezra@easyb.ch
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
> 
> In the patch series [1] only one patch was marked with Fixes tag, that's
> why the secon patch was not applied to 6.6.y, 6.7.y and 6.8y. It breaks
> ESMT detection flow with logs:
> 
> [    0.770730] spi-nand spi0.0: unknown raw ID c8017f7f
> [    0.772688] spi-nand: probe of spi0.0 failed with error -524
> 
> Please cherry-pick the second patch from the series to 6.6.y, 6.7.y and
> 6.8.y.

What commit id is "the second patch" here?  The one referenced above?
If so, again, this is already in a released kernel, so I'm confused as
to what to do here.

thanks,

greg k-h

