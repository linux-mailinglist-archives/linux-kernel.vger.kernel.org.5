Return-Path: <linux-kernel+bounces-144287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421338A4431
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6741C2181B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D6C135407;
	Sun, 14 Apr 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/4k9JbT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719036121;
	Sun, 14 Apr 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713113237; cv=none; b=LXJPhCq+om1f/XxWLJPvHkuBeBiqmfg4x2GlxOTgqn5Q/42yVkDBSN+bAIaZKdjMP8a4fHpPSmjqFoXK2PUz1xfmCUttxYXL41cIi2xCQGrykd3fzGzbYUQWouIiiVbs/7OG3mJLlNDe0KgZdQB4EEt8GhP22PhfKN4czZWDvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713113237; c=relaxed/simple;
	bh=AolP9PgyV9zpndfsjC2nvy9UABqdvDFwC4+BmEHkEUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RMaFzraqc/0knVyzwax3CsBXzJikT+sn3FOKtrk/myXajTWTD25MjCzNT7bZwWpYVQsASyIFobJ21baRs9IMf6JE9NDJTDQgJm6sOBx9l9rciF0A4tpnL9CrwYd1mg84mMqIZn78DBhHvpODHfgf0PBd+fQRoXUzgFaKT9rx0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/4k9JbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391CAC072AA;
	Sun, 14 Apr 2024 16:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713113237;
	bh=AolP9PgyV9zpndfsjC2nvy9UABqdvDFwC4+BmEHkEUM=;
	h=From:To:Cc:Subject:Date:From;
	b=d/4k9JbTnLVkVTRpjTZb2INcZaOAXpFw/KFwA/VedWLe0UVj/gaKg70QYMld2vX3w
	 b21hxKnFPonxK3UB5fvHAawx0a3Isogh/QWpfUffQiAb/Ei/Q3emBIsqyAw0QLTyg7
	 ivAJxtx6OLhbPMKnM1KQ5TTkuON1ndUx7A0zBp8D3n0teiwgU2e8JL7L9ebK7Z/QhR
	 K88PBZBA3SDIEC8e7LInNnous1m77nz/6TVkPA0SHOiJZqX7ZZs6p3h+3HEJ5wlPJS
	 2faoAp+tFH/uhYSY7bRXFfw9wEoDvJU/WZR6Trx9Roi4u8yE1d61meVWrZVZyyAdBN
	 62zIU3LodlSDg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] ASoC: amd: acp-da7219-max98357a: Constify regulator_ops
Date: Sun, 14 Apr 2024 18:47:03 +0200
Message-Id: <20240414164703.239851-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neither core nor the driver modifes 'struct regulator_ops', so it can be
const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 84f3d65ba52e..77cf72082e73 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -733,7 +733,7 @@ static struct regulator_config acp_da7219_cfg = {
 	.init_data = &acp_da7219_data,
 };
 
-static struct regulator_ops acp_da7219_ops = {
+static const struct regulator_ops acp_da7219_ops = {
 };
 
 static const struct regulator_desc acp_da7219_desc = {
-- 
2.34.1


