Return-Path: <linux-kernel+bounces-22351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65753829C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3591C20F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5DC4B5A1;
	Wed, 10 Jan 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D5B/bia0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3E4A99C;
	Wed, 10 Jan 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704896714;
	bh=vwOsYK81Kz7ekPSjYz//FcETzOWODCjxJchEEfAb39s=;
	h=From:To:Cc:Subject:Date:From;
	b=D5B/bia0HVVwkZiV0SO4gzRNmHqonfK01qPchiAJpbfX5nI7JJQ2tgcRNDUrM/Pu1
	 wI2R0GxMa3nTsiPNsLq5dej97eMn+I9kcFXWTLHm76Rdmftx5E3BGVm74V5aha/+50
	 AvmIL7SjElDBUEitXy4RYk3t4Bn0W1y5T5I2gdUFnQZkvCYNtoDA9fAnQnHwGRmO8m
	 lRl3FSYNYRzHpVcofQRSgoYrYpJmP/pvlAToPIDaEeUZG80EgFeHX+lqVGoN4TlsiE
	 ZceLgY4fZxZCdA166gNLRIKjECmYdTiEh9H3R3kHnAIiaWPebjTu8xYV7zkeNESp6d
	 kenMdZhU4HUug==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D94AE378045F;
	Wed, 10 Jan 2024 14:25:08 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"Hector.Yuan" <hector.yuan@mediatek.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/2] Fixes for hang on MT8195-Tomato during mediatek-cpufreq-hw init
Date: Wed, 10 Jan 2024 11:23:00 -0300
Message-ID: <20240110142305.755367-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


These two patches fix an issue observed on MT8195-Tomato where if the
mediatek-cpufreq-hw driver enabled the hardware (by writing to
REG_FREQ_ENABLE) before the SPMI controller driver (spmi-mtk-pmif),
behind which lies the big CPU supply, probed the platform would hang
shortly after with "rcu: INFO: rcu_preempt detected stalls on
CPUs/tasks" being printed in the log.

Changes in v2:
- Moved supply phandles to CPU nodes in DT
- Added fixes tags
- Added patch to verify CPU supplies are available before proceeding in
  the mediatek-cpufreq-hw driver

Nícolas F. R. A. Prado (2):
  arm64: dts: mediatek: cherry: Describe CPU supplies
  cpufreq: mediatek-hw: Wait for CPU supplies before probing

 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 32 +++++++++++++++++++
 drivers/cpufreq/mediatek-cpufreq-hw.c         | 19 ++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

-- 
2.43.0


