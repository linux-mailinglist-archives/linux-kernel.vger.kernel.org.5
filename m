Return-Path: <linux-kernel+bounces-99401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF0B8787E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10711C21712
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067160BB4;
	Mon, 11 Mar 2024 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfnVScOu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0854F92;
	Mon, 11 Mar 2024 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182305; cv=none; b=cZCeAoq9l4zJ8AgKm9AsqNSh17UFXgXzoHM0b4fYbbklIQmcmBXJzPAU0U+Wqch2qQX7CeWSsRoJhbUmBMyekpC6iCpdH/ADR9YpyryI3glyJ7FWau82epjbznDRKxQ37T/hVun8f2JuqEws+8d0M6+RqfHVDLKubf+od8SoQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182305; c=relaxed/simple;
	bh=6i6wxaZzYQIHnPtoUFQzJHucGTNeOHrxMItXv93pAgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvAcLQAgzdYtatL+R4hLtmcWblhn/yXz385rJCp8x7ALCx6WlSAlUgwagVz/QUKmMD1a/ykCQUQaCkR4dYN7qX6iEwC4isUZK0zXP0bUAjZTXeAd+8u2McZkViVVrl304+M8WVMrExnem2PtHJrm5w1gRivJRYjVTmnvdykTp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfnVScOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE713C433F1;
	Mon, 11 Mar 2024 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182305;
	bh=6i6wxaZzYQIHnPtoUFQzJHucGTNeOHrxMItXv93pAgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfnVScOudG9GBttddhPMiypPsv5PpD3evz7o4TzKVwsPyp97RIjfGf5APCl/977uR
	 sKsOpq8J29/V1UIJ7Cg8BdyNuSNVa57BoM/dB6fcNgYnXXy48ot2NULMFbqvbzsNq5
	 EnNOnkOSMIahJyYyeBOQMJhHMIJgYt0dZCOsyKaPvVa9kMcBM/BOv1O47dS/+Gdq+B
	 YlFGWPvKsw2dbdBtyJuLvbUtlLrVn96AVXEcm8vUGJpcYcfNDI2hW0BfBRt2E+XmsD
	 iOLCpXnyILISZ5AlWNZSSo4sz3mUNIgiAC4rtSaEd38rCRfIGTxW7WU5My1C5gCJcZ
	 QLS0OL7FT0BtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.6 12/12] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:37:26 -0400
Message-ID: <20240311183727.328187-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183727.328187-1-sashal@kernel.org>
References: <20240311183727.328187-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
Content-Transfer-Encoding: 8bit

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 96e202f8c52ac49452f83317cf3b34cd1ad81e18 ]

Use source instead of ret, which seems to be unrelated and will always
be zero.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-5-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 914f8eb418357..4f50b07848fd8 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2933,7 +2933,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0


