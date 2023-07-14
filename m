Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C436C754038
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjGNRLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbjGNRKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:10:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197763ABC;
        Fri, 14 Jul 2023 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689354646; x=1720890646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lhIzZFfcEcJps7lcQP/nAxoYlG5hsQcTY92/w+e8fV0=;
  b=i5V95Dfo6doULw0JXaLxr92vplBvnp7Tjj7oNrBmEImxmIACcM7mbQex
   kF7wyvl2e4vX5zrOG82GFIzQYQm655fsn3RJK5oQAN1D0jZfC0AEDGdAm
   It61f+Y9JcaykvHySfdTandDnPgyWXZExUCTa7yNg1y4ZndPAiRzujuwT
   oDFgLq6d9W2puC5ylPSNjXDlz26wcTJxFJwkq4QV20SXcRtR+NFe5c0nY
   hoHjryQsApt3q5y61heYQO4Brc0Uct+zXTkvpaeJIVo8FKc9ju6lHe4iY
   jaSKdsJrqZ/HkmZVeJ8pld4tzeq1ykmaudeYqlCskWs3i58FkcgrK8dKw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="451891946"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="451891946"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="787907090"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="787907090"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2023 10:10:41 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v2 6/7] net: skbuff: avoid accessing page_pool if !napi_safe when returning page
Date:   Fri, 14 Jul 2023 19:08:51 +0200
Message-ID: <20230714170853.866018-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714170853.866018-1-aleksander.lobakin@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, pp->p.napi is always read, but the actual variable it gets
assigned to is read-only when @napi_safe is true. For the !napi_safe
cases, which yet is still a pack, it's an unneeded operation.
Moreover, it can lead to premature or even redundant page_pool
cacheline access. For example, when page_pool_is_last_frag() returns
false (with the recent frag improvements).
Thus, read it only when @napi_safe is true. This also allows moving
@napi inside the condition block itself. Constify it while we are
here, because why not.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/skbuff.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4de280c454e4..fc1470aab5cf 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -881,9 +881,8 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 
 bool page_pool_return_skb_page(struct page *page, bool napi_safe)
 {
-	struct napi_struct *napi;
+	bool allow_direct = false;
 	struct page_pool *pp;
-	bool allow_direct;
 
 	page = compound_head(page);
 
@@ -903,9 +902,12 @@ bool page_pool_return_skb_page(struct page *page, bool napi_safe)
 	 * in the same context as the consumer would run, so there's
 	 * no possible race.
 	 */
-	napi = READ_ONCE(pp->p.napi);
-	allow_direct = napi_safe && napi &&
-		READ_ONCE(napi->list_owner) == smp_processor_id();
+	if (napi_safe) {
+		const struct napi_struct *napi = READ_ONCE(pp->p.napi);
+
+		allow_direct = napi &&
+			READ_ONCE(napi->list_owner) == smp_processor_id();
+	}
 
 	/* Driver set this to memory recycling info. Reset it on recycle.
 	 * This will *not* work for NIC using a split-page memory model.
-- 
2.41.0

