Return-Path: <linux-kernel+bounces-151873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5438AB514
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9EC1C20A79
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9B13C3F2;
	Fri, 19 Apr 2024 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsamz1Ub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937B13BC3A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551352; cv=none; b=ns5lDv3ygl/oFDXXxyEk797Xvf5JxcawO57MSXb2Iujxc0u+/2kEjinIbQzrDzwtOAf5AgZs+E5x3Phcir4+RUmCql0413vlsCE8wAdQ7AmtEpN1HhErzENCFmFp03ifTAyhDlXqimjAzWOMce37HUN+gzc/Uut5Cw/Gm37jzlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551352; c=relaxed/simple;
	bh=6R+P+UeAxQGe+bDmE9m6x0YWHQzXSf7Vg9v8QpuqQ+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ih1e/HCaEl67doJZ7QbJk8x3Meu7jlD31qWVcjxU3XvM5/KNRs6XYhrOQ8niqHaXvFfGs1J3dYPxB3+IoiMQVxBHCEpI4YBUZ8xflGSo3srtxa9R2Q10VhwSvzlMjopvIqarH6pDM3jPk+8/2fs/fQbzRyNzB+KFFi2Sh5TGy3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsamz1Ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F87C072AA;
	Fri, 19 Apr 2024 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713551351;
	bh=6R+P+UeAxQGe+bDmE9m6x0YWHQzXSf7Vg9v8QpuqQ+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Bsamz1Ub8tO84zmAm44w4K/bujDprj6GzORuCSBYFXsWdTR+DEwii8xQZ4wMvAOB5
	 4IMNONXrgLiRdk1QSEnUi2dPfWFIWcWGmIer+qs9T+Ht4HOCDJx2/9gKCV4D0yY/MD
	 f9WBP0ewmLDw8Tgy+5KVxaLqpcMhHm25tj44c+Ktntnpto2oRtIJOSAT+oFrMdJLOg
	 F54tEdi4EWh8AwOsvax0n+yb9/CLNoRX6cq812xkw3gHr3oszB/Ix6+YTP7J0qKf9L
	 2cJxO9PZ2p6xNkWSCHUMnprXDnXErM49AHin+orzYNH9JCPiHYxJVYeYzJGnTBBiHQ
	 oPT1Kqp4azZJQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Ricardo Ribalda <ribalda@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 4/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
In-Reply-To: <20240419141249.609534-5-mwalle@kernel.org> (Michael Walle's
	message of "Fri, 19 Apr 2024 16:12:47 +0200")
References: <20240419141249.609534-1-mwalle@kernel.org>
	<20240419141249.609534-5-mwalle@kernel.org>
Date: Fri, 19 Apr 2024 20:29:09 +0200
Message-ID: <mafs0plul5hqi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 19 2024, Michael Walle wrote:

> The evervision FRAM devices are the only user of the NO_FR flag. Drop
> the global flag and instead use a manufacturer fixup for the evervision
> flashes to drop the fast read support.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

