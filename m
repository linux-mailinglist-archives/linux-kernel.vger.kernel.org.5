Return-Path: <linux-kernel+bounces-48704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DF0845FFA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219901C247D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82108405F;
	Thu,  1 Feb 2024 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="tt1qRTli"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3A7E112;
	Thu,  1 Feb 2024 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812339; cv=none; b=EkIA8IukoW/k9xKTkgRyZYFwtKoh3I1zLT/qIrvFS3JDxZ5kNxYUbmrkMUo7NPST8itQR0P8nP7nlCgS0pCoupLogSIMhgNxfeYMPhDrGICzIgcsRlUQzajxICYxIdix7Q5EA7wrsfGUXa768Q0b0aBm9WGqpeHC3ECVZcLlsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812339; c=relaxed/simple;
	bh=KCztPjFje46tTvFIspE4Yw+0iPrI8st5t4y4xeZHOTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MpmAklX62L2wf3LdBMAfVfX5MKnFyJ44lKkWkx5rK8Y9TmPghveMBs04LxEOnwmHxzmrfT7csz4UaYvW4KwH4ToPIQX+MXFWgGs22sfI5u+ovnKHhAOzJyO4hMT5rk9qK7IfFqcbvW9mDlqcOfUwrzl58ZNZ70bQEHe7gDLlj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=tt1qRTli; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout2.routing.net (Postfix) with ESMTP id 15933615E9;
	Thu,  1 Feb 2024 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1706811856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FM4cDbc05aFm+s5YmM2e5LZAZcaagXIlqsb3avH/P4U=;
	b=tt1qRTliyFFSUHcMcviRe+VcJNZonpH26E8dcYVWElrfwmBvJGErlNZWu9vcwvtc29m+ld
	fR5Hj/0LQVl3HMVwY/cVXoz7qP3B5GC5yngrA0SoYtLeEawZL16MajOChDPaxfV48q8kDC
	8n6YvCFuSVht9AX1E3/QJ/H+Ao8fK7M=
Received: from frank-G5.. (fttx-pool-217.61.148.248.bambit.de [217.61.148.248])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id F247440533;
	Thu,  1 Feb 2024 18:24:14 +0000 (UTC)
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
Subject: [PATCH v4 0/2] Add reset controller to mt7988 infracfg
Date: Thu,  1 Feb 2024 19:24:07 +0100
Message-Id: <20240201182409.39878-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: c0fd09d3-398d-40e5-b864-847111d8224c

From: Frank Wunderlich <frank-w@public-files.de>

Infracfg on mt7988 supports reset controller function which is
needed to get lvts thermal working.

changes:
 v4:
   - changed commit message of dt-bindings patch to include information
     about starting from 0 again suggested by Conor Dooley.
 v3:
   - start resets on RST0 offset (LVTS is RST1)
   - rename offset constants with MT7988 prefix (else collision with reset.h)
 v2:
   - change value of constant to 0 from 9
   - add missing SoB and commit-message for binding-patch


Frank Wunderlich (2):
  dt-bindings: reset: mediatek: add MT7988 infracfg reset IDs
  clk: mediatek: add infracfg reset controller for mt7988

 drivers/clk/mediatek/clk-mt7988-infracfg.c    | 23 +++++++++++++++++++
 .../reset/mediatek,mt7988-resets.h            |  6 +++++
 2 files changed, 29 insertions(+)

-- 
2.34.1


