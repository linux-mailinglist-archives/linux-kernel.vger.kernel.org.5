Return-Path: <linux-kernel+bounces-113360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514E18883B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E648A1F24B26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4915E19C3AC;
	Sun, 24 Mar 2024 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX7BGfNw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826EC19BBB7;
	Sun, 24 Mar 2024 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320161; cv=none; b=UMYMjRYEppUCkcKBizUVo2ELMMUK2kYPd6Yu4tB1trWQXH0iLEKFtABx8QQ2qZwb8hlGhCaKeQ1xkpbvAC+W0ZDOC09v5E6c+V1OEVRk50qCVJXMhQp4//MFmH7+jesqieOngxkNZ96EX4Ijrk/Adz6LgmT4PCqDPoXSCKgVbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320161; c=relaxed/simple;
	bh=6NKZ+nns2FDi5/2LhPWcehmggKBZIPf/gzGtIL9UKCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyFX8YFVuIbSlxanDJIqV485fC/84m+lOBYu/aZgSx1reTkRloMrEVlqBUB/cdJ4hhNIQ+O0oZan8f1MQlHhS0sR0aCsgko9mM8t6DPaRSPE9MNo6sdCPwe7oCiuZUjQnV27pZpTadovVx1Xsj6C00y6Rz3WCEmYuPl5bIFcB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX7BGfNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB8CC433C7;
	Sun, 24 Mar 2024 22:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320161;
	bh=6NKZ+nns2FDi5/2LhPWcehmggKBZIPf/gzGtIL9UKCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eX7BGfNwGrsIeiIAhkUsSG8JKXTXL9R3jTPk0ij1Cn4gq0yCX0M8FyoiI/5MCx8gH
	 tPVKIXd2BFtBsrcwy5/oBOowyKEIzVdecc7EFxhKan9P9MAmpJHrvL9ckef24XmOyr
	 nvtw04flbSkCvNuSJ9IGXrfkab/OrHC+pqHDcRUWr7CS9NIGnM/9vfCC4bMFoPAouy
	 Lw35vy5bKIkufecBwjftfo5AlA8xV8/gIKEMfgeqobqLtgl6FjEiwDeeabGG1iX4Lf
	 Z0aB1EbYCUuEpvgCQoHTL1yqt6dumnaz9TXopaKHY0mrbpoFryXqyLNTD3pIWQRnVk
	 53XdkVhV4ibng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Guerin <adam.guerin@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 469/715] crypto: qat - avoid division by zero
Date: Sun, 24 Mar 2024 18:30:48 -0400
Message-ID: <20240324223455.1342824-470-sashal@kernel.org>
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

From: Adam Guerin <adam.guerin@intel.com>

[ Upstream commit f99fb7d660f7c818105803f1f1915396a14d18ad ]

Check if delta_us is not zero and return -EINVAL if it is.
delta_us is unlikely to be zero as there is a sleep between the reads of
the two timestamps.

This is to fix the following warning when compiling the QAT driver
using clang scan-build:
    drivers/crypto/intel/qat/qat_common/adf_clock.c:87:9: warning: Division by zero [core.DivideZero]
       87 |         temp = DIV_ROUND_CLOSEST_ULL(temp, delta_us);
          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: e2980ba57e79 ("crypto: qat - add measure clock frequency")
Signed-off-by: Adam Guerin <adam.guerin@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_clock.c b/drivers/crypto/intel/qat/qat_common/adf_clock.c
index 01e0a389e462b..cf89f57de2a70 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_clock.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_clock.c
@@ -83,6 +83,9 @@ static int measure_clock(struct adf_accel_dev *accel_dev, u32 *frequency)
 	}
 
 	delta_us = timespec_to_us(&ts3) - timespec_to_us(&ts1);
+	if (!delta_us)
+		return -EINVAL;
+
 	temp = (timestamp2 - timestamp1) * ME_CLK_DIVIDER * 10;
 	temp = DIV_ROUND_CLOSEST_ULL(temp, delta_us);
 	/*
-- 
2.43.0


