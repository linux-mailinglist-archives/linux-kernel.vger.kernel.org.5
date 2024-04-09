Return-Path: <linux-kernel+bounces-136769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2C989D7F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16292289902
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB9B12D212;
	Tue,  9 Apr 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2IgQfOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E49126F19;
	Tue,  9 Apr 2024 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662312; cv=none; b=s+v6Mc2VU571yi9+T0Wd9Knirc06pcBueO9T1gCH4pggeaLj7+FRGcDNv3Xql3SJWDyjxOyfjou7ZsOB/lfj7RP+zKOFxzfk+q2ocqM/yKDovxnixC9lTVqIdVZaAqFMoZx5UZ7QfOkS0GRmQg2hLdu6pNndNrFM86guqgmjGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662312; c=relaxed/simple;
	bh=l0bizUbI1uFq+/2K0w1QbeBH9cHRDMhCMHsAdShn0ps=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=NbZjkFHzLkSf4WSSUysHzuyN/tcptjkTqog4ZSAF4k9O/B4MkSu1TnfdWKoA48bwbIeXggIg1SPZZFWsmVbQqXcfMNbMCdd4eYEjOyfHxVJZzJfpaJQU6fa21PjJLMsXxYm0Vul7mKvB4QCD+vXn0euRXUK9iykILamyyrj3A6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2IgQfOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F946C433F1;
	Tue,  9 Apr 2024 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712662311;
	bh=l0bizUbI1uFq+/2K0w1QbeBH9cHRDMhCMHsAdShn0ps=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Q2IgQfOn5TyDR2PC/KrBOG+X9FUXgM9mt/2eSxCk6bIYm9CSpYVkQ5MvocSZlN5Mb
	 2pONDTBP9TbwZtLuaqr5QHDb9muTnWnexkjxe+SPFuzUtu419MTq3qqdWu9Jh42s4A
	 GM5J25nF51rk4d069hNAhCAk+X1fYuOixNGyyzrVG+weJAjQ0eBStsAs7omvnrKrsD
	 xeCCZXfIXiOafh2Tv4IRjPya0RA7X1isLaVz5c1WsjlFpiRecPD1a7vipdAisl2zEH
	 6Rz2ltaxNXQyVfOpE7BLvKocnURptf9XQFNRUmwRqX5xFMge0D/SAJ+iTkXhxE0/Cz
	 psdw4n4ldhiTA==
Message-ID: <8415e2f4065ede19c6999708d64e8619.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240120100711.2832897-1-cristian.marussi@arm.com>
References: <20240120100711.2832897-1-cristian.marussi@arm.com>
Subject: Re: [PATCH] clk: Check ops are available in clk_gate_restore_context
From: Stephen Boyd <sboyd@kernel.org>
Cc: sudeep.holla@arm.com, peng.fan@oss.nxp.com, Cristian Marussi <cristian.marussi@arm.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
To: Cristian Marussi <cristian.marussi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Apr 2024 04:31:49 -0700
User-Agent: alot/0.10

Quoting Cristian Marussi (2024-01-20 02:07:11)
> Add a check in clk_gate_restore_context() to assure that the clock enable
> and disable ops are available before calling them.
>=20
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Fixes: 9be766274db4 ("clk: Clean up suspend/resume coding style")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Spotted this by code inspection.
> I may be missing something, though, given my limited familiarity with CLK.

It assumes this is for a gate clk, which has enable/disable clk ops.
Also, only TI uses this code and I suggest you don't use it.

