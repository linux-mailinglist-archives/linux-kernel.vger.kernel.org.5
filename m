Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D34678CFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbjH2W7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbjH2W6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:58:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39662CC9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=r866mTX9mOfhvGB9ROtXhk9rJqVPkd1gFKMTDNSdM8s=; b=WDkROUj70tpZ/oy6+pT0EW6Dgk
        0j6tBLRgzNZai+KOwjuL/IU/hNmJKxkTyxMtiDAquG6QGrLlEPIMcFa5B0lrR2lKmte0UODUsOBHx
        KSVJBbR51slZdqVV4PRX9hi4WzlstnVLp0pfSjf56btM7cmZB6NkreOjjX8u1FbsbQbvuHH2eAXU/
        GBAhIJkK51u7suDv7khh7QyVeP2l57mjgmuNF3sx8CqdpooOKKfiIog2Nyx9XSVprxhaRhGDEnH1n
        Vdc1nzVAShp8J+m2jr6jojNpTAmbzkh1N9/F0JTBtpMyBdo+aLBkakVXzJC+kAlOaVq09CPHftao1
        5AwGbtXg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qb7fS-00CQ0P-2Q;
        Tue, 29 Aug 2023 22:58:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] macintosh/ams: linux/platform_device.h is needed
Date:   Tue, 29 Aug 2023 15:58:37 -0700
Message-ID: <20230829225837.15520-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ams.h uses struct platform_device, so the header should be used
to prevent build errors:

drivers/macintosh/ams/ams-input.c: In function 'ams_input_enable':
drivers/macintosh/ams/ams-input.c:68:45: error: invalid use of undefined type 'struct platform_device'
   68 |         input->dev.parent = &ams_info.of_dev->dev;
drivers/macintosh/ams/ams-input.c: In function 'ams_input_init':
drivers/macintosh/ams/ams-input.c:146:51: error: invalid use of undefined type 'struct platform_device'
  146 |         return device_create_file(&ams_info.of_dev->dev, &dev_attr_joystick);
drivers/macintosh/ams/ams-input.c: In function 'ams_input_exit':
drivers/macintosh/ams/ams-input.c:151:44: error: invalid use of undefined type 'struct platform_device'
  151 |         device_remove_file(&ams_info.of_dev->dev, &dev_attr_joystick);
drivers/macintosh/ams/ams-input.c: In function 'ams_input_init':
drivers/macintosh/ams/ams-input.c:147:1: error: control reaches end of non-void function [-Werror=return-type]
  147 | }

Fixes: 233d687d1b78 ("macintosh: Explicitly include correct DT includes")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Herring <robh@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/macintosh/ams/ams.h |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/macintosh/ams/ams.h b/drivers/macintosh/ams/ams.h
--- a/drivers/macintosh/ams/ams.h
+++ b/drivers/macintosh/ams/ams.h
@@ -6,6 +6,7 @@
 #include <linux/input.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
