Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C668755C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGQGx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjGQGxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:53:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758A1B8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:53:22 -0700 (PDT)
Received: from workpc.. (109-252-154-2.dynamic.spd-mgts.ru [109.252.154.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A750B6606FC8;
        Mon, 17 Jul 2023 07:53:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689576801;
        bh=Qg+dZVqpBhB0tdjxJjayctf5oTh5j/Q35LZHB4aWX3g=;
        h=From:To:Cc:Subject:Date:From;
        b=iZCsocr3wv7hB+yJWmF5hTomJIme07DhhvIYvcWqMPVFNTRfCvx+YawXBboyyFpFl
         kV0xjtcCRFxBVRJ8XxGlq8Hiku6EAqGbr9Lke5lvFDLJu6HqIQkZvUfoGS5Fn3Mtt4
         XK3kjvcWufScXyyxCNdoN/CVhwj8S177fpdX8BcCOEbUObGnXzz2jGOM3s7jPc+Sis
         CuuTwV4hUItmkcoFy+R5eVmp0KSao32sNs4nObbZNh8ZYO87AxOz/vB+lkl3aQ44bs
         o48Lk9r83tPm9gwer4C91W/rvFdz6KDngH8OFlWdrKHBZ2t6hPMqRg+9l76o9HfQI6
         +RI+c4gAN6NkQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v1] drm/panfrost: Sync IRQ by job's timeout handler
Date:   Mon, 17 Jul 2023 09:52:54 +0300
Message-ID: <20230717065254.1061033-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panfrost IRQ handler may stuck for a long time, for example this happens
when there is a bad HDMI connection and HDMI handler takes a long time to
finish processing, holding Panfrost. Make Panfrost's job timeout handler
to sync IRQ before checking fence signal status in order to prevent
spurious job timeouts due to a slow IRQ processing.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index dbc597ab46fb..a356163da22d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -713,6 +713,8 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
 	struct panfrost_device *pfdev = job->pfdev;
 	int js = panfrost_job_get_slot(job);
 
+	synchronize_irq(pfdev->js->irq);
+
 	/*
 	 * If the GPU managed to complete this jobs fence, the timeout is
 	 * spurious. Bail out.
-- 
2.41.0

