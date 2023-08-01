Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C876B2A1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjHALFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjHALEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE391526E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:58:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 729016150F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48116C433C8;
        Tue,  1 Aug 2023 10:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690887534;
        bh=5JszLrVl14NYpDg2t9eZAPFv3d27caE8ile05br6iwY=;
        h=From:To:Cc:Subject:Date:From;
        b=BsLJsuBkZ7IsGXvQVTLM0rvXkIdYf1Us6CNONmRdUlJjziGHzVaKyaNjcmw6UrTGw
         NvVBbySJItFMnTZtVTjTbG7WKmEz1o7RJOtjZJ2E2KsnsYXG9T4wgtNrqMi4s7M3il
         5THtfTQy6xZo0vvD5XU7kP3l/F7TpPqL6CN2uxkPbnYTRNha0UqHkusRWVTbAILmmj
         5R/OEz8vVDSD7qkJjYDZp6nra2WnSxiLGomD5CHZhtu8mFDeWg3u/46sV+laiw+/zm
         3ZI5sGQts4BitwYQdEIGX//WGQhwy81EoShB481+Sys17qA42K8wEZZ5yM9GhoEbYD
         3liyT1RnICCnQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Feng Liu <feliu@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: Remove PM #ifdef guards to fix i2c driver
Date:   Tue,  1 Aug 2023 12:58:15 +0200
Message-Id: <20230801105846.3708252-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A cleanup in the virtio i2c caused a build failure:

drivers/i2c/busses/i2c-virtio.c:270:10: error: 'struct virtio_driver' has no member named 'freeze'
drivers/i2c/busses/i2c-virtio.c:271:10: error: 'struct virtio_driver' has no member named 'restore'

Change the structure definition to allow this cleanup to
be applied everywhere.

Fixes: 73d546c76235b ("i2c: virtio: Remove #ifdef guards for PM related functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/virtio.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 0f3b9017dff40..9b94e2c9bbb81 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -218,10 +218,8 @@ struct virtio_driver {
 	void (*scan)(struct virtio_device *dev);
 	void (*remove)(struct virtio_device *dev);
 	void (*config_changed)(struct virtio_device *dev);
-#ifdef CONFIG_PM
 	int (*freeze)(struct virtio_device *dev);
 	int (*restore)(struct virtio_device *dev);
-#endif
 };
 
 static inline struct virtio_driver *drv_to_virtio(struct device_driver *drv)
-- 
2.39.2

