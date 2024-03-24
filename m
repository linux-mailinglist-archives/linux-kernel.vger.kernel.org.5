Return-Path: <linux-kernel+bounces-113373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E468883CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574E71F25992
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4719D8B9;
	Sun, 24 Mar 2024 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QonjUkfY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B4519E687;
	Sun, 24 Mar 2024 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320174; cv=none; b=QKSaUjg8bBKZes9iDjE88NbvHz1PvuWZRUVzsLL5s8eSdNHeT3niSjVdk2QehrqwhOBsY/R5u7Jvm/BbseXFDonFTaqdul0dMF269d8833L3PNRoE9ezOQFIAm1lbf44o1i4/0t5gcwz1B5lZ4xOuzJGURu/JB3mkqr6abmwh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320174; c=relaxed/simple;
	bh=UcpuHo6S1LSr579056nVXn/HN/K/fVaSCMdpsLmxNuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGkqxtubtX1eypOdPUro45NpsQVb8NoAQ5qvzfBvgBNqC2fB9gkXZ4M6bbnnyig9AqXuUSyjsJw/x7sY2sipO6Sh+rGNCLKzqY/OekraaZxgQozHIz10iivC16Py/Yu+mvgPrxUXw41X92Fverssp/T14cNWw0wfy6n6QQ5Kl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QonjUkfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D3BC43601;
	Sun, 24 Mar 2024 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320174;
	bh=UcpuHo6S1LSr579056nVXn/HN/K/fVaSCMdpsLmxNuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QonjUkfYNAY3BvupFqgso/TRrCpmQWJfdEEiqpgMPwIG3kcTQCKnS9nEp/G27HH9v
	 krGGXuzk8PNJRYI5thCpGYY34whXI5tjmg+fa3Dr0oBTtVf5dqXkrgGvfq2xVgihme
	 nRx5TUb/FcsDwiZadk2bIoJzmagwroP4SvNHIb8E/TW+3TP5VYOrQyfcXa/MayJ3rE
	 DMUixBzkGnA82ZfTkuNezEFNzjzVX8GsC0YjetZ6JiHsrI3E+RSr3Bu79ooJTuFoTr
	 e8r13URz8Z6bF7WMj3Qb3Dp3K2yJ2/ZDEOloJTyY4bo0IUsQv7BRrIAiKaq5k5Krjr
	 oJ1XjWi89SqRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Leonard Lausen <leonard@lausen.nl>,
	Connor Abbott <cwabbott0@gmail.com>,
	Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 482/715] drm/msm/a6xx: specify UBWC config for sc7180
Date: Sun, 24 Mar 2024 18:31:01 -0400
Message-ID: <20240324223455.1342824-483-sashal@kernel.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 0d7dfc79fb9b4b81f642f84796111f2bae8427e2 ]

Historically the Adreno driver has not been updating memory
configuration registers on a618 (SC7180 platform) implying that the
default configuration is fine. After the rework performed in the commit
8814455a0e54 ("drm/msm: Refactor UBWC config setting") the function
a6xx_calc_ubwc_config() still contained this shortcut and did not
calculate UBWC configuration. However the function which now actually
updates hardware registers, a6xx_set_ubwc_config(), doesn't contain such
check.

Rather than adding the check to a6xx_set_ubwc_config(), fill in the
UBWC config for a618 (based on readings from SC7180).

Reported-by: Leonard Lausen <leonard@lausen.nl>
Link: https://gitlab.freedesktop.org/drm/msm/-/issues/49
Fixes: 8814455a0e54 ("drm/msm: Refactor UBWC config setting")
Cc: Connor Abbott <cwabbott0@gmail.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Connor Abbott <cwabbott0@gmail.com>
Patchwork: https://patchwork.freedesktop.org/patch/579113/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index c9c55e2ea5849..dc80e5940f51e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1292,9 +1292,8 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 		gpu->ubwc_config.ubwc_mode = 1;
 	}
 
-	/* a618 is using the hw default values */
 	if (adreno_is_a618(gpu))
-		return;
+		gpu->ubwc_config.highest_bank_bit = 14;
 
 	if (adreno_is_a619_holi(gpu))
 		gpu->ubwc_config.highest_bank_bit = 13;
-- 
2.43.0


