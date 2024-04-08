Return-Path: <linux-kernel+bounces-134725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82389B609
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A0B1F2154E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9E1851;
	Mon,  8 Apr 2024 02:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz2LHvRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839154C63;
	Mon,  8 Apr 2024 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543780; cv=none; b=NpuTkN8yuYw8kQxnJCUIEMB7SMEVnvqP4bPmPvm9eW8OhnFNBQyqnabrmAC2jfF5aPLaXOSdpQnkKSKz5T30lhCiK8D8djod/ycv7gz0WHFGoltnsYwF19qboGsjfZWxFE5xm68phrPQBe3i7aT9j+E+ZnsVHLOzzTWclu3cyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543780; c=relaxed/simple;
	bh=Qy3aIcnw128COjcx5ZkLH7sn4aLCJPiOUq2u2hUN8ak=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=vErE4Zl0xVk0g+uhLmYqvNKvPyoZAyQKDjRvPYbpcm30OaGku/b3KvZ8L1HPO6ait4BDj6ajXMhPwoByNj+ZniNUd18h4hX9x3hIYhlgPnpPzf29WY30lRNF9inbXGzLNoq//H3va6G80mvEcygjyZNPW5WzYE6lenohwBe2mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz2LHvRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02506C433F1;
	Mon,  8 Apr 2024 02:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712543780;
	bh=Qy3aIcnw128COjcx5ZkLH7sn4aLCJPiOUq2u2hUN8ak=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Nz2LHvRO5rSrzZFXLK8P17cotOVKV4gDgenEsN5Psrhybwr3VnT+68TR90mFzNfyc
	 PA11WbLEBzLG8u2jFPqUHAo/VhCCsMPGrXnHKUKmfe/U8QjYUjRoqmOcWcJZICUnXN
	 816PfSnhKzyBk2qPxbWnSjwn0tbvAqwKjmWfA23quaAMXghyxyDCbZJi4xcCbFSsYq
	 r+qtzRWOa6ZSXClsKzRC9/7qAAmbFbChkxQ+0G+FldL4sHdHz/QTrv9Et8RLPwRgie
	 Y7/MLmVXy8zf/re14wDZoGbyF6Coxy3xPDZ0tjkXqq/5KVf1kLkjVIQbwqbqE+Fei6
	 9E3ByLd7ptUAQ==
Message-ID: <f3839b38b16150689722d05045440e75.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240325184204.745706-4-sboyd@kernel.org>
References: <20240325184204.745706-1-sboyd@kernel.org> <20240325184204.745706-4-sboyd@kernel.org>
Subject: Re: [PATCH v2 3/5] clk: Initialize struct clk_core kref earlier
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Sun, 07 Apr 2024 19:36:17 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-03-25 11:41:57)
> Initialize this kref once we allocate memory for the struct clk_core so
> that we can reuse the release function to free any memory associated
> with the structure. This mostly consolidates code, but also clarifies
> that the kref lifetime exists once the container structure (struct
> clk_core) is allocated instead of leaving it in a half-baked state for
> most of __clk_core_init().
>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-fixes

