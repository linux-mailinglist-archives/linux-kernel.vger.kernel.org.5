Return-Path: <linux-kernel+bounces-79748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A083C86262C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29117B21BAD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445E947A6B;
	Sat, 24 Feb 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asRaPFNE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05FDDCB;
	Sat, 24 Feb 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793774; cv=none; b=KahoRnMODPtOzMd9DOFPz9OHov6XFz7Dtie1ccgRJ0/XYDjsJN8DV4UTzdDC6B+PktHpEnlnGleuxmXncX6YJdZEhDTM6rn4a6HcO7Y65hrYjz+MyQVt0MZLBUq2SRFoxgQtRMZafeXKMGJZxCQFd0pdO2vvzSSMtEqjLSzidyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793774; c=relaxed/simple;
	bh=qtrP800EKdOTmakNAoNosODy8gqESCOm/APUkVSRbhY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jLzEXcIiMUvlOyoROht8DRjRnpljIWRT0/FJVP7eBNjGYanOzePHlelBTFOI0nPx4qSRK3TUwY7H0zRmOfZ4HwZcAhU9agNhO8k8thx4jRr04pHFtAZxpNTZGDnn4yBqrFxA8TFrnTJVEqXOvPSCUQw/VK3R9iIWOb82HF3wZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asRaPFNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFBD4C433F1;
	Sat, 24 Feb 2024 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708793774;
	bh=qtrP800EKdOTmakNAoNosODy8gqESCOm/APUkVSRbhY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=asRaPFNE5fnyNq+onqbaiQKvKBv8MEwZ2GKeXdBSccm6uAi6CdZiIvPL1NGEI0Q/4
	 AQ3YQDNc5MV1VfkDt73WD3dugifFcGpf20l6kAsHZLEm5Q6edTmIcK9WwX0LxpRsWQ
	 28BcTuN/Lsy1GApV7b9DrehoYHMHjvnIqW0S3eEIaj4DQpyI0sE/pfUS4z1fRCkksP
	 SddaZC/jL6/O3fnzl1HywCdRaA7nJujmvBMpSnUHGE8d0G3ri5deEegMp55dO/ltjq
	 67tNdQnfgauLHWnMCGvY4vOZc+jQ4Mrz81/owENuZyISW8pbS/5kWkzljlryS1OS/k
	 hAPpN7F6BO+ZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0276C5478C;
	Sat, 24 Feb 2024 16:56:13 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC 0/2] clk: hisilicon: add support for PLL
Date: Sun, 25 Feb 2024 00:56:08 +0800
Message-Id: <20240225-pll-v1-0-fad6511479c6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKgf2mUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNT3YKcHF0jM1NjM3PzZNNUwxQloMqCotS0zAqwKdFKQW7OSrG1tQD
 OUuxAWgAAAA==
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@foundries.io>, 
 Jorge Ramirez-Ortiz Gmail <jorge.ramirez.ortiz@gmail.com>, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708793775; l=863;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=qtrP800EKdOTmakNAoNosODy8gqESCOm/APUkVSRbhY=;
 b=VWJx7sn+15PK7vXf+ej8Tpz2unugzwQue+YKYT03SMOkuuerrVwyZG8WJLBnAciOPt5OL6Gl5
 AU9RANsVZYJASYwKbIKwjuzsTBxnyTqY1qcsYQ9BTMbKnxBS6NeIyjA
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

HiSilicon PLLs are used by various SoCs to provide variable clocks for
various system on the SoC.

Hi3559 has implemented their own PLL driver. Also fix name duplication
because of that.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (2):
      clk: hisilicon: rename hi3519 PLL registration function
      clk: hisilicon: add support for PLL

 drivers/clk/hisilicon/Makefile      |   2 +-
 drivers/clk/hisilicon/clk-hi3559a.c |   4 +-
 drivers/clk/hisilicon/clk-pll.c     | 171 ++++++++++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk.c         |  24 +++++
 drivers/clk/hisilicon/clk.h         |  12 +++
 5 files changed, 210 insertions(+), 3 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240225-pll-2653677c5e1d

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


