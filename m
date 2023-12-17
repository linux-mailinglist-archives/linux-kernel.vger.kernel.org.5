Return-Path: <linux-kernel+bounces-2429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576E3815CFF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1371A28440E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37B9A47;
	Sun, 17 Dec 2023 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmGTOZcD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090A417F6;
	Sun, 17 Dec 2023 01:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4FBC433C7;
	Sun, 17 Dec 2023 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702776081;
	bh=MFysK8RWl80ildkfG7SPnOou5akXq8Kqg9KXX8e5xoQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AmGTOZcDg/YYsQh4ThiQ4T/2F6Ku1jmNqCXd89jbNzfDWlmteSgUVWL9uyErKakJT
	 vh8leOa+yhYytNzLsDJXOJ0KVwJ9bMm42pKYmzPq8OSAlpap7F/+Hi+tmRxr7gzWfT
	 YJ3Ze1kSYt/neT58GarqWJOjFxm9Eo92JT+6WSK81UbWWP4rOkqYmRccIjdxGHIMq/
	 vvW9rQnZzJTJxjrDMKZ6MMlAUf2ZJM2GRrrV5erw9MCZiU2iZdbqMxlj8b9/Kpf/Z+
	 9eo6r3+OGcBQR6IBsq99m2KuDcP87YgD938nPOOg3FsicfwnU5dq+gYAq0DPnW72DD
	 JWSvS4D4O62vw==
Message-ID: <3ddba76f5f44a7b32c5852094667d189.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231129112916.23125-2-jay.buddhabhatti@amd.com>
References: <20231129112916.23125-1-jay.buddhabhatti@amd.com> <20231129112916.23125-2-jay.buddhabhatti@amd.com>
Subject: Re: [PATCH RESEND v2 1/2] drivers: clk: zynqmp: calculate closest mux rate
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: Jay Buddhabhatti <jay.buddhabhatti@amd.com>, michal.simek@amd.com, mturquette@baylibre.com, shubhrajyoti.datta@xilinx.com
Date: Sat, 16 Dec 2023 17:21:19 -0800
User-Agent: alot/0.10

Quoting Jay Buddhabhatti (2023-11-29 03:29:15)
> Currently zynqmp clock driver is not calculating closest mux rate and
> because of that Linux is not setting proper frequency for CPU and
> not able to set given frequency for dynamic frequency scaling.
>=20
> E.g., In current logic initial acpu clock parent and frequency as below
> apll1                  0    0    0  2199999978    0     0  50000      Y
>     acpu0_mux          0    0    0  2199999978    0     0  50000      Y
>         acpu0_idiv1    0    0    0  2199999978    0     0  50000      Y
>             acpu0      0    0    0  2199999978    0     0  50000      Y
>=20
> After changing acpu frequency to 549999994 Hz using CPU freq scaling its
> selecting incorrect parent which is not closest frequency.
> rpll_to_xpd            0    0    0  1599999984    0     0  50000      Y
>     acpu0_mux          0    0    0  1599999984    0     0  50000      Y
>         acpu0_div1     0    0    0   533333328    0     0  50000      Y
>             acpu0      0    0    0   533333328    0     0  50000      Y
>=20
> Parent should remain same since 549999994 =3D 2199999978 / 4.
>=20
> So use __clk_mux_determine_rate_closest() generic function to calculate
> closest rate for mux clock. After this change its selecting correct
> parent and correct clock rate.
> apll1                  0    0    0  2199999978    0     0  50000      Y
>     acpu0_mux          0    0    0  2199999978    0     0  50000      Y
>         acpu0_div1     0    0    0   549999995    0     0  50000      Y
>             acpu0      0    0    0   549999995    0     0  50000      Y
>=20
> Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---

Applied to clk-next

