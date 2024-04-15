Return-Path: <linux-kernel+bounces-145486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C39F8A56C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA1E1C2144F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961B67C090;
	Mon, 15 Apr 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joCh/hq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF15B29414
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196148; cv=none; b=FYl4q8L/que1U7pcP0VPDUVbn9Tgg6teaykaqM3ka9MLXVZbnNqR+5PtnrHNQJ85WxqXsIU5cf9BD43GELMLCLOHY22UhsTOcSGkt8TEKBdn2tzxx+sNUIKlv26oT3rjNvsIrrSaoKzfll/nyqskpX0ZEHzeAeCARr5KDPlC8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196148; c=relaxed/simple;
	bh=BJXjB4r8u0vb4Jwuxwghtyi9WRN5rvURICx0OP1Z1io=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7p2CJIr9rkrhQvuEfavkTDUv0VYbW9gLynKiEPgNf3mfWPGANRt6IhrypUi0U80UbAjB52szs4I1Z3/o+xNIGASgxahFk+z6wl0TdA2dAWz/vUtRQjVpSNQ7dFGZTQUlsG2NajqWurgxM1tzndwH9doanvfFu7HIb4n7Hw/gGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joCh/hq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F75CC113CC;
	Mon, 15 Apr 2024 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713196147;
	bh=BJXjB4r8u0vb4Jwuxwghtyi9WRN5rvURICx0OP1Z1io=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=joCh/hq9tOzj6rQAF98jynVX4S0K+b70h1HXUwyOAd9QJgy1Y+AQInX4fkHj+qVHA
	 QnletxDqJLaMlTKAI9gq0/9GwL70u4G1LyHSKCRflUhmI1b3uLOtOkeiicJ9alf2Pl
	 am7MlrbTF/aB4fOa72+vRYSXuOayo+NSGvqMTOZulHBD5hi9a6VuS9qRK3iMRV/WoB
	 QadCiTi6dOMmLq1iTlNb7ySDygToYF+YWn9rq5lV4mjjPx56kuM4fRfj8uguk/F5HW
	 1T/kn2bXe9lWxAX4ro8rjgAH4BoX7ggwa/ukXdlIkn1zyQLC1HcfftexYuQxer1wc1
	 SdNjx4mImwP2A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 2/6] mtd: spi-nor: get rid of non-power-of-2 page
 size handling
In-Reply-To: <20240412134405.381832-3-mwalle@kernel.org> (Michael Walle's
	message of "Fri, 12 Apr 2024 15:44:01 +0200")
References: <20240412134405.381832-1-mwalle@kernel.org>
	<20240412134405.381832-3-mwalle@kernel.org>
Date: Mon, 15 Apr 2024 17:49:04 +0200
Message-ID: <mafs05xwi8w3z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Fri, Apr 12 2024, Michael Walle wrote:

> The Xilinx flashes were the only user of the page sized that were no
> power of 2. Support for them were dropped, thus we can also get rid of
> the special page size handling for it.

Looks like the Xilinx flashes are the only users of
flash_info->page_size, and params->convert_addr (along with
spi_nor_convert_addr()) so those should also be dropped.

The patch looks good to me otherwise.

[...]

-- 
Regards,
Pratyush Yadav

