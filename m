Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F457F1C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjKTSey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjKTSeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:34:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF680E7;
        Mon, 20 Nov 2023 10:34:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 60AD51F8AA;
        Mon, 20 Nov 2023 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700505281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GrBCfvjCtpiJqa8ygwZPoxY8exS+14FRB1r254RD0U=;
        b=FPhfQvkViYNNlLlkqIEvH6iJhcWdFbB1ez85bYh8m3z0ThOtjlrGrlmkMjnw1bYrcZgkBZ
        s6BizyqBVl8v6MFrHNRVozqNd5S2ikSD9cqJht54OgsPIAffS3/d1cwqTw3lAUtEvsWuJR
        FLk+oJYbPTunJNoefJgvn9jcqiA5k9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700505281;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GrBCfvjCtpiJqa8ygwZPoxY8exS+14FRB1r254RD0U=;
        b=7Bn+lpV9eESttWXYK2/IDuDAs+80Cw4I8lxuhU97Ce0QM22jBm6pBGT4R79YoOPE2qKvAP
        JIqClnPt2p9h8XCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30A8113912;
        Mon, 20 Nov 2023 18:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EAFrC8GmW2UUMgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 20 Nov 2023 18:34:41 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
Date:   Mon, 20 Nov 2023 19:34:19 +0100
Subject: [PATCH v2 08/21] mm/mempool/dmapool: remove CONFIG_DEBUG_SLAB
 ifdefs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-slab-remove-slab-v2-8-9c9c70177183@suse.cz>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
In-Reply-To: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, linux-hardening@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.12.4
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 1.30
X-Spamd-Result: default: False [1.30 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         R_RATELIMIT(0.00)[to_ip_from(RL563rtnmcmc9sawm86hmgtctc)];
         BAYES_SPAM(5.10)[100.00%];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[24];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.dev,google.com,arm.com,cmpxchg.org,kernel.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_SLAB is going away with CONFIG_SLAB, so remove dead ifdefs
in mempool and dmapool code.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/dmapool.c | 2 +-
 mm/mempool.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index a151a21e571b..f0bfc6c490f4 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -36,7 +36,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 
-#if defined(CONFIG_DEBUG_SLAB) || defined(CONFIG_SLUB_DEBUG_ON)
+#ifdef CONFIG_SLUB_DEBUG_ON
 #define DMAPOOL_DEBUG 1
 #endif
 
diff --git a/mm/mempool.c b/mm/mempool.c
index 734bcf5afbb7..4759be0ff9de 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -20,7 +20,7 @@
 #include <linux/writeback.h>
 #include "slab.h"
 
-#if defined(CONFIG_DEBUG_SLAB) || defined(CONFIG_SLUB_DEBUG_ON)
+#ifdef CONFIG_SLUB_DEBUG_ON
 static void poison_error(mempool_t *pool, void *element, size_t size,
 			 size_t byte)
 {
@@ -95,14 +95,14 @@ static void poison_element(mempool_t *pool, void *element)
 		kunmap_atomic(addr);
 	}
 }
-#else /* CONFIG_DEBUG_SLAB || CONFIG_SLUB_DEBUG_ON */
+#else /* CONFIG_SLUB_DEBUG_ON */
 static inline void check_element(mempool_t *pool, void *element)
 {
 }
 static inline void poison_element(mempool_t *pool, void *element)
 {
 }
-#endif /* CONFIG_DEBUG_SLAB || CONFIG_SLUB_DEBUG_ON */
+#endif /* CONFIG_SLUB_DEBUG_ON */
 
 static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 {

-- 
2.42.1

