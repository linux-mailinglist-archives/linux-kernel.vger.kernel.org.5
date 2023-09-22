Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE177ABAED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjIVVMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjIVVML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:12:11 -0400
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5AEFB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 14:12:05 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 7D7E9C60DC4C; Fri, 22 Sep 2023 14:11:49 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Carl Klemm <carl@uvos.xyz>
Subject: [PATCH v4 1/2] mm/ksm: support fork/exec for prctl
Date:   Fri, 22 Sep 2023 14:11:40 -0700
Message-Id: <20230922211141.320789-2-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230922211141.320789-1-shr@devkernel.io>
References: <20230922211141.320789-1-shr@devkernel.io>
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

Today we have two ways to enable KSM:

1) madvise system call
   This allows to enable KSM for a memory region for a long time.

2) prctl system call
   This is a recent addition to enable KSM for the complete process.
   In addition when a process is forked, the KSM setting is inherited.

This change only affects the second case.

One of the use cases for (2) was to support the ability to enable
KSM for cgroups. This allows systemd to enable KSM for the seed
process. By enabling it in the seed process all child processes inherit
the setting.

This works correctly when the process is forked. However it doesn't
support fork/exec workflow.

From the previous cover letter:

....
Use case 3:
With the madvise call sharing opportunities are only enabled for the
current process: it is a workload-local decision. A considerable number
of sharing opportunities may exist across multiple workloads or jobs
(if they are part of the same security domain). Only a higler level
entity like a job scheduler or container can know for certain if its
running one or more instances of a job. That job scheduler however
doesn't have the necessary internal workload knowledge to make targeted
madvise calls.
....

In addition it can also be a bit surprising that fork keeps the KSM
setting and fork/exec does not.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process")
Reviewed-by: David Hildenbrand <david@redhat.com>
Reported-by: Carl Klemm <carl@uvos.xyz>
Tested-by: Carl Klemm <carl@uvos.xyz>
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

