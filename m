Return-Path: <linux-kernel+bounces-75894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A385F065
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EFA1F23711
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE291799B;
	Thu, 22 Feb 2024 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2IkThWj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BBC14A8F;
	Thu, 22 Feb 2024 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708575855; cv=none; b=KUpQ2Vhul2dEJ7vWibt45X8eTeUv8aHxbFC59t7U0qZRhijvDep4RR/3ReoaPVC468tjB+rhVJJrQngrxt5KYiJeoh9cOE8Y0uj+cUyNLAjXX4FS5WDNG6lLSuHQwRjf8l4nATsHFmws39Quxl4w4wOF9Yno0midx9+QtEl71H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708575855; c=relaxed/simple;
	bh=d9S37lA+8Flk7L+rhFCq54DZFysAzFpIrDZ4k0n/A5c=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mwT/C0QUld2Ey5INjDmexrVlD5ZuOFzoFfZvVLQiPtrcqbq9APqr0+pzykv/s/2scZoafWH1LM3YcBBSDyu2/EcOOziG3Jol927ljQqBk8I6HWO3enX5suv9MaDE+kyxbzCo63U3dB+UpLZmiGWrw9Zh2u/ZXoUr/QjBvlWGFpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2IkThWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C97BC433C7;
	Thu, 22 Feb 2024 04:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708575854;
	bh=d9S37lA+8Flk7L+rhFCq54DZFysAzFpIrDZ4k0n/A5c=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=I2IkThWjlCpzMK9SugnrC70otRpHakffSuIXWuHACP5e/48kwgPZM/JoquVcHbDAG
	 4ZvwL1g4ETI+QalZv75fz4ThwbJ9F1RJ6MzX8SimGQyLEJRcqncLblR06y+vjYnaXt
	 Gd67GdBOowaAntU5VNQdr9Ei+skDEX0Fik7MT4QHUK34eFbBPUgzQXBlTFZOVZjuhB
	 Yy8a+psRKgJYt0B4vi1xwrO92Owp4pLxVQNH/8CqP6xvgWXL49hU3brWPLXb/PTs9d
	 LglqclzddD5Q+8Pj48wWqHE7sxJZvFTWsTPDw/jn7f9OhvyoY1X+y250Ky5zvwZZQd
	 7DQe66BCRkHeA==
Message-ID: <539c9f8dfb9233e61eccb8c7bcfc2ae3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c3f1877c9a0886fa35c949c8f0ef25547f284f18.1704912510.git.christophe.jaillet@wanadoo.fr>
References: <c3f1877c9a0886fa35c949c8f0ef25547f284f18.1704912510.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: hisilicon: hi3519: Release the correct number of gates in hi3519_clk_unregister()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Jiancheng Xue <xuejiancheng@hisilicon.com>, Michael Turquette <mturquette@baylibre.com>
Date: Wed, 21 Feb 2024 20:24:12 -0800
User-Agent: alot/0.10

Quoting Christophe JAILLET (2024-01-10 10:58:21)
> The gates are stored in 'hi3519_gate_clks', not 'hi3519_mux_clks'.
> This is also in line with how hisi_clk_register_gate() is called in the
> probe.
>=20
> Fixes: 224b3b262c52 ("clk: hisilicon: hi3519: add driver remove path and =
fix some issues")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next

