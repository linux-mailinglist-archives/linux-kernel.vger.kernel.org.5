Return-Path: <linux-kernel+bounces-70176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB785945D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8641F2151B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DCC1848;
	Sun, 18 Feb 2024 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFi7B0eA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65D15C0;
	Sun, 18 Feb 2024 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708226555; cv=none; b=fKUFLYE8QbElSiMgv0I+wCCTF0ibIvNRITLql8Pc8WdgxiMjEoeejDa3S+RFrT1VQQQKRRTWLvW6oLQ/+OlCwc1Q9NPfRWteHUnU5mxEXH8cLftsycbSnHU53iSdIX20Lhz8dTosDY2MEKwD3p5lMb7pb9i9H8b4GEW5B3Riwkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708226555; c=relaxed/simple;
	bh=OepOXvUp/jIusLtBhIQ3BEZ3rKiXUEDzMyoiEqL8BII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WurIVWWN4LufhGr6y3nNlIw/8Fk457pFZUyFgGJfT8+8nyZQvZ+iOAi5XFnQmgTnHBoM/IaIYpjdlXrQub9wp/jsvcjxN9vfk6PuC7I6w9mloLTUq+rZ7b9+loIVFadwRqob/MsMq2wsA1Qlm+yEccTAuEzEIOmDAYaqhrmy0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFi7B0eA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CA1C433F1;
	Sun, 18 Feb 2024 03:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708226554;
	bh=OepOXvUp/jIusLtBhIQ3BEZ3rKiXUEDzMyoiEqL8BII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFi7B0eA65wcP5VVG9HxWBy2s3gtZf/jc+iKDCbBSXUyrmBKyMk5U9k/UoWXIRIyR
	 n0EV8KgoZT4D/H1dGyDbh5XIwV3Ib5PHBeEJQDjb/iJexCWW10pBSar1Hd3WhjDQSh
	 DKpjMbTre8A7ZbVh3fDSoN4o1N4vQH9Yz1roV5fZF23Pq66dzSjksTm9ODf7rZhAjf
	 HJ1CRFJ3E9a2HI8gn/n56FdIlRtQt8rZQAlhGxXVcwsXLt/KTd2UU6fRUDdKfSFnQ/
	 vvl6ye3zsI5Uh5+i0XgmXeKOL7bX1k6Wuyv4xqdm2nWMEmupNPiJcomr45WnF38usj
	 QfuyCryEopmFg==
Date: Sat, 17 Feb 2024 21:22:31 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Guru Das Srinagesh <quic_gurus@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: Re: [PATCH v7 01/12] firmware: qcom: add a dedicated TrustZone
 buffer allocator
Message-ID: <5ppezcfez6tb3xmeevznwefvjjwjefwyzb5r6co4zlo53ht2c2@tdbwgbnxaalt>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <20240205182810.58382-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205182810.58382-2-brgl@bgdev.pl>

On Mon, Feb 05, 2024 at 07:27:59PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[..]
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> new file mode 100644
> index 000000000000..44a062f2abd4
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Could you please confirm that "-or-later" is intended?

> +/*
> + * Memory allocator for buffers shared with the TrustZone.
> + *
> + * Copyright (C) 2023 Linaro Ltd.
> + */
[..]
> +/**
> + * qcom_tzmem_pool_new() - Create a new TZ memory pool.
> + * @size: Size of the new pool in bytes.
> + *
> + * Create a new pool of memory suitable for sharing with the TrustZone.
> + *
> + * Must not be used in atomic context.

 * Context: Describes whether the function can sleep, what locks it takes,
 *          releases, or expects to be held. It can extend over multiple
 *          lines.

> + *
> + * Returns:
> + * New memory pool address or ERR_PTR() on error.

 * Return: Describe the return value of function_name.

both from:
https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

Regards,
Bjorn

