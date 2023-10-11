Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABB17C5656
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjJKOEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjJKOD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:03:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D295E184;
        Wed, 11 Oct 2023 07:03:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D101C433C8;
        Wed, 11 Oct 2023 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697033027;
        bh=Zh3bJ54D4zW63Ncr/mu6xJinQ4B8/2BBuvC0nnjCJ+c=;
        h=Date:From:To:Cc:Subject:From;
        b=ZkP4DcvHTv+CAU+Bxp7bY8mRMIANtm2V9mIigWhS4C7tKd8ksjtwI42hJdKV47med
         Zbh8xz/Qia5Y0t4GtL+bAr4a4l8PKf5ZgCLjus2Zq+ODqvNMgmih9PufW6kUfk51mI
         BZ2j/V/EkLskGGRbRjul2+hRAY8mXTUH+y05qVcxCZRllwFjc8O5kvg564yw6Vctkm
         ZesOPr/II66swDL/BQ1+W5CawaE4hg0vrD8HdvBIFpSIZaSt82Px8k4kKlJeQRwDR6
         Sz+vbYcmtVygTHd5vsfk0MRCm6zl/6eriAYykaLUak4pPitWYW56gTGnVIVmUAQGoo
         c3iDm5VQFx7OQ==
Date:   Wed, 11 Oct 2023 08:03:43 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Arvind Yadav <Arvind.Yadav@amd.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] dma-buf: Fix NULL pointer dereference in
 dma_fence_enable_sw_signaling()
Message-ID: <ZSarP0/+hG8/87//@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a NULL pointer dereference will happen in function
`dma_fence_enable_sw_signaling()` (at line 615), in case `chain`
is not allocated in `mock_chain()` and this function returns
`NULL` (at line 86). See below:

drivers/dma-buf/st-dma-fence-chain.c:
 86         chain = mock_chain(NULL, f, 1);
 87         if (!chain)
 88                 err = -ENOMEM;
 89
 90         dma_fence_enable_sw_signaling(chain);

drivers/dma-buf/dma-fence.c:
 611 void dma_fence_enable_sw_signaling(struct dma_fence *fence)
 612 {
 613         unsigned long flags;
 614
 615         spin_lock_irqsave(fence->lock, flags);
			       ^^^^^^^^^^^
				    |
			  NULL pointer reference
			  if fence == NULL

 616         __dma_fence_enable_signaling(fence);
 617         spin_unlock_irqrestore(fence->lock, flags);
 618 }

Fix this by adding a NULL check before dereferencing `fence` in
`dma_fence_enable_sw_signaling()`. This will prevent any other NULL
pointer dereference when the `fence` passed as an argument is `NULL`.

Addresses-Coverity: ("Dereference after null check")
Fixes: d62c43a953ce ("dma-buf: Enable signaling on fence for selftests")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 9 ++++++++-
 include/linux/dma-fence.h   | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 8aa8f8cb7071..4d2f13560d0f 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -607,14 +607,21 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
  * This will request for sw signaling to be enabled, to make the fence
  * complete as soon as possible. This calls &dma_fence_ops.enable_signaling
  * internally.
+ *
+ * Returns 0 on success and a negative error value when @fence is NULL.
  */
-void dma_fence_enable_sw_signaling(struct dma_fence *fence)
+int dma_fence_enable_sw_signaling(struct dma_fence *fence)
 {
 	unsigned long flags;
 
+	if (!fence)
+		return -EINVAL;
+
 	spin_lock_irqsave(fence->lock, flags);
 	__dma_fence_enable_signaling(fence);
 	spin_unlock_irqrestore(fence->lock, flags);
+
+	return 0;
 }
 EXPORT_SYMBOL(dma_fence_enable_sw_signaling);
 
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index ebe78bd3d121..1e4025e925e6 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -399,7 +399,7 @@ int dma_fence_add_callback(struct dma_fence *fence,
 			   dma_fence_func_t func);
 bool dma_fence_remove_callback(struct dma_fence *fence,
 			       struct dma_fence_cb *cb);
-void dma_fence_enable_sw_signaling(struct dma_fence *fence);
+int dma_fence_enable_sw_signaling(struct dma_fence *fence);
 
 /**
  * dma_fence_is_signaled_locked - Return an indication if the fence
-- 
2.34.1

