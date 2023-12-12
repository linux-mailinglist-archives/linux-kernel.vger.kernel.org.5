Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6EA80DFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbjLLAOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbjLLAOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:14:05 -0500
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170FBB5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:14:12 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702340050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OwbAGppKL3WPs8Dt+2mYc7aec7Z15bPqx/lY8lY4n/4=;
        b=AhuNEvWc+xId+ebmaR6PLfGdXFqw+Wg1SNRrPQ1ZlK1Sc1etaByaW4J7PAGKThBVnj447n
        j8TePKCfHAMCJ1KwilljkT2LUfiq2L5u0pH0HA7XJfeRd1JbF++UGx/w+zfsttHD227a+f
        IZQYQmT7JGekNhMS5pIy488rlfoaazI=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 3/4] kasan: memset free track in qlink_free
Date:   Tue, 12 Dec 2023 01:14:02 +0100
Message-Id: <d0943bd69fdfe27fbda20fde9b143e57c825546f.1702339432.git.andreyknvl@google.com>
In-Reply-To: <cover.1702339432.git.andreyknvl@google.com>
References: <cover.1702339432.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Instead of only zeroing out the stack depot handle when evicting the
free stack trace in qlink_free, zero out the whole track.

Do this just to produce a similar effect for alloc and free meta. The
other fields of the free track besides the stack trace handle are
considered invalid at this point anyway, so no harm in zeroing them out.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

This can be squashed into "kasan: use stack_depot_put for Generic mode"
or left standalone.
---
 mm/kasan/quarantine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 265ca2bbe2dd..782e045da911 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -157,7 +157,7 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 	if (free_meta &&
 	    *(u8 *)kasan_mem_to_shadow(object) == KASAN_SLAB_FREETRACK) {
 		stack_depot_put(free_meta->free_track.stack);
-		free_meta->free_track.stack = 0;
+		__memset(&free_meta->free_track, 0, sizeof(free_meta->free_track));
 	}
 
 	/*
-- 
2.25.1

