Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA53978FCC8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349307AbjIAL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjIAL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:59:39 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D16691;
        Fri,  1 Sep 2023 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wkAQCeB8ivWJVGIWqgukmSlEUJIdHHVhiV1w4Hs/i3s=; b=lUWjhbzxex5UKwd4UDmSOaYSDW
        +cvdNBav2pHwqTIlKdYXJ7XCTznd59kpyXCvGjXJj6TAtcXkqcTsSbP1HF28NuEJCuSrO2YQ9d+RB
        lZvGAmy/VGgVrrtVBAH2FAriuh1dY8Jgx37FTfkdsYomX+SXfd19GFsSDVMGmruYoIGGvovObqjKc
        +nGIY/d1U/6rWSTa/3kFAVEpR6QxR6LYcnHdmeVCR/xYNIAn2s30Od/rlnMckbeECWPum+oAyVUr2
        wR7O7QC2OmGl1m3hBEHmOoWKgN7p1yRdtZnTdlGutRluiM2EloEfs7fhAo6Gw6qeRsuaWq0owaca2
        Z4nsAGCA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <cyndis@kapsi.fi>)
        id 1qc2oG-008yBF-0n;
        Fri, 01 Sep 2023 14:59:32 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/tegra: Zero-initialize iosys_map
Date:   Fri,  1 Sep 2023 14:59:10 +0300
Message-ID: <20230901115910.701518-2-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901115910.701518-1-cyndis@kapsi.fi>
References: <20230901115910.701518-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

UBSAN reports an invalid load for bool, as the iosys_map is read
later without being initialized. Zero-initialize it to avoid this.

Reported-by: Ashish Mhetre <amhetre@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index a4023163493d..346f70edfb15 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -177,7 +177,7 @@ static void tegra_bo_unpin(struct host1x_bo_mapping *map)
 static void *tegra_bo_mmap(struct host1x_bo *bo)
 {
 	struct tegra_bo *obj = host1x_to_tegra_bo(bo);
-	struct iosys_map map;
+	struct iosys_map map = {0};
 	int ret;
 
 	if (obj->vaddr) {
-- 
2.41.0

