Return-Path: <linux-kernel+bounces-80115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E69862AE3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574CB28169F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF117BD6;
	Sun, 25 Feb 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfU40wHC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3D117BB5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873215; cv=none; b=fZiLrsdS6e8b9mG/ZRnOCzIGmWEow1gXfsh9nNxN+4gM4J9EN3+Oe5RBqaG6p9qdFeJydqxmU405k/Yi0x9Ic58fnVnp9SUyl1nv07s94OTxw7vcFoquh6jLYwPF6qfCJL0K1dx/cEn8R1QOP7FlJZ6n0pPMkd1AY+SJuyb63L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873215; c=relaxed/simple;
	bh=X9+qvEO2XEVtcl0Z37unwdXVLozBPbckvKpRaBgpa9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGatcKqRQ3mnXbiPDNfG/8i95PNUyK805b6m7TaOQrYU9mqfp2SfzQqET5ox0rAODjHEhuGoYUR7xocHeT21VYh4h7Li4DrPoU6eLucBcgBMxcL/BX/WgACMVMauTIWD/FdVKFlPDDH/9w8cvP/f7Q6cvl3+TNkBr0TrgPAx7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfU40wHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B045EC43390;
	Sun, 25 Feb 2024 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708873214;
	bh=X9+qvEO2XEVtcl0Z37unwdXVLozBPbckvKpRaBgpa9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KfU40wHCwMEnS3HnRuVIWBzGhhBbNMigz4OjNQEGUqUeBlaqP/4Sp7MuVF9Ypp6Oo
	 X24epenmtHJ410NVGI4vZmpNlJCER/XDVmjqPLi+Gf7RDmZ9fihcLPEliyAFg52xJV
	 HhC+QTbcLsBW7GqwfxNTPwmGyjEwmSLN1BqrYc9zRR1jrcm99b2SDCutMmq725OdeU
	 pxcm9/8q7BctGkZhYYE0ptquAy1z2TKZo5JRoQMaoHCQRwvxfxQFWRond7UDHotqTz
	 JhSLC9ChpU+2I5KJMuDn5GVmi2R1fDjqWZxQ8fFMUUDIY5X5WNeLZcoUi7y62Ou0CR
	 kmVOSWHFGMokg==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 25 Feb 2024 14:59:31 +0000
Subject: [PATCH 5/8] regulator: mp8859: Support active discharge control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-regulator-mp8859-v1-5-68ee2c839ded@kernel.org>
References: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
In-Reply-To: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=broonie@kernel.org;
 h=from:subject:message-id; bh=X9+qvEO2XEVtcl0Z37unwdXVLozBPbckvKpRaBgpa9c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl21XtL09mnouWsPOM5gMsWsesbkXsUDdZmXXvV
 w/vc6LAiPCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZdtV7QAKCRAk1otyXVSH
 0J2DB/4nEO8nZKFIEwHzKSUMOUN7rEK9/bdPwWeBTOBH0yluUzJaq09BU8iP70DhfqCXoIjZtLJ
 hMVRgk3lRnbZ+pRBvqfZEzIcjWAl+PSChWuUlkQOuy13bPRyaKJHylNHCFam988r1R+55HXDBTi
 78tDSNj/EvcVVhX8pDXgU/Ucg9AzurVXMh+v+4OE8kHpXLXjZYIZ3sQwF4DP/ErI6msdZIgdKjk
 dMK8tZrtSCBahS5rrFRxpHF53HXguAiWxlHGx4KcPTWWM+aVl7NQqc/foELX/pjeeYgv/On/Y6/
 kq0cQViY7cV1ykOlvWDPlFSmw4l2v/03RTnZDcNr7QVvQ/Ji
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The MP8859 can actively discharge the output when disabled, add support for
controlling this feature.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp8859.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index b97c00097148..87ef34875be1 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -36,6 +36,7 @@
 #define MP8859_GO_BIT			0x01
 
 #define MP8859_ENABLE_MASK		0x80
+#define MP8859_DISCHG_EN_MASK		0x10
 #define MP8859_MODE_MASK		0x08
 
 static int mp8859_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
@@ -167,6 +168,7 @@ static const struct regulator_ops mp8859_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.set_mode = mp8859_set_mode,
 	.get_mode = mp8859_get_mode,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
 };
 
 static const struct regulator_desc mp8859_regulators[] = {
@@ -182,6 +184,9 @@ static const struct regulator_desc mp8859_regulators[] = {
 		.enable_reg = MP8859_CTL1_REG,
 		.enable_mask = MP8859_ENABLE_MASK,
 		.enable_val = MP8859_ENABLE_MASK,
+		.active_discharge_reg = MP8859_CTL1_REG,
+		.active_discharge_on = MP8859_DISCHG_EN_MASK,
+		.active_discharge_mask = MP8859_DISCHG_EN_MASK,
 		.ops = &mp8859_ops,
 		.owner = THIS_MODULE,
 	},

-- 
2.39.2


