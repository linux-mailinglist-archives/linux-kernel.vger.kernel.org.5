Return-Path: <linux-kernel+bounces-42809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5759D840709
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895E61C22103
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244F64CF6;
	Mon, 29 Jan 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFGCjtsq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3164CE0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535262; cv=none; b=IOxfamkEV6nwZ8cJYkEzPHttpQYmVjXu2RhoHvznb2jy69xM4VnuB2cgghs03oIwS33FGyKDrqv0KlrMlRqJfge0K/7XooT5P+8lnsPHv0+Po3AjsZyzFFyv8DhlSWBYWAMPMsT4VM0cRcfYpawB056+c0rP9IbGfPX7KoPwbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535262; c=relaxed/simple;
	bh=Y32Ro5hXWgmbKAtIr0bWdglhv9oAGAt86HXcokVaqoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PGIFUwipK6LUPAxaiOuqWnTOlHC0XN5fww06t4IHTd7Px77wmDavizli+n4Eu0ZnJxP6URreXevNrYIMZmtnQiuJiJWJ3K/GjlOnx3dxfGruZqONb+vNle3wrg4zApxhd0yExMWCFR7jzBrmaWiLz2biskxK/kqn6laUZ+XcvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFGCjtsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B50C433F1;
	Mon, 29 Jan 2024 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706535262;
	bh=Y32Ro5hXWgmbKAtIr0bWdglhv9oAGAt86HXcokVaqoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tFGCjtsqpCEdO0JDTVGrqvdHwzKxH7Y9iuq0p9pfWkGybaBpGSKQMDua/IPS4l4qq
	 cWvRe1qQ50t/XO2y4GlrTjsO9fPe3QfwGQ55yRLs+idMjYao08vvU6pnriLb23QpgA
	 SNZCaRtJ6nYnOjMdG6hGcK2PdGP06ISk2KzdzcZBy2RjePiMOAIuKTkJi1+H6djk9g
	 EQeY3K1rQvPUrtRmV8cjcAhKLIBnE42RqtS+vYH28qQi3NV8+zGvvG9E5rOAFGrvoI
	 lAVtgE7OwVaQ0p55xvlxGlLYmotph51SKpToeLtJguEkGC5MoNEEw8sbnfiCj90/N7
	 FGEQN6gRKdz1A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  michael@walle.cc,
  miquel.raynal@bootlin.com,  richard@nod.at,  jaimeliao@mxic.com.tw,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: spi-nor: drop superfluous debug prints
In-Reply-To: <99babcb3-770d-487c-a297-beea2f6f8e9e@linaro.org> (Tudor
	Ambarus's message of "Mon, 29 Jan 2024 13:27:50 +0000")
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
	<20231215082138.16063-5-tudor.ambarus@linaro.org>
	<120bf090-0c07-4971-a18a-a1b326f1b139@linaro.org>
	<mafs0v87cs238.fsf@kernel.org>
	<99babcb3-770d-487c-a297-beea2f6f8e9e@linaro.org>
Date: Mon, 29 Jan 2024 14:34:20 +0100
Message-ID: <mafs0r0i0s1pf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 29 2024, Tudor Ambarus wrote:

> On 1/29/24 13:26, Pratyush Yadav wrote:
>> On Fri, Dec 15 2023, Tudor Ambarus wrote:
>> 
>>> I missed to drop some unused variables. Will drop them if everything
>>> else is fine.
>>>
>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>> index a708c3448809..92c992eb73d5 100644
>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>> @@ -3492,9 +3492,7 @@ int spi_nor_scan(struct spi_nor *nor, const char
>>> *name,
>>>  {
>>>         const struct flash_info *info;
>>>         struct device *dev = nor->dev;
>>> -       struct mtd_info *mtd = &nor->mtd;
>>>         int ret;
>>> -       int i;
>>>
>>>         ret = spi_nor_check(nor);
>>>         if (ret)
>> 
>> 
>> With these, 
>> 
>> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>> 
> Hi, Pratyush,
>
> All in these series were already applied, as I specified in a reply.
> Please check patchwork for patches that are not yet handled.

Ah sorry, I didn't see that. I was browsing through my email backlog and
these patches just caught my eye.

Will look at the newer ones.

-- 
Regards,
Pratyush Yadav

