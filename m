Return-Path: <linux-kernel+bounces-113831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D80888EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660D02903B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B81E7DF0;
	Sun, 24 Mar 2024 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRMcPzXG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4C129A70;
	Sun, 24 Mar 2024 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320870; cv=none; b=Kwd65z6zGFfaERFJ7e74Qyw3DWZ1MQMtKBVMFLJvvFeMGuSMM2r8fCJCZu+EQrvSdsAu0R9hOPv97FF82NDYAsy5AIGQmj6Hx3Fi3GfYUiAJQmBMIe0Tc+SZgST6/vyWiXa0e2VAc1j6pzuoN7nbY/s5p+aQaKGamyX5f33Zr7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320870; c=relaxed/simple;
	bh=RjDm9ULGYGXR/Ui5vm0FWksgcl8NMVnW5oGvvsNB4/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ib8SP44F0lJIEjGAPZQ0ahkHzCf/FJMTRKCyADrxOGsD8JtjPbWdvOtu/ci+8k6ek/aeBANezC0OIo7KB8G/qs7hQYQTBys/fIkcumLf3aiXIDxA+qy3be8YgGOSVblvBFykJliWRNHiAQTM39O98sD2lSsMTiQ3W+L3t1zpvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRMcPzXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F48C43394;
	Sun, 24 Mar 2024 22:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320869;
	bh=RjDm9ULGYGXR/Ui5vm0FWksgcl8NMVnW5oGvvsNB4/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRMcPzXGhmtTnjfIr5JEyB8xJwy5CV5PlLGkKLEnLEtON3k6YqqMML0jDVBWuzVXM
	 OZLkN6VmucjhlSPgbCuhbAbNal5TXtPRz6j5nLtn6Gj/bli+EzTjUyWxv+l6mww6oH
	 zI80dxFZaB4oJXezQAVXJA6O9nOddLlFRUmgQg7W98Vz2Zn5h/pxRV/fLfPMP1robN
	 ek2/TcyL0DtyLITvEIkNkIMqXVK+OHyAkdVskrGIIwVTr82AeWmXcD+AbnfdYcU6cE
	 AUng6wsI7L/hZ+WC9EY88w/IK0cLaFs/epMGfCekqRIjn04yRt0HUvn6OM4awdilR1
	 MKtnje7ylIxhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 433/713] pinctrl: mediatek: Drop bogus slew rate register range for MT8186
Date: Sun, 24 Mar 2024 18:42:39 -0400
Message-ID: <20240324224720.1345309-434-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 3a29c87548809405bcbc66acc69cbe6f15184d94 ]

The MT8186 does not support configuring pin slew rate. This is evident
from both the datasheet, and the fact that the driver points the slew
rate register range at the GPIO direction register range.

Drop the bogus setting.

Fixes: 8b483bda1e46 ("pinctrl: add pinctrl driver on mt8186")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240131071910.3950450-1-wenst@chromium.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt8186.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8186.c b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
index a02f7c3269707..09edcf47effec 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8186.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
@@ -1198,7 +1198,6 @@ static const struct mtk_pin_reg_calc mt8186_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8186_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt8186_pin_di_range),
 	[PINCTRL_PIN_REG_DO] = MTK_RANGE(mt8186_pin_do_range),
-	[PINCTRL_PIN_REG_SR] = MTK_RANGE(mt8186_pin_dir_range),
 	[PINCTRL_PIN_REG_SMT] = MTK_RANGE(mt8186_pin_smt_range),
 	[PINCTRL_PIN_REG_IES] = MTK_RANGE(mt8186_pin_ies_range),
 	[PINCTRL_PIN_REG_PU] = MTK_RANGE(mt8186_pin_pu_range),
-- 
2.43.0


