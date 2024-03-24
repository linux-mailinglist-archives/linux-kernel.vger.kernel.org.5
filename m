Return-Path: <linux-kernel+bounces-113842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF78886E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B3A1F255C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E8D1E8907;
	Sun, 24 Mar 2024 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz5ACIru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB51E9653;
	Sun, 24 Mar 2024 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320899; cv=none; b=aMDkd2D/9E8vRl7KVYCN0lw86GspZS4CwtswTfNxzkmLRyey9l34v1JKyYesPC/ccajAduQCpdIPQHDkI5BAPBS9o4faYTL6Fu74YDSMvKalLMZrllPCpQwfTwCeQjJM8zCUUxgzgdQ6NU14LrVBCIKbP43uzhBzy1VXFNsGEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320899; c=relaxed/simple;
	bh=BUaEXJZUG8etbIU7z42ZW4ULk/Wh+ZSN13xgmYO0WqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Alk0f1yS+frJWr0suEoPmCZMhfuDp/LcdNmkNoCw7dvpQzcg4twCb7TZ+eGKdtJXt1lGHwxhEspmOTBFFSn7VP+Rlc3JYM31HZpF397KGHhlnaH/aogq1s7omlSkZ3DSe2MxZHglbJ+wP0iv1uYZcCOe5kCqUb53MN95LExXWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz5ACIru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86CAC43399;
	Sun, 24 Mar 2024 22:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320899;
	bh=BUaEXJZUG8etbIU7z42ZW4ULk/Wh+ZSN13xgmYO0WqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oz5ACIrude7WKhFMQiM0Ic3t4IBlBoPoUXk6gatTLvIxkTx4xl6wRsLG0qDQOE8PA
	 P5PB2FcjymHuVClK3Qg7DdlZbYf4VM4zpSsckwD67u9r7wc7IEsblg2rRH13Okjk2Q
	 bQwNl7gb1F1/DLch+NsA70iKgFNVL6RgEZ4/fJDNnRS0dShTSbe9cQ6g1/47OPl/l0
	 hjV+SkuOIGe4fVDyIfoO5ihMW2Wd/3E9hzI1Mn3TZ8eGK/L9l4IYRjxzh79GkU9gny
	 ZIbql9pcXBX+qc+jxzT/YDL1W2ob8qAvfwY5PfbEwjc5hA4Eaplwax+Hnpel/Y+7nG
	 rDgnYGRV4j8mA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 462/713] ASoC: SOF: Add some bounds checking to firmware data
Date: Sun, 24 Mar 2024 18:43:08 -0400
Message-ID: <20240324224720.1345309-463-sashal@kernel.org>
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


