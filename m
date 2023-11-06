Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DCB7E2BC9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjKFSTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjKFSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:19:37 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4388DD69
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:19:34 -0800 (PST)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 9D200EE24BAF; Mon,  6 Nov 2023 10:19:19 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1] mm: Fix for negative counter: nr_file_hugepages
Date:   Mon,  6 Nov 2023 10:19:18 -0800
Message-Id: <20231106181918.1091043-1-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While qualifiying the 6.4 release, the following warning was detected in
messages:

vmstat_refresh: nr_file_hugepages -15664

The warning is caused by the incorrect updating of the NR_FILE_THPS
counter in the function split_huge_page_to_list. The if case is checking
for folio_test_swapbacked, but the else case is missing the check for
folio_test_pmd_mappable. The other functions that manipulate the counter
like __filemap_add_folio and filemap_unaccount_folio have the
corresponding check.

I have a test case, which reproduces the problem. It can be found here:
  https://github.com/sroeschus/testcase/blob/main/vmstat_refresh/madv.c

The test case reproduces on an XFS filesystem. Running the same test
case on a BTRFS filesystem does not reproduce the problem.

AFAIK version 6.1 until 6.6 are affected by this problem.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Co-debugged-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 064fbd90822b4..ea6bee675c4d3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2740,7 +2740,8 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
 			if (folio_test_swapbacked(folio)) {
 				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
 							-nr);
-			} else {
+			} else if (folio_test_pmd_mappable(folio)) {
+
 				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
 							-nr);
 				filemap_nr_thps_dec(mapping);

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
--=20
2.39.3

