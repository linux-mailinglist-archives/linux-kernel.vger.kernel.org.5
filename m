Return-Path: <linux-kernel+bounces-124827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52CB891CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B8E1C2175B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97C11B489F;
	Fri, 29 Mar 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJQEsp6o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347441B251D;
	Fri, 29 Mar 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716243; cv=none; b=TFU635Ax58a5UCtRnYd7gsTAZ58aLoDJ/hLqwynHbe3gcDlhlYB5/HU7vq+UwineU23RXKIpllTv/gxQHRRAznj8EF0lLV7QgwjJE3ue0rXBXWI01YqbJIBQSFUP/fPlGav93eHhYTF82qTTWGMdQsXDm1YttBRhahdZbDSCiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716243; c=relaxed/simple;
	bh=uRO9hNSHchqspmCb1F6je6akXTN4Hy8qBEMg95DG9jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbmQncNOJryz0pntSnkxkV8Jjo0zrPMz/RHP1QjmapGL4ThAEqYclLKNmyns/vuWtesWUSYMfYs2ph9S7e7VNvVffAzaF3Cwo+xBNOSv52d6TfwyCVU8157wwYcQLtM4XNTvqJVFeAYSzctFCWHXLNadrjffCkdgmne/wkbiFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJQEsp6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B417DC43390;
	Fri, 29 Mar 2024 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716243;
	bh=uRO9hNSHchqspmCb1F6je6akXTN4Hy8qBEMg95DG9jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJQEsp6oISBucig7g+0diMfjpNLFzX1OYjSonZmhrMT0pzLYGa9hL2nzJ9zAY/eoq
	 lGoFw/BSdtDyKj2Ysef1jOWyBY+lckjc8yoi2PcallQOIQYTX0/YW2lToESRJOgyMH
	 lYw7AA7TU8elRVnnr8p8HlHmw9aVA8GQvEAmAeFitjCzOIUT2yTucgj0ZiqLQP1v++
	 xpxqgMitQ4jYTpakLOEyBnBvdH1UuRBeAyDGhiHoezpw0e6S1qQz2SbQYKg2RZUF+/
	 1toAtbTQMKG9OAwNaJXPVehLWyUYvzUx7Sl4h0C2yqU+8pdRe6BemJmUxP0txNrrQ6
	 M89ILP7PQWK6g==
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
Subject: [PATCH AUTOSEL 6.6 18/75] cpuidle: Avoid potential overflow in integer multiplication
Date: Fri, 29 Mar 2024 08:41:59 -0400
Message-ID: <20240329124330.3089520-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index d9cda7f6ccb98..cf5873cc45dc8 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -16,6 +16,7 @@
 #include <linux/cpumask.h>
 #include <linux/tick.h>
 #include <linux/cpu.h>
+#include <linux/math64.h>
 
 #include "cpuidle.h"
 
@@ -187,7 +188,7 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 			s->target_residency = div_u64(s->target_residency_ns, NSEC_PER_USEC);
 
 		if (s->exit_latency > 0)
-			s->exit_latency_ns = s->exit_latency * NSEC_PER_USEC;
+			s->exit_latency_ns = mul_u32_u32(s->exit_latency, NSEC_PER_USEC);
 		else if (s->exit_latency_ns < 0)
 			s->exit_latency_ns =  0;
 		else
-- 
2.43.0


