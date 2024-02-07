Return-Path: <linux-kernel+bounces-57083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E784D3DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEE2282E53
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BBF129A79;
	Wed,  7 Feb 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa9wGBg0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EEC136667;
	Wed,  7 Feb 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340941; cv=none; b=k8PhhAottm37q81WufpVYGDZ5ajWkXXLtR6CQKiuYw3WG0R77vxpJRvgMr1mqxaguAwwNCVVne9sTii8nnHgDSTadQk1u8hbg8hoKp0478djYtcxiaVRe1WGciMEZ3xQrziTjDhgKEgUyKgcvvZEdoqCPb0GoZSjhb9JciVSMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340941; c=relaxed/simple;
	bh=7tDtXXLhukjCThdDgcFeym7od/Dd8RgO6dXE6j133no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSUhN3+V7KnqQ8/fD10TgO9pM7tpkjwdqNF+RWhrAdwBji+4WPAomfPzcwEC2xonzlq5rM3IE3V4PMp/fqMTHrLSqNjrW6rGfSU3W9Ugrsq+fNf9d9uqa2+GouEMN3zVXV75F2N8wKxEx2eVFCRR8iN8hH1Bw8utoNe3Mh79Tu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa9wGBg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90A0C43390;
	Wed,  7 Feb 2024 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340940;
	bh=7tDtXXLhukjCThdDgcFeym7od/Dd8RgO6dXE6j133no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aa9wGBg0PO3gfMCarp/B9PbtUUR3MMWpcad3HpQ9ieuIKBLsbkwumpgtZn8h2t23D
	 81JfL7b4szrAufXZM4zzxmJBrlWiE4iSEoEbo4AeGBeLYBtBEmIWtdrvF3Apz7kstR
	 /4M8kGm3inAUKdm40Va7wiJqLINSPSwNVaogKz9Hpvfw5eYYDrXe4Vo+8NllWek2KI
	 LNACk4LgDwLVqF39KTvBcrGuvA9oSLt13lDOVabRg9OBNeiZtpsAEDDWlY26QTNgqY
	 iGKJRcID1c83NP4noxzSu+p2JOSCicw1Fj/IwP2tugHsYpF3ye/3jO3ZkRnByMf2t2
	 0DaE1yFFxXCxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.7 19/44] regulator (max5970): Fix IRQ handler
Date: Wed,  7 Feb 2024 16:20:46 -0500
Message-ID: <20240207212142.1399-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index bc88a40a88d4..830a1c4cd705 100644
--- a/drivers/regulator/max5970-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -392,7 +392,7 @@ static int max597x_regmap_read_clear(struct regmap *map, unsigned int reg,
 		return ret;
 
 	if (*val)
-		return regmap_write(map, reg, *val);
+		return regmap_write(map, reg, 0);
 
 	return 0;
 }
-- 
2.43.0


