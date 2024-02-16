Return-Path: <linux-kernel+bounces-69339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B210C858794
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABED9B28ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB9C146007;
	Fri, 16 Feb 2024 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGl53bd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CBB12CDBC;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117351; cv=none; b=LO+0N6b8TElx+tMQ/YJ1iE8NZxprzmpjUZTlz6B/Bnfpxz/ldVVGbbVXzomK1OUuQturf18zDyHwrJvPBNlSHAzrsh8ElpL567W+U9MCN7WABL5ivykazVDmo+Ut7pt8vYFUjUO4MyY1WghoSA0dSUk2qwxJQUjN971HCfG7cY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117351; c=relaxed/simple;
	bh=ZVfCAP1yCNLycGHnzMNfXr0x2HXb2x238OngVPxw9tI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OrwVwUNiQdaRflQHi6Yl2kD+3+RexA7zc+9cwUekKH2rZf3Onz0VLT3dOJ/dzhmXF8/ixfRd/fWadr/xYodvsqIJEXpKsl8qs5QyWENGzS1HOE+vweEbC5xlIZV801S8rVZPaScl0YrGBPhq/KqHV/N6lcsTeGkGXH6Q+/n9y6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGl53bd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93A20C433C7;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708117350;
	bh=ZVfCAP1yCNLycGHnzMNfXr0x2HXb2x238OngVPxw9tI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VGl53bd2t/YLfY9eY9wTVeYPdIqYxwKyzjoIUsh1TSlIqUj+fQgeqVMti3pAlqFP1
	 NQouBb1iJW1IBvsz1Km12OVsTMwQ5UFzXoiDgGwWinakp7N6/Zd1INVeFgDXcjl3cQ
	 A5BCZ9fBBsL5VFnGyWa7p5VGS6Sc56M5a9JdHfkdn1D48duRcTgJkLa8aY7K4HO6Cq
	 kW3P+RnxjZl3Sb+4N5yXTA0EosvCw2B+to2/E2gmbp90o5zc72S8R2ka597UXlXPF5
	 GCVcOAABH/lOhKH+CwCj7KFRSJKjsabIsb7PqK2sAbs0E8+pfc2vBmfvU/zRWIGJyS
	 4tlUf+H1oonMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762C0C48BF3;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v3 0/4] mmc: add hi3798mv200 specific extensions of DWMMC
Date: Sat, 17 Feb 2024 05:02:28 +0800
Message-Id: <20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTNz2UC/4XNQQ7CIBCF4asY1mKGgdLqynsYFxSoJUoxUImm6
 d2ldWVi4vJ/yXwzkWSjs4kcNhOJNrvkwlCCbzdE92q4WOpMaYKAAhgy2grqvaa94/W+8RkBqKp
 qDtZ0DFGTcniPtnPPFT2dS/cujSG+1h+ZLeuHQyZ/cZlRoLUR0rSNqJSVx/AYbyFcdzp4soAZ/
 yNYEGBgJLdSMVN9I/M8vwE5EHwb+wAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708117349; l=1954;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=ZVfCAP1yCNLycGHnzMNfXr0x2HXb2x238OngVPxw9tI=;
 b=sZcA+Pc8k8KLVVEe9c7hHJ2JBgE+HJrvDGPFqJB54TKwRVl9McepwC4+/FUG/FexIpzZdVZ8i
 OqzkM1g4Jk6AZ2SjOq3gCiULPrnmMcoGbS2I/MS6EY5pILqTBsCOW/z
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

it's modified from hi3798cv200 driver, but quite a lot of code gets
rewritten because of the hardware differences. Actually cv200 DWMMC core
is called HIMCIV200 while mv200 DWMMC core is called HIMCIV300 in
downstream.

Pending on:
[PATCH] mmc: host: replace 1st argument to struct device * for mmc_of_parse_clk_phase():
	https://lore.kernel.org/all/20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com/

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v3:
- dw_mmc-hi3798: fix bot error (Rob Herring)
- Link to v2: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com

Changes in v2:
- dw_mmc-hi3798mv200: use dev_err_probe() helper - Suggested by Krzysztof Kozlowski.
- dw_mmc-hi3798mv200: add missing err=0;
- dw_mmc-hi3798c(m)v200: remove unused MODULE_ALIAS() - Suggested by Krzysztof Kozlowski.
- binding: rename the binding, a lot of tweaks suggested by Krzysztof Kozlowski.
- Link to v1: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com

---
Yang Xiwen (4):
      mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
      mmc: dw_mmc: add support for hi3798mv200
      dt-bindings: mmc: dw-mshc-hi3798cv200: convert to YAML
      dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc: rename to hisilicon,hi3798-dw-mshc

 .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ----
 .../bindings/mmc/hisilicon,hi3798-dw-mshc.yaml     |  94 +++++++++
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   1 -
 drivers/mmc/host/dw_mmc-hi3798mv200.c              | 235 +++++++++++++++++++++
 6 files changed, 339 insertions(+), 41 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240121-b4-mmc-hi3798mv200-a5730edf122c

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


