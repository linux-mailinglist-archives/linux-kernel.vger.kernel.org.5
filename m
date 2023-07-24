Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEDA75E75F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGXB1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjGXB06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B287423A;
        Sun, 23 Jul 2023 18:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E05AF60F16;
        Mon, 24 Jul 2023 01:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD11DC433BB;
        Mon, 24 Jul 2023 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161841;
        bh=qUp5vqA1iYuMeiYgHI22R7egZ7L63vuv2kVGE69DbDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYCLxxvxl6VIJk+sxsJwkz+OC71f+QGsG9LhDgdPPBhyA9A8kL0OnZ9Absl1kUfBb
         oWxAUWI//p4rmkTFxaeR8+SMxId/FlYBB7ysBXhe9PYBQWLwbMpqHnqw5tMul7+a7t
         oM1H7nMghCW19/dfgxzbWRgMik5UiNGnU4KAUnUvjtAPF9G+MKyrp05ApgMWLvEgOd
         mYjVOU1i+C5jArO8q78OG8ICv7bOdp1QkNI32xgqwX1y7xEMCkP2zWQ9wRrdV/PTkX
         yDLWepOisTcUbcyDq7tkKS5y7D8BH8GTs1a/AKJcfL8gAJFAwjfVKrrjkL+3cYyRVE
         swVqXo8WzUZBQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     gaoxu <gaoxu2@hihonor.com>, Suren Baghdasaryan <surenb@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.15 11/23] dma-remap: use kvmalloc_array/kvfree for larger dma memory remap
Date:   Sun, 23 Jul 2023 21:23:22 -0400
Message-Id: <20230724012334.2317140-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012334.2317140-1-sashal@kernel.org>
References: <20230724012334.2317140-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gaoxu <gaoxu2@hihonor.com>

[ Upstream commit 51ff97d54f02b4444dfc42e380ac4c058e12d5dd ]

If dma_direct_alloc() alloc memory in size of 64MB, the inner function
dma_common_contiguous_remap() will allocate 128KB memory by invoking
the function kmalloc_array(). and the kmalloc_array seems to fail to try to
allocate 128KB mem.

Call trace:
[14977.928623] qcrosvm: page allocation failure: order:5, mode:0x40cc0
[14977.928638] dump_backtrace.cfi_jt+0x0/0x8
[14977.928647] dump_stack_lvl+0x80/0xb8
[14977.928652] warn_alloc+0x164/0x200
[14977.928657] __alloc_pages_slowpath+0x9f0/0xb4c
[14977.928660] __alloc_pages+0x21c/0x39c
[14977.928662] kmalloc_order+0x48/0x108
[14977.928666] kmalloc_order_trace+0x34/0x154
[14977.928668] __kmalloc+0x548/0x7e4
[14977.928673] dma_direct_alloc+0x11c/0x4f8
[14977.928678] dma_alloc_attrs+0xf4/0x138
[14977.928680] gh_vm_ioctl_set_fw_name+0x3c4/0x610 [gunyah]
[14977.928698] gh_vm_ioctl+0x90/0x14c [gunyah]
[14977.928705] __arm64_sys_ioctl+0x184/0x210

work around by doing kvmalloc_array instead.

Signed-off-by: Gao Xu <gaoxu2@hihonor.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/remap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index b4526668072e7..27596f3b4aef3 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -43,13 +43,13 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 	void *vaddr;
 	int i;
 
-	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
+	pages = kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return NULL;
 	for (i = 0; i < count; i++)
 		pages[i] = nth_page(page, i);
 	vaddr = vmap(pages, count, VM_DMA_COHERENT, prot);
-	kfree(pages);
+	kvfree(pages);
 
 	return vaddr;
 }
-- 
2.39.2

