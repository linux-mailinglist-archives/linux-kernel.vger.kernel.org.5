Return-Path: <linux-kernel+bounces-113793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD578886A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059B01C25BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE551E4A11;
	Sun, 24 Mar 2024 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjAbnaui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB71E5856;
	Sun, 24 Mar 2024 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320831; cv=none; b=kQQVurSB1D0oDrwNOoaLps8E4GZPa3Hh9Y2hT1YvAqoNvxsgqsdViZEfmxT+7HyOMJjKQnRkyxoKSfNfkZpAaP/U+1ucHuriCkhkrP3+oq0nFImJFEZVvac4U9Oa6mLN3EwoijuvyPDqe/tXdWmcCYfUj+W9tzN5f96/+FrvRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320831; c=relaxed/simple;
	bh=xx4kwvzAxT8EfZAIHWdVzcLqTUvuj8Q6VMgCYvPhFCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acSbmWXurrpKeZm5X2sIvigayx5w4Ic/Bkf+Dvhxvcvw7xduEIFVcjIOoKEW6N2R1/dsMQIy1bpEMZuAFvqIKOOAHnebANH1TQfSbpnc83DiW73jEjK587jgvu3lx6r8mkKmxhpLN2VqbQbpddhPirX6TiFR0ccZc4nMG8eVkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjAbnaui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7191CC43394;
	Sun, 24 Mar 2024 22:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320830;
	bh=xx4kwvzAxT8EfZAIHWdVzcLqTUvuj8Q6VMgCYvPhFCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjAbnauiifz0+8vEmJCbUZWjB2HNSWNBHvNEf4i4XkdywBUAouD8Dz2V6l9u6Btem
	 JAQr1NKCqptJP0FbqoGPhgBsrm7/roFvLEEX4uMxi+uXOKesXv8Tw8EyM7z67nkBjc
	 dfzAD6eZOqCNnlkWtlxZIMtI9XiBdH5m5Sn4BPfW7wmKTj5qvWcXKbKjUDgq3bUOth
	 cJywLWkvxI0mVBXnlzX21E2dZBpUwdYyJvWz9uY6t4whv4onIgy5MuAfnNPXqPgjqd
	 4aYAr/CHzOgQzrqrkG08cTxI3k4i/VcU3tRKTDWtnyveuqx40HKIPMZDUFXkC7MLuO
	 ORVHnfD8YHwbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 395/713] drm/tegra: rgb: Fix missing clk_put() in the error handling paths of tegra_dc_rgb_probe()
Date: Sun, 24 Mar 2024 18:42:01 -0400
Message-ID: <20240324224720.1345309-396-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 45c8034db47842b25a3ab6139d71e13b4e67b9b3 ]

If clk_get_sys(..., "pll_d2_out0") fails, the clk_get_sys() call must be
undone.

Add the missing clk_put and a new 'put_pll_d_out0' label in the error
handling path, and use it.

Fixes: 0c921b6d4ba0 ("drm/tegra: dc: rgb: Allow changing PLLD rate on Tegra30+")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/0182895ead4e4730426616b0d9995954c960b634.1693667005.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/rgb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index 53c492b13d129..1e8ec50b759e4 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -254,7 +254,7 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 		if (IS_ERR(rgb->pll_d2_out0)) {
 			err = PTR_ERR(rgb->pll_d2_out0);
 			dev_err(dc->dev, "failed to get pll_d2_out0: %d\n", err);
-			goto remove;
+			goto put_pll;
 		}
 	}
 
@@ -262,6 +262,8 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 
 	return 0;
 
+put_pll:
+	clk_put(rgb->pll_d_out0);
 remove:
 	tegra_output_remove(&rgb->output);
 	return err;
-- 
2.43.0


