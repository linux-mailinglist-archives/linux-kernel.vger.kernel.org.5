Return-Path: <linux-kernel+bounces-133582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B53089A5FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96BE28288B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E219D174EFE;
	Fri,  5 Apr 2024 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1tfiwIB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A817BAA;
	Fri,  5 Apr 2024 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351637; cv=none; b=Raf96mTHg68gCZSJ3xYQqs06+qSyJWLmXFiBxSTXyAdH8ogqPQ+AF31P8jZOES1aCEPw1FKiyZA09Zbzq4tMGjxNpbULBCZq4Uy8vQSxNpQbHlfYv42BogtVcAgMIXhHyWoxzUc2df5leZvSylQomP4smHO/wRmgIWDsHuihwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351637; c=relaxed/simple;
	bh=Y7Ao24dnCE4fH/ngOC+esesqyBbO+AsAqJ6Ru5APgIs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ryUH5P/7Tr30mLNP0gWzSjT1KhfnMKNFbkvELDj6q6vMlBr2A5DVqmDku5Mxa0cYr0GQsQiH4ccn6cm7VL4p9aR2pnIrB9IG2w2d60oxdgNtBxyjuDjJd4SMzgm62YSnOvwqPNUaT08dyzGiLVBsmkSjca7XseSHbO8ymHiXpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1tfiwIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBD6C43390;
	Fri,  5 Apr 2024 21:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712351636;
	bh=Y7Ao24dnCE4fH/ngOC+esesqyBbO+AsAqJ6Ru5APgIs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=F1tfiwIBqQOax9AN7aCZJXVerB4DPlPbAIreDE17KLBamc5uNy81keSNDZJKyTyN0
	 5KBe8rHWE8sKu1cP/TVUKByMBsBkf5n7k8IraXcQRAGv1DG5AHX81U26lnOuMghl9V
	 WrvUTtMo82f1slSpTHW8IofW4qubRwRvGGY0twxxaRSlVxHZm4zZKVLU+DJQrXz419
	 Mmwqhe/mr+zWxL8MT3pMEvZLGBhhGm2JOqOI2ymCvyd53fBMNQGLG59ssP6Xo3UkdO
	 yd+PrmRrjCtZxu9apQWdKq4YRLwhjwrtmsFJr76iujhkTdLQB5UdCpvezTJqb7m70g
	 rWWoefag9Q22w==
Message-ID: <3128e29f9fdf5ab16c1cb7afe133c5a7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240403080702.3509288-12-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org> <20240403080702.3509288-12-arnd@kernel.org>
Subject: Re: [PATCH 11/34] clk: ti: dpll: fix incorrect #ifdef checks
From: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
To: Arnd Bergmann <arnd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org
Date: Fri, 05 Apr 2024 14:13:54 -0700
User-Agent: alot/0.10

Quoting Arnd Bergmann (2024-04-03 01:06:29)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Building with W=3D1 shows warnings about unused const variables like this=
 one:
>=20
> drivers/clk/ti/dpll.c:99:29: error: unused variable 'omap3_dpll_core_ck_o=
ps' [-Werror,-Wunused-const-variable]
> static const struct clk_ops omap3_dpll_core_ck_ops =3D {};
>=20
> The problem is that the #ifdef checks for some of the structures in this
> file have gone out of sync with the code referencing them. Update these
> to match the current usage.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next

