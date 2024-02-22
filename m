Return-Path: <linux-kernel+bounces-75896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12A85F069
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4031C2215F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60811799F;
	Thu, 22 Feb 2024 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="degz5bbf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD911775B;
	Thu, 22 Feb 2024 04:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576055; cv=none; b=dAmWzxPjJXcEkqk8EMEa2F5D+Yv64XRqL9uxibdoA0eF5pbvbxF9bgI5Tbq/MgObje/BeZxnAG0e6UzCFj7Or70foRXYMLg1by4ZD0z/jGqOYZ0Fyx9DGQ0nhFTdY//vibRptvf+YJQPt7AKZU7WSil6nDpjlm1KKZOpaEgPZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576055; c=relaxed/simple;
	bh=oFSGpvFms3hEQid0nl1slnjolsRI31AFhOlPP3m17wA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=HGWvfBferquwfSN8yHc0ZnX8CU82xEljaSHTU6RThPINtpQrg/wUQ/03JgvVZNMVT9wur1fReBURl0eGZR0Q1SzD4piqbbQd9D63rSkh4rfHhPhzCIQOdBd9R6wqQYQ288c88VjhyWc58D7N5FamJkERGUwkD/uFD6EB69D3dXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=degz5bbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34DBC433F1;
	Thu, 22 Feb 2024 04:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708576054;
	bh=oFSGpvFms3hEQid0nl1slnjolsRI31AFhOlPP3m17wA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=degz5bbfCmTaX8+5xbK3rWriaahvDIWKfVNKagSXqfrDwnJYzezNaMrFgFKzQVhPO
	 OXlyXwpvl5c2miPkr3w9BXgN/by/UynCS9BaSNGeO2fC6O18AAYU8SsqSLGdcqlao0
	 SMabx0q4vSAu82azyCa1AOq5qfnqbej1qBz7pz7ji1T3RRZTmi5kuBUHBs0DTDrGh/
	 0GX8E9pPELXyU1acG/xtKhEQ4hkTOjzk66sY9Eq/P1wrfKavrZYFUhcebc3kw0whiA
	 2iYk4dvQkZ51w3wGKLWecb3as1adaWETmS/n6aHcObe+1VaTW4lYCQH0JHzo53/J+3
	 EwMiMFyKbEAgQ==
Message-ID: <61113ffd54a32399ebdc31fc1a57912f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240121142946.2796-1-erick.archer@gmx.com>
References: <20240121142946.2796-1-erick.archer@gmx.com>
Subject: Re: [PATCH] clk: hisilicon: Use devm_kcalloc() instead of devm_kzalloc()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
To: Conor Dooley <conor.dooley@microchip.com>, Dinh Nguyen <dinguyen@kernel.org>, Erick Archer <erick.archer@gmx.com>, Gustavo A. R. Silva <gustavoars@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, Nick Alcock <nick.alcock@oracle.com>, Rob Herring <robh@kernel.org>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Wed, 21 Feb 2024 20:27:32 -0800
User-Agent: alot/0.10

Quoting Erick Archer (2024-01-21 06:29:46)
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>=20
> So, use the purpose specific devm_kcalloc() function instead of the
> argument size * count in the devm_kzalloc() function.
>=20
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-c=
oded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---

Applied to clk-next

