Return-Path: <linux-kernel+bounces-50422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC1E8478C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C56F1F236E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B8159591;
	Fri,  2 Feb 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVabTbJT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C7E155F52;
	Fri,  2 Feb 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899326; cv=none; b=hYKOccuDU/9Q1uuylvZq8JLmhrIAMvl1RyuxOxyHJHqt5O117+4IajFTrK3y2h2SRtcDU6RHbgBCAANq8SOm4JTYTEENs/Yiv018Tj0CSLgzB2eZtSWnHqL0jHsj3SCOMQJrS55+y3GmMVlSzGkHmACX8v+HDu9onfy9MSkxhl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899326; c=relaxed/simple;
	bh=NpTsJFLB3ZR0CMS3/Duwe4Ep3wMAa9mNjC7PPZZqebE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbPEO0cyhfkO0/sQCHzVp+tnRjPK7XkXtAbvQBujIxHGq6wOkw0n/A7s9U4YVkwOiiJz7+sXo6AgRJFvZibTW8HnHWSMmn0cIMhIR+m3O8TIwzyNlxe8eYFsKk0fAMlOx0QZoPsSl3WZjEOFW1Q9/zMxr/qBscJllhNsZlkGP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVabTbJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243DCC43390;
	Fri,  2 Feb 2024 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899326;
	bh=NpTsJFLB3ZR0CMS3/Duwe4Ep3wMAa9mNjC7PPZZqebE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVabTbJTREuJ6tdtDdtrqPfSLeVGs67LmeBpk7zLwHoPyYfPzoXZasuA0aatlWOtV
	 rg8Jg72+FuNfR/9TBMZsW1K85FjVcKtfUWjZigHiuFVaQuUx1l0aLEl+i6z6PISI/d
	 44kf1iHTL06/3a887ykmUTVciroQiK5JVC49gbkYYYlYE6HDAfrGAmRCT3XkTtg3Hr
	 tB9pnO5cWWWf5loDl7a457FHWKlFxw52coGGCC6uQOzoZXH1rL2Wwqwt1dvhLTCCAB
	 52I/BrTjWpeKfaz4BNzjaA/XHt/DjTFmNQhAGsknpeTxtiUTDoo48Iv/teduYyULL0
	 haLlcuHWWvEJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devyn Liu <liudingyuan@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	f.fangjian@huawei.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 5/8] spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected
Date: Fri,  2 Feb 2024 13:41:49 -0500
Message-ID: <20240202184156.541981-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184156.541981-1-sashal@kernel.org>
References: <20240202184156.541981-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Devyn Liu <liudingyuan@huawei.com>

[ Upstream commit de8b6e1c231a95abf95ad097b993d34b31458ec9 ]

Return IRQ_NONE from the interrupt handler when no interrupt was
detected. Because an empty interrupt will cause a null pointer error:

    Unable to handle kernel NULL pointer dereference at virtual
  address 0000000000000008
    Call trace:
        complete+0x54/0x100
        hisi_sfc_v3xx_isr+0x2c/0x40 [spi_hisi_sfc_v3xx]
        __handle_irq_event_percpu+0x64/0x1e0
        handle_irq_event+0x7c/0x1cc

Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
Link: https://msgid.link/r/20240123071149.917678-1-liudingyuan@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 4650b483a33d..e0c3ad73c576 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -365,6 +365,11 @@ static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
 static irqreturn_t hisi_sfc_v3xx_isr(int irq, void *data)
 {
 	struct hisi_sfc_v3xx_host *host = data;
+	u32 reg;
+
+	reg = readl(host->regbase + HISI_SFC_V3XX_INT_STAT);
+	if (!reg)
+		return IRQ_NONE;
 
 	hisi_sfc_v3xx_disable_int(host);
 
-- 
2.43.0


