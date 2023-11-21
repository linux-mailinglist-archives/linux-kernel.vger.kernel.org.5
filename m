Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1B7F2D37
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjKUMbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjKUMbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:31:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348BCD8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:31:40 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALA9TR1011167;
        Tue, 21 Nov 2023 12:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=UT6PJ7wxHz9LTqez0TYiCSC4HK4PIiOlBrnHF6eVSgw=;
 b=o+Srooa+JAa3gYEL1VkgyaI45ziZ+Pl3SVwKf3nNzCPMjVnMUy3QkalDYElsBqxa+wX7
 mqalnN8yCov1jhHm3jZUy2KmHpq+Bwjk4UOETdJm+/J0VegsaK4hziNOUwmBT4kkNWjL
 Dy2LrH93hHh2t+xlIkyNcCl6giGiu77EYoAGOT3lcNvCqv7q/HSfHzHwAjlmPCj5uDuN
 RhaT2nLDynOOeTOL+nSFPQBALRnLgbY2JFrisr0xyA7WNvQLWNzgjGb1ck73Ejj+hYAC
 ZgrkUnD+WL0XkTotfjgnUdskAb02u9GUdN3YUz5XNO4LPfaxHRH8nR0TgpsMNp2Wt0Qq eg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugrk20v4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 12:31:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALCV98M019727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 12:31:09 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 04:31:06 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <hannes@cmpxchg.org>,
        <kirill.shutemov@linux.intel.com>, <shakeelb@google.com>,
        <n-horiguchi@ah.jp.nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH] [RFC] mm: migrate: rcu stalls because of invalid swap cache entries
Date:   Tue, 21 Nov 2023 18:00:40 +0530
Message-ID: <1700569840-17327-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Pxa7keu9mkjU_iee9OT6SYcjyyfo_Xfj
X-Proofpoint-ORIG-GUID: Pxa7keu9mkjU_iee9OT6SYcjyyfo_Xfj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below race on a folio between reclaim and migration exposed a bug
of not populating the swap cache with proper folio resulting into the
rcu stalls:

Reclaim                         migration
			      (from mem offline)
--------                      ------------------
1) folio_trylock();

2) add_to_swap():
   a) get swap_entry to
     store the thp folio
     through folio_alloc_swap().

   b) do add_to_swap_cache() on
      a folio, which fills the xarray
      with folio corresponding to
      indexes of swap entries. Also
      dirty this folio.

   c) try_to_unmap(folio, TTU_SPLIT_HUGE_PMD)
      which splits the pmd, unmaps the folio
      and replace the mapped entries with
      swap entries.

   d) as the folio is dirty do,
     pageout()::mapping->a_ops->writepage().
     This calls swap_writepage() which unlock
     the page from 1) and do submit_bio().

3) Since the page can still be under writeback,
add the folio added back to the LRU.

				4) As the folio now on LRU,
				it is visible to migration
				thus will endup in
				offline_pages()->migrate_pages():
				  a) isolate the folio.
				  b) do __unmap_and_move():
				     1) lock the folio and wait till
					writeback is done.
				     2) Replace the eligible pte entries
					with migrate and then issue the
					move_to_new_folio(), which calls
					migrate_folio()->
					folio_migrate_mapping(), for the
					pages on the swap cache which
					just replace a single swap cache
					entry source folio with
					destination folio and can endup
					in freeing the source folio.

Now A process in parallel can endup in do_swap_page() which will try
read the stale entry(of source folio) after step4 above and thus will
endup in the below loop with rcu lock held.
mapping_get_entry():
 rcu_read_lock();
repeat:
    xas_reset(&xas);
	folio = xas_load(&xas);
	if (!folio || xa_is_value(folio))
		goto out;

	if (!folio_try_get_rcu(folio))
		goto repeat;

folio_try_get_rcu():
	if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
	   /* Either the folio has been freed, or will be freed. */
	   return false;

Because of the source folio is freed in 4.b.2) The above loop can
continue till the destination folio too is reclaimed where it is removed
from the swap cache and then set the swap cache entry to zero where the
xas_load() return 0 thus exit. And this destination folio can be either
removed immediately as part of the reclaim or can stay longer in the
swap cache because of parallel swapin happen between 3) and 4.b.1)(whose
valid pte mappings, pointing to the source folio, is replaced with the
destination folio). It is the latter case which is resulted into the rcu
stalls.

The similar sort of issue also reported sometime back and is fixed in
[1].

This issue seems to be introduced from the commit 6b24ca4a1a8d ("mm: Use
multi-index entries in the page cache"), in the function
folio_migrate_mapping()[2].

Since a large folio to be migrated and present in the swap cache can't
use the multi-index entries, and migrate code uses the same
folio_migrate_mapping() for migrating this folio, any inputs you can
provide to fix this issue, please?

What I have thought is, if the adjacent entry in the xarray is not a
sibling, then assume that it is not a multi-index entry thus store as
2^N consecutive entries.

[1] https://lore.kernel.org/all/20180406030706.GA2434@hori1.linux.bs1.fc.nec.co.jp/T/#u
[2] https://lore.kernel.org/linux-mm/20210715033704.692967-128-willy@infradead.org/#Z31mm:migrate.c

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/migrate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 35a8833..05cb4a9b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -403,6 +403,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 	struct zone *oldzone, *newzone;
 	int dirty;
+	void *entry;
 	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
 	long nr = folio_nr_pages(folio);
 
@@ -454,6 +455,16 @@ int folio_migrate_mapping(struct address_space *mapping,
 	}
 
 	xas_store(&xas, newfolio);
+	entry = xas_next(&xas);
+
+	if (nr > 1 && !xa_is_sibling(entry)) {
+		int i;
+
+		for (i = 1; i < nr; ++i) {
+			xas_store(&xas, newfolio);
+			xas_next(&xas);
+		}
+	}
 
 	/*
 	 * Drop cache reference from old page by unfreezing
-- 
2.7.4

