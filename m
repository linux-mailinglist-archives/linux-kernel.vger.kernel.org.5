Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406F2758DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGSGcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjGSGcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:32:16 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7771FC4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:32:14 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b9edef7993so486827a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689748334; x=1692340334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c9KrLLP8cL1uPsjJ1nSTy5SK2yTBHa/947mlcAdb160=;
        b=OdMNMSpEfv/yH1YzdMwSElZuj3ZFDDe2Uvr+0uT/C9mKCgI3PnkaDphepFbwXZGaEh
         4veUsr3yq4av+3Kyq+YmVd8InvdEWYYmEbxxSbxVZpDlbA8mF7IUCkYe0beFK37O129D
         HwZepvEjoG0zFUPtNuvTTJNeKyeFZNy5V0aLxZXX4omIC3Pi/jf6NyTqsEStkdHwzKpp
         KLIRLmMK5x4fsT0nFh8BTFe6u7ptjPcC8XeOO6h7Zj9FF0SK+Hg5C4Ln1YpMWgWaPOIQ
         DcqIgGRwYzCSxddeZapFOS1ZpehwxS41A/L2zcFcH55bH7WPxxoB8TARBVQ51D1vrgax
         vtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689748334; x=1692340334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9KrLLP8cL1uPsjJ1nSTy5SK2yTBHa/947mlcAdb160=;
        b=Be0DXbvYyI+gb5RPqZGdZdeXggPSAN2vIgrUY+3NVCX1zSQ5nsx0eb0oYSg50kbo4S
         JCQxoU+1wWoqnfyxSykgdKSiKaAwhosBydw+jKz7QkNXyUFJvCgbfPolL8aXZu4GkuoW
         iR7uiOQjqXyuxJ+kuMH57ph9r/nZjkB9um9EWT0xlKTINbEjnlAE8ln0oM23mR0+tobd
         xLT65ka45n3tyaZ6jt6eCMpUHcvVwWXTfQh48cW4nq/+G9W/hWsLJ/lZH5I6faauwQum
         xumoMnTxMY6Pu5pieooDc+OrqegP1Kd/0RdgNWkCLzobjDlS7+eLYEZ/fHgu/3TX3T2J
         H9Qw==
X-Gm-Message-State: ABy/qLYDPuBUXHS6t+6+YnZamWhWV7++B4TWscReRfMVw7ITvNWZGg6t
        HxgNgKASwOiHNTGmu6VY9EzQz0SaxefHRpSZygng7w==
X-Google-Smtp-Source: APBJJlG7Hnr+DLSYxVj/kGW324BYuM9R7IW3z2osuMAejNGZ153KuMIBDUA2MT+Nc81tM5Yh8hK+Hg==
X-Received: by 2002:a05:6830:1110:b0:6b8:90cd:47b5 with SMTP id w16-20020a056830111000b006b890cd47b5mr5139616otq.7.1689748333811;
        Tue, 18 Jul 2023 23:32:13 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id p12-20020a631e4c000000b005348af1b84csm2701678pgm.74.2023.07.18.23.32.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Jul 2023 23:32:12 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: hugetlb_vmemmap: use PageCompound() instead of PageReserved()
Date:   Wed, 19 Jul 2023 14:31:31 +0800
Message-Id: <20230719063132.37676-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ckeck of PageReserved() is easy to be broken in the future, PageCompound()
is more stable to check if the page should be split.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4b9734777f69..8068fe890f52 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -73,8 +73,10 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 		 * be treated as indepdenent small pages (as they can be freed
 		 * individually).
 		 */
-		if (!PageReserved(head))
+		if (PageCompound(head)) {
+			VM_BUG_ON(compound_order(head) != get_order(PMD_SIZE));
 			split_page(head, get_order(PMD_SIZE));
+		}
 
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
-- 
2.11.0

