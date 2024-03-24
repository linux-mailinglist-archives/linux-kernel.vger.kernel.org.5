Return-Path: <linux-kernel+bounces-115971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622BB8898E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9342F1C31851
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772283949B1;
	Mon, 25 Mar 2024 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvLuKEgH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54206232106;
	Sun, 24 Mar 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322259; cv=none; b=a4d6XJVi4qQ330krPRrgPwf6IIDPeBEpNiwGQQdvVUWL8fjFCSQ1CjG33iks04e+98OXp68x3W1k77OViyyce1n/KHQD+YqDAM+LO/7tCmer1ijIV5q59KdCmR1zApn+j9MY+up6FPfF5a/oUP/k8ZuwcuTtBqTf55zf+WfwEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322259; c=relaxed/simple;
	bh=aLVdbHof967+A7os53sAyGT6DPP+RUzjhhVJB9ZfGww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blBGUYzs/ylsPgcAFVLpNfUePgTfdOv+SMDgxCC3peH5BthrOwiSkYELBkSLh89oUwhL4XqE5rLAPaiJXEXbmDG6AarsEZxIFbEyDhsOasCcK0sCWz4R2DbhIu8ChlBYM4SOUWyuhEhXMmcFFjmKF/flxLcWK2Zaupv5mz9jDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvLuKEgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C858C433C7;
	Sun, 24 Mar 2024 23:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322258;
	bh=aLVdbHof967+A7os53sAyGT6DPP+RUzjhhVJB9ZfGww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvLuKEgHAyesMwYJHGVwR5uEJt0aWOdTgqECDiIWCML263UgOfQ2eRbtwOEtOhE61
	 h0DjyvG45ofckGWQR2SU5sCCeI0XX4isJGs7KbStJpgVPF37tZM2WAR1Hc9PLQRVx4
	 Sf/E22anZNBZacGnPLD1/oTlpK9JOsSUcoZYPYEsNsQ2St9Qq3QHYPaWjL79MoPaNw
	 h+/WkyGtRLr2VF/PDgU4rYbZpKTCKgKCWayJ77VVLHFXvYnSEFmf75wONG67NMorK9
	 696hC+b4dajamoOvq455AsyH1ccowRls/T+MiWmthlcGr6gqXryD8tV/SAtiPT1ALU
	 jTtORkPkBCeQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 341/451] backlight: lm3639: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:10:17 -0400
Message-ID: <20240324231207.1351418-342-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel.thompson@linaro.org>

[ Upstream commit abb5a5d951fbea3feb5c4ba179b89bb96a1d3462 ]

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: 0f59858d5119 ("backlight: add new lm3639 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220153532.76613-3-daniel.thompson@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3639_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 6580911671a3e..4c9726a7fa720 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -339,6 +339,7 @@ static int lm3639_probe(struct i2c_client *client,
 	}
 
 	/* backlight */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = pdata->init_brt_led;
 	props.max_brightness = pdata->max_brt_led;
-- 
2.43.0


