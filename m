Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A845798CD3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbjIHSSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbjIHSST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:18:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C624126A5;
        Fri,  8 Sep 2023 11:17:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4846C116C9;
        Fri,  8 Sep 2023 18:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196951;
        bh=6z5fHVoFtm3zAuIl+nLazhpZWYNxVKrPQUCEKNYBfdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dqa/ToTkPhTyLwXpQwfsRVXb7LouyCrfoD6T3LLLWP/mgpVKsAPzP4qIUXuvQcKy9
         hhJ9pKhTMiojSJZpYVgNd7d0632THssba+ZQRN+agfmn6YbXFB6xnbLlWkqgn4angq
         dGjz0go9JwCz9HRemUD9QsAaQ0iLNq1Xu/3qg+Z1prpqfp3Ns8E46zuaIvw3MGRg5E
         CXUz84gdnCFj7sV5OflSN8k/JgW230ShltSGfXv1LNxPgmJlxy+nZOvUjxf1fXEeYm
         HY4D4TklSAPvFCMiZGNy4JbtiXXYocemy9FsNquK+ce7ACsi9CBh//SWI6Tlh9DThp
         nF76CBeXeC13Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 44/45] bpf: Consider non-owning refs trusted
Date:   Fri,  8 Sep 2023 14:13:25 -0400
Message-Id: <20230908181327.3459042-44-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Marchevsky <davemarchevsky@fb.com>

[ Upstream commit 2a6d50b50d6d589d43a90d6ca990b8b811e67701 ]

Recent discussions around default kptr "trustedness" led to changes such
as commit 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the
verifier."). One of the conclusions of those discussions, as expressed
in code and comments in that patch, is that we'd like to move away from
'raw' PTR_TO_BTF_ID without some type flag or other register state
indicating trustedness. Although PTR_TRUSTED and PTR_UNTRUSTED flags mark
this state explicitly, the verifier currently considers trustedness
implied by other register state. For example, owning refs to graph
collection nodes must have a nonzero ref_obj_id, so they pass the
is_trusted_reg check despite having no explicit PTR_{UN}TRUSTED flag.
This patch makes trustedness of non-owning refs to graph collection
nodes explicit as well.

By definition, non-owning refs are currently trusted. Although the ref
has no control over pointee lifetime, due to non-owning ref clobbering
rules (see invalidate_non_owning_refs) dereferencing a non-owning ref is
safe in the critical section controlled by bpf_spin_lock associated with
its owning collection.

Note that the previous statement does not hold true for nodes with shared
ownership due to the use-after-free issue that this series is
addressing. True shared ownership was disabled by commit 7deca5eae833
("bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed"),
though, so the statement holds for now. Further patches in the series will change
the trustedness state of non-owning refs before re-enabling
bpf_refcount_acquire.

Let's add NON_OWN_REF type flag to BPF_REG_TRUSTED_MODIFIERS such that a
non-owning ref reg state would pass is_trusted_reg check. Somewhat
surprisingly, this doesn't result in any change to user-visible
functionality elsewhere in the verifier: graph collection nodes are all
marked MEM_ALLOC, which tends to be handled in separate codepaths from
"raw" PTR_TO_BTF_ID. Regardless, let's be explicit here and document the
current state of things before changing it elsewhere in the series.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20230821193311.3290257-3-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_verifier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f70f9ac884d24..b6e58dab8e275 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -745,7 +745,7 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
 	}
 }
 
-#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
+#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED | NON_OWN_REF)
 
 static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 {
-- 
2.40.1

