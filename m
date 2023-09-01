Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650DE78FC28
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349126AbjIALPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbjIALPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:15:45 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26601A8;
        Fri,  1 Sep 2023 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vdXa1UaNUQSlT7QLXvthll4ZmNwCFn/bAqBkA3cQD5g=; b=E/LUa5hvmQMUHnz//X7eViUI45
        Srtk5lQrRrDV1fXQLB1vXAlnW1ON//wfE2rW4ZR1TURAigxjj/fuo4WacIi/wn2wJusIRiwBcNA+k
        sspgDHaEc/WpqBnKwMzgVPG6nLRzT384uZ1P/RHE0IuPaX8C9hVC4rquz59lxnD64FfMmVJuTAJPd
        WU6HRTSL6XjSYG30OvUiILU4r6sr954+RpHjbXleLFqj1tMBdExcqSuiYdKgQEz+ZYmPubTCL/GXy
        XX5tXEICjALqltCLZE3lMux1799IOR95sbroIOf+S8osP4o3Ij8ElW5D6HHmRnq45DMAXIQJJ8xdX
        ANxx8ecw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <cyndis@kapsi.fi>)
        id 1qc27l-008kr0-18;
        Fri, 01 Sep 2023 14:15:37 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] gpu: host1x: Stop CDMA before suspending
Date:   Fri,  1 Sep 2023 14:15:08 +0300
Message-ID: <20230901111510.663401-2-cyndis@kapsi.fi>
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

Before going into suspend, wait all CDMA to go idle and stop it.
This will ensure no channel is still active while we enter
suspend, and ensures the driver doesn't think that CDMA is still
active when coming back from suspend (as HW state has been reset).

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/channel.c | 19 +++++++++++++++++++
 drivers/gpu/host1x/channel.h |  1 +
 drivers/gpu/host1x/dev.c     |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/host1x/channel.c b/drivers/gpu/host1x/channel.c
index 79501c957532..08077afe4cde 100644
--- a/drivers/gpu/host1x/channel.c
+++ b/drivers/gpu/host1x/channel.c
@@ -81,6 +81,25 @@ void host1x_channel_stop(struct host1x_channel *channel)
 }
 EXPORT_SYMBOL(host1x_channel_stop);
 
+/**
+ * host1x_channel_stop_all() - disable CDMA on allocated channels
+ * @host: host1x instance
+ *
+ * Stop CDMA on allocated channels
+ */
+void host1x_channel_stop_all(struct host1x *host)
+{
+	struct host1x_channel_list *chlist = &host->channel_list;
+	int bit;
+
+	mutex_lock(&chlist->lock);
+
+	for_each_set_bit(bit, chlist->allocated_channels, host->info->nb_channels)
+		host1x_channel_stop(&chlist->channels[bit]);
+
+	mutex_unlock(&chlist->lock);
+}
+
 static void release_channel(struct kref *kref)
 {
 	struct host1x_channel *channel =
diff --git a/drivers/gpu/host1x/channel.h b/drivers/gpu/host1x/channel.h
index b23a8071fbd0..d7aede204d83 100644
--- a/drivers/gpu/host1x/channel.h
+++ b/drivers/gpu/host1x/channel.h
@@ -40,5 +40,6 @@ int host1x_channel_list_init(struct host1x_channel_list *chlist,
 void host1x_channel_list_free(struct host1x_channel_list *chlist);
 struct host1x_channel *host1x_channel_get_index(struct host1x *host,
 						unsigned int index);
+void host1x_channel_stop_all(struct host1x *host);
 
 #endif
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 7c6699aed7d2..6501bee9e8c1 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -655,6 +655,7 @@ static int __maybe_unused host1x_runtime_suspend(struct device *dev)
 	struct host1x *host = dev_get_drvdata(dev);
 	int err;
 
+	host1x_channel_stop_all(host);
 	host1x_intr_stop(host);
 	host1x_syncpt_save(host);
 
-- 
2.41.0

