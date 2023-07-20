Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9856C75AB66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGTJtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjGTJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:48:19 -0400
Received: from out-48.mta0.migadu.com (out-48.mta0.migadu.com [IPv6:2001:41d0:1004:224b::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DA110A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:47:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQ3vuI5C6djnpQbCi1PW59Gj+FCebISZRVuxTvWKvqo=;
        b=w4MmY0D51B5mbGeKCwtzsoKhqXXNdLV/Jh+Z8f4ocFu4r2lgNM2FMx5joP6MZg61eMRcPe
        SWTBP0I8vkvNLPEK871eybgV69GeQS2Ltb1S/JfKkNAgDSRsA3dseXHhNnlHdXo/ewd8zK
        JY+lUtfuC2q3a1WZ9PWsuyHaW+deVy0=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 3/6] sbitmap: don't loop twice in find_next_zero_bit()
Date:   Thu, 20 Jul 2023 17:45:52 +0800
Message-ID: <20230720094555.1397621-4-chengming.zhou@linux.dev>
In-Reply-To: <20230720094555.1397621-1-chengming.zhou@linux.dev>
References: <20230720094555.1397621-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

__sbitmap_get_shallow() try to allocate a free bit with a limited depth,
which always wrap when finding a free bit in the word, even in the
round-robin case. So it seems we don't need strict round-robin here.

This way will loop twice in find_next_zero_bit() in the word, no point
in looping twice in find_next_zero_bit() if we don't want strict
round-robin for this case.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 lib/sbitmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index ccb96d1f92ba..0f3943bd3940 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -268,7 +268,9 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 	unsigned int index;
 
 	index = SB_NR_TO_INDEX(sb, alloc_hint);
-	alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
+
+	/* No point in looping twice in find_next_zero_bit() for this case. */
+	alloc_hint = 0;
 
 	return sbitmap_find_bit(sb, shallow_depth, index, alloc_hint, true);
 }
-- 
2.41.0

