Return-Path: <linux-kernel+bounces-86009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9289D86BE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33505B234EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B325364A0;
	Thu, 29 Feb 2024 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8peBKae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2D2E405;
	Thu, 29 Feb 2024 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170949; cv=none; b=sQvIPOY5kxvwQLvPHVqN2Ig56/3NY2UHJfVwO35wHl046rxqztJUAj24KQ07/7+th1rxlUGb+/CFtAOsPHEWX6nAg5kp235E9DUUw1/VOEKqvlXMsr2hQgMLwTtQAqwmGBsgSrb3IwjhaOGTuIFFqJSYEVL9NE4svKhtt767V44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170949; c=relaxed/simple;
	bh=Re6qXz3o/b8SvRuyQAdXe/GP8greLRsmO3K6B3cgElE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ti8c37rbQRDDWWd9vLk4P7eCycRIweCzTe2z7zHmGktj/l9BMAElCKzeBkqxn8PPvWhcZOexKbF9XsQT6ZKkTsryyvl8GHxAnQLddSU7zIOBETDomLjcaRnaRpC17GjqBXWuWCf7Z7EF3EkSrIjTH2cNq7pGFO5ruFU3TiJleC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8peBKae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CB4C433F1;
	Thu, 29 Feb 2024 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709170949;
	bh=Re6qXz3o/b8SvRuyQAdXe/GP8greLRsmO3K6B3cgElE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=r8peBKaeaFaNJML2f3KZ8Zp/77o6uF3WFFMSeBwTR0voty8TBptajgEw5VN+0PwNe
	 kBrkWX4E7m9aMEEgJg87EV8dUZUzzgwq1BSquJ3G2ejZT2NFJgxJ4JHykgIwOYYTV0
	 2SJA/b8CSdUUiVd1cFqoCqdGuS8BlVy1Z0Zci+ZB4LSs4JL9aDL7TRjSx07TInLdp9
	 g9Zd1qswqO8tWvYQT33KGAFZuhu/OsJvMqbeITggNz9FS+4UmqmTLPXQJDdwfdNji7
	 aszT2fx6ts30CsneTRPdLFPSLHWOutY1vVb72jBbnCF8iryxyu0JJ7jGBBFHG+Ox1B
	 PG+asZt3CeZ2Q==
Message-ID: <74bf05834dcd1a39da804f19f2a809fc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6a64e7b3-b1ce-46c4-9c85-89f731aee592@web.de>
References: <6a64e7b3-b1ce-46c4-9c85-89f731aee592@web.de>
Subject: Re: [PATCH] clk: mediatek: clk-mt8173-apmixedsys: Use common error handling code in clk_mt8173_apmixed_probe()
From: Stephen Boyd <sboyd@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
To: Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Markus Elfring <Markus.Elfring@web.de>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org
Date: Wed, 28 Feb 2024 17:42:26 -0800
User-Agent: alot/0.10

Quoting Markus Elfring (2024-02-26 04:26:26)
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 26 Feb 2024 13:10:37 +0100
>=20
> Add a label so that a bit of exception handling can be better reused
> at the end of this function implementation.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Applied to clk-next

