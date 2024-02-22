Return-Path: <linux-kernel+bounces-75968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468EB85F14B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE10B2835BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FAF175B5;
	Thu, 22 Feb 2024 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB/tSz2+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DE14A96;
	Thu, 22 Feb 2024 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708582368; cv=none; b=grPUCswCwsRE/nFf4ZXWw5gKws4gNKq/IAKLX1Xm57tS9Jn4VxOo4IyTYN0p5lu48f3Pny8nHcwp4oX9e6xQjkRcvdrvNl3MXIfedJQygbkPzGKIyZ4gSVLcDAKQNnJtsPzVvsDguf64xSuERzBvFfIiOthRAJlj6qQkcoyStjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708582368; c=relaxed/simple;
	bh=AMZ9L9h77qL2qKSyUaf9Y7pkPFgHKjt6oguMDxLm5/s=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=k0AIQxo8VK7Ui3yznLDPuhY862RmGVjRA3Uss3S92ztjpylH8OE3taVKiL/Bbvob9jM0KVsvgYnmylv2EKPKcO4Qpr1kP4DngVWrxrkQXZC5kNfsdqdLYnMIyulF/0SQoY77X7w7oYYdp+Vutwj6URL7QuzB57mzNSOF5nK6p1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB/tSz2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3342FC433C7;
	Thu, 22 Feb 2024 06:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708582368;
	bh=AMZ9L9h77qL2qKSyUaf9Y7pkPFgHKjt6oguMDxLm5/s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kB/tSz2+DwGggX08LhXeIHcG0PebeGdf9oeSQXvQ/Wz/LW/bcRG1GoJFbqkr01dQl
	 aD4W3uau/rFWoUj91xTlnYvR6TsBqDG9xKb//rSoCmTCmC07N2Da8WLDLhsvlE46gA
	 5/liaHzWjof3RrnWn9ZvzlGuQAqYs4IbmzrHf+K6MFNHzvDPPNRZBVL1f9ACiSa4C7
	 Gvh0QX5z/wClAATiH02u7F1SZcyMobKlEFS9wwg7FmSWAX5qGLinrFYAX5QZObZupo
	 5IYPzyBa9FelXtBkUZD/XPNorXVzrOHbCRBBn24PtGnqbDKE4DCv1tfudjhNLJvpd6
	 GFw/l8i4TUsSA==
Message-ID: <5b2d83e343fa218c791d468a863a6c65.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240221-mbly-clk-v7-1-31d4ce3630c3@bootlin.com>
References: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com> <20240221-mbly-clk-v7-1-31d4ce3630c3@bootlin.com>
Subject: Re: [PATCH v7 01/14] clk: fixed-factor: add optional accuracy support
From: Stephen Boyd <sboyd@kernel.org>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Rob Herring <robh+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Wed, 21 Feb 2024 22:12:46 -0800
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-02-21 10:22:09)
> Fixed factor clock reports the parent clock accuracy. Add flags and acc
> fields to `struct clk_fixed_factor` to support setting a fixed
> accuracy. The default if no flag is set is not changed: use the parent
> clock accuracy.
>=20
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---

Applied to clk-next

Please consider adding a test.

