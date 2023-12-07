Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CDA8088EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjLGNK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjLGNKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:10:41 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C59910CF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:10:47 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5be30d543c4so617988a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701954647; x=1702559447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zhkw2Q2fxvLpVCfPy6TQyBx3BzZfQXBxqcbsZhqAxCU=;
        b=LRNZqUq2UK5dssGBc65JtiLBJhhSccOnjJSmzVR+SifBhx1A2DMf3irwX3Lgnw3+TK
         xi4HpFB9Tt8vfKyDPMryZAEzTvyrhFSWvCB6Ebb/6qSwaNIdpb3aAdbkCn6KyxuAftcu
         /p33UhJ7378m9TUJRVvs2VHb5KLU+h6i0SL4JyM87eXjacN13zZ4yQieM/8OJk7ZrF4e
         pdsZ4pzKHikMjoOKMvZVFsDtcJZvnXWMTgaR/gt2T+77YKyDJhDH3DZknDuGFNbDHI2/
         pBCXO7TN0jZep1Z4F1RAA2Cl33pWjgY7EAJmFEmfrAT099DDRFAuq72Z5rDsmfZ1yUY0
         yXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701954647; x=1702559447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zhkw2Q2fxvLpVCfPy6TQyBx3BzZfQXBxqcbsZhqAxCU=;
        b=J4H7fEtmir0yYQ8rj6Pf/zAgTRmWFZsMx3wmRMLpwbOFBwgjpK2pxjCSqatkM15vKU
         So+MH7fo6EJ99gu7AnHOAUs+nPgGbUapeCJ2Itr9xGjQLfe1mSNJqKhlnnUBQ7U+ilDF
         4x09gYDA1EK5ywXVmS2gh8KqzcU9VQ7e0Hor8uA0Faq6cP744i5ytCcywSAHG8UBrxta
         L1cRoKpns32g5ymfDpkqR3VfjiLJCsyCD/eQN6w+lIMu2+Sszv5uXTaW/U/RdOImkY1i
         BFkyXrZmi2Fv2Hm/U3nzr+H3NbJHZ9vKi/1TwpdzsUk4Syat1AEBXg+bpsBeS3Kn11Lk
         41WQ==
X-Gm-Message-State: AOJu0YytuiU9E8EfpFh3iGIgsLwGiNIXEZeszZksZGGNlDfKx2VCXTga
        iRz8aOXIfK02AG9m7K7MiROfUPimPlo=
X-Google-Smtp-Source: AGHT+IFab04mQkrGt5aKvlslYUXNGB4g5Ira/IEnpoOq5pw8jwKQw0PXwZEQJ4YaFZqUq8fZo6rNAA==
X-Received: by 2002:a05:6a20:12c8:b0:18f:97c:8248 with SMTP id v8-20020a056a2012c800b0018f097c8248mr2300799pzg.82.1701954646690;
        Thu, 07 Dec 2023 05:10:46 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id n1-20020aa78a41000000b006c320b9897fsm1229036pfa.126.2023.12.07.05.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:10:46 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] memblock: Return NUMA_NO_NODE instead of -1 to improve code readability
Date:   Thu,  7 Dec 2023 21:10:01 +0800
Message-ID: <20231207131001.224914-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When no corresponding memory region is found for the given pfn, return
NUMA_NO_NODE instead of -1. This improves code readability and aligns with
the existing logic of the memblock_search_pfn_nid() function's user.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 5a88d6d24d79..c1f579c23396 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1851,7 +1851,7 @@ int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
 	int mid = memblock_search(type, PFN_PHYS(pfn));
 
 	if (mid == -1)
-		return -1;
+		return NUMA_NO_NODE;
 
 	*start_pfn = PFN_DOWN(type->regions[mid].base);
 	*end_pfn = PFN_DOWN(type->regions[mid].base + type->regions[mid].size);
-- 
2.43.0

