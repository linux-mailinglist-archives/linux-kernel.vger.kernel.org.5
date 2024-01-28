Return-Path: <linux-kernel+bounces-41705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A2783F6D4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F3F281887
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8BE54672;
	Sun, 28 Jan 2024 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aaxh3998"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0854659;
	Sun, 28 Jan 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458332; cv=none; b=Lq9xoQI3jc5LRyZx9UjaMSu91360RJ1VNQcKdwUqmJwU1cyLEr4TnxOPie9vjofopN73SsDdoogU49uqycOSYI4mHpOfIz1fX2B960TqLsj/Ogb9hMCrvynZpVsfFRNpJappGpYP7x9MROyyWQfHZDZSb498lgVF6Zt6OlH6nYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458332; c=relaxed/simple;
	bh=VWY9NpPEAlb28+/OE3xDNSNkYn1A2yBpJbSReKpyaOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IouULJrBYN/pxYYh4v6PO1d9GdUJy6Mxi8nfjyJZqjMNHlEHN/JsmD2V1nyai/OMuAirkPXGY9G2ZAj96Pp7FNfLB03Ew6QHjZCtbzBg7KWoEqhcghcHIgslJQIQmzbqmQhDdjV9nFENw/UdlW2fsJ6B7ScUEpGnLkUOObsCr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aaxh3998; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60ACC43399;
	Sun, 28 Jan 2024 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458331;
	bh=VWY9NpPEAlb28+/OE3xDNSNkYn1A2yBpJbSReKpyaOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aaxh3998KnIRbX0LNfqdSC47rdzbqIaYcq4yJMvzAw7rQA9wop2juw+FESa9m5lqo
	 WUcwDF+tqvre5osFuNSPiVB9kECTBdU8QddEnYL2P4IGZJkOJJiFy+ahagKtpmf2wq
	 cegOXXnCUHgvC3GJFpItfZmcZBu+5oSksWx2Zz97numNfZ0sATlrRMHOgzaISklCNP
	 MgEavXMe/qRKBJR+NY2AcCNSmCD+z7VbE5IXCZaEv0JXj5xzBuf+Dbc//K6epbejuq
	 UXumVdoJarN1K0/7yFtVmRtZGCrG7ZWULdJfTeeimurbSQFQnLCuav4WWEcXchfLlX
	 wrkkgSzHLFIfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ChiYuan Huang <cy_huang@richtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 23/39] ASoC: codecs: rtq9128: Fix PM_RUNTIME usage
Date: Sun, 28 Jan 2024 11:10:43 -0500
Message-ID: <20240128161130.200783-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: ChiYuan Huang <cy_huang@richtek.com>

[ Upstream commit 35040410372ca27a33cec8382d42c90b6b6c99f6 ]

If 'pm_runtime_resume_and_get' is used, must check the return value to
prevent the active count not matched problem.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Link: https://msgid.link/r/bebd9e2bed9e0528a7fd9c528d785da02caf4f1a.1703813842.git.cy_huang@richtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rtq9128.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rtq9128.c b/sound/soc/codecs/rtq9128.c
index c22b047115cc..bda64f9eeb62 100644
--- a/sound/soc/codecs/rtq9128.c
+++ b/sound/soc/codecs/rtq9128.c
@@ -391,7 +391,11 @@ static int rtq9128_component_probe(struct snd_soc_component *comp)
 	unsigned int val;
 	int i, ret;
 
-	pm_runtime_resume_and_get(comp->dev);
+	ret = pm_runtime_resume_and_get(comp->dev);
+	if (ret < 0) {
+		dev_err(comp->dev, "Failed to resume device (%d)\n", ret);
+		return ret;
+	}
 
 	val = snd_soc_component_read(comp, RTQ9128_REG_EFUSE_DATA);
 
-- 
2.43.0


