Return-Path: <linux-kernel+bounces-57127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6852D84D449
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA320B25237
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6076114F9E4;
	Wed,  7 Feb 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXzSJrCY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E314F9D8;
	Wed,  7 Feb 2024 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341052; cv=none; b=Vph3qXg8LiBhStZhYJasXrayKNJ1SwU/7/+GaXK2wt+EkUJR6HU9OfSbkhh19yF4ppnO0RxIghBdGt5idQUk7BuDOoB5MOBHgfqmJmcJVFh7C9b9Qhq9UQ+KJTuuUD7yoq6WEJ6icKVDB75cwTNyfXAT++q6XYt5lsUvXqynw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341052; c=relaxed/simple;
	bh=TWOysI0DhXj3gs3UF1lbIc/ZOque/tFNGwms9Q+WRBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFy54f1J+xK0LNG6048tFRO0ddP7/y5F7JImhrcAIVB8INFmBPdmJAVioEH5kYUmMqAyj5zXZ0l70tclfELFVwjqi1yCKvhmoniaTO9VgXlPq+JleQp2GOKsRlKFo0b5jLvVKjDLwh6ViJVgNCGa8vGsFco8mvHg33EDAT3N55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXzSJrCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23467C433F1;
	Wed,  7 Feb 2024 21:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341052;
	bh=TWOysI0DhXj3gs3UF1lbIc/ZOque/tFNGwms9Q+WRBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXzSJrCY3PxdqLqlws6kt29s40p+9BiGyl8bETx1I5xk+x3l9wpnTn2VOIXQlYt/o
	 h+RS/Mynn2U9UURzcKsmFFaQvGRaf07bisuMqNFIY1Je/0wsqRkEQL1tgBJI1F65QU
	 9aqj1sP9yr/wcn0azsf8m+5W2OzPEtKzL4/M1S2WCe5dtQqmVjtjQQgzOj1btPcQz7
	 uc9mYr8wSHtR+eNPGmtOWwkfhyqB8MRzlh9fhWCypNf7NltTu5LNLJBE3Bq2q825+x
	 y9BmU1BYLqBIeouGun6+O7aTdyfQ2FKNftnG2EJsC0YQ9gxnv8Cpt9e95X6wugiIVx
	 U39b2cKyZxkVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.6 17/38] regulator (max5970): Fix IRQ handler
Date: Wed,  7 Feb 2024 16:23:03 -0500
Message-ID: <20240207212337.2351-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Patrick Rudolph <patrick.rudolph@9elements.com>

[ Upstream commit a3fa9838e8140584a6f338e8516f2b05d3bea812 ]

The max5970 datasheet gives the impression that IRQ status bits must
be cleared by writing a one to set bits, as those are marked with 'R/C',
however tests showed that a zero must be written.

Fixes an IRQ storm as the interrupt handler actually clears the IRQ
status bits.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Link: https://msgid.link/r/20240130150257.3643657-1-naresh.solanki@9elements.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/max5970-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
index b56a174cde3d..5c2d49ae332f 100644
--- a/drivers/regulator/max5970-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -265,7 +265,7 @@ static int max597x_regmap_read_clear(struct regmap *map, unsigned int reg,
 		return ret;
 
 	if (*val)
-		return regmap_write(map, reg, *val);
+		return regmap_write(map, reg, 0);
 
 	return 0;
 }
-- 
2.43.0


