Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABBE78C5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbjH2Neo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbjH2Nd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF21BE;
        Tue, 29 Aug 2023 06:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BDD26569F;
        Tue, 29 Aug 2023 13:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE26DC433C9;
        Tue, 29 Aug 2023 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315946;
        bh=9QijeGTlxozfjBzrNSDqt/zF9GOmvBM/ioFMMrZj0M4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLtT66ReY+l95B8TXsdWCpfgs4jRt0GL9gL2qzdnSFyPrY5xhPJfRXttAd/eigwd4
         GJJLoIbkychLdKFB5ra2NaKWIcdWMjl3loxhDajxrR/HWvpWdYnhY9Z+h4YqouLCI/
         O6wpzBOiUwcipWQDPSqN2L8r3AW2lJOmXbFgDxxT8F7k7Wyk5Bpa52Mn+1sm3BvyD7
         g0Hut204wtlTSMc6Qr12rRpZ3tSEB2ZImY7ESaR3MH7AZZ+94HHRWFwsi0AY3vXqJA
         81ctHOAagKND9PfjnQrSuJ/UymAMFVhgqOsYJWpOb5QHaEzorfmsNZ2OCMzlNQXfvm
         FQTeCVWT+Zbtg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 6.4 07/17] virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
Date:   Tue, 29 Aug 2023 09:31:54 -0400
Message-Id: <20230829133211.519957-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

[ Upstream commit ddf409851461f515cc32974714b73efe2e012bde ]

Just like we do with alloc_contig_range(), let's convert all unknown
errors to -EBUSY, but WARN so we can look into the issue. For example,
offline_pages() could fail with -EINTR, which would be unexpected in our
case.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230713145551.2824980-3-david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mem.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index ed15d2a4bd96b..1a76ba2bc118c 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -741,11 +741,15 @@ static int virtio_mem_offline_and_remove_memory(struct virtio_mem *vm,
 		 * immediately instead of waiting.
 		 */
 		virtio_mem_retry(vm);
-	} else {
-		dev_dbg(&vm->vdev->dev,
-			"offlining and removing memory failed: %d\n", rc);
+		return 0;
 	}
-	return rc;
+	dev_dbg(&vm->vdev->dev, "offlining and removing memory failed: %d\n", rc);
+	/*
+	 * We don't really expect this to fail, because we fake-offlined all
+	 * memory already. But it could fail in corner cases.
+	 */
+	WARN_ON_ONCE(rc != -ENOMEM && rc != -EBUSY);
+	return rc == -ENOMEM ? -ENOMEM : -EBUSY;
 }
 
 /*
-- 
2.40.1

