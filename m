Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC74D79CA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjILImj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjILImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:42:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BFE1704;
        Tue, 12 Sep 2023 01:40:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6C45E660732A;
        Tue, 12 Sep 2023 09:40:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694508056;
        bh=0Ue2Nq3K4F+Ieb9zAp+RPvwDsQ7N3mlVuWGujSt9n9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvSJjzxc1ZmhnYwleAuh164cV0uUwzzl6vV5TH3j16K8fXZpmA7rEv0BWiGX7xWVb
         78AEuLxGmmnxyLpKEBdwqUp9MUgJsj+6ZvnZK1qiAasHj8lL6Ps6SkBGfmFA1dnLOe
         aIYganw77fJYimILn74XWzlmk6vNaSvF9NzcsNko7k8c1XDvBw5Lcgw5cKkXung5qV
         Cq3t35tTf4aKLQ7uAy9V2nwRyROn5Nf2Ciw43ikqbu3sgbLOeAzlKOlxUTvgFBz5Sv
         rlfZEgYpfPP1eHqrG7ZUqtSPx8xMNSMOomNEzy5DpMmAyYAp8/qjuPcrAr3QXnLPYq
         Vyi/X5yFjwHyw==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     adrian.larumbe@collabora.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com
Subject: [PATCH v4 6/6] drm/drm-file: Show finer-grained BO sizes in drm_show_memory_stats
Date:   Tue, 12 Sep 2023 09:37:00 +0100
Message-ID: <20230912084044.955864-7-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912084044.955864-1-adrian.larumbe@collabora.com>
References: <20230912084044.955864-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation will try to pick the highest available size
display unit as soon as the BO size exceeds that of the previous
multiplier. That can lead to loss of precision in BO's whose size is
not a multiple of a MiB.

Fix it by changing the unit selection criteria.

For much bigger BO's, their size will naturally be aligned on something
bigger than a 4 KiB page, so in practice it is very unlikely their display
unit would default to KiB.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/drm_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 762965e3d503..bf7d2fe46bfa 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -879,7 +879,7 @@ static void print_size(struct drm_printer *p, const char *stat,
 	unsigned u;
 
 	for (u = 0; u < ARRAY_SIZE(units) - 1; u++) {
-		if (sz < SZ_1K)
+		if (sz & (SZ_1K - 1))
 			break;
 		sz = div_u64(sz, SZ_1K);
 	}
-- 
2.42.0

