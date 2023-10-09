Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1CF7BE92C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377559AbjJISYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377544AbjJISYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:24:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728E7D8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:24:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA41DC433C7;
        Mon,  9 Oct 2023 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696875871;
        bh=GX827MInhdg+9mFXDOrIyDM25nqfnAIqJdLH+cnFaYc=;
        h=Date:From:To:Cc:Subject:From;
        b=kfb/PFt1GOw5zC7CWQpYjFj1PXHizJBGvSfYLfMzu1Fu153G6IibmU7pIiE36MWaz
         Wq5Mbd63mgNvyj381SHoYS/kgRDRAwW4svc1+EjTpZytGPUC6BnHmjhe/1TbQKluOd
         lJwEvwm99bGucNKSkxo8yjWenMOkgH1X/PTJSUNlhE85Jmh4tatu/HsNRN2tGkdr8f
         n//Ox8QHbqjDlpowcP8WVokEry8qPiiQFpPH/FDZZnxgZuHZUJw0iYZbRVLeH7Bc6P
         33Axz2LTWi6+hZU7n2PdSHI6Q19g4MdzRer4+pDnB+9NDTvZrWNKAMdz3katFpP7Xh
         pO6IoFkkMbihA==
Date:   Mon, 9 Oct 2023 12:24:27 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
Message-ID: <ZSRFW0yDlDo8+at3@work>
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

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/iommu/virtio-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 17dcd826f5c2..379ebe03efb6 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -85,7 +85,7 @@ struct viommu_request {
 	void				*writeback;
 	unsigned int			write_offset;
 	unsigned int			len;
-	char				buf[];
+	char				buf[] __counted_by(len);
 };
 
 #define VIOMMU_FAULT_RESV_MASK		0xffffff00
@@ -230,7 +230,7 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
 	if (write_offset <= 0)
 		return -EINVAL;
 
-	req = kzalloc(sizeof(*req) + len, GFP_ATOMIC);
+	req = kzalloc(struct_size(req, buf, len), GFP_ATOMIC);
 	if (!req)
 		return -ENOMEM;
 
-- 
2.34.1

