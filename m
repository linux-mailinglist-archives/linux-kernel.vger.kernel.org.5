Return-Path: <linux-kernel+bounces-114048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8C888812
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11D21F265A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F701FC108;
	Sun, 24 Mar 2024 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPjyfK2G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5CB130AC3;
	Sun, 24 Mar 2024 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321341; cv=none; b=txs6RiukfeisG0PRpbcR/nPPZGCUrXZNEAlS6cU7Xw85HVN13yoCjfohRXA0sZZLNIuHZYj7uqCI9PTYyYJ1g08X8TdqocGxcNkgGc61mFHX9vgxhuNARvPw8p4DU1V/tTA/stxO8tknSu4Qaw4/jcEraUoClDB/XRdEx2RRUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321341; c=relaxed/simple;
	bh=g0bIDGsnLq4XPpGnk9HQAmPP+fiIyU1Ypk3bcF0ztd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSL1JynK5BOCUQtUcPu3kE2LRiteWGxQPt9d77ToZbcATfQwjHjQznqyrZW5gW722eY48OGnXzURVSDW31ndf1OZz40KwJxMGVAsVPtC/h6/YQAXZlNqr1OX6nx7zktSjEVghOkAz3LbU6DhGyOCnBR/PN63BeIiDSXIGRCM88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPjyfK2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DA1C433C7;
	Sun, 24 Mar 2024 23:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321340;
	bh=g0bIDGsnLq4XPpGnk9HQAmPP+fiIyU1Ypk3bcF0ztd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPjyfK2Gja47pXwH4Gbb/wQhgLhvneFGSDTyyS8lsWRD98er6yr/FrRWZMwom8B+u
	 UN+R6pxXL77afQ+6iqr3WYKKHvJqN8fCbvJVWCZ4Bf/OiM4PsHA+5VBsyJMsPx1DME
	 iooSbHeD3TsDgBaVZGgAE+lOO5DepiQsTyksWHji3Z9gJEYh+5udeSS/8qc5mBcjB8
	 GOkf75GqYAcj+cArw/I0ld4RJN2lL9B/sixUJuNn4plBBcf4m5KsyqNypcWC8PDcmG
	 ivv5roVSsQKbxr3k2bDeSscaO/u+vM4vJG/u/s/xIQH0fuynCYiVzi5kZsOeejPM3V
	 /y2biPaPbmsoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 064/638] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Sun, 24 Mar 2024 18:51:41 -0400
Message-ID: <20240324230116.1348576-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 03c7874106ca5032a312626b927b1c35f07b1f35 ]

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-1-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 83ce5dbecc45d..d444b7776ece1 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2914,8 +2914,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 	switch (fll_id) {
 	case WM8962_FLL_MCLK:
 	case WM8962_FLL_BCLK:
+		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		break;
 	case WM8962_FLL_OSC:
 		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		snd_soc_component_update_bits(component, WM8962_PLL2,
+					      WM8962_OSC_ENA, WM8962_OSC_ENA);
 		break;
 	case WM8962_FLL_INT:
 		snd_soc_component_update_bits(component, WM8962_FLL_CONTROL_1,
-- 
2.43.0


