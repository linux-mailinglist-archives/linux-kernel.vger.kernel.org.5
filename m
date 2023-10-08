Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94EF7BCEED
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343585AbjJHOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjJHOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:37:02 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387EA4;
        Sun,  8 Oct 2023 07:37:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [85.89.126.105])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4C4ED40F1DEB;
        Sun,  8 Oct 2023 14:36:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4C4ED40F1DEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1696775817;
        bh=RoI0NzZPsRKEzf3D3JCemfXog6bSvCczYoK0HGBz6tk=;
        h=From:To:Cc:Subject:Date:From;
        b=Q8eNVonyqxFLuwSGdRKO3poe5TFCrbHZorXms5AfSGQK/RYBvjDy5T6lJiNKTtKEM
         hisIozg7H45+6TZ4xM8DJF6FYvAC9qaMwpwZqpNpB2BIEmZfmAvjT3znNBXzTMpn4m
         y6DKkfx+IMycG/5rg0CdUm8BDz8h7RMB1UfPG9cQ=
From:   Pavel Sakharov <p.sakharov@ispras.ru>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Pavel Sakharov <p.sakharov@ispras.ru>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Arvind Yadav <Arvind.Yadav@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] dma-buf: Fix NULL pointer dereference in sanitycheck()
Date:   Sun,  8 Oct 2023 17:36:36 +0300
Message-ID: <20231008143637.113957-1-p.sakharov@ispras.ru>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mock_chain() returns NULL, NULL pointer is dereferenced in
dma_fence_enable_sw_signaling().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Pavel Sakharov <p.sakharov@ispras.ru>

Fixes: d62c43a953ce ("dma-buf: Enable signaling on fence for selftests")
---
 drivers/dma-buf/st-dma-fence-chain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
index c0979c8049b5..661de4add4c7 100644
--- a/drivers/dma-buf/st-dma-fence-chain.c
+++ b/drivers/dma-buf/st-dma-fence-chain.c
@@ -84,11 +84,11 @@ static int sanitycheck(void *arg)
 		return -ENOMEM;
 
 	chain = mock_chain(NULL, f, 1);
-	if (!chain)
+	if (chain)
+		dma_fence_enable_sw_signaling(chain);
+	else
 		err = -ENOMEM;
 
-	dma_fence_enable_sw_signaling(chain);
-
 	dma_fence_signal(f);
 	dma_fence_put(f);
 
-- 
2.42.0

