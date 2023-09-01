Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0378FC29
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349133AbjIALPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbjIALPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:15:45 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B9E42;
        Fri,  1 Sep 2023 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cLUDx6R4lVjt6PQsec9JUvjLyFB0OdGh18Ty+QH+p7c=; b=oE6/n9h4Y2f6nT/sQF/PF+67Gx
        mggDwXZ7xHa7KmPsWxsM6Oe/IAkzRi/iUY71pfj1YINAoGPKHH6BEbSXwIohM3uwy3KWPGNkmT4wz
        gd7qnjMD/0V5mxJcrHT2d6Yc1i5/eqa7O1qJYDbEF/kexgdElTPDjz3G57dzAkE+hiXOjPy3QPxP2
        ZPrF3JbxC5qbTtRtyJe8FHcmZjdCotc5GWwfgcVQFPnYGwqRNWyR+/muaG6pr1bidRXHnp61FjrsI
        gG0VpErCmWBWWSFiFNCANYPkVgDIKh+GvRwqeWzAij6ny224rN2KyFVWy4IZ6YfMyZqNxxblnb4Tz
        ATC2hxDw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <cyndis@kapsi.fi>)
        id 1qc27l-008kr0-1p;
        Fri, 01 Sep 2023 14:15:37 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] gpu: host1x: Enable system suspend callbacks
Date:   Fri,  1 Sep 2023 14:15:09 +0300
Message-ID: <20230901111510.663401-3-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901111510.663401-1-cyndis@kapsi.fi>
References: <20230901111510.663401-1-cyndis@kapsi.fi>
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

With the previous CDMA stop fix, executing runtime PM ops around
system suspend now makes channel submissions work after system
suspend, so do that.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 6501bee9e8c1..b8ac44e7d11a 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -720,7 +720,7 @@ static int __maybe_unused host1x_runtime_resume(struct device *dev)
 static const struct dev_pm_ops host1x_pm_ops = {
 	SET_RUNTIME_PM_OPS(host1x_runtime_suspend, host1x_runtime_resume,
 			   NULL)
-	/* TODO: add system suspend-resume once driver will be ready for that */
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver tegra_host1x_driver = {
-- 
2.41.0

