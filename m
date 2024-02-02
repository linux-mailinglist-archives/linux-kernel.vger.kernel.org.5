Return-Path: <linux-kernel+bounces-50353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A058477E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D34283646
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F81415CD4C;
	Fri,  2 Feb 2024 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovbITdMy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA515B0FD;
	Fri,  2 Feb 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899181; cv=none; b=PmKwnMVqgP4/n2mY6IocJxsmRZfo0uv//9TexOMRDJYuQ6XnP/19n74fX/eOH04J9Q95hw6IyQktfV9DwX/LCQraEeVi6Jxsd7BfwCxu4lDI6FZvTFX/67+GblAauW2ZzVpkzPf3ytD0Lf/UEN95kySaHSkmLhjblrlPY3YHVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899181; c=relaxed/simple;
	bh=GHyHSzTgm3gdZbjt+hEx429NAxCpZmy3qVPJPR3r/pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4ryBBo/MYxneUu4Dkqnj6eJ6Kvfhq2dAXjIhKUKdrQ2/Opyv8fVj0Zo1l725Fo42Dvbe144l2h91pvesJ6p6/BWxHbYY2kkmPJp1s1fFlsj+yz0AOiE02YftP0/h5RsT5KHoVvxbHilRA7daOKY+QBOZRqiz24Y3OOky5e0+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovbITdMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4616AC433F1;
	Fri,  2 Feb 2024 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899181;
	bh=GHyHSzTgm3gdZbjt+hEx429NAxCpZmy3qVPJPR3r/pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovbITdMy+V/ZhswrkT6UCZr1SAJJoXfwjmGRAVIano/1UvjmSDm2ydBycgPAD/bU4
	 sGQX7jFgkFbCp2l/t+VAbsZYXINNRZrvlLie7WLEJ+EGczb++KTYrDBdmA2xLaT+nC
	 NKcY7ZkqUB+YkisIAJ3Cy5wlq4ccgYwpzbK0Ujcr4MV8kdRkksNizSwkwrtBbwqLlx
	 vXLMjEd9hbL1ujAm20SpFGvDwsbNvlN96ydHZq4RP9QSOwXgC2WqX0uAAs7HHfwrbv
	 1ecTA5FPagOGnOc81J0slHHXMVGTkXGJP1X0j5tHqHvr6z7U+GlN/Cb7vmTxiibhv8
	 6XETK9PATYBYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devyn Liu <liudingyuan@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	f.fangjian@huawei.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 09/23] spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected
Date: Fri,  2 Feb 2024 13:39:05 -0500
Message-ID: <20240202183926.540467-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
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
index 9d22018f7985..1301d14483d4 100644
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


