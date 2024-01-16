Return-Path: <linux-kernel+bounces-26762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CECD82E5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860501F27906
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7644E1F614;
	Tue, 16 Jan 2024 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMo/Etuo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5343AAB;
	Tue, 16 Jan 2024 00:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3013AC43394;
	Tue, 16 Jan 2024 00:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364782;
	bh=NxpqsO3yj33VWaO2m8CzkxJFAAtKW59jzjIbaK632fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dMo/EtuoEeQAgMC8SYBR/juN48Qdtu5mUtfWml9HCSP9oaJAIzBCkJVKYANCrs+Z/
	 c/l8dq0geqA2lioH3Mz8js9659u/uHmd2Z9pell218qRf5/phiAK8gVEUUvBidSsSD
	 NM8wJcjx25t17utdiDKy4nMF3zMZJILY48XFdp2AwZrA13CJgu5Wc79U1V+PSgBL3d
	 fVgzOdZKOXiS2eCI50s8XW7fSIsxi7cmtwt+BJIhUvy3ICBiGdGifOWWMbJ2hii2XQ
	 rA05jutzMU7E71h2k9bkcfS5NFHeaNE93ZuSYZFv2n+Gc7+/SBpD5XSrovVSGhnIn7
	 o90O4ccM3VBJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Weichen Chen <weichen.chen@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	angelogioacchino.delregno@collabora.com,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 07/13] pstore/ram: Fix crash when setting number of cpus to an odd number
Date: Mon, 15 Jan 2024 19:25:43 -0500
Message-ID: <20240116002603.215942-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002603.215942-1-sashal@kernel.org>
References: <20240116002603.215942-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Weichen Chen <weichen.chen@mediatek.com>

[ Upstream commit d49270a04623ce3c0afddbf3e984cb245aa48e9c ]

When the number of cpu cores is adjusted to 7 or other odd numbers,
the zone size will become an odd number.
The address of the zone will become:
    addr of zone0 = BASE
    addr of zone1 = BASE + zone_size
    addr of zone2 = BASE + zone_size*2
    ...
The address of zone1/3/5/7 will be mapped to non-alignment va.
Eventually crashes will occur when accessing these va.

So, use ALIGN_DOWN() to make sure the zone size is even
to avoid this bug.

Signed-off-by: Weichen Chen <weichen.chen@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Tested-by: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Link: https://lore.kernel.org/r/20230224023632.6840-1-weichen.chen@mediatek.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/ram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index f3fa3625d772..e15b4631364a 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -519,6 +519,7 @@ static int ramoops_init_przs(const char *name,
 	}
 
 	zone_sz = mem_sz / *cnt;
+	zone_sz = ALIGN_DOWN(zone_sz, 2);
 	if (!zone_sz) {
 		dev_err(dev, "%s zone size == 0\n", name);
 		goto fail;
-- 
2.43.0


