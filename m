Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9DF7A79C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjITKwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjITKwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:52:15 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6664B97;
        Wed, 20 Sep 2023 03:52:09 -0700 (PDT)
Received: from localhost.ispras.ru (unknown [10.10.165.14])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8B4CD40F1DF9;
        Wed, 20 Sep 2023 10:52:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8B4CD40F1DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1695207125;
        bh=bH6qdMnm7rw9N28xMlf+P+4+Ai14NUr7R3xOVTfyoRw=;
        h=From:To:Cc:Subject:Date:From;
        b=ZYAqjy04bTpqLkPvFGAYzOTJxHFfOEx1hyzAATWxCHqFXI7mZ/kmYSLl/BZr6Sans
         915xbHPTdFIJDZBD9Vakc5EYjc0eafMG5Q/bhzfsFlV6mlWUXvp827lPY0dMPJbaA9
         RsOYaxAZuZCHKB8FqMi+vrlIuK2XcTcPZzNVG8ZQ=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: [PATCH] dm-zoned: free dmz->ddev array in dmz_put_zoned_device
Date:   Wed, 20 Sep 2023 13:51:16 +0300
Message-ID: <20230920105119.21276-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4dba12881f88 ("dm zoned: support arbitrary number of devices")
made the pointers to additional zoned devices to be stored in a
dynamically allocated dmz->ddev array. However, this array is not freed.

Free it when cleaning up zoned device information inside
dmz_put_zoned_device(). Assigning NULL to dmz->ddev elements doesn't make
sense there as they are not supposed to be reused later and the whole dmz
target structure is being cleaned anyway.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 4dba12881f88 ("dm zoned: support arbitrary number of devices")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/md/dm-zoned-target.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index ad8e670a2f9b..e25cd9db6275 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -753,12 +753,10 @@ static void dmz_put_zoned_device(struct dm_target *ti)
 	struct dmz_target *dmz = ti->private;
 	int i;
 
-	for (i = 0; i < dmz->nr_ddevs; i++) {
-		if (dmz->ddev[i]) {
+	for (i = 0; i < dmz->nr_ddevs; i++)
+		if (dmz->ddev[i])
 			dm_put_device(ti, dmz->ddev[i]);
-			dmz->ddev[i] = NULL;
-		}
-	}
+	kfree(dmz->ddev);
 }
 
 static int dmz_fixup_devices(struct dm_target *ti)
-- 
2.42.0

