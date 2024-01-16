Return-Path: <linux-kernel+bounces-26775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962D82E60F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18460284190
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0F35788D;
	Tue, 16 Jan 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNydv1QC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20357876;
	Tue, 16 Jan 2024 00:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0414C433A6;
	Tue, 16 Jan 2024 00:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364828;
	bh=PddBw6uDzqipD7P9eSsG2zgouGOp/A1QGYqGB+hWYys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNydv1QCOaiW2k5jGEUdEODQucaEZ3TsDUxTxvHuQFj8F3TOzbwIO3/vFjRkLeSW9
	 LoEQVR9K7vckp4e0ilET1e0NWaTNpVQwcsMPJJzFFS1eLfyL/hHmbxqrJDqmZDxa7F
	 KW8IBGVhYnFgeRMe4EosouY3RjjN8N8iuAy4Rt8jWsOGzomou7dedEtg/f24gbs9+6
	 l5b1C4Wwh2pfx8ATAsGOuFPueHvUBq5tWgI4S8k+1DJpSYtvY98yrgkoI7JEXLsMl5
	 16dbAUpGnUbeuBoEqY8kwktsCTJS9Fl0dbvHm4gkZ5zeRTOV5fzaBSjYOjkV2Ds8Wu
	 5oaFt86M0piFw==
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
Subject: [PATCH AUTOSEL 5.10 07/12] pstore/ram: Fix crash when setting number of cpus to an odd number
Date: Mon, 15 Jan 2024 19:26:32 -0500
Message-ID: <20240116002649.216260-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002649.216260-1-sashal@kernel.org>
References: <20240116002649.216260-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 98e579ce0d63..44fc3b396288 100644
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


