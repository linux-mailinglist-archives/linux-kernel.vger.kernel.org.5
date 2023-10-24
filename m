Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8207D47BE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjJXGuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjJXGus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:50:48 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409DED7D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:50:46 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a82f176860so41300847b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698130245; x=1698735045; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3C4xL26+by/nNiNIi96kjQArUXkrd2oNhMsXtWit3Y=;
        b=tjpZuc4Y1/xa8m5rEOsR9xAcoaedfTeNM84ipSUHJTvgSDpt/LmPKBCSZxeci1Ziis
         KDqCRmQg+UNAwPHei0qzSYU6oNcWuwiVDW4DJ2eJ5Vizy6zFF0+0KrnN8DLHGC8nxL+S
         RnbVh14ByE5Da/sPqWDF4bLApLXuPC4s2f2ehzMSFGUtWZ33mag0uJYTJGyQrb/YwYOE
         oHMoI96+ueV/+3HROQ3gSQTXQbkDi5Gs9uWsWj+jjC0DJQq5B/KPWNsFmNlXAtRuv6pn
         6qy8C913WDhFJ/RduKwmcPrug5vbGtSpLGiEMdNkHrXJpmzNYJVYeYri8hITiQbBNMle
         8uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698130245; x=1698735045;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3C4xL26+by/nNiNIi96kjQArUXkrd2oNhMsXtWit3Y=;
        b=rMOIBGxoumqWXDezF2T/Ka8ZFDHEW2Ub/nHUVHVxPfc6fysQhIQe8MdYtpyDrn0xY7
         FBtOEnvBZhjL9MZpHkga/Ynn1HKv5Ci/VQ1aC/PmvPx2/8TRLrU9EVDcXdl+ayiNhO7Y
         NKTFCqqJv1mB3Fpn3sHpsOfqwsvuO5vlSEXErDX/XDT7GQYrASIjegoTh0NfjuxMdoQS
         aBYxSVGUsHYcgKmuVmpkp4DbWRru96R+ELpfQ8q+CiHvtHGAh+n78wKHCRmfMd9+6yze
         sIDZzo1kP/eocM7yAxmN439tIKBAJ7Yekd6LdRTbGgA+EB7CBqfCCdWIf7uREeAsLIGW
         RMuw==
X-Gm-Message-State: AOJu0YyI2xQoSaW5tzxMsECBmbnJFE0wh4/MYGcNZdJ2Ds4JVYltir+f
        CyAs5M+eckP6JF4HLBGekM6yWQ==
X-Google-Smtp-Source: AGHT+IHzuoz/z+GIe/hmLTh1Bx0JUA8EBXee8rMOTjxms3aAhBTqy3zTfa7HbZJDIwVTZL+QLCMlDw==
X-Received: by 2002:a81:8441:0:b0:5a7:ba09:e58b with SMTP id u62-20020a818441000000b005a7ba09e58bmr12869572ywf.14.1698130245291;
        Mon, 23 Oct 2023 23:50:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e6-20020a0df506000000b005837633d9cbsm3781211ywf.64.2023.10.23.23.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 23:50:44 -0700 (PDT)
Date:   Mon, 23 Oct 2023 23:50:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Andi Kleen <ak@linux.intel.com>, Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mempolicy: migration attempt to match interleave nodes:
 fix
In-Reply-To: <77954a5-9c9b-1c11-7d5c-3262c01b895f@google.com>
Message-ID: <3311d544-fb05-a7f1-1b74-16aa0f6cd4fe@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com> <77954a5-9c9b-1c11-7d5c-3262c01b895f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm-unstable commit edd33b8807a1 ("mempolicy: migration attempt to match
interleave nodes") added a second vma_iter search to do_mbind(), to
determine the interleave index to be used in the MPOL_INTERLEAVE case.

But sadly it added it just after the mmap_write_unlock(), leaving this
new VMA search unprotected: and so syzbot reports suspicious RCU usage
from lib/maple_tree.c:856.

This could be fixed with an rcu_read_lock/unlock() pair (per Liam);
but since we have been relying on the mmap_lock up to this point, it's
slightly better to extend it over the new search too, for a well-defined
result consistent with the policy this mbind() is establishing (rather
than whatever might follow once the mmap_lock is dropped).

Reported-by: syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/000000000000c05f1b0608657fde@google.com/
Fixes: edd33b8807a1 ("mempolicy: migration attempt to match interleave nodes")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mempolicy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 989293180eb6..5e472e6e0507 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1291,8 +1291,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 		}
 	}
 
-	mmap_write_unlock(mm);
-
 	if (!err && !list_empty(&pagelist)) {
 		/* Convert MPOL_DEFAULT's NULL to task or default policy */
 		if (!new) {
@@ -1334,7 +1332,11 @@ static long do_mbind(unsigned long start, unsigned long len,
 				mmpol.ilx -= page->index >> order;
 			}
 		}
+	}
 
+	mmap_write_unlock(mm);
+
+	if (!err && !list_empty(&pagelist)) {
 		nr_failed |= migrate_pages(&pagelist,
 				alloc_migration_target_by_mpol, NULL,
 				(unsigned long)&mmpol, MIGRATE_SYNC,
-- 
2.35.3

