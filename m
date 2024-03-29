Return-Path: <linux-kernel+bounces-124640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D807891AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0BA1C25D90
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB869160790;
	Fri, 29 Mar 2024 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtIMhUz+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF715FD1E;
	Fri, 29 Mar 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715607; cv=none; b=oyCPdc+HtrCEIQO0xG0ZB9UlOfbc3FrrTvc8JScxVaRoE47n+T9omPqQYt2147w2EOcUVhiuBB0pCcg/jv/JoqovKBAE5NGHXKrlTGiuyj0udym+eFQ5Gp9krkKa1NFZmmU6N6G+jMocMXMZMjW+SSVe9bfrNPsejuXzJ46axpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715607; c=relaxed/simple;
	bh=Kx+1H+QtnuCB8ciX29fyhB79zT4Lxwy5pONlNfKxAiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzxxAdfazUuGsCgwEkaY/4ceAMH1O9tGzDrjcR8kYRpLGl+Pw7rseZXCBoX/8OJ48wjsZkLSQN25p5/gNQoiRU5QelAs1KMCS0tqxmIIDtiwM+KcNS7BLixo83/LttQqXP8FnH3N1P6lzr1E0M9JJaJkcnpr30DGVFy9HwZgclc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtIMhUz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2734C43390;
	Fri, 29 Mar 2024 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715607;
	bh=Kx+1H+QtnuCB8ciX29fyhB79zT4Lxwy5pONlNfKxAiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtIMhUz+sjAK2RIAXT0244Fa83nkSFwUPuMJyUW1fJrPI4ci51MyCJ/qXMDlINIZl
	 DGjD+A197VcN/cZeNK6NxXQMgfObBm4Tp4dBRzUyTjm4Isf9TAbTIa6i0HWxN8M5F1
	 ErEizI+j2IKccahFXAdgHA+W0qt8v0/uSCXoEnOka4yVJBv/UQ5woJAgM9gVwM/3YY
	 rbcHDRe/mT0EjrFV4nwUsai+zF9dsSMlMMjwu1+FL6mn54JLjj7FX2ENEu0yI67xFi
	 zR9ZZXjg3OrF92z9Fy6UCGfPGia5YyO1mI57vmOcDTARIVNYd4Pb+GT/kRbz6Fmmcr
	 e69NRzo/eT7kA==
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
Subject: [PATCH AUTOSEL 5.15 06/20] cpuidle: Avoid potential overflow in integer multiplication
Date: Fri, 29 Mar 2024 08:32:54 -0400
Message-ID: <20240329123316.3085691-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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


