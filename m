Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC94C7E68A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjKIKsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjKIKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:48:05 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6102139
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:48:02 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231109104759euoutp01379ce79744cdfd2fdc618c09569c570e~V7rFFLRBL1650616506euoutp01J
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:47:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231109104759euoutp01379ce79744cdfd2fdc618c09569c570e~V7rFFLRBL1650616506euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699526879;
        bh=ghDtuNm/rprsB94SZ+nrIouWWrb2Q3jHekqjdqhln5s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VI/ADahax0HsXra5ywaFvb9JA1dO3RVHZF+LDTECuHlFTVzKEIeWzi6rKQMFLuDA3
         zuDQWvtjY6d3WujN3ZSz7ynbrOhqAv3GRSBV5mJMrcvX2WoJons4TaG1GSyVZrycIF
         +kgtZ1InJy2szVpR2V07DKnJuB8BVp7UcJSGBKxw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231109104759eucas1p263e75fab40bb2b3ad5cc4646e0cd2634~V7rEyTyIH2943429434eucas1p2B;
        Thu,  9 Nov 2023 10:47:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 69.5D.11320.FD8BC456; Thu,  9
        Nov 2023 10:47:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231109104758eucas1p2e98e8cf22a42aae212a98228e46b4438~V7rEeWd6a2942529425eucas1p2A;
        Thu,  9 Nov 2023 10:47:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231109104758eusmtrp252bf200468d54124faf3feab1d57f613~V7rEdi5xx2298322983eusmtrp2t;
        Thu,  9 Nov 2023 10:47:58 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-89-654cb8dfa774
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.21.25043.ED8BC456; Thu,  9
        Nov 2023 10:47:58 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231109104758eusmtip2b084c095a97cd533501393d6e8d08ea9~V7rD2N_nf0866008660eusmtip2E;
        Thu,  9 Nov 2023 10:47:58 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] pwm: samsung: Fix broken resume after putting
 per-channel data into driver data
Date:   Thu,  9 Nov 2023 11:47:47 +0100
Message-Id: <20231109104748.2746839-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7r3d/ikGky8zGHxYN42Nou9r7ey
        W2x6fI3V4vKuOWwWd++uYrSYcX4fk8XaI3fZLX7umsdicXviZEYHTo+ds+6ye9y5tofNY/OS
        eo/+vwYefVtWMXp83iQXwBbFZZOSmpNZllqkb5fAlXH8aAdjwXn2ikcv1jI2MK5n62Lk5JAQ
        MJE4cqmHqYuRi0NIYAWjxLdPzSwQzhdGicknzzJDOJ8ZJTpnPmSCaWlpucAKkVjOKNGy8Twb
        XMufs4dZQKrYBAwlut52gSVEBNoYJZoufwBzmAWamSSafncD9XNwCAukSdzfbg7SwCKgKnH+
        6FGwZl4Be4k/c3tYINbJS+w/CHIHSFxQ4uTMJ2BxZqB489bZYPdJCGzhkJh7YQVUg4vEjwl3
        mCFsYYlXx7ewQ9gyEv93zmeCaGhnlFjw+z6UM4FRouH5LUaIKmuJO+d+sYFcxyygKbF+lz5E
        2FFi6aeVLCBhCQE+iRtvBSGO4JOYtG06M0SYV6KjTQiiWk1i1vF1cGsPXrgEdY6HxIXpO8Bs
        IYFYiUcXXrNOYFSYheS1WUhem4VwwwJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiB
        qej0v+NfdjAuf/VR7xAjEwfjIUYJDmYlEd4LJj6pQrwpiZVVqUX58UWlOanFhxilOViUxHlV
        U+RThQTSE0tSs1NTC1KLYLJMHJxSDUxGsSbKczMeGnY1RtbrpsYn7NE78fF/2Qq1+8JzI8vb
        FJ853WyNCjKMUhLmDX500HHb6fS9PB6rpOZJa3ofVrwRct5Et2XPr4/3DlRxZxieEnl27ULe
        NLsQibIivYt+MXYTtnMWcSdyxxuWTdqly7tssWR67IXbOxZ1vP91aFPB07qYy5u0PL/OSVJe
        VcNvnbQt+URS+lNBKcH2t0bnZr6NjLO1jqzgqCx29z1icjMgckHJ6tPri83dZHSEpDVF+FmE
        4spe3XRSu1bjLCy6NXPngRxbA5Wy348dxT68V/MMCt+f8u/oAWk7rjdnJ5YLuvG/OO03/aP2
        oetJnwPdxJ94BV/gYWUpygwIFfmpxFKckWioxVxUnAgAxJg2JLQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsVy+t/xe7r3dvikGvTcNLB4MG8bm8Xe11vZ
        LTY9vsZqcXnXHDaLu3dXMVrMOL+PyWLtkbvsFj93zWOxuD1xMqMDp8fOWXfZPe5c28PmsXlJ
        vUf/XwOPvi2rGD0+b5ILYIvSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQyzh+tIOx4Dx7xaMXaxkbGNezdTFyckgImEi0tFxg7WLk4hASWMooMWv2
        P0aIhIzEyWkNrBC2sMSfa11sEEWfGCV+rGgBS7AJGEp0vYVIiAh0MUr8PraWEcRhFmhlkmg4
        sYoFpEpYIEXiYecWZhCbRUBV4vzRo2BxXgF7iT9ze1ggVshL7D94lhkiLihxcuYTsDgzULx5
        62zmCYx8s5CkZiFJLWBkWsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYA9uO/dyyg3Hlq496
        hxiZOBgPMUpwMCuJ8F4w8UkV4k1JrKxKLcqPLyrNSS0+xGgKdN9EZinR5HxgFOaVxBuaGZga
        mphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTBxZWjMmLb0y8Wirz0Lvh+w7Glc
        eLzSW+eUgcCETXceVLv+d5Wv+R2ZHsTm6v9BlCUgySTLcsXqkvd7p6efv7ZRaNraa+kP/ueJ
        btj9n3FpZNgq8bCtq2IqHTt4n36dz7ji+8rAb+oSjtaXpK/t+MA5gTNyt33tl8/Ju1d2+zYd
        tDlvfvDacvu7Ple2r3WON3ynUmz1t/i31j2d71ZZbj9ON6xksJGv/Ljk1cPSX5dZmwxzire/
        eX9r+rlP5XcCjvj3HhZcn1I4/2Utf8gCfY0J39ft7MoU5jin6nd873XONT90NpbnHT/zJ/iK
        aMXVmLB5+p5KFXJLdIQ0n7LJfrnYLq3g58fowMETmcF/r/maEktxRqKhFnNRcSIAc04Y9goD
        AAA=
X-CMS-MailID: 20231109104758eucas1p2e98e8cf22a42aae212a98228e46b4438
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231109104758eucas1p2e98e8cf22a42aae212a98228e46b4438
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231109104758eucas1p2e98e8cf22a42aae212a98228e46b4438
References: <CGME20231109104758eucas1p2e98e8cf22a42aae212a98228e46b4438@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PWMF_EXPORTED is misleadingly used as a bit numer in the pwm->flags, not
as a flag value, so the proper test for it must use test_bit() helper.
This fixes broken resume after putting per-channel data into driver data.

Fixes: e3fe982b2e4e ("pwm: samsung: Put per-channel data into driver data")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/pwm/pwm-samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 568491ed6829..69d9f4577b34 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -631,7 +631,7 @@ static int pwm_samsung_resume(struct device *dev)
 		struct pwm_device *pwm = &chip->pwms[i];
 		struct samsung_pwm_channel *chan = &our_chip->channel[i];
 
-		if (!(pwm->flags & PWMF_REQUESTED))
+		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
 		if (our_chip->variant.output_mask & BIT(i))
-- 
2.34.1

