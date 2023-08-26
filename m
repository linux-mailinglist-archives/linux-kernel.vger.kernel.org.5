Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6DA7893BB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 05:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjHZD6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 23:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjHZD6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 23:58:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8DA2698
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 20:58:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-56b0c5a140dso963458a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 20:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693022301; x=1693627101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oX6TBXoSKdcVe2hZwMHpUN85Ja2Oqu1Hi+5JRnOR9tk=;
        b=rT4JalxRnWwUmm4Bp68YHrwVDaOJKFykjCet0hhLjadFS/Pgec8mvvvv6gnQAeeoR7
         LDA/om5jiwY2YeBypqNFhBa8+A0BYOjbieUTAMy1eGAWUjKHYFcaOfMImDXijFJswfbI
         +b42JToURg+vVlne2pInaPRJCMtZTHzsda/q3qkjJ2ouRGKlgEBnb/8VdRE7Ldd9SIjq
         KIgdqv8wTvuVtVmQXO83Zd531esPoKfXVTysPyoagw/M5FTe9/+hXVTvxG8zlWQbhHGE
         Lt/5ofdE12bNV1EOJV2zQeIwe3qjFGN9xt6phAdYfEKiWgPLpU5EClGOdL/VpG2XXA63
         u2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693022301; x=1693627101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oX6TBXoSKdcVe2hZwMHpUN85Ja2Oqu1Hi+5JRnOR9tk=;
        b=K6BY19OXFHV2rkGBUrv06wkTkzZ5ZB7zpuuRc5hCxe1OYIi0pl7/nMAsfTLB0k4pXE
         I6H2SpUyuY5vpx9fPiS04cgF+2CdWQo/XbAu92Auo/JutoPYe3JYuE3fvSUoG5E4ZQa6
         vR4Kz31AgamNB2q9qD77EUZvyTYfaOZeMPlUojfxw3QnXxgaCrdi5BGLcpabWzasmWn2
         oHCjiobFU6ah7LJx567NvtucmlJGlZVyFIIba8ZgP06x/8LMrlbBXo9M7iMk7O+MXTPL
         MROitsM9ZQKm0pqdvT74XIyCsn9felq8enhl6RblzOVP6FztOlXXnquRFMsCrtXWz458
         a46A==
X-Gm-Message-State: AOJu0YxtpZ66zMVhAKPpGNoNjLqqvy4kM3SJuaiF7Bs0PvSxAoHzUkR3
        cEm66bK8yUVOHi56Ro2/Vv/4IQ==
X-Google-Smtp-Source: AGHT+IG2Yw2nwSGMcIIrvCvJUUY+jEO4R+Hf+fFczQ68Axsf9tzph1fCSAfomGkwKVEvbHpkQypm5g==
X-Received: by 2002:a05:6a20:7f8a:b0:140:54ab:7f3f with SMTP id d10-20020a056a207f8a00b0014054ab7f3fmr28689344pzj.50.1693022300779;
        Fri, 25 Aug 2023 20:58:20 -0700 (PDT)
Received: from nixos.tailf4e9e.ts.net ([1.202.18.10])
        by smtp.googlemail.com with ESMTPSA id fm25-20020a056a002f9900b0068aca503b9fsm2306367pfb.114.2023.08.25.20.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 20:58:20 -0700 (PDT)
From:   Xueshi Hu <xueshi.hu@smartx.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Xueshi Hu <xueshi.hu@smartx.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugeltb: fix nodes huge page allocation when there are surplus pages
Date:   Sat, 26 Aug 2023 11:57:48 +0800
Message-Id: <20230826035748.891697-1-xueshi.hu@smartx.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In set_nr_huge_pages(), local variable "count" is used to record
persistent_huge_pages(), but when it cames to nodes huge page allocation,
the semantics changes to nr_huge_pages. When there exists surplus huge
pages and using the interface under
/sys/devices/system/node/node*/hugepages to change huge page pool size,
this difference can result in the allocation of an unexpected number of
huge pages.

Steps to reproduce the bug:

Starting with:

				  Node 0          Node 1    Total
	HugePages_Total             0.00            0.00     0.00
	HugePages_Free              0.00            0.00     0.00
	HugePages_Surp              0.00            0.00     0.00

create 100 huge pages in Node 0 and consume it, then set Node 0 's
nr_hugepages to 0.

yields:

				  Node 0          Node 1    Total
	HugePages_Total           200.00            0.00   200.00
	HugePages_Free              0.00            0.00     0.00
	HugePages_Surp            200.00            0.00   200.00

write 100 to Node 1's nr_hugepages

		echo 100 > /sys/devices/system/node/node1/\
	hugepages/hugepages-2048kB/nr_hugepages

gets:

				  Node 0          Node 1    Total
	HugePages_Total           200.00          400.00   600.00
	HugePages_Free              0.00          400.00   400.00
	HugePages_Surp            200.00            0.00   200.00

Kernel is expected to create only 100 huge pages and it gives 200.

Fixes: fd875dca7c71 ("hugetlbfs: fix potential over/underflow setting node specific nr_hugepages")
Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
---
 mm/hugetlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6da626bfb52e..54e2e2e12aa9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3494,7 +3494,9 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	if (nid != NUMA_NO_NODE) {
 		unsigned long old_count = count;
 
-		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
+		count += persistent_huge_pages(h) -
+			 (h->nr_huge_pages_node[nid] -
+			  h->surplus_huge_pages_node[nid]);
 		/*
 		 * User may have specified a large count value which caused the
 		 * above calculation to overflow.  In this case, they wanted
-- 
2.40.1

