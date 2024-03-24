Return-Path: <linux-kernel+bounces-113321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B348F888364
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37B51C23837
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816E194C63;
	Sun, 24 Mar 2024 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9eXcbaM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FFE194697;
	Sun, 24 Mar 2024 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320123; cv=none; b=aNzgJMl1beVKkImBCN3ydip8cW0ZxP1pTkWg9+KcWoTdbOQjeCrvYAe1uuuh2m3D+mV/SqnWhlmVEdu3dw7WnAKX/sdqb4ePkXq9lYprEuwJFmLfNjc+yaObOnPdsSCTfbrYd6C5p5xb29BIoKeDuOuRgaHCgB9GcsS4Sop0Mis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320123; c=relaxed/simple;
	bh=BUaEXJZUG8etbIU7z42ZW4ULk/Wh+ZSN13xgmYO0WqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLgNgBXv8TchT4Mnw/vfKaz03oKM77JwDkeLIRcJLDCn/FJIG6RfBmvRn37i41PwbvahdmvTqHlGfOsBQ+CWL+6X51qph5zbMyAtemqJAQVvT4Kj7TnRO/3koIw3Tpdz9QqunA3iYREBWd9Y5VRSX9JHlU2uIVbhT/os/8O08Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9eXcbaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5457BC433F1;
	Sun, 24 Mar 2024 22:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320123;
	bh=BUaEXJZUG8etbIU7z42ZW4ULk/Wh+ZSN13xgmYO0WqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c9eXcbaMdNTMSPTX1pktnpBYnQdqcCw4ag/0y1zx/cZec2MFFs/X5BFohiAxD2bw8
	 BOE9/q2KeTRactk/rDIUkwOK9WVzHD3l2mk88ORO6bbH3/Ul7ZtcyVCMA72NZ1aT9X
	 abVZ2xzFee5BEcpABYAcnslR3iVSG1VJstznOghQecIANoj+NaCARq3PNSk47B54+Y
	 6bsQyN2NctshWZ7OOmT4CAdcHSvPrAQ8OGNjwQ2rp7teLPh7U/lR1s2fIG7KrC112P
	 G5L1bC0nkEEzUXW6Xs2bkcx1f9vhNM2KQb4/Ku755MXH3Y9C5okl9fPpCIYFzEs5pW
	 ImX31WtnJKqMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 430/715] ASoC: SOF: Add some bounds checking to firmware data
Date: Sun, 24 Mar 2024 18:30:09 -0400
Message-ID: <20240324223455.1342824-431-sashal@kernel.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 98f681b0f84cfc3a1d83287b77697679e0398306 ]

Smatch complains about "head->full_size - head->header_size" can
underflow.  To some extent, we're always going to have to trust the
firmware a bit.  However, it's easy enough to add a check for negatives,
and let's add a upper bounds check as well.

Fixes: d2458baa799f ("ASoC: SOF: ipc3-loader: Implement firmware parsing and loading")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://msgid.link/r/5593d147-058c-4de3-a6f5-540ecb96f6f8@moroto.mountain
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc3-loader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/ipc3-loader.c b/sound/soc/sof/ipc3-loader.c
index 28218766d2114..6e3ef06721106 100644
--- a/sound/soc/sof/ipc3-loader.c
+++ b/sound/soc/sof/ipc3-loader.c
@@ -148,6 +148,8 @@ static size_t sof_ipc3_fw_parse_ext_man(struct snd_sof_dev *sdev)
 
 	head = (struct sof_ext_man_header *)fw->data;
 	remaining = head->full_size - head->header_size;
+	if (remaining < 0 || remaining > sdev->basefw.fw->size)
+		return -EINVAL;
 	ext_man_size = ipc3_fw_ext_man_size(sdev, fw);
 
 	/* Assert firmware starts with extended manifest */
-- 
2.43.0


