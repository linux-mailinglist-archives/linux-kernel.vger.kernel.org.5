Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D697863C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbjHWWzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbjHWWye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:54:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B4211F;
        Wed, 23 Aug 2023 15:54:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc63ef9959so48077225ad.2;
        Wed, 23 Aug 2023 15:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692831271; x=1693436071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/9S+DT2bHHVQ86J/5iRoGc+MToWBUPT+Ym29+JuIKg=;
        b=eJTAKWCXuX8SYXR9BsX7cHdZHzFMGkmtyNAu70Fu9BYIdErK5ut2ay+EPF0nz0o3ui
         LwHuyNUHtTFacbHeE9uKbFtV125xYZppGGfSxq95ExGE0W3NaSXgHr4geEpa06CplJjh
         /XZIZM2jLdXTm1LEYThSyZWBtd7Vx/WsEZYRTuZTHv48hP8I3a4xXq1EOZ7t3A/QOGAJ
         Jt1Hgkw6F1MxcKI98IYb8lswxFznnFUy1SZ6ZD3PNg8XD9SkFN3UCPpChU9G0jiHy3Nc
         GIoTn4N0RNZ2IP6Pmvyyw4rNGYDwuYfldF+mAO3xU3LCnsu/22t/9ViQO/4DShSLKHd0
         zuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692831271; x=1693436071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/9S+DT2bHHVQ86J/5iRoGc+MToWBUPT+Ym29+JuIKg=;
        b=YK/cxPlZ1+ppYoR9UV9Gg4gcjAk4roba6tCc7DJ0AErueExEcXUVlDPLpxCWmFSiOk
         vuMoIrJbNTb3PuSJsSl6Ugjs7ikDOolFb2+bkgSZPsnwHlFQb6ONedpVg/dwlEloslye
         fneafkRM74pwQaovHDKoWJwi7yL9BqhmUA1GJJxg1E+RhDdpXDv1DBbirwVkHquNBymB
         67SLok897M2nl3ntKloyOf5AvvS61t3U36WbylFR84eucZsgPMISeHMgiQO31TLdsEEh
         V1FSQN4FfTCTlly2JRy0+i8c2OQxfPdZS94kRt7oSpwOIbKmmoBKZ0BtBBpjzZ18ZC1m
         4S+Q==
X-Gm-Message-State: AOJu0YwMjZ3bfFZYFIgVxIjingKbKu/xpd04euMGsjgB5CzTaHqWj9HW
        oEkhYKgQ0aD97UhKpJm5q4k=
X-Google-Smtp-Source: AGHT+IEeNBWJK5VzE7/ifUxQkJ5yjcrSJK0P7ivC5qGgi4VZPuGX0n62hO54VT6gphCIIkakKFBTjQ==
X-Received: by 2002:a17:902:748b:b0:1bf:2e5c:7367 with SMTP id h11-20020a170902748b00b001bf2e5c7367mr12571767pll.42.1692831271504;
        Wed, 23 Aug 2023 15:54:31 -0700 (PDT)
Received: from localhost (fwdproxy-prn-010.fbsv.net. [2a03:2880:ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902e9c600b001b895336435sm11362796plk.21.2023.08.23.15.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 15:54:31 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, kernel-team@meta.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        yosryahmed@google.com
Subject: [PATCH] memcontrol: ensure memcg acquired by id is properly set up
Date:   Wed, 23 Aug 2023 15:54:30 -0700
Message-Id: <20230823225430.166925-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

In the eviction recency check, we attempt to retrieve the memcg to which
the folio belonged when it was evicted, by the memcg id stored in the
shadow entry. However, there is a chance that the retrieved memcg is not
the original memcg that has been killed, but a new one which happens to
have the same id.

This is a somewhat unfortunate, but acceptable and rare inaccuracy in
the heuristics. However, if we retrieve this new memcg between its
allocation and when it is properly attached to the memcg hierarchy, we
could run into the following NULL pointer exception during the memcg
hierarchy traversal done in mem_cgroup_get_nr_swap_pages():

[ 155757.793456] BUG: kernel NULL pointer dereference, address: 00000000000000c0
[ 155757.807568] #PF: supervisor read access in kernel mode
[ 155757.818024] #PF: error_code(0x0000) - not-present page
[ 155757.828482] PGD 401f77067 P4D 401f77067 PUD 401f76067 PMD 0
[ 155757.839985] Oops: 0000 [#1] SMP
[ 155757.887870] RIP: 0010:mem_cgroup_get_nr_swap_pages+0x3d/0xb0
[ 155757.899377] Code: 29 19 4a 02 48 39 f9 74 63 48 8b 97 c0 00 00 00 48 8b b7 58 02 00 00 48 2b b7 c0 01 00 00 48 39 f0 48 0f 4d c6 48 39 d1 74 42 <48> 8b b2 c0 00 00 00 48 8b ba 58 02 00 00 48 2b ba c0 01 00 00 48
[ 155757.937125] RSP: 0018:ffffc9002ecdfbc8 EFLAGS: 00010286
[ 155757.947755] RAX: 00000000003a3b1c RBX: 000007ffffffffff RCX: ffff888280183000
[ 155757.962202] RDX: 0000000000000000 RSI: 0007ffffffffffff RDI: ffff888bbc2d1000
[ 155757.976648] RBP: 0000000000000001 R08: 000000000000000b R09: ffff888ad9cedba0
[ 155757.991094] R10: ffffea0039c07900 R11: 0000000000000010 R12: ffff888b23a7b000
[ 155758.005540] R13: 0000000000000000 R14: ffff888bbc2d1000 R15: 000007ffffc71354
[ 155758.019991] FS:  00007f6234c68640(0000) GS:ffff88903f9c0000(0000) knlGS:0000000000000000
[ 155758.036356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 155758.048023] CR2: 00000000000000c0 CR3: 0000000a83eb8004 CR4: 00000000007706e0
[ 155758.062473] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 155758.076924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 155758.091376] PKRU: 55555554
[ 155758.096957] Call Trace:
[ 155758.102016]  <TASK>
[ 155758.106502]  ? __die+0x78/0xc0
[ 155758.112793]  ? page_fault_oops+0x286/0x380
[ 155758.121175]  ? exc_page_fault+0x5d/0x110
[ 155758.129209]  ? asm_exc_page_fault+0x22/0x30
[ 155758.137763]  ? mem_cgroup_get_nr_swap_pages+0x3d/0xb0
[ 155758.148060]  workingset_test_recent+0xda/0x1b0
[ 155758.157133]  workingset_refault+0xca/0x1e0
[ 155758.165508]  filemap_add_folio+0x4d/0x70
[ 155758.173538]  page_cache_ra_unbounded+0xed/0x190
[ 155758.182919]  page_cache_sync_ra+0xd6/0x1e0
[ 155758.191738]  filemap_read+0x68d/0xdf0
[ 155758.199495]  ? mlx5e_napi_poll+0x123/0x940
[ 155758.207981]  ? __napi_schedule+0x55/0x90
[ 155758.216095]  __x64_sys_pread64+0x1d6/0x2c0
[ 155758.224601]  do_syscall_64+0x3d/0x80
[ 155758.232058]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 155758.242473] RIP: 0033:0x7f62c29153b5
[ 155758.249938] Code: e8 48 89 75 f0 89 7d f8 48 89 4d e0 e8 b4 e6 f7 ff 41 89 c0 4c 8b 55 e0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 45 f8 e8 e7 e6 f7 ff 48 8b
[ 155758.288005] RSP: 002b:00007f6234c5ffd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
[ 155758.303474] RAX: ffffffffffffffda RBX: 00007f628c4e70c0 RCX: 00007f62c29153b5
[ 155758.318075] RDX: 000000000003c041 RSI: 00007f61d2986000 RDI: 0000000000000076
[ 155758.332678] RBP: 00007f6234c5fff0 R08: 0000000000000000 R09: 0000000064d5230c
[ 155758.347452] R10: 000000000027d450 R11: 0000000000000293 R12: 000000000003c041
[ 155758.362044] R13: 00007f61d2986000 R14: 00007f629e11b060 R15: 000000000027d450
[ 155758.376661]  </TASK>

This patch fixes the issue by moving the memcg's id publication from the
alloc stage to online stage, ensuring that any memcg acquired via id
must be connected to the memcg tree.

Fixes: f78dfc7b77d5 ("workingset: fix confusion around eviction vs refault container")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Co-developed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Cc: stable@vger.kernel.org
---
 mm/memcontrol.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cf57fe9318d5..6d67a3a81cd9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5326,7 +5326,6 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
 	memcg->deferred_split_queue.split_queue_len = 0;
 #endif
-	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	lru_gen_init_memcg(memcg);
 	return memcg;
 fail:
@@ -5398,14 +5397,27 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (alloc_shrinker_info(memcg))
 		goto offline_kmem;
 
-	/* Online state pins memcg ID, memcg ID pins CSS */
-	refcount_set(&memcg->id.ref, 1);
-	css_get(css);
-
 	if (unlikely(mem_cgroup_is_root(memcg)))
 		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
 				   FLUSH_TIME);
 	lru_gen_online_memcg(memcg);
+
+	/* Online state pins memcg ID, memcg ID pins CSS */
+	refcount_set(&memcg->id.ref, 1);
+	css_get(css);
+
+	/*
+	 * Ensure mem_cgroup_from_id() works once we're fully online.
+	 *
+	 * We could do this earlier and require callers to filter with
+	 * css_tryget_online(). But right now there are no users that
+	 * need earlier access, and the workingset code relies on the
+	 * cgroup tree linkage (mem_cgroup_get_nr_swap_pages()). So
+	 * publish it here at the end of onlining. This matches the
+	 * regular ID destruction during offlining.
+	 */
+	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
+
 	return 0;
 offline_kmem:
 	memcg_offline_kmem(memcg);
-- 
2.34.1

