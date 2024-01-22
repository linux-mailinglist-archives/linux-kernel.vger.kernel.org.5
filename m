Return-Path: <linux-kernel+bounces-32996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448688362F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86B2B2448D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5343BB2D;
	Mon, 22 Jan 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob2Qox9R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE73B2B6;
	Mon, 22 Jan 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926012; cv=none; b=AWAQksmf3k3Pgoil3Vy+F3M2MTP3QiHAzTABwvnbxiu8k6nixXSCwIJ5/UMxUahEYbhXRPN+hLUaJuDBKuwfG9s3+ZpopE6P5PZ7BkLtG8yr57xpcnB51rkqEo6rb129G9bXQSoPkRd+bW5+DwXZ48ivT6F7cGsCDsDEJEJDBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926012; c=relaxed/simple;
	bh=IlLNZwCv119gs+G1XZGQUJ/nTZHJ2OxfZVk+jo076AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tf0K9iQ6JZtzsOzi1fZU2jJJToDlr0uBxFPDp07GGgKhUiHQIzIZjqLYf4xeu4KdGkRznftM6MQ4cOxg48Csr/7eC0V5OFQd+lKdVTy7qnBZYa1NUHDJ2CBi89eOdl5I7WN0L2w/nXDmB+/zvxsHuRr194xp3fup/l3k0xa+ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob2Qox9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3934FC433F1;
	Mon, 22 Jan 2024 12:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705926011;
	bh=IlLNZwCv119gs+G1XZGQUJ/nTZHJ2OxfZVk+jo076AY=;
	h=From:To:Cc:Subject:Date:From;
	b=ob2Qox9Rq4r16y13ck9Hpq/TMnEm3RnAjWh84mJdSYOZTkruw2jb+VCPFnb0Lh4YU
	 pS5oIzblRyjnRjjqPfAHjKIZKxL9x42SXUb8gB1lQbEUn+1l+lMIUcaAV95xVZGoUU
	 P2XGfjHWsDWVYKJuf3CompvjiOERgDFSqMsfHP5LatjVDA5SEfF20l6DqbM7sIlXi8
	 RV6aXp4F2GBCs1WO8rmakFi3XVxuIQUthGmGg/B3KKVmCmgRzoVZl6cS3czqWGreXt
	 2FZGSOYl7DWpB/B9+H/v/gNjlgs6z/gBcfpU6eBBKBhJk55mR7KOgsYj8TsM5AK61G
	 EdbigUbi7JqxQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
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
Subject: [PATCH v2 0/7] MPFS clock fixes required for correct CAN clock modeling
Date: Mon, 22 Jan 2024 12:19:48 +0000
Message-ID: <20240122-catty-roast-d3625dbb02fe@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2564; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=LljwZDfMNfbMVLp7XtH+2mdlVEJFVNUoZZukL9HDn4g=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnrYpNPeB3Nb1kttaDRUG6G2KQrfo9W/pvGmv1XWTDCd +Zr1hbbjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEyEjZvhfzE3J/uknFOdS1IO rBILU2HdXCJ24FX6s1di79+EBT29fpqRYfPeFnMmbcM8vdZjkyPudL37ZpvB+vux3oJDb74//3y ligUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

While reviewing a CAN driver internally for MPFS [1], I realised
that the modeling of the MSSPLL such that only one of its outputs could
be used was not correct. The CAN controllers on MPFS take 2 input
clocks - one that is the bus clock, acquired from the main MSSPLL and
a second clock for the AHB interface to the result of the SoC.
Currently the binding for the CAN controllers and the represetnation
of the MSSPLL only allows for one of these clocks.
Modify the binding and devicetree to expect two clocks and rework the
main clock controller driver for MPFS such that it is capable of
providing multiple outputs from the MSSPLL.

Cheers,
Conor.

1 - Hopefully that'll show up on the lists soon, once we are happy with
  it ourselves. (As of v2, that's not happened yet, Christmas etc gettin
  in the way, soonTM).

Changes in v2:
- Swap MSSPLL out for MSSPLL0 in the driver, there's no functional
  change there.
- drop the unneeded maxItems from clocks.

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Wolfgang Grandegger <wg@grandegger.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: linux-can@vger.kernel.org
CC: netdev@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-clk@vger.kernel.org

Conor Dooley (7):
  dt-bindings: clock: mpfs: add more MSSPLL output definitions
  dt-bindings: can: mpfs: add missing required clock
  clk: microchip: mpfs: split MSSPLL in two
  clk: microchip: mpfs: setup for using other mss pll outputs
  clk: microchip: mpfs: add missing MSSPLL outputs
  clk: microchip: mpfs: convert MSSPLL outputs to clk_divider
  riscv: dts: microchip: add missing CAN bus clocks

 .../bindings/net/can/microchip,mpfs-can.yaml  |   6 +-
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |   4 +-
 drivers/clk/microchip/clk-mpfs.c              | 154 ++++++++++--------
 .../dt-bindings/clock/microchip,mpfs-clock.h  |   5 +
 4 files changed, 98 insertions(+), 71 deletions(-)

-- 
2.43.0


