Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDE57A6C89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjISUwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:52:21 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A50FBD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:52:14 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 51999C361C1D; Tue, 19 Sep 2023 13:51:59 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Carl Klemm <carl@uvos.xyz>
Subject: [PATCH v1 1/2] mm/ksm: support fork/exec for prctl
Date:   Tue, 19 Sep 2023 13:51:57 -0700
Message-Id: <20230919205158.1897353-2-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230919205158.1897353-1-shr@devkernel.io>
References: <20230919205158.1897353-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A process can enable KSM with the prctl system call. When the process is
forked the KSM flag is inherited by the child process. However if the
process is executing an exec system call directly after the fork, the
KSM setting is cleared. This patch addresses this problem.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Reported-by: Carl Klemm <carl@uvos.xyz>
---
 include/linux/sched/coredump.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredum=
p.h
index 0ee96ea7a0e9..205aa9917394 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -87,8 +87,11 @@ static inline int get_dumpable(struct mm_struct *mm)
=20
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
=20
+#define MMF_VM_MERGE_ANY	29
+#define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
+
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
-				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
+				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
+				 MMF_VM_MERGE_ANY_MASK)
=20
-#define MMF_VM_MERGE_ANY	29
 #endif /* _LINUX_SCHED_COREDUMP_H */
--=20
2.39.3

