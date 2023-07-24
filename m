Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A2175F8E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGXNuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjGXNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:49:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1BC1BE7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:46:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so41886315e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690206410; x=1690811210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUFHsk/m/GY1eTNfZx8Py//rj4lEwu1OMjpML8i4XiA=;
        b=MgcuJRY5CZqiaM6oN+2ZgOrZfx75ny19uB226sSasic7Mnx54MWMiPH2vVvPOLfApJ
         prGjNWXiRaSzV4+PdVcYOKWYfpjwq8s/M8+afykb+Nc06bZYe/+gbxa1+Be4Rm3jeWI0
         8cCsZq8cfyydU59ItSQYEJs5yxH0yKdyeTfFZmwx6fK1dDSSKyPHBvlQzTgukYT3kPUX
         EQcr7s+o30vHTb1ipJOy2fJMjidD+R8BdV4yReZet1FTj9rlNgXk8HK6ZpTxwwfR3+Y5
         MrrxBs3KhFwb0TnnMWnCPZSjTb//F/UJ43wX8Vj0/TqJXnIo2EGyycAVn4dvvn7wm2nd
         L09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206410; x=1690811210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUFHsk/m/GY1eTNfZx8Py//rj4lEwu1OMjpML8i4XiA=;
        b=XhtmUH4OuJ4WByiG5qJ3hctyQSSnW2cEK8uJQNivA21DpL1qHugvL90JO0BAyUUQwo
         368/i0Rthopp0qxK3N3cpwh47d19QU/9//VqhWB8jHJKvE0mZYOi4wn7zWJii9CW49C0
         o2D/v3Q5vWv+tg311fjZdHBkp6I01Srv6uoUfvM0gln8LwUCkycNNsqeJi9vUWS0wiMX
         VQ3l1jHxo6bgR3H1YfJlaVvUi5bOAv79PxcmVMorHKw7EK9iKu8AyDfM1qnDveFBeH4x
         sMrpKz5ePFxJBPhVYF8fi7bqmhCqq9jbPUOcwOc5wnJQFI4VUrbzeddvrUdi5yA6tltw
         NPXg==
X-Gm-Message-State: ABy/qLY12o5WG42qKKKFekNAuic5JSHMIyUgceW6yh+l3S9DMq2UCm0A
        50eeD/h0kL1xam8mPF9IqOWUMw==
X-Google-Smtp-Source: APBJJlGKyOnJzA0snmPQ5aknmyxWInB37EjZPNgnEdY747vTPxkIvkOio6Xp4jLPbIkb3rasSdJxGQ==
X-Received: by 2002:a7b:c349:0:b0:3fc:5bcc:a909 with SMTP id l9-20020a7bc349000000b003fc5bcca909mr7478357wmj.2.1690206410523;
        Mon, 24 Jul 2023 06:46:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:d7c4:7f46:8fed:f874])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003fbe791a0e8sm10209354wme.0.2023.07.24.06.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:46:49 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [RFC 3/4] mm/hugetlb_vmemmap: Use nid of the head page to reallocate it
Date:   Mon, 24 Jul 2023 14:46:43 +0100
Message-Id: <20230724134644.1299963-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724134644.1299963-1-usama.arif@bytedance.com>
References: <20230724134644.1299963-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

