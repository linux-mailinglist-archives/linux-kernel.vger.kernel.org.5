Return-Path: <linux-kernel+bounces-71152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F8A85A167
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0572C283689
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D6D28E09;
	Mon, 19 Feb 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fh4i/OOb"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391C328DCB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339892; cv=none; b=UXjEXea1BJ39YvvHvrg08q0BvtVClv4y9c/ATjRlCmtM2BlRESVAJ3JDPGkG40BSQi0I3SILuFD+ERvl3CDJiEz+kzDrw2jlWsodsceQVHkMpTkcWJjVYVgRIWgOxkCnvPPNVZEciuoDBOQZ27XD2osi2CtEnTxzLKVRVWTxNbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339892; c=relaxed/simple;
	bh=1kduv3wsXHoy8j19LVAOeFeOJlRIBbn+iYy1T77WYB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wfk7xg915tPf+wltU04+kx3RpiHwaRMAr2e6+a0E2hK5vlvOBBiCWwnkbzFUiqe4OoJAQE6aAtJRtr5nffn5mfXjFnC2ty75/QwSxpW27RCHb+gO+9Pyzx+e8o2LHa0ZHqCTn0TTRRtjgbQzQ9JDr7Lo4Wu3qm9pPg37psPeFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fh4i/OOb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d746856d85so22841385ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708339890; x=1708944690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/L4TPn2Q4JShJP0yVub7epn9w+mmtxiJMbsQbqv5v8k=;
        b=fh4i/OObzKrK/OvixOGSE51X+QCpwbU1oahhhNbyoJPv1MIkozzK42Wy1PSJQAHCj+
         nBVc47rab7VAR3mribu6m7o2LE6ZvdNyBw9Ik0ES2lTi16Rbr9qoOMUxDd1p31yyLvBx
         FZ4D+whiQsPWvGdp3M50qQ1GOTvuYam7sasOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708339890; x=1708944690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/L4TPn2Q4JShJP0yVub7epn9w+mmtxiJMbsQbqv5v8k=;
        b=qfXk0aIRCPKzhr3eUJx8WK/fIYwZ1olk5AZt8t1WNdCa4NrcmjEyswxpJ9PVOreBxg
         8yL++MFcVp209ByZcjzRbrLgZbI4oF9mF6JRcDtivZOsbtdVm782lzncOz7SjDvYMbM7
         hto9amEFZtWY6IJoN8BRqrrTyep2/N3AnHnXM6xQmuFdxj+nUU0DsBKx2hLMv7RFzLZQ
         PMCs9tQ7UM/3Hk3z3ufTPHVrcUvRpaNxEUTA/yX3/fheQ8YoIkvEl0BekUT3he3ymruB
         u9T62bgF2TU7hgRdlnjgXRe+F22y4Qk5D4OrceBicrlU0Y6iYLzdAQsvAqaCznelEDLu
         cqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Dk1FxLpd/qZeoS2bfiQs8Z4tOh+gSDvu05I3fWp305aw2/J+7VQubSxwbgu1r5pHGqdnWq3UvFL/QqxUbjg4Mkqp4AXPxDTYXCJS
X-Gm-Message-State: AOJu0YwerBJ2N72uapG6WRsTS8SE6qjHu/u+jRy9S6KNphrT30i1btul
	8cSfzk7luBDVHtfJ3PNE7pYVR4bNvx6Hxh9HKWrk89KT26kJUxX2v1Li5eFJMA==
X-Google-Smtp-Source: AGHT+IHPxsNk8CcRBmex8+7iHAv2rbVy7LnqzC7zcg3vEHr8P63/RN+y2pbr/3u9rT1dt5y2Af/XIg==
X-Received: by 2002:a17:902:f542:b0:1d5:dac4:5015 with SMTP id h2-20020a170902f54200b001d5dac45015mr13208265plf.11.1708339890465;
        Mon, 19 Feb 2024 02:51:30 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:36aa:521a:5948:9614])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001d8edfec673sm4112281plb.214.2024.02.19.02.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 02:51:30 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-clk@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt8183: Correct parent of CLK_INFRA_SSPM_32K_SELF
Date: Mon, 19 Feb 2024 18:51:24 +0800
Message-ID: <20240219105125.956278-1-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CLK_INFRA_SSPM_32K_SELF has the "f_f26m_ck" clock assigned as its parent.
This is inconsistent as the clock is part of a group that are all gates
without dividers, and this makes the kernel think it runs at 26 MHz.

After clarification from MediaTek engineers, the correct parent is
actually the system 32 KHz clock.

Fixes: 1eb8d61ac5c9 ("clk: mediatek: mt8183: Add back SSPM related clocks")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8183.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 6e23461a0455..934d5a15acfc 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -790,7 +790,7 @@ static const struct mtk_gate infra_clks[] = {
 	/* infra_sspm_26m_self is main clock in co-processor, should not be closed in Linux. */
 	GATE_INFRA3_FLAGS(CLK_INFRA_SSPM_26M_SELF, "infra_sspm_26m_self", "f_f26m_ck", 3, CLK_IS_CRITICAL),
 	/* infra_sspm_32k_self is main clock in co-processor, should not be closed in Linux. */
-	GATE_INFRA3_FLAGS(CLK_INFRA_SSPM_32K_SELF, "infra_sspm_32k_self", "f_f26m_ck", 4, CLK_IS_CRITICAL),
+	GATE_INFRA3_FLAGS(CLK_INFRA_SSPM_32K_SELF, "infra_sspm_32k_self", "clk32k", 4, CLK_IS_CRITICAL),
 	GATE_INFRA3(CLK_INFRA_UFS_AXI, "infra_ufs_axi", "axi_sel", 5),
 	GATE_INFRA3(CLK_INFRA_I2C6, "infra_i2c6", "i2c_sel", 6),
 	GATE_INFRA3(CLK_INFRA_AP_MSDC0, "infra_ap_msdc0", "msdc50_hclk_sel", 7),
-- 
2.44.0.rc0.258.g7320e95886-goog


