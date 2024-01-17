Return-Path: <linux-kernel+bounces-29329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F99830CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC79BB25686
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7258923779;
	Wed, 17 Jan 2024 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="XZlpggnU"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9532376E;
	Wed, 17 Jan 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516878; cv=none; b=NKLc7Rjc0/FXrVNa7WukjqRTGPdD30uong3oPBtw3Z/Xu6tFgHKf10wz0fgor3kM2kUrnkow7ZbYVotHfZVEWvF7sFaUDKBWRD4hZE7kQ3ISKv37oXKD3fZWPtebpt7K2S3jlauHIXekPYSWFHiznkQeF0hAyvh4dBEP/kzbpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516878; c=relaxed/simple;
	bh=3VdOjc3X148qsKr0xLzhVrZ+WN/d9jtjGD8XrGEuK1E=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mail-ID; b=IhYkXi8Oj3PrgAmXrMeXL2MdA+2qvWNPx1AI07wZtB1v+Dx3Lr9FhAJBrHkRkm1fTST1P7zy9jsoXSyhYc8beMhAV+B+lufUiZtaL9IoMgipjdt9dg3xkhF5QbH1E0m5ZINml8SSYaO1r/79ZjkFX1an4JgW9ig2kXZUCYSCPGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=XZlpggnU; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout2.routing.net (Postfix) with ESMTP id F23E660C47;
	Wed, 17 Jan 2024 18:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1705516875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=faaWm9kKMcck2ImmwhnetGgTDP4WHiKRSvb4Y2er2NM=;
	b=XZlpggnUqZvsTF9Yb7WvggZQdzQgKsu8sQYTSEpcJaUqmgnXUOTkpnbPGTFBUxel0cL3C2
	SoDBk19pNESWo8LZ2YmZlXGQqkVa2y1ovU//PeXdBCo+dGY2/sp8CGoanWLm7P38b0f6KQ
	7JmyZfC9//F0qGEHISoVA78HT8TliwU=
Received: from frank-G5.. (fttx-pool-217.61.151.254.bambit.de [217.61.151.254])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id CCDEC10022F;
	Wed, 17 Jan 2024 18:41:13 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/2] Add reset controller to mt7988 infracfg
Date: Wed, 17 Jan 2024 19:41:09 +0100
Message-Id: <20240117184111.62371-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: df2cc20f-ff88-4040-bb30-13fca5955db2

From: Frank Wunderlich <frank-w@public-files.de>

Infracfg on mt7988 supports reset controller function which is
needed to get lvts thermal working.

Patches are based on clk-next due to recently added mt7988 clock driver:
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git

changes:
 v3:
   - start resets on RST0 offset (LVTS is RST1)
   - rename offset constants with MT7988 prefix (else collision with reset.h)
 v2:
   - change value of constant to 0 from 9
   - add missing SoB and commit-message for binding-patch


Frank Wunderlich (2):
  dt-bindings: reset: mediatek: add MT7988 reset IDs
  clk: mediatek: add infracfg reset controller for mt7988

 drivers/clk/mediatek/clk-mt7988-infracfg.c    | 23 +++++++++++++++++++
 .../reset/mediatek,mt7988-resets.h            |  6 +++++
 2 files changed, 29 insertions(+)

-- 
2.34.1


