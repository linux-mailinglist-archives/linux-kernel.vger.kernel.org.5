Return-Path: <linux-kernel+bounces-50412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 157DB8478A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B163B27843
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30092150992;
	Fri,  2 Feb 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyO7sfYi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F7150474;
	Fri,  2 Feb 2024 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899302; cv=none; b=D4qmxConJ1T2poxejSPfNsCNp8FYLhNHW9vyUM5JXrwpBH78OhyxSAnVKG2E6hG6tHNnsqaOoXtFsKM8S/tf0eTjbqJGGLGGBxNsGiywtqviOw+M24ft5Q53xK56ogI434sYD8cQxB31gpBAx2WCFF1NxTIEis5ifAD5LDBNemc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899302; c=relaxed/simple;
	bh=8xd+HaBx8HFhxNoJoDn2ZaWc9Aydn6hKsS84wUq5FCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bS7she0sj6R9VOvsTZp6LF+CHDuSuN5duvh7ddJ3IwXQVsVt9gg7J7MG0bIriG0QV3F4tDcsIe4e7OLneqflSVSJLNGN9YcuGrVojOtkDvn9r01fNr3dE5cL29GwVPaZ1tPyUF3fbHEt/ImPZGsxzmFD+6PC8qQf3TwmtpUpEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyO7sfYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142C7C433F1;
	Fri,  2 Feb 2024 18:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899301;
	bh=8xd+HaBx8HFhxNoJoDn2ZaWc9Aydn6hKsS84wUq5FCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XyO7sfYiLbDbeOks/Qokr620J9FSF79oI+XZ+22FJPeAWkiKP1CLjhWTFTox/UyH8
	 hT7jC1MSLRXaRllZdX4h2NQhgJAp+881I5GRrRb51YjENXkSnKGNSh197KOUmSSF6R
	 jSKJZxk4EJoJfCaciOIPs0HTM6sfGN63d4Dupx6DMe79M5y1zUJs66GuD42TZ3/Y6k
	 g122RcQy+CzjOb154hyEcV6NC4YMsXjteofCgXq9ghVwGinbgvREzJ3/dj5AJ6LYG/
	 kjDvEygzPYCSdKU3MOxiVbo18uR0j2NLPt0EpCdOHawSbX4Q4fkRPLmIDdMvwVR/h2
	 g9oJBCQ4Rv5tQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devyn Liu <liudingyuan@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	f.fangjian@huawei.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/11] spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected
Date: Fri,  2 Feb 2024 13:41:20 -0500
Message-ID: <20240202184130.541736-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184130.541736-1-sashal@kernel.org>
References: <20240202184130.541736-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index d3a23b1c2a4c..61bf00dfe9c3 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -377,6 +377,11 @@ static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
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


