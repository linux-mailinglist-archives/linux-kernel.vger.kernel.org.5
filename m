Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B2D75AB61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGTJso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjGTJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:48:10 -0400
Received: from out-2.mta0.migadu.com (out-2.mta0.migadu.com [91.218.175.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF702704
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:47:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQrUdY1vRsj8E+dCm96975wE2JF9r7J+GLmQavXqC6U=;
        b=ppP0xq24ptj/OlMY3SPOuHL6Ff4dQYJc12lo4pwlHFUru/0kT+yUO+nGANDCOXMijpY0zh
        0xRV/YP9illwyEGWdRzcnR+C2a2oqd4/o3nAXfqCCcJ3QCVAM4J4lj3lf7TdGBwhgX25Kc
        aqsmNNgQe9Mnd4K/gYhs9jp73e9/KfE=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 1/6] sbitmap: fix hint wrap in the failure case
Date:   Thu, 20 Jul 2023 17:45:50 +0800
Message-ID: <20230720094555.1397621-2-chengming.zhou@linux.dev>
In-Reply-To: <20230720094555.1397621-1-chengming.zhou@linux.dev>
References: <20230720094555.1397621-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

```
hint = nr + 1;
if (hint >= depth - 1)
	hint = 0;
```

Now we wrap the hint to 0 in the failure case, but:
1. hint == depth - 1, is actually an available offset hint, which
   we shouldn't wrap hint to 0.
2. In the strict round_robin non-wrap case, we shouldn't wrap at all.

```
wrap = wrap && hint;
```

We only need to check wrap based on the original hint ( > 0), don't need
to recheck the new hint which maybe updated in the failure case.
Also delete the mismatched comments by the way.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 lib/sbitmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index eff4e42c425a..5ed6c2adf58e 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -144,12 +144,7 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 	while (1) {
 		nr = find_next_zero_bit(word, depth, hint);
 		if (unlikely(nr >= depth)) {
-			/*
-			 * We started with an offset, and we didn't reset the
-			 * offset to 0 in a failure case, so start from 0 to
-			 * exhaust the map.
-			 */
-			if (hint && wrap) {
+			if (wrap) {
 				hint = 0;
 				continue;
 			}
@@ -160,8 +155,13 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 			break;
 
 		hint = nr + 1;
-		if (hint >= depth - 1)
-			hint = 0;
+		if (hint >= depth) {
+			if (wrap) {
+				hint = 0;
+				continue;
+			}
+			return -1;
+		}
 	}
 
 	return nr;
-- 
2.41.0

