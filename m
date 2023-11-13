Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E767EA37A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjKMTOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjKMTOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:14:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965BF171A;
        Mon, 13 Nov 2023 11:14:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 116C31F85D;
        Mon, 13 Nov 2023 19:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699902851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZpP3yTw5ZZBFa2ECQqDZfpxxgpcXUank5jkC+X3eYo=;
        b=aPJLjdUI8hKVcvhpJwk5gEbY624MQiQFCDOYdgBwSCjd41pCB1KETdbV2uRpmIDNKx233o
        0mqz3dSDh0+f1jgHWQFD/k9MWDWW6jJ1beMZl5N0JzcgmTTx1yOFBC1QJ+Vjea6Yfgc6Th
        45+Vv1z+SdDlZ/rbg37SCItabUbCC1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699902851;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZpP3yTw5ZZBFa2ECQqDZfpxxgpcXUank5jkC+X3eYo=;
        b=Cs8sRMut++fgm4qFb0T1IW1oy5KIMJWGr5+E9MhgTZbWKEv7hsN8c7F9GoQrGWIhgi9Yw8
        6/UkVL069in7bCAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B52FB13907;
        Mon, 13 Nov 2023 19:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cOyQK4J1UmVFOgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:10 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
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
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 05/20] cpu/hotplug: remove CPUHP_SLAB_PREPARE hooks
Date:   Mon, 13 Nov 2023 20:13:46 +0100
Message-ID: <20231113191340.17482-27-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113191340.17482-22-vbabka@suse.cz>
References: <20231113191340.17482-22-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPUHP_SLAB_PREPARE hooks are only used by SLAB which is removed.
SLUB defines them as NULL, so we can remove those altogether.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 8 --------
 kernel/cpu.c         | 5 -----
 2 files changed, 13 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index d6d6ffeeb9a2..34e43cddc520 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -788,12 +788,4 @@ size_t kmalloc_size_roundup(size_t size);
 
 void __init kmem_cache_init_late(void);
 
-#if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
-int slab_prepare_cpu(unsigned int cpu);
-int slab_dead_cpu(unsigned int cpu);
-#else
-#define slab_prepare_cpu	NULL
-#define slab_dead_cpu		NULL
-#endif
-
 #endif	/* _LINUX_SLAB_H */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9e4c6780adde..530b026d95a1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2125,11 +2125,6 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= relay_prepare_cpu,
 		.teardown.single	= NULL,
 	},
-	[CPUHP_SLAB_PREPARE] = {
-		.name			= "slab:prepare",
-		.startup.single		= slab_prepare_cpu,
-		.teardown.single	= slab_dead_cpu,
-	},
 	[CPUHP_RCUTREE_PREP] = {
 		.name			= "RCU/tree:prepare",
 		.startup.single		= rcutree_prepare_cpu,
-- 
2.42.1

