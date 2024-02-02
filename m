Return-Path: <linux-kernel+bounces-50376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE3C847833
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A54C289F71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A28F131B22;
	Fri,  2 Feb 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJH/kEAj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E103131B05;
	Fri,  2 Feb 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899229; cv=none; b=bbpb3pSQyoFxC5QQ+QF8Ffj0tNl5IAcY4dvYgblj7mMuqma80HhKdVee7giNhaHwxSHNelEDTZlzfarwq3/o42bcLDOPzEje24H9RxAuca+Bvsvho5LJSwK689mphn01XRIKJVmVp+OeL9PGyz/2MTTfvifHOH4A+e3kEj7oXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899229; c=relaxed/simple;
	bh=GHyHSzTgm3gdZbjt+hEx429NAxCpZmy3qVPJPR3r/pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEyjpQBUk2nrEZa5ZbhIIYFL+7RRC9Y2z3sbYUT2cJLn2B1fxb7PEtBRHyZN6/IoMXRoAQtJFgVqnJpnW35y9lFeMrmdArnB1Snk3VQiEC75nBOeJ3H5eBng+lB7gd94swdMuLs3pn9Q9ZnkjF6jQqoOJIfHL5qaQZRizey37cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJH/kEAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753B0C433C7;
	Fri,  2 Feb 2024 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899229;
	bh=GHyHSzTgm3gdZbjt+hEx429NAxCpZmy3qVPJPR3r/pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJH/kEAjFI18Y2IE0w3xK8qEcqI7q0ZFTP1XwBcmtybEaTLTAgD681M6V1Qc8J65M
	 WhD7kQkfE5zKJPhnqXBPooNmpcqEyS1Q9Cc8e0lNfDFK37BURmcgz7Lz+c7u1VM89+
	 0E/C8AJrXvVQoZCDON/6fz+0yzJo58fXRdfwCaqsh0XpQL7jjldOJwD4gO8+keEGkA
	 aanLRhk1kr58VbtzeMOEeZvKfE5M9HKNuKl5SwMyDv8+f4rEHmqjMiP96pYWVOU+29
	 TTtQH9Uj+/wDiwLa7EwI91qP1iGuMJbNIySOEWgBRiU7UybZZszJ4vNv9b2NHaYJCQ
	 AQoVaV57vsw3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devyn Liu <liudingyuan@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	f.fangjian@huawei.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/21] spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected
Date: Fri,  2 Feb 2024 13:39:55 -0500
Message-ID: <20240202184015.540966-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
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


