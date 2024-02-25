Return-Path: <linux-kernel+bounces-80111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4927A862ADF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D068F28156C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA8814A89;
	Sun, 25 Feb 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSGrdNIN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872C14292
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873205; cv=none; b=GL30Dt5qFOOi53wfX5OYFXuBf5ojOw1iwm+07vFYpff/G+8NrlMVaN3TczOms1z4Tej08gy4LUyw8u6OM8SoyflYX57q1pETynVirjYI6aWJqWK+mdP+lkswGPZuiA84hNuBHfadlXoZ5RFju0bsDYQkXF82q+k7xUSQPuCxUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873205; c=relaxed/simple;
	bh=v/1um5RVar9lfHIiYBKMm3UP7u/wfUbuAs6nd5YLVZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E5DbAgjYSlHV8Q0chtaldzEYN6QLKVDa8TxFtyaysmgU1ZTA8RWoeb+fa//h/rEkp7Kcju19vLiPTzS7SYOtaD7CO1bPMqp/myJDRsHkjkSVhBKCQwCak8tpMbpubmJAh3McPc6cWJ+io1d6I38+CZ97OJp8NjjBIWOiK0n/8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSGrdNIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E5AC433C7;
	Sun, 25 Feb 2024 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708873204;
	bh=v/1um5RVar9lfHIiYBKMm3UP7u/wfUbuAs6nd5YLVZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aSGrdNINQnsr6bxDbxh4tza2MVbLCMYLLndCpkRlfVJq2pb8S+Jj4dcVl6h/3rifT
	 6QQI4iux20Q9CLowZh58WAQ7XGJjgF7Ck1iHHaYYWy7nQOlEERT6c0mBQ+60Hzy6Nz
	 cdImloRhrDai9hlV9Y3mVpGkx5n6YZDWtoVPO1pDIzlH3ciJY2IMvfR4EL24kudssV
	 Rn138Q1ihiqv7f96jy7/G9amaW/sqgfbjIckZOPnxtj3mmYvCm84xp5r0y/nsNeC2l
	 1AAW0HzSiRbsvc5/0IKqbwjYCIcjs2Zsqo7QlV/ROnCYfOp1+4Qtq42WcA9dtyYc2y
	 +qIW52LgQizNw==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 25 Feb 2024 14:59:27 +0000
Subject: [PATCH 1/8] regulator: mp8859: Specify register accessibility and
 enable caching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-regulator-mp8859-v1-1-68ee2c839ded@kernel.org>
References: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
In-Reply-To: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=broonie@kernel.org;
 h=from:subject:message-id; bh=v/1um5RVar9lfHIiYBKMm3UP7u/wfUbuAs6nd5YLVZQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl21XqkXCKhTdBGzeg12/P/43zz+1z+7XO8teGX
 0jonjO767eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZdtV6gAKCRAk1otyXVSH
 0KNoCACGPXWCCYY4hPTNzfz+xxSJ1j4eWWdwytpFcmB0KZMwSANfB79bGE42PG18kAy4dcxa+dD
 T5Lvvjv2HQwe4xozIuiq0xOQ5Kv+D3SyPRE02DdLORo89ygAGh8zJl2kI2jdUh131d2jiULrskG
 IagjBhNgJwQte+aW9M1UA2OtMxNi5MW/XI3TGqD+OBeqoOdY0RPwHiVKCGg3bvrZyWlE6+LvQKl
 SSxD9MK+yy/kLnfSTbP118ZKwrQA4wX4enXTZlifqQY05CjDNEzRiygFORYTPqmeVB+FN5qFAzw
 050t/6cpW4E5DUROtFxMWmaduENXe9VeFlJPhqp5y9WxxfV7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Avoid needless accesses to the hardware by caching register values that
we know, marking status registers as volatile as appropriate.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp8859.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index b820bd6043e5..689b56680d93 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -77,11 +77,47 @@ static const struct linear_range mp8859_dcdc_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, VOL_MIN_IDX, VOL_MAX_IDX, 10000),
 };
 
+static bool mp8859_readable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MP8859_VOUT_L_REG:
+	case MP8859_VOUT_H_REG:
+	case MP8859_VOUT_GO_REG:
+	case MP8859_IOUT_LIM_REG:
+	case MP8859_CTL1_REG:
+	case MP8859_CTL2_REG:
+	case MP8859_STATUS_REG:
+	case MP8859_INTERRUPT_REG:
+	case MP8859_MASK_REG:
+	case MP8859_ID1_REG:
+	case MP8859_MFR_ID_REG:
+	case MP8859_DEV_ID_REG:
+	case MP8859_IC_REV_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mp8859_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MP8859_VOUT_GO_REG:
+	case MP8859_STATUS_REG:
+	case MP8859_INTERRUPT_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct regmap_config mp8859_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = MP8859_MAX_REG,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
+	.readable_reg = mp8859_readable,
+	.volatile_reg = mp8859_volatile,
 };
 
 static const struct regulator_ops mp8859_ops = {

-- 
2.39.2


