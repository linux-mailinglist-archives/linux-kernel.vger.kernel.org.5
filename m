Return-Path: <linux-kernel+bounces-134727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBDC89B60F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C0B1C2119F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706F41860;
	Mon,  8 Apr 2024 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfXdnLU8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F1364;
	Mon,  8 Apr 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543822; cv=none; b=EyJrinLGP20M0oW/8iZqGzLcMVksf4MxJw+iqi2pDxIXpVU/ix2dG12izXX99Ggv1zjxrtVc0SOqVeq6Y18CjJday6o7lfCtgGoQw4aXnOVq1lNvS+jUf6t7Ld8H6meOuTfZs04yc1OuExz9X2IsMAByiNohkBmrQkNIEI3FVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543822; c=relaxed/simple;
	bh=wV5KGdkQGsUGfPws8quqEY4wmroa1qr5lDFj4xLhkXM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=EhVQeEvjvos0rtqahoQ1v62dA/+c5arGyIsHUmsZHeVDxN/wKRN6IeY+oEqxbACZun87eLjnJpRiRwgtsII7VRkS8Fy1RyEEa862NFWVzoO3D32FNdY9Pt094FcRS3lsJC16tEJ2LLqDy+5kCaNSVw0hk85ame4CkYqSAzY0yFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfXdnLU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A00DC433F1;
	Mon,  8 Apr 2024 02:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712543822;
	bh=wV5KGdkQGsUGfPws8quqEY4wmroa1qr5lDFj4xLhkXM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=CfXdnLU8EMwnmIAhO4SgHbCD8VU5D5V2hr2XsqUg6lLYL73E5FTf0zXKXi+4pmKmA
	 Vf1eVb63x5lloYzyYh1Zr/auX5wX+khVcoasYHGSjWtaGlPOUmZ2QRn/kDKooralN4
	 78DOTNEYSmdwqk1wUuuzCiSPFT9V5dP5umPfnkYY7QXT8NfHoR9fAkQRrDK8pwX1v4
	 y1WDFyYxaUAbqJkMBfmiG3J0LXbutDDexMsvIdiAoaVwsy4UyqepOHDM2fuQ4ZVtIU
	 NjbrYupm7shDUVWpoN43A7wqnKauQvCsWta4h8a2ldL2DoZD5BiZFlY7laMn7OwMZb
	 cdQfJlMsiOaJQ==
Message-ID: <c9f6efd00fb9cbff47926243520714af.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240325184204.745706-6-sboyd@kernel.org>
References: <20240325184204.745706-1-sboyd@kernel.org> <20240325184204.745706-6-sboyd@kernel.org>
Subject: Re: [PATCH v2 5/5] clk: Get runtime PM before walking tree for clk_summary
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>, Douglas Anderson <dianders@chromium.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Sun, 07 Apr 2024 19:37:00 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-03-25 11:41:59)
> Similar to the previous commit, we should make sure that all devices are
> runtime resumed before printing the clk_summary through debugfs. Failure
> to do so would result in a deadlock if the thread is resuming a device
> to print clk state and that device is also runtime resuming in another
> thread, e.g the screen is turning on and the display driver is starting
> up. We remove the calls to clk_pm_runtime_{get,put}() in this path
> because they're superfluous now that we know the devices are runtime
> resumed. This also squashes a bug where the return value of
> clk_pm_runtime_get() wasn't checked, leading to an RPM count underflow
> on error paths.
>=20
> Fixes: 1bb294a7981c ("clk: Enable/Disable runtime PM for clk_summary")
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-fixes

