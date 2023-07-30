Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7300876862B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjG3PQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjG3PQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:16:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56421716
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso41888745e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690730171; x=1691334971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUFHsk/m/GY1eTNfZx8Py//rj4lEwu1OMjpML8i4XiA=;
        b=JoxH10l13AhAr8ISmwB2i1gOf6hMfDgdag1NYZGf8eqVGmEdh4R3IE2D1prI5+wzm7
         vu1QD7xvEBstHjEIbxAMlgCCO00ONBH3G5zPFMoDk4Drvk6SzML5WNLP4tfo6lnQh865
         TX13dZrkIeWswvkw6xN/xmei3GAwgiUombSwNiUwcW22Vp57PvkxefJyTKdVVA+u+gzP
         VbGxb9p/bzQfa6R6GWeFqN5krmkkMZbJxyXakbPqdmWiMydGR5JelRYvQMAxOrQf62pU
         o4lWtSXohDF8KsxmkSED8zQCamat1slkfvH7Xda+Eyuy3MLasON3KHOua9umK5WY8Nob
         wW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690730171; x=1691334971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUFHsk/m/GY1eTNfZx8Py//rj4lEwu1OMjpML8i4XiA=;
        b=RMg2GfdFISe3acNSNOvZ9cm0P9VWd0Zb2Ad1F5XQz4wsNUj+BoWzPGtB9Ei/1o86vC
         kFPBKuzBs0SIm1Lp1iyQHe0A3triHfOn6CMmdFMKqgWTayOz7W6yWqX+xQV+Fk61M/rJ
         R4NQ85/KvwOYHs4ilJsMpDJlCU2TL9R6ZycgsE2TiVwixWcHPlUIvxN+jdwNhHQ4Lz3B
         m/p7OErswrzoSyKku5JU+LUc33wgieqFX3X3P+ySmqB10+VhXwL6Pfsv5uWloqO6v37F
         LMFT6m8udhud/JaFiGbdnomVGAAmlARW+UznJ2wGHy5DUzC5Mgj0ZkB7MvU/4x7Df3gg
         x6LA==
X-Gm-Message-State: ABy/qLbd6bAzhkiuORD4pY0uxbXQTzFydHg2tc7dA08gWsTyJAH1npUV
        KwNb+faOysaCcPHTeFG5dQepOQ==
X-Google-Smtp-Source: APBJJlFtcqfY902vGXRLqPZchnNVVitcnCdU3eEgHgB4d1amxrHvfEkxn/i1iktNVcoW6QdeU+DsCA==
X-Received: by 2002:a7b:cbd5:0:b0:3fe:1db2:5168 with SMTP id n21-20020a7bcbd5000000b003fe1db25168mr1370994wmi.11.1690730171283;
        Sun, 30 Jul 2023 08:16:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:eda5:aa63:ce24:dac2])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcc11000000b003fd2d33ea53sm9123027wmh.14.2023.07.30.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 08:16:10 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v2 2/6] mm: hugetlb_vmemmap: Use nid of the head page to reallocate it
Date:   Sun, 30 Jul 2023 16:16:02 +0100
Message-Id: <20230730151606.2871391-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230730151606.2871391-1-usama.arif@bytedance.com>
References: <20230730151606.2871391-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tail page prep and initialization is skipped, then the "start"
page will not contain the correct nid. Use the nid from first
vmemap page.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index b721e87de2b3..bdf750a4786b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -324,7 +324,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
 	};
-	int nid = page_to_nid((struct page *)start);
+	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
 			__GFP_NOWARN;
 
-- 
2.25.1

