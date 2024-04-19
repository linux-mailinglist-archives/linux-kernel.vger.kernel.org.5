Return-Path: <linux-kernel+bounces-151863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F18AB4E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561121C221EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3588913BAFC;
	Fri, 19 Apr 2024 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E51hjAZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0B12E1ED
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550529; cv=none; b=ZRhjdoIsOYOPSH0djDWR0on6qtR4oganUabvVZaz+eYgK5a2pKupdPqURHb5htObS42kFmJt2ryMdPi1PHjDYeT2tzPPQwcsXYWXDLtwfscAp+e1yMyj0uqGMLwKdKku3fOkZoj2JG88TkDEgI65mWMF9nf1NNjhhE8SOT8e+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550529; c=relaxed/simple;
	bh=l+4xcakx3AeagHaYK7SO0dZjcjwn/mRxbV7FhZhIm/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ygib2CWsKiEWcKPrrn2GvFMzetpiP8NZviI2DQfBEGTkoYI+OxWqRwU0zdoeMGmelc+n4BtB8J1LXjAaUDuc7rim0IHg0uGhaM4hjubQANPURJXRHE671ByWkaoaZqBTaFnEs0iu8Wj/QVDfPtLIWrwoD8Y890JSBlqicTMygHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E51hjAZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81697C072AA;
	Fri, 19 Apr 2024 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713550529;
	bh=l+4xcakx3AeagHaYK7SO0dZjcjwn/mRxbV7FhZhIm/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=E51hjAZFVPfEks3QjAW42TSzAgiART9PGozK96xEylO7jcAo/iAsTPq0pmMg5kLLX
	 eYJi4+XTm3OitMbChJ8chFz9V0lP0pgV8zyGvfQSXaggPxcQcA5ktseHWRiPR/r6wV
	 EH340fIPVm5Ykhnh+vebnkD/v/L6XF8HdJrs5XEfTkWvnAyvtHYr9mrRkhba7Nv/Qv
	 cpnucZT4fZAlNAZ9oOhVcUOmq2/zrlT8XFhHph7Ft9akMsqq7Lp4dqbZSiyWRzBJi0
	 3WQgzX38GVEIT/DKUAUtyjkodpHc/R4p6+v2G4DErukXfEwstuHJVkoTVM3xAIFj+v
	 qWp3bGfGh25nA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Ricardo Ribalda <ribalda@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/6] mtd: spi-nor: get rid of non-power-of-2 page
 size handling
In-Reply-To: <20240419141249.609534-3-mwalle@kernel.org> (Michael Walle's
	message of "Fri, 19 Apr 2024 16:12:45 +0200")
References: <20240419141249.609534-1-mwalle@kernel.org>
	<20240419141249.609534-3-mwalle@kernel.org>
Date: Fri, 19 Apr 2024 20:15:26 +0200
Message-ID: <mafs0ttjx5idd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 19 2024, Michael Walle wrote:

> The Xilinx flashes were the only user of the page sized that were no
> power of 2. Support for them were dropped, thus we can also get rid of
> the special page size handling for it.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

