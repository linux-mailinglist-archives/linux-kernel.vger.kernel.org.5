Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB6757CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjGRNDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjGRNCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:02:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E019D212F;
        Tue, 18 Jul 2023 06:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31C0B614FB;
        Tue, 18 Jul 2023 13:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1ECC433C7;
        Tue, 18 Jul 2023 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689685268;
        bh=pBS4evmuojvGZNpkpvZA6FWxaaRdlIHQ6sTGa/XNWCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAgLfbJOtr+4I7rn52XFmVGRiSEZGY7xOoxXJ1EQxCHe8l/oD5LehpTXCm3JdU8ET
         00euiRXw07Qk3I4eEEdfmMMjTsSPj2ml/HIpJxGiPqIQrY14+lOMg2eLmflyiEB6Dq
         375ucDgl6JZJKZwqAQOJ4H1ZjCdq7n20z4QrRVb0Pb3ms7M/rRB5Hq3VfKVdi2+QWD
         ygHX4ro1tUjT04KIb23Tj92+dxSmjILwUZng92A1L7nibXGC2cKf03Nwf+VJQCSna8
         2Of8CuSbkv+f6mVIZm433GfUcB2FXO3yZKza0xpOc1TWl8OJhk1XlMee6YU++ijUqC
         5L4T/+H8ExINw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Haren Myneni <haren@us.ibm.com>,
        Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Richard Weinberger <richard@nod.at>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        qat-linux@intel.com, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org
Subject: [RFC PATCH 21/21] crypto: scompress - Drop the use of per-cpu scratch buffers
Date:   Tue, 18 Jul 2023 14:58:47 +0200
Message-Id: <20230718125847.3869700-22-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7664; i=ardb@kernel.org; h=from:subject; bh=pBS4evmuojvGZNpkpvZA6FWxaaRdlIHQ6sTGa/XNWCs=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbT3tLmkjv/s0bnUUz6+YWqHyfYPrt30PrH4wvXi9gu zB/Y2xYRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIRz7DX9kVFbWr6oI67P7v F1mXlcX/zKa5g+2W38JQdYu2A2ZBpxkZrpf3PBfVDpm+YdPJA28zyi5tefKQvYLzLLfrcyn7Rsa DLAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scomp to acomp adaptation layer allocates 256k of scratch buffers
per CPU in order to be able to present the input provided by the caller
via scatterlists as linear byte arrays to the underlying synchronous
compression drivers, most of which are thin wrappers around the various
compression algorithm library implementations we have in the kernel.

This sucks. With high core counts and SMT, this easily adds up to
multiple megabytes that are permanently tied up for this purpose, and
given that all acomp users pass either single pages or contiguous
buffers in lowmem, we can optimize for this pattern and just pass the
buffer directly if we can. This removes the need for scratch buffers,
and along with it, the arbitrary 128k upper bound on the input and
output size of the acomp API when the implementation happens to be scomp
based.

So add a scomp_map_sg() helper to try and obtain the virtual addresses
associated with the scatterlists, which is guaranteed to be successful
100% of the time given the existing users, which all fit the prerequisite
pattern. And as a fallback for other cases, use kvmalloc with GFP_KERNEL
to allocate buffers on the fly and free them again right after.

This puts the burden on future callers to either use a contiguous
buffer, or deal with the potentially blocking nature of GFP_KERNEL.
For IPcomp in particular, the only relevant compression algorithm is
'deflate' which is no longer implemented as an scomp, and so this change
will not affect it even if we decide to convert it to take advantage of
the ability to pass discontiguous scatterlists.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/scompress.c                  | 159 ++++++++++----------
 include/crypto/internal/scompress.h |   2 -
 2 files changed, 76 insertions(+), 85 deletions(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index 3155cdce9116e092..1c050aa864bd604d 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -18,24 +18,11 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/vmalloc.h>
 #include <net/netlink.h>
 
 #include "compress.h"
 
-struct scomp_scratch {
-	spinlock_t	lock;
-	void		*src;
-	void		*dst;
-};
-
-static DEFINE_PER_CPU(struct scomp_scratch, scomp_scratch) = {
-	.lock = __SPIN_LOCK_UNLOCKED(scomp_scratch.lock),
-};
-
 static const struct crypto_type crypto_scomp_type;
-static int scomp_scratch_users;
-static DEFINE_MUTEX(scomp_lock);
 
 static int __maybe_unused crypto_scomp_report(
 	struct sk_buff *skb, struct crypto_alg *alg)
@@ -58,56 +45,45 @@ static void crypto_scomp_show(struct seq_file *m, struct crypto_alg *alg)
 	seq_puts(m, "type         : scomp\n");
 }
 
-static void crypto_scomp_free_scratches(void)
-{
-	struct scomp_scratch *scratch;
-	int i;
-
-	for_each_possible_cpu(i) {
-		scratch = per_cpu_ptr(&scomp_scratch, i);
-
-		vfree(scratch->src);
-		vfree(scratch->dst);
-		scratch->src = NULL;
-		scratch->dst = NULL;
-	}
-}
-
-static int crypto_scomp_alloc_scratches(void)
-{
-	struct scomp_scratch *scratch;
-	int i;
-
-	for_each_possible_cpu(i) {
-		void *mem;
-
-		scratch = per_cpu_ptr(&scomp_scratch, i);
-
-		mem = vmalloc_node(SCOMP_SCRATCH_SIZE, cpu_to_node(i));
-		if (!mem)
-			goto error;
-		scratch->src = mem;
-		mem = vmalloc_node(SCOMP_SCRATCH_SIZE, cpu_to_node(i));
-		if (!mem)
-			goto error;
-		scratch->dst = mem;
-	}
-	return 0;
-error:
-	crypto_scomp_free_scratches();
-	return -ENOMEM;
-}
-
 static int crypto_scomp_init_tfm(struct crypto_tfm *tfm)
 {
-	int ret = 0;
+	return 0;
+}
 
-	mutex_lock(&scomp_lock);
-	if (!scomp_scratch_users++)
-		ret = crypto_scomp_alloc_scratches();
-	mutex_unlock(&scomp_lock);
+/**
+ * scomp_map_sg - Return virtual address of memory described by a scatterlist
+ *
+ * @sg:		The address of the scatterlist in memory
+ * @len:	The length of the buffer described by the scatterlist
+ *
+ * If the memory region described by scatterlist @sg consists of @len
+ * contiguous bytes in memory and is accessible via the linear mapping or via a
+ * single kmap(), return its virtual address.  Otherwise, return NULL.
+ */
+static void *scomp_map_sg(struct scatterlist *sg, unsigned int len)
+{
+	struct page *page;
+	unsigned int offset;
 
-	return ret;
+	while (sg_is_chain(sg))
+		sg = sg_next(sg);
+
+	if (!sg || sg_nents_for_len(sg, len) != 1)
+		return NULL;
+
+	page   = sg_page(sg) + (sg->offset >> PAGE_SHIFT);
+	offset = offset_in_page(sg->offset);
+
+	if (PageHighMem(page) && (offset + sg->length) > PAGE_SIZE)
+		return NULL;
+
+	return kmap_local_page(page) + offset;
+}
+
+static void scomp_unmap_sg(const void *addr)
+{
+	if (is_kmap_addr(addr))
+		kunmap_local(addr);
 }
 
 static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
@@ -116,30 +92,52 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	void **tfm_ctx = acomp_tfm_ctx(tfm);
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
-	struct scomp_scratch *scratch;
+	void *src_alloc = NULL;
+	void *dst_alloc = NULL;
+	const u8 *src;
+	u8 *dst;
 	int ret;
 
-	if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
+	if (!req->src || !req->slen || !req->dst || !req->dlen)
 		return -EINVAL;
 
-	if (!req->dst || !req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
-		return -EINVAL;
-
-	scratch = raw_cpu_ptr(&scomp_scratch);
-	spin_lock(&scratch->lock);
-
-	scatterwalk_map_and_copy(scratch->src, req->src, 0, req->slen, 0);
-	if (dir)
-		ret = crypto_scomp_compress(scomp, scratch->src, req->slen,
-					    scratch->dst, &req->dlen, *ctx);
-	else
-		ret = crypto_scomp_decompress(scomp, scratch->src, req->slen,
-					      scratch->dst, &req->dlen, *ctx);
-	if (!ret) {
-		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
-					 1);
+	dst = scomp_map_sg(req->dst, req->dlen);
+	if (!dst) {
+		dst = dst_alloc = kvmalloc(req->dlen, GFP_KERNEL);
+		if (!dst_alloc)
+			return -ENOMEM;
 	}
-	spin_unlock(&scratch->lock);
+
+	src = scomp_map_sg(req->src, req->slen);
+	if (!src) {
+		src = src_alloc = kvmalloc(req->slen, GFP_KERNEL);
+		if (!src_alloc) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		scatterwalk_map_and_copy(src_alloc, req->src, 0, req->slen, 0);
+	}
+
+	if (dir)
+		ret = crypto_scomp_compress(scomp, src, req->slen, dst,
+					    &req->dlen, *ctx);
+	else
+		ret = crypto_scomp_decompress(scomp, src, req->slen, dst,
+					      &req->dlen, *ctx);
+
+	if (src_alloc)
+		kvfree(src_alloc);
+	else
+		scomp_unmap_sg(src);
+
+	if (!ret && dst == dst_alloc)
+		scatterwalk_map_and_copy(dst, req->dst, 0, req->dlen, 1);
+out:
+	if (dst_alloc)
+		kvfree(dst_alloc);
+	else
+		scomp_unmap_sg(dst);
+
 	return ret;
 }
 
@@ -158,11 +156,6 @@ static void crypto_exit_scomp_ops_async(struct crypto_tfm *tfm)
 	struct crypto_scomp **ctx = crypto_tfm_ctx(tfm);
 
 	crypto_free_scomp(*ctx);
-
-	mutex_lock(&scomp_lock);
-	if (!--scomp_scratch_users)
-		crypto_scomp_free_scratches();
-	mutex_unlock(&scomp_lock);
 }
 
 int crypto_init_scomp_ops_async(struct crypto_tfm *tfm)
diff --git a/include/crypto/internal/scompress.h b/include/crypto/internal/scompress.h
index 858fe3965ae347ef..69e593d72cbdaa99 100644
--- a/include/crypto/internal/scompress.h
+++ b/include/crypto/internal/scompress.h
@@ -12,8 +12,6 @@
 #include <crypto/acompress.h>
 #include <crypto/algapi.h>
 
-#define SCOMP_SCRATCH_SIZE	131072
-
 struct acomp_req;
 
 struct crypto_scomp {
-- 
2.39.2

