Return-Path: <linux-kernel+bounces-55119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4974E84B7FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C893BB2B434
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B7F1332A0;
	Tue,  6 Feb 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaD+yq5Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A021E88D;
	Tue,  6 Feb 2024 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229957; cv=none; b=ZpWDl8wjQbh2qFKR5/rtGpGsw0h/fAOPAfBPfmp0kq2VtdwY/i9h6fVNq0sq7AZL3ekT4teETKYMhmogTFHGxjKFjQohczBPHn0qBbuqDsepnwioIVYxYa1MdyIWL2T/V/8EO9v48AEEqEMZamezo029jCeGOZ8Pco8JPY6RK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229957; c=relaxed/simple;
	bh=et5rRptvkGz54dS+7a+fsl6EJMUrV2qa3AEGOsdAEDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7Ud7lfrYII2yhqU5O8ZGL6jiShDhrMDvpH1YIYPy5Ba/7vphniuCdBQ21s82P6TW02iwE7JnjrnR1BwdMHFPQepvGCCq+sQRg2ryW+ly/EGONnZmajAMABQ0CRhP3/K5kKBxihPnbMlh6jj5kYs1n7pOWwlS+0t3mcPKqOeeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaD+yq5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A905EC433A6;
	Tue,  6 Feb 2024 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707229956;
	bh=et5rRptvkGz54dS+7a+fsl6EJMUrV2qa3AEGOsdAEDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iaD+yq5ZruiFRajM7YMGHPc08vRN62xdbsOlWGbncKdXd9Y0kW5yIoUvSqxvqWU0G
	 DtRmudIUIzt4M1k+hBzo4tebFxyJc2r8HJQXsTfp37p3XHJ8eyfRTEftjVhzf+9bnh
	 C2vT11JrIiqflalCujkazoXl8IoRq4ZniS969b+YDKes9/YWlHm0fzPo0gjzvrolB8
	 jUGR8zIMbBRT8y8AUbywGA5SNVzIaUdIrgQRNNQ1Pwewl5YgI228C/BsvE+O0oLoAJ
	 qhyLVAl12LupY9z8VksULiRIz9LaRu4Iuqm+lHRYnTMsnB9T+4peTzZB8ybhw/+VVJ
	 S/Gu/wBSSCbaQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/7] MPFS clock fixes required for correct CAN clock modeling
Date: Tue,  6 Feb 2024 14:27:31 +0000
Message-ID: <20240206-cloud-subduing-cb42cc496621@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122-catty-roast-d3625dbb02fe@spud>
References: <20240122-catty-roast-d3625dbb02fe@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=960; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=hnKnUQMm2IjOwpyCk+YzqyIAY3kVJ7l3mv8OoK5FHck=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmHHC/9F6+WlmxxPu61ZmpR1NEDe7K/cHvbRwltUvp2b NtE53vMHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiI92pGhl+uiQFJX799K4hb 8n9Vztpd6zgE2KMPBn5Zu7bg9rM1YUkM/x09FapepGZnvi+/ujzZXafzgkfXOXtvnajnIaZxG2Y eYgAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 22 Jan 2024 12:19:48 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> While reviewing a CAN driver internally for MPFS [1], I realised
> that the modeling of the MSSPLL such that only one of its outputs could
> be used was not correct. The CAN controllers on MPFS take 2 input
> clocks - one that is the bus clock, acquired from the main MSSPLL and
> a second clock for the AHB interface to the result of the SoC.
> Currently the binding for the CAN controllers and the represetnation
> of the MSSPLL only allows for one of these clocks.
> Modify the binding and devicetree to expect two clocks and rework the
> main clock controller driver for MPFS such that it is capable of
> providing multiple outputs from the MSSPLL.
> 
> [...]

And this one is applied to riscv-dt-for-next. I don't think sending this
for the -rcs is needed as there's no impact until the CAN driver shows up.

[7/7] riscv: dts: microchip: add missing CAN bus clocks
      https://git.kernel.org/conor/c/6c7353836a91

Thanks,
Conor.

