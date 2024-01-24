Return-Path: <linux-kernel+bounces-37149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3802283AC10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD281C2125C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2CE7E592;
	Wed, 24 Jan 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJPsUMX5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E9C7E58D;
	Wed, 24 Jan 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106610; cv=none; b=EE9lPxIxLL86wqewal1pBhKQAUriU2raCBOZgB2xlRCf7/X2bomZZhVnw6DlIwTtz6aLLAClVcH/e7y5FtWUBJmj4ZaxPYULHTIAOTFldrdPM+oyK43LgMOSxl0q1Z9oagn+mNRw6Zz/Fn/GRZDw/YM1YxA+hzJqG2Gc//6TNBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106610; c=relaxed/simple;
	bh=4NLraLO7/AX0zW13dim0c0URPDyyqwoeRLWjqOfYK/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrijIUNkw9gOahz+dH7kDoNyBxQoRQPYSULdRchSM96PlWdaEl94DJIL0H+RunvwY8i8kpd6BbStHzHWc7cH9CxvgfHZT+NIr06I8CmDp0C2gNFylpVwFZ5mCgww5nDQvae7WzrPcJ4mvXzFywoVpCB3DJms+CcxsUrYKVSlrQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJPsUMX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A10C433C7;
	Wed, 24 Jan 2024 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106609;
	bh=4NLraLO7/AX0zW13dim0c0URPDyyqwoeRLWjqOfYK/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJPsUMX5h1m6G96o2TTL7e71ZTMMD+H+JmiJREZ2o8lm2/bPHjfPmLqlkgQlDQctw
	 QTksrPqfygUFzwcM+8oTZEbX5CmPwQF/WBIv9TZqz9+O/4871LJb++ancfOCnZg3yq
	 Ac61VnAuNkw01DnxLdpaTM0pZaN6gN/sc8jpnPvkRTGKVca8ubp61aROpp/wJWmxgq
	 Eta/SJuOTJYNs2w1oucumqJJvteN6yPZ9kGteoZxPiuYICDk5FH7ujLMK+EZhs7oCO
	 cqJiwoQdO6ziBDse74fS3iUWnekvjH+kjFJV05hEQuELU8TXQehKApNz9gL0EUCG4H
	 0c4wtQ8N3K0Mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 6.1 7/9] xen/gntdev: Fix the abuse of underlying struct page in DMA-buf import
Date: Wed, 24 Jan 2024 09:29:37 -0500
Message-ID: <20240124142949.1283818-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142949.1283818-1-sashal@kernel.org>
References: <20240124142949.1283818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

[ Upstream commit 2d2db7d40254d5fb53b11ebd703cd1ed0c5de7a1 ]

DO NOT access the underlying struct page of an sg table exported
by DMA-buf in dmabuf_imp_to_refs(), this is not allowed.
Please see drivers/dma-buf/dma-buf.c:mangle_sg_table() for details.

Fortunately, here (for special Xen device) we can avoid using
pages and calculate gfns directly from dma addresses provided by
the sg table.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Acked-by: Daniel Vetter <daniel@ffwll.ch>
Link: https://lore.kernel.org/r/20240107103426.2038075-1-olekstysh@gmail.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/gntdev-dmabuf.c | 50 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 940e5e9e8a54..335451309566 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-direct.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -50,7 +51,7 @@ struct gntdev_dmabuf {
 
 	/* Number of pages this buffer has. */
 	int nr_pages;
-	/* Pages of this buffer. */
+	/* Pages of this buffer (only for dma-buf export). */
 	struct page **pages;
 };
 
@@ -484,7 +485,7 @@ static int dmabuf_exp_from_refs(struct gntdev_priv *priv, int flags,
 /* DMA buffer import support. */
 
 static int
-dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
+dmabuf_imp_grant_foreign_access(unsigned long *gfns, u32 *refs,
 				int count, int domid)
 {
 	grant_ref_t priv_gref_head;
@@ -507,7 +508,7 @@ dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
 		}
 
 		gnttab_grant_foreign_access_ref(cur_ref, domid,
-						xen_page_to_gfn(pages[i]), 0);
+						gfns[i], 0);
 		refs[i] = cur_ref;
 	}
 
@@ -529,7 +530,6 @@ static void dmabuf_imp_end_foreign_access(u32 *refs, int count)
 
 static void dmabuf_imp_free_storage(struct gntdev_dmabuf *gntdev_dmabuf)
 {
-	kfree(gntdev_dmabuf->pages);
 	kfree(gntdev_dmabuf->u.imp.refs);
 	kfree(gntdev_dmabuf);
 }
@@ -549,12 +549,6 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
 	if (!gntdev_dmabuf->u.imp.refs)
 		goto fail;
 
-	gntdev_dmabuf->pages = kcalloc(count,
-				       sizeof(gntdev_dmabuf->pages[0]),
-				       GFP_KERNEL);
-	if (!gntdev_dmabuf->pages)
-		goto fail;
-
 	gntdev_dmabuf->nr_pages = count;
 
 	for (i = 0; i < count; i++)
@@ -576,7 +570,8 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 	struct dma_buf *dma_buf;
 	struct dma_buf_attachment *attach;
 	struct sg_table *sgt;
-	struct sg_page_iter sg_iter;
+	struct sg_dma_page_iter sg_iter;
+	unsigned long *gfns;
 	int i;
 
 	dma_buf = dma_buf_get(fd);
@@ -624,26 +619,31 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 
 	gntdev_dmabuf->u.imp.sgt = sgt;
 
-	/* Now convert sgt to array of pages and check for page validity. */
+	gfns = kcalloc(count, sizeof(*gfns), GFP_KERNEL);
+	if (!gfns) {
+		ret = ERR_PTR(-ENOMEM);
+		goto fail_unmap;
+	}
+
+	/*
+	 * Now convert sgt to array of gfns without accessing underlying pages.
+	 * It is not allowed to access the underlying struct page of an sg table
+	 * exported by DMA-buf, but since we deal with special Xen dma device here
+	 * (not a normal physical one) look at the dma addresses in the sg table
+	 * and then calculate gfns directly from them.
+	 */
 	i = 0;
-	for_each_sgtable_page(sgt, &sg_iter, 0) {
-		struct page *page = sg_page_iter_page(&sg_iter);
-		/*
-		 * Check if page is valid: this can happen if we are given
-		 * a page from VRAM or other resources which are not backed
-		 * by a struct page.
-		 */
-		if (!pfn_valid(page_to_pfn(page))) {
-			ret = ERR_PTR(-EINVAL);
-			goto fail_unmap;
-		}
+	for_each_sgtable_dma_page(sgt, &sg_iter, 0) {
+		dma_addr_t addr = sg_page_iter_dma_address(&sg_iter);
+		unsigned long pfn = bfn_to_pfn(XEN_PFN_DOWN(dma_to_phys(dev, addr)));
 
-		gntdev_dmabuf->pages[i++] = page;
+		gfns[i++] = pfn_to_gfn(pfn);
 	}
 
-	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gntdev_dmabuf->pages,
+	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gfns,
 						      gntdev_dmabuf->u.imp.refs,
 						      count, domid));
+	kfree(gfns);
 	if (IS_ERR(ret))
 		goto fail_end_access;
 
-- 
2.43.0


