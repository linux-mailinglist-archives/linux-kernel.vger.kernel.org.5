Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4E375DAE0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjGVHtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 03:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjGVHtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 03:49:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BBA3C3D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 00:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 941496010F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 07:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A43DC433C8;
        Sat, 22 Jul 2023 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690012082;
        bh=6MQ29HDi9RobghOfq9ww6P1ehrV7jdzcjLwHNnWU8TY=;
        h=From:To:Cc:Subject:Date:From;
        b=Kj9zb2QV2XUlO6ArJk7Um1dVjnJix123wkWielmwHI1G12aNiMOftnyppaawHQ2Ev
         9QihLXgFdtBBVHkdUPcfxtp1WVr9oya/sDbZZHbv5Kb0KTENPsRQoJpiK84Nf9JszY
         aSsTkzZicl1F5DjvqaDwI9SkAjwEaPqXUptOLRt+EbkNT4pzyFXhdl5Cyn8e/gkXum
         e76D0qNn7Zm3o1CUc/bhEHQtKDqPC4tV5gIUdbrXCZmma6fqI8R8SpEqaQeIK8ZVYJ
         HoNqbHSk/r12c+HB/7bmVVjDFGFtClCwxaOpVGUlPJlPNz0x5ot1ozRxr9xlTQOSuh
         fZztE9O4HIqIg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: force inc_active()/dec_active() to be inline functions
Date:   Sat, 22 Jul 2023 09:47:44 +0200
Message-Id: <20230722074753.568696-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Splitting these out into separate helper functions means that we
actually pass an uninitialized variable into another function call
if dec_active() happens to not be inlined, and CONFIG_PREEMPT_RT
is disabled:

kernel/bpf/memalloc.c: In function 'add_obj_to_free_list':
kernel/bpf/memalloc.c:200:9: error: 'flags' is used uninitialized [-Werror=uninitialized]
  200 |         dec_active(c, flags);

Mark the two functions as __always_inline so gcc can see through
this regardless of optimizations and other options that may
prevent it otherwise.

Fixes: 18e027b1c7c6d ("bpf: Factor out inc/dec of active flag into helpers.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/memalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 51d6389e5152e..23906325298da 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -165,7 +165,7 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
-static void inc_active(struct bpf_mem_cache *c, unsigned long *flags)
+static __always_inline void inc_active(struct bpf_mem_cache *c, unsigned long *flags)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		/* In RT irq_work runs in per-cpu kthread, so disable
@@ -183,7 +183,7 @@ static void inc_active(struct bpf_mem_cache *c, unsigned long *flags)
 	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
 }
 
-static void dec_active(struct bpf_mem_cache *c, unsigned long flags)
+static __always_inline void dec_active(struct bpf_mem_cache *c, unsigned long flags)
 {
 	local_dec(&c->active);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-- 
2.39.2

