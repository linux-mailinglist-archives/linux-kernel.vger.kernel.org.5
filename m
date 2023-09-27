Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3F7AFBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjI0HWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjI0HWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:22:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E510E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:22:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB79C433C7;
        Wed, 27 Sep 2023 07:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695799322;
        bh=m5nfXz80AWeNtcIS3xT2eMv/ZWCdRSi9WrXYqrxYqO8=;
        h=From:To:Cc:Subject:Date:From;
        b=h0xpiHy+ZovLsv2A6p13vmT/0h9gFwVFLq8EgBzJpTut0o8awrM7l08zbXFDqu90t
         Cro4MYvgyiv/X6qvHRpDmasv6bbfVEvFNjbP08ZdAn15c61yBC75Kip4qcRKwwbNM/
         bSmmOEpMucRdNp4AJ7iGKoZ79+3jsxkc5UqoMVUXlbX6VeDKU9klN8y8NAWCdkWVXl
         sBs27S64ZOi/BoGohFFsAH5Qbtv1lVZWDvSOPrYuj0Cdy/cDvlJMvQUxszNqgNoLhp
         vjTzyGmzJetND31JIX8VIQdXUzcy+eZce1ci7rRiVLJ3KDia2KUvvzRZlFA2Wxs1eV
         pW4G4OoH7m0dA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Oded Gabbay <ogabbay@kernel.org>, Tomer Tayar <ttayar@habana.ai>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ofir Bitton <obitton@habana.ai>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Ohad Sharabi <osharabi@habana.ai>,
        Dafna Hirschfeld <dhirschfeld@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] accel/habanalabs: add missing debugfs function stubs
Date:   Wed, 27 Sep 2023 09:21:53 +0200
Message-Id: <20230927072157.2544601-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Two function stubs were removed in an earlier commit but are now needed
again:

drivers/accel/habanalabs/common/device.c: In function 'hl_device_init':
drivers/accel/habanalabs/common/device.c:2231:14: error: implicit declaration of function 'hl_debugfs_device_init'; did you mean 'drm_debugfs_dev_init'? [-Werror=implicit-function-declaration]
 2231 |         rc = hl_debugfs_device_init(hdev);
drivers/accel/habanalabs/common/device.c:2367:9: error: implicit declaration of function 'hl_debugfs_device_fini'; did you mean 'hl_debugfs_remove_file'? [-Werror=implicit-function-declaration]
 2367 |         hl_debugfs_device_fini(hdev);
      |         ^~~~~~~~~~~~~~~~~~~~~~

Fixes: 3b9abb4fa642e ("accel/habanalabs: expose debugfs files later")
Fixes: 09fe78d2e4421 ("accel/habanalabs: register compute device as an accel device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/accel/habanalabs/common/habanalabs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 2a3acdbf91714..1655c101c7052 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -4041,6 +4041,15 @@ void hl_debugfs_set_state_dump(struct hl_device *hdev, char *data,
 
 #else
 
+static inline int hl_debugfs_device_init(struct hl_device *hdev)
+{
+	return 0;
+}
+
+static inline void hl_debugfs_device_fini(struct hl_device *hdev)
+{
+}
+
 static inline void hl_debugfs_add_device(struct hl_device *hdev)
 {
 }
-- 
2.39.2

