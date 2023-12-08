Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755DF8097E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444220AbjLHAxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjLHAxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:53:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A843172D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:53:16 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c5daf2baccso17492397b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996795; x=1702601595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPnDX1rYMAtCe+hQ8qdPonfWEnFnkE5EPZQcdSbkY2c=;
        b=tItI9ksJxKZZeSA4cIlz1awMH257FvktV3a5FQasmksOiVe6EDUTdc38DlVmY9AMUv
         1yUbt++nhyY11JmQKVKMdqq/CKI60A8ETh2zdhXhofyLY1NvfvxI27vAS+LaBEfcsC0m
         dMAr4tkoEokr4qCBaTMo4v6nkfqhHxyI7j+wwuw3MRT2niwmzCRi6fGzm0jpDy+wGnvE
         PZvJaSLBlM5QaFpeBtM0oCVky9+C8Jg5N9L//cguRIlLlMuU524zOQUz7g3+6xyaACVK
         H4SLrLLPCGbX164C9j9lRBfetzidTop22PysOSNLg7487MDm0dggC/tegdH5rd8KCgry
         Sp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996795; x=1702601595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPnDX1rYMAtCe+hQ8qdPonfWEnFnkE5EPZQcdSbkY2c=;
        b=wfrh5rYuJBkAmgEK5GW85mB1dsq0hqHr7SMLlDp01xPRGW8ggiq9shlhOkZfixXZco
         MbMdZTtPrhdI4MeLGuHb9E7uEEulb/nv5da9oaNJ9bDEH+Lt5dOXhWIonxJbqD6Kl9+T
         6LsJLShhCuEII8KUJOrBPjrP0f1Tmp/lf2gn2k/aJKcdCohQ5bygUNYIpo7amD9CO9l9
         c3Aa3IvDSroE3okcBEQoF8uSaCKwVBVA/rteYjc1E8r7SWe1ZmCtWh9dEJOBGgNTsA7j
         08jsTWuO6lG65pRipLcIklJhMHebudtcVAz8C9X8awxjPYKWPkpFW/yA7em8Q6Nw1TKN
         lOVA==
X-Gm-Message-State: AOJu0Ywx6dcR+VAyXIYojEHvdTyGPywDVEAa6E2lMsXoGXGcxfM8pTUt
        /hYLtPtUt80GljocxmjTh1GuR0RkPzGOrkr0ag==
X-Google-Smtp-Source: AGHT+IEKP0wg/owThAA3/mC6Vxrn1R6Pw24Bozp4eJkoXp2s6/m2Qgw2X1bYwO4di4FgizGGC3rWfu0KjgUDlNjaXA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:4707:b0:5d4:ce2:e908 with
 SMTP id gz7-20020a05690c470700b005d40ce2e908mr53364ywb.3.1701996795620; Thu,
 07 Dec 2023 16:53:15 -0800 (PST)
Date:   Thu,  7 Dec 2023 16:52:41 -0800
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-11-almasrymina@google.com>
Subject: [net-next v1 10/16] page_pool: don't release iov on elevanted refcount
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

Currently the page_pool behavior is that a page is considered for
recycling only once, the first time __page_pool_put_page() is called on
it.

This works because in practice the net stack only holds 1 reference to
the skb frags. In that case, the page_pool recycling works as expected,
as the skb frags will have 1 reference on the pages from the net stack
when __page_pool_put_page() is called (if the driver is not holding
extra references for recycling), and so the page will be recycled.

However, this is not compatible with devmem TCP. For devmem TCP, the net
stack holds 2 references for each frag, 1 reference is part of the SKB,
and the second reference is for the user holding the frag until they
call SO_DEVMEM_DONTNEED. This causes a bug in the page_pool recycling
where, when the skb is freed, the reference count goes from 2->1, the
page_pool sees a pending reference, releases the page, and so no devmem
iovs get recycled.

To fix this, don't release iovs on elevated refcount.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f0148d66371b..dc2a148f5b06 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -731,6 +731,29 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 		/* Page found as candidate for recycling */
 		return page;
 	}
+
+	if (page_is_page_pool_iov(page)) {
+		/* With devmem TCP and ppiovs, we can't release pages if the
+		 * refcount is > 1. This is because the net stack holds
+		 * 2 references:
+		 *	- 1 for the skb, and
+		 *	- 1 for the user until they call SO_DEVMEM_DONTNEED.
+		 * Releasing pages for elevated refcounts completely disables
+		 * page_pool recycling. Instead, simply don't release pages and
+		 * the next call to napi_pp_put_page() via SO_DEVMEM_DONTNEED
+		 * will consider the page again for recycling. As a result,
+		 * devmem TCP incompatible with drivers doing refcnt based
+		 * recycling unless those drivers:
+		 *
+		 * - don't mark skb_mark_for_recycle()
+		 * - are sure to release the last reference with
+		 *   page_pool_put_full_page() to consider the page for
+		 *   page_pool recycling.
+		 */
+		page_pool_page_put_many(page, 1);
+		return NULL;
+	}
+
 	/* Fallback/non-XDP mode: API user have elevated refcnt.
 	 *
 	 * Many drivers split up the page into fragments, and some
-- 
2.43.0.472.g3155946c3a-goog

