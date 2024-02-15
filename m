Return-Path: <linux-kernel+bounces-67429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6F4856B76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC1EB220D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D06E1386BA;
	Thu, 15 Feb 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi6EPdrC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA9132C04;
	Thu, 15 Feb 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019203; cv=none; b=pUw7oHNiZpavvR8xGhHkRj7IOhd1Yisu2zNmfh0VjB6jbm/WGV8HCglGsg65ovNlfThvLvg/LO6KM47+XNpvn6hmPIFRcAlnBtoMGQXebTnepVrELCTsHmaMp2D+3TIRWP/B+25LotiNgb2iALCKDhxnqYZpKBjpF8bVO7WyFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019203; c=relaxed/simple;
	bh=3SmWmcck5G21RkHFmC4DweIdttsir78RJ8t2utgkGNQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XB6SJ5Q0pAvWsA8RlMLi9Uqp2kpTJzQF/Tu/OQiMVD5yZMNagaQVmgJktGH9c5+7kRIH2VS5Bkgz6ZlmTvQo9uRLmHG+7TBmyYQIGOGM0ISX/cVnV9M/Z5iyz2kUlpcybl44erp3zocChi+PkQeURUce7XuKgGg9M8s6rnFe4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi6EPdrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1690C433F1;
	Thu, 15 Feb 2024 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708019202;
	bh=3SmWmcck5G21RkHFmC4DweIdttsir78RJ8t2utgkGNQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Qi6EPdrCc9v89k+Gm73FXJRcklShAe0JaStEoTGaOsHOZx4A6nJXfUYHCZxr1eYwa
	 5DSX3gfAdzLA++F72H7WqmfSwfNZMDydaRqr5fs7lHXvWX8msxP3RVnqRZWSkCYF9X
	 qCHY6jcWZQjpX15S1u7w9OD63YARQWxjOLk3ThEgU/XqEzjARRV0pCvVhB5s2nQ9Lh
	 g8e70In+BINtknlacjzN0NGu8FtK9Lbg1wgq08dAaNXLwp7XjRXeDG15W4DhdtjSAo
	 0aIATAYjiCCE5VWtfGaQiIss1ecWHhvt533cUwmF6i2ewOB7mycLbxqX6H1QALLowr
	 RcB78yQblUDdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9081DC4829E;
	Thu, 15 Feb 2024 17:46:42 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH 0/3] mmc: add hi3798mv200 specific extensions of DWMMC
Date: Fri, 16 Feb 2024 01:46:41 +0800
Message-Id: <20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFOzmUC/x3MPQqAMAxA4atIZgNpVPy5ijhom2qGqrQggnh3i
 +M3vPdAkqiSYCgeiHJp0mPPMGUBdpv3VVBdNjBxTYYNLjWGYHHTqu27cDERzk1bkThvmC3k8Iz
 i9f6n4/S+HxbAM4FkAAAA
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708019203; l=1049;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=3SmWmcck5G21RkHFmC4DweIdttsir78RJ8t2utgkGNQ=;
 b=iDJmQqTXs95Iec5RYgBkbeSZNLygTPRYG7YrVtIPzwwKnTycoUIsL5xoH+f3o+MFsRz0AY/z3
 hPEFez78WuhDTV2TNtdCfyP+ZoRA1tu2zw+hH8asPLXEDBC5PvPIlWu
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

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (3):
      mmc: dw_mmc: add support for hi3798mv200
      dt-bindings: mmc: dw-mshc-hi3798cv200: convert to YAML
      dt-bindings: mmc: dw-mshc-hi3798cv200: rename to dw-mshc-histb

 .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ----
 .../devicetree/bindings/mmc/histb-dw-mshc.yaml     | 130 +++++++++++
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-hi3798mv200.c              | 238 +++++++++++++++++++++
 5 files changed, 378 insertions(+), 40 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240121-b4-mmc-hi3798mv200-a5730edf122c

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


