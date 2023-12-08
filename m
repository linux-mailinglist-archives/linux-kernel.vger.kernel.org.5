Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E2E8097B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjLHAwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjLHAwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:52:51 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F21721
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:52:57 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d1ed4b268dso18386367b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996777; x=1702601577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfCMsfp1IUoZ64EVVtr7gxYSAUWCUtGUA5R8s2RxKzs=;
        b=XWkp78Jt2QfvZg8KL7llBcvri5RjxOftzxLo0jx+7924tKzy++MPlqogZva2qqiyHY
         +bueHNbRUnR3T9ac90rBm7qI3/wDGbnJN/nP8rsklNS96u4ZWHZSFl+syYtRZ0VX77x3
         4H+75nfKvExAlegJE/i8inw6F53Al++9/MEQy42vYTBYdujlyUcroYYZtih02yNAIzge
         8n9USaAsYZMIKt5sMYTcgQ2a0AtrWPCAh6X7T6YCdxNsTCfWn+sGys4zJnbJwZRVveoz
         xBNWojBDl1810EOBaMMJh2y57X8lkYKiRr9DE5U1SXABZldjMU/S2aKk893QNxUF4YmV
         Pt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996777; x=1702601577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfCMsfp1IUoZ64EVVtr7gxYSAUWCUtGUA5R8s2RxKzs=;
        b=j+6iJ7ABxSbzGJSTgKp+VVtC6qz4Ad7jGj1gmiMdxRwVy9wO2cV6bdjyCvOIEJZeBj
         lN+vup2yZ2Qt6h0cNxTgpeeQhjex8cBHvHK3abLi0HGCECzCJnLiFFd5eXAVFSkhCuEE
         hJelNOYCiI62c6mJmiqGWmmBNb2012/onCacLlm099IdJOZkg4Q3ETScOCCWDrehq6aB
         bOzW2pqv9GEwnMm946K3pcr/dO6PnxYB85zrsBzRwBAhNl6F23WRXOpKr2UWBmv22akw
         37c6lxfX2jCjEV/WLFbNH8DF/0bys/nQ8jQVKaRZR2+XWj517TzJENZrvsVy55Km3ies
         q1Cg==
X-Gm-Message-State: AOJu0YwDPqzeaihc0MV7CMb0kHOBPljrHCUGxtAcjZI1bYFbdd70gDnG
        v9HOen+w49MaH884n1E+40unWgIivm/jx3/zzA==
X-Google-Smtp-Source: AGHT+IEutjJnS2EH/ZQ+5x+IuH211lQgvDfZASfUKd2jgJtW5JenzTRObxK0Vp6bTrTGEljS7VIcMH18dMhy9n5y3A==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a81:441f:0:b0:5d5:5183:ebdb with SMTP
 id r31-20020a81441f000000b005d55183ebdbmr57205ywa.10.1701996776836; Thu, 07
 Dec 2023 16:52:56 -0800 (PST)
Date:   Thu,  7 Dec 2023 16:52:32 -0800
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-2-almasrymina@google.com>
Subject: [net-next v1 01/16] net: page_pool: factor out releasing DMA from
 releasing the page
From:   Mina Almasry <almasrymina@google.com>
To:     Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Mina Almasry <almasrymina@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

Releasing the DMA mapping will be useful for other types
of pages, so factor it out. Make sure compiler inlines it,
to avoid any regressions.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

This is implemented by Jakub in his RFC:

https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com/T/

I take no credit for the idea or implementation. This is a critical
dependency of device memory TCP and thus I'm pulling it into this series
to make it revewable and mergable.

---
 net/core/page_pool.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index c2e7c9a6efbe..ca1b3b65c9b5 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -548,21 +548,16 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 	return inflight;
 }
 
-/* Disconnects a page (from a page_pool).  API users can have a need
- * to disconnect a page (from a page_pool), to allow it to be used as
- * a regular page (that will eventually be returned to the normal
- * page-allocator via put_page).
- */
-static void page_pool_return_page(struct page_pool *pool, struct page *page)
+static __always_inline
+void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
 {
 	dma_addr_t dma;
-	int count;
 
 	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
 		/* Always account for inflight pages, even if we didn't
 		 * map them
 		 */
-		goto skip_dma_unmap;
+		return;
 
 	dma = page_pool_get_dma_addr(page);
 
@@ -571,7 +566,19 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr(page, 0);
-skip_dma_unmap:
+}
+
+/* Disconnects a page (from a page_pool).  API users can have a need
+ * to disconnect a page (from a page_pool), to allow it to be used as
+ * a regular page (that will eventually be returned to the normal
+ * page-allocator via put_page).
+ */
+void page_pool_return_page(struct page_pool *pool, struct page *page)
+{
+	int count;
+
+	__page_pool_release_page_dma(pool, page);
+
 	page_pool_clear_pp_info(page);
 
 	/* This may be the last page returned, releasing the pool, so
-- 
2.43.0.472.g3155946c3a-goog

