Return-Path: <linux-kernel+bounces-124898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78192891DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49DF0B227AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D23238182;
	Fri, 29 Mar 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLLRPfom"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182B14B08A;
	Fri, 29 Mar 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716390; cv=none; b=I2a/Ux+42jRTmpsascIZ820KvcUUlVASmV5EgLfh1I5kkCqtjBKNhFG9pRJdL3Ev7se6orELViOIWCbpVyULOd1sNTdsIf8fWf5NPkyCqdKyjN8k4fLTjLlH0QLw2F5a6n0F9syBlIsxy9VJoq9UpupgMUBCwjT7mlzWGVPLMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716390; c=relaxed/simple;
	bh=Kx+1H+QtnuCB8ciX29fyhB79zT4Lxwy5pONlNfKxAiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1hkYimQFEmIAEpk9MdX0X4+JK1V/jOvljmcJBu1E02FrxFBikOs35dIKzuVhFqvSnGmaqt4uBvVjOx9ighAVd/z5qqrQDXrRQukHmnlnayqCyfGwVU3UZLylVSC3Rn4Y4FVJvqLqLvAyJLbyajDWs/KBa91DhQwjzhwX1PUFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLLRPfom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2963EC433C7;
	Fri, 29 Mar 2024 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716390;
	bh=Kx+1H+QtnuCB8ciX29fyhB79zT4Lxwy5pONlNfKxAiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLLRPfomblxWnL5E8qu46AJV+9GDc72gVoeF7+a7nr8txIB2Yx7pQEKiudlo/IIen
	 03jmk9Ws8E5CEsMqpaJtIe2nAEYYJFk4BOCisHENYNHQsx3NlMQ3DEVYnzd2fd6G1R
	 HEjkOjB9wK20w0iHUmB4Bg0nPJ4DnUVY0LZM9wMkaJFzH8392K0XypK51K7ErWCB0m
	 syFs8kn5l7PZ3ZTp+Z0EhgnDJmwPgr+qyfFC504zNnF3+SOH8IXDvvBjDC0pRlXjDZ
	 820BrgWqvVk0KXaNkZBRyHyG5JnoP91toMOttPmHhNOpuDLv/4KpfJ8GqEyqC8GGa5
	 ffKdNLBFx+J3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: C Cheng <C.Cheng@mediatek.com>,
	Bo Ye <bo.ye@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	matthias.bgg@gmail.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 14/52] cpuidle: Avoid potential overflow in integer multiplication
Date: Fri, 29 Mar 2024 08:45:08 -0400
Message-ID: <20240329124605.3091273-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: C Cheng <C.Cheng@mediatek.com>

[ Upstream commit 88390dd788db485912ee7f9a8d3d56fc5265d52f ]

In detail:

In C language, when you perform a multiplication operation, if
both operands are of int type, the multiplication operation is
performed on the int type, and then the result is converted to
the target type. This means that if the product of int type
multiplication exceeds the range that int type can represent,
an overflow will occur even if you store the result in a
variable of int64_t type.

For a multiplication of two int values, it is better to use
mul_u32_u32() rather than s->exit_latency_ns = s->exit_latency *
NSEC_PER_USEC to avoid potential overflow happenning.

Signed-off-by: C Cheng <C.Cheng@mediatek.com>
Signed-off-by: Bo Ye <bo.ye@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
[ rjw: New subject ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index f70aa17e2a8e0..c594e28adddf3 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -16,6 +16,7 @@
 #include <linux/cpumask.h>
 #include <linux/tick.h>
 #include <linux/cpu.h>
+#include <linux/math64.h>
 
 #include "cpuidle.h"
 
@@ -185,7 +186,7 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 			s->target_residency_ns = 0;
 
 		if (s->exit_latency > 0)
-			s->exit_latency_ns = s->exit_latency * NSEC_PER_USEC;
+			s->exit_latency_ns = mul_u32_u32(s->exit_latency, NSEC_PER_USEC);
 		else if (s->exit_latency_ns < 0)
 			s->exit_latency_ns =  0;
 	}
-- 
2.43.0


