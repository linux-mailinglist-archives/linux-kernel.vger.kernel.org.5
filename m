Return-Path: <linux-kernel+bounces-69675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E92858D31
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5061F223E1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED71CA98;
	Sat, 17 Feb 2024 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qY59KLK4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024581CA86;
	Sat, 17 Feb 2024 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708144834; cv=none; b=tJrpfMwKFS3B/vgFohEjNDOWydVXnaojmRKfFmZFSWUOGtzhp4FmILTOhLzBLPUvJl5DPRz2DL+ggZ2QrQb94mvkQsi7K6RKrRQwbwTxNjw7b7GiicngoZcNTdEN2dYV3eSvtR23AHEo8WKDHACAo176/hweYiDAsjIl59R/7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708144834; c=relaxed/simple;
	bh=LUJDC/VfEayPO/LNjl7p0MlBSOcC2kOdKtdoDYyCuiY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SSZ1hYB5pn5kRMVvGTs92wARFVvvNId/eIvIvXmDh/LVg2Z+vkQUKsLAJfTl+PgOAQ72kr+VqseqiPvw6MtfCNvuCL9pLHwBdNqg+4UJpDz5JEVTNgDYm1utokPFeJevPyZJDf7RVHAkUMOpL0i0yFBKwoMA4CZG2kD8hO+HMlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qY59KLK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B524C433F1;
	Sat, 17 Feb 2024 04:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708144833;
	bh=LUJDC/VfEayPO/LNjl7p0MlBSOcC2kOdKtdoDYyCuiY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qY59KLK4H+KZVWQWakhsfsXav41jKBUuDbm/I2fYb9p/rvTTug5Xk5yv3pmbIKIWH
	 zVHgzG56xc0iU4GE8KedLKYvOF8kI8u5ceuJG8j4xD5EiCDiF71GwDbLCD+BZ8lCf4
	 dXSELR0nElsZ1ZsHcwEZ0HuPF8tpplJDTP8KtIqKNq7H8eiR/0dKbwTdiy8ofFukfw
	 XjAQFzqpLDW2hoqzc0ahGnIAbzuvxOE6l8w4HGze0zKlZwoPhmLw6895sv0hGeqaYA
	 /D+TZev/PftbuuPss7XIwsVTGBu2lQWoX6IFGe855n7nIgDmozfHts/Enx/I3FdzJg
	 CbKXV/0Ok57qA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D0EC48BC3;
	Sat, 17 Feb 2024 04:40:33 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH 0/2] watchdog: sp805: add reset control support
Date: Sat, 17 Feb 2024 12:40:33 +0800
Message-Id: <20240217-hisi-wdt-v1-0-cdb9ddcab968@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAME40GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0Nz3QygEt3ylBJd4yRTI0tzw0QzU0tDJaDygqLUtMwKsFHRsbW1AAF
 SbwlaAAAA
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708144833; l=590;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=LUJDC/VfEayPO/LNjl7p0MlBSOcC2kOdKtdoDYyCuiY=;
 b=0rqqZcArxThG2yX3Hq+rdGLGQsJvuKSoEyteZdrJRyKY14vkNn89yYUJ5TWBgd/TfYi+SFcIs
 JTK/0/6wGJmCEg6DdJ/6ICqR6ZfE6wCIjivmGUiPNshX7xFWzwOt3oX
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Deassert the reset if it's available.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (2):
      watchdog: sp805_wdt: deassert the reset if available
      dt-binding: watchdog: arm,sp805: document the reset signal

 Documentation/devicetree/bindings/watchdog/arm,sp805.yaml | 6 ++++++
 drivers/watchdog/sp805_wdt.c                              | 9 +++++++++
 2 files changed, 15 insertions(+)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240217-hisi-wdt-3b52971a6591

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


