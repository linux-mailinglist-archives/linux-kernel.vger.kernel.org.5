Return-Path: <linux-kernel+bounces-116072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC484889557
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7651F34A19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979A42892A1;
	Mon, 25 Mar 2024 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipXR1IFv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFD27A834;
	Sun, 24 Mar 2024 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323491; cv=none; b=T3O0TZRsEXt2vHeTFke3Jmqj5FZWBDZqjs/rXg05g+Nxcp/cB5steza+UyZ8cnzV9btb2qaGrKv1L+iqHZDRIV9kYRvStZy4W+nnaNurUyppmb1Ijf1yIRNErayorpCPDpBs9rdrjqnXVD7lsRs2r0C6qGehn89e2x4Sjo4hTgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323491; c=relaxed/simple;
	bh=tKj454ypPCbhkDrsMDWUObexL7a78f2S5jbHcsMACmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on9mwN1e9TT1STjH0QRnOGwMI087AdbnZF7EinB6AcKmOxSecAqTzBXfML/9EF7EfIdl9WNK8W55VwVYC7ewwaIR9Q8F926yxhjsIoM7kwKzT/ba3spd1Y8YCVHp+lG0AF3bA8Sh5q6s3H0n9XBObo9E30G9tVnDeqW4UgeNMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipXR1IFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FBDC433F1;
	Sun, 24 Mar 2024 23:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323491;
	bh=tKj454ypPCbhkDrsMDWUObexL7a78f2S5jbHcsMACmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ipXR1IFv+xoaHZRpijhWdjvg6+i3gYtaiUdfkczgY6Id6HYlCduyZE9Ng7MQwofOP
	 NkM0/b8rZvFNstmrcS4PLe4n822QO7cM+5bYtTlO7r+Ji4ddkYNxQOM8tT4SDdZEIb
	 g+jX/rUUTQ7VHRMLE8zb5fmsOmjeNq6Aaro7I/lLc2PXw9wq37EmqkmidvrtdX9JnF
	 6sb84L7MXJgQQU929dUjCYp5z1YgOhOsAuM7YZVczl3MQq0CPlQ37XxXsn+zMBJN1H
	 jE9ojTSMAAHfmPK5Gf/uPsmt3v87RA3kWVcVfyHca9FZ77uplNmRn/0W7ZEkqnLHjE
	 mNVvl6DufqPjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 197/317] drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()
Date: Sun, 24 Mar 2024 19:32:57 -0400
Message-ID: <20240324233458.1352854-198-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit c4891d979c7668b195a0a75787967ec95a24ecef ]

Clean up a typo in pr_err() erroneously printing NI MC 'rdev->mc_fw->size'
during SMC firmware load. Log 'rdev->smc_fw->size' instead.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 6596afd48af4 ("drm/radeon/kms: add dpm support for btc (v3)")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/ni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 4a364ca7a1be7..b041b6bfaeca6 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -813,7 +813,7 @@ int ni_init_microcode(struct radeon_device *rdev)
 			err = 0;
 		} else if (rdev->smc_fw->size != smc_req_size) {
 			pr_err("ni_mc: Bogus length %zu in firmware \"%s\"\n",
-			       rdev->mc_fw->size, fw_name);
+			       rdev->smc_fw->size, fw_name);
 			err = -EINVAL;
 		}
 	}
-- 
2.43.0


