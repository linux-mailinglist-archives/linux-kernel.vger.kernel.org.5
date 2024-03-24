Return-Path: <linux-kernel+bounces-114569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B0C888B16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822951C28FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0D822F4F1;
	Sun, 24 Mar 2024 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOBfIDDm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503122F8D0;
	Sun, 24 Mar 2024 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322214; cv=none; b=tnh3fn5Abl5g39QonZAi6UHpk1kh+h7lKqCwG7xHN9glsEa0anl+FLJmIZulCFQc7x5+xJB/NzWkQic0aTuVFbnLolU53x5RgzEk9IK3bd12EcZGOfK6EeJTSXw7ZV8xdIfR/XSG4wfb74pPP0WdJ9MMjWLwdotmNi0vly9OcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322214; c=relaxed/simple;
	bh=BUaEXJZUG8etbIU7z42ZW4ULk/Wh+ZSN13xgmYO0WqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNqoiyPW7+QEMHlFWmN9jBdRIf+EsAq3hScvW8qHqO6jdjYv6KAsaPr6yHEk22Ef3O0/Oo+sNsDqoaRAIzFKLOXyas8GES1sW6HJ6XFLxApk8DC9InjLrupkiFtgao5hCYYFgCdtiFJriFsWYpFcNI9FeLrrA4ERj+aDuhKfm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOBfIDDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE95C433F1;
	Sun, 24 Mar 2024 23:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322213;
	bh=BUaEXJZUG8etbIU7z42ZW4ULk/Wh+ZSN13xgmYO0WqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOBfIDDm8Z/KEyAQW1sVlj50TAVNSv6Rh1uK4msq7A7MY8nY5v+XQOTlIUvSqGkVa
	 5c4Vvnmet65xeZvpomL23RgPLWDK3sbAi/jPm2RZK5rN83ZIuyblaWA+rqwYRHOKHU
	 Uc/ygwo6GBRVhwIOe1Dq5gM4T5y43MjaZHiUHknIRUDFsv05ptEYCLRAxfIIxVROFP
	 Xgz22LHNT3+CKxLyls2To1957wnwA/Il1r3D9v6QY+6+7l/GSU096IjzMbkXP95sUv
	 uUNELb1n2Veq1KjKW1FmDV+8tbn9fUMPopE0VQo2OlJjUxR0NLrvs8HoN/FG4mXGZX
	 3rdXoXWbXiLxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 293/451] ASoC: SOF: Add some bounds checking to firmware data
Date: Sun, 24 Mar 2024 19:09:29 -0400
Message-ID: <20240324231207.1351418-294-sashal@kernel.org>
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


