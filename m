Return-Path: <linux-kernel+bounces-42768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB5684066D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F01C243C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31B264CD3;
	Mon, 29 Jan 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krqBjcdp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809464CC2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533966; cv=none; b=jmR/qXYyb680wYeJTjH5B6VztugvtIsro6qkMS5IS+nIfg77ey0SkaZxRRf2VIDxABpLn/801TTy7h37iTO1Sj+HGu1YhAu/5Fwhoy5JWyXKLMrHPTgWnnX1fxuDAelTn2BpxzCkMv4N5n6jsXXyoUY2ZXKA7WphnUV/R7Kx7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533966; c=relaxed/simple;
	bh=oakpWDsRl1gGwlgcieDaPaxmTDGAvNAsQ355A4wMePA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ExF+HcswLUwOU46XXZiGZ9GkL8uwPqpEgfgjSAR9qHb3we8A5S5FLi0ZZbR8r6tMZkZIeBuJwYANRGlD3bIzKWXy0xXqY/l0NQ7KbxGJo1pqFKV1N7mvlLTYSapa6j7ScKI0v/WIzNwxmPdlcNQkR3PJyqSIJM0QRTZV9iEs1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krqBjcdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606EAC433C7;
	Mon, 29 Jan 2024 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706533965;
	bh=oakpWDsRl1gGwlgcieDaPaxmTDGAvNAsQ355A4wMePA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=krqBjcdpRG3sl9Ez/i+KC0XlVbKHyzasQI19z3NDb7siP+1SHqPxpvbQgxIX8FjtE
	 wn4idOIbFgzr7K53WcBawSKdAKJ7kXam45FPUUlMQzMWBJMqdOH7mzsoMu7dtUeUOe
	 0zbDiQ53xXEz93B7OOyaFTG3K1M6lhXcOjGtlrNOniDl3sdASvoEgfignpdDVQNPJk
	 QSHNr0DaVDLz6TCqrt+wb7uPYpQ+TS+7QCrMHyw0rCXBWncSqBQL7Zf9iIdMRV0B9B
	 yCYWxVk1TvjlQAvWVANf+DacbL8fOHUAwW891uH8MrgM+4wFll0WTOaCv0zjt+3wvb
	 +ePXRjWoBEnEg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org,  michael@walle.cc,  miquel.raynal@bootlin.com,
  richard@nod.at,  jaimeliao@mxic.com.tw,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mtd: spi-nor: print flash ID instead of name
In-Reply-To: <20231215082138.16063-2-tudor.ambarus@linaro.org> (Tudor
	Ambarus's message of "Fri, 15 Dec 2023 10:21:35 +0200")
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
	<20231215082138.16063-2-tudor.ambarus@linaro.org>
Date: Mon, 29 Jan 2024 14:12:43 +0100
Message-ID: <mafs0bk94th9w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 15 2023, Tudor Ambarus wrote:

> We saw flash ID collisions which make the flash name unreliable. Print
> the manufacgturer and device ID instead of the flash name.

Typo. s/manufacgturer/manufacturer/

>
> Lower the print to dev_dbg to stop polluting the kernel log.

FWIW, I find these prints to be somewhat useful. they serve to
"announce" that the kernel probed a device successfully. This can be
somewhat helpful when reading logs from customers trying to figure out
why something doesn't work.

I don't have any strong opinions of course since it is not such a big
deal but I wanted to point out that these prints _are_ somewhat useful.

Acked-by: Pratyush Yadav <pratyush@kernel.org>

> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

-- 
Regards,
Pratyush Yadav

