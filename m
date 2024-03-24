Return-Path: <linux-kernel+bounces-113430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54B888444
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECC81F2A5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3701A995C;
	Sun, 24 Mar 2024 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbkSr/lk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0D1A9F7A;
	Sun, 24 Mar 2024 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320233; cv=none; b=W5Fl35plo2R+wsb1eWyR+JtB1QUT4Pd4g0FIa1LdodAjvUoOHxyqrxJ7MExAMSm1o3kWIp1a9fcK4Z4iUJm0gq/cHhbsPncI+mfeGbB0wTDbweE00ABdSYSXfdneWup2rV7nWW3GdN8YZJnzXnguXYp6hiDXEGn4FNxR6+5BPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320233; c=relaxed/simple;
	bh=S7BtX5WQhGbEetRp34J8AH8eiiHgB3tYhQu62wPDUz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV7Dg3vQM3nnm49iGzPFfODvuhPYbFef36+XcXVDXulIQ2jlRx0ICEZ8sfiP3M2TK1u3w3boEcOrtOInDHlVZEJ+2OAlG13bgIWE1oVuEW4mY3/6p8wn19Rq/brW45OFkgyYdm+VlxyGJYBAwg3RLQYWkDsiBykiRmfFs4BvyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbkSr/lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F81BC433B1;
	Sun, 24 Mar 2024 22:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320232;
	bh=S7BtX5WQhGbEetRp34J8AH8eiiHgB3tYhQu62wPDUz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbkSr/lkItcIYfJkjE1cpatyqOrQYnnbG/s+k9qAWH+D6u8wLdDlwK7ELozFHCqEf
	 Q+XtrszG3GdM5dzmN2/SzCEgMrT5DHrANmsf5aU+enWo76DqI/QlOcJ7E6laeJB8dD
	 yCNBStYaQY0PV6UMwMYRpGRgeXolc+dKw2go4TN6SlSLp1BMnaQeQpbfUnhEo0yZyF
	 pQgc1HwHXZlTeYeR9unzUOu7GxXBiTP/IAkazybgAOBIpOfdPwWgaxHs8AIu514RKw
	 CJDB5Q4bEVJ+82u8dPQvgBe1Pi7mAEv25yJvEG+ntNnszbp9RWsC/A6pxHBKEYBEOk
	 eHcvcMQrTHsWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 539/715] ALSA: hda/tas2781: use dev_dbg in system_resume
Date: Sun, 24 Mar 2024 18:31:58 -0400
Message-ID: <20240324223455.1342824-540-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit c850c9121cc8de867ce3ac36b9ae9d05f62bef14 ]

The system_resume function uses dev_info for tracing, but the other pm
functions use dev_dbg.

Use dev_dbg as the other pm functions.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <140f3c689c9eb5874e6eb48a570fcd8207f06a41.1709918447.git.soyer@irl.hu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 1bfb00102a77a..ee3e0afc9b313 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -900,7 +900,7 @@ static int tas2781_system_resume(struct device *dev)
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 	int i, ret;
 
-	dev_info(tas_hda->priv->dev, "System Resume\n");
+	dev_dbg(tas_hda->priv->dev, "System Resume\n");
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
-- 
2.43.0


