Return-Path: <linux-kernel+bounces-75908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F6885F089
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF1D1C21499
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05DB4C7E;
	Thu, 22 Feb 2024 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcQqu2kN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088AB1388;
	Thu, 22 Feb 2024 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577507; cv=none; b=AR3HG8DHWEBOWrLL7ht9UjB3yU10/36C3ACX8n9NChwVTAEzRTV+Cr3HuPdk8YaejwiXf06xppiCKm6O5GsgA5b71qnvJyHVok+L30W4WpFQgIY1Q7yEg9RbbtpzAEe/x3zsrQbS8gKbhDk4DqTfHYCl8y0CNRauNb2zjegKyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577507; c=relaxed/simple;
	bh=Kqm4qtGh5X7VQ2ZIzlQV4yJvQ+ZhC2H7zx2PY73LdsA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ptSepewFnPK3XZ/pOBhv4+/EGxMwmFnzc7J5gFcxZu6mkxV3VYNjypXCv2lnx0/osHq/7d2IASGFF1pniuxo0pHMD/kDW/rIAMYsMzxAB5Dc5ffxONyC7vsKTj+HfgFoonPJCL0SaSpUyW+JafDwvUT0dtBl6SVbOUrIeTmLl5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcQqu2kN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89818C433C7;
	Thu, 22 Feb 2024 04:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708577506;
	bh=Kqm4qtGh5X7VQ2ZIzlQV4yJvQ+ZhC2H7zx2PY73LdsA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YcQqu2kNN29T3Z51lNh60xwqsX+awcPkZ/MZumOPOcqIigGS17IrY2Ti7kaSaG2Uk
	 dkiSUP0r6hgqIEIE5tVlNPnxEwVQw9sLskiVekU+ERNuN6SomAfEunI9MSGpH8bXrT
	 /CWtzElONcF7v+TunxLiH3nNyQdLwVieANCz8oY+anTozViOtQl/G7R+ax3h5Ec6XH
	 OlivNVgikog5occyxMUlgBhaYf4GBQi66KEAqMiw+0jHAaqTzUWpvJBSLgS6FNHAiI
	 KxOTAidH3G833mzG5HEVXCyPHyNPFSFx8DwtFN44rjc3d3BBtEojH9e5iZeJ/xiJqj
	 F02ZZJsDMKdGQ==
Message-ID: <17ab00b5cbf2b9aefa7ee99daf305f46.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6cd6af61e5a91598068227f1f68cfcfde1507453.1704615011.git.christophe.jaillet@wanadoo.fr>
References: <6cd6af61e5a91598068227f1f68cfcfde1507453.1704615011.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: mediatek: mt8135: Fix an error handling path in clk_mt8135_apmixed_probe()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>
Date: Wed, 21 Feb 2024 20:51:44 -0800
User-Agent: alot/0.10

Quoting Christophe JAILLET (2024-01-07 00:12:17)
> If an error occurs after mtk_alloc_clk_data(), mtk_free_clk_data() should
> be called, as already done in the remove function.
>=20
> Fixes: 54b7026f011e ("clk: mediatek: mt8135-apmixedsys: Convert to platfo=
rm_driver and module")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next

