Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B868088FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjLGNRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLGNRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:17:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD96D54
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:17:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d05e4a94c3so7696155ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701955067; x=1702559867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u7Lgx3Zbpr1E7puAaYjXgpPZvKd9rN9LGgZ0ZOsq1+M=;
        b=GXzrMIBNsXeA4G1rieHucgy47+6kgaErRTdQYsRogE2IAb5ZNjtc3xWxlFibx/WO4M
         nuA1/aRbi/GILanQgYGxUW4MHyrJyrASpS1sP4BR2vYLFg21UEjJewCiagzT5QEPSMHg
         5+bx6iQabkwQcIQnrr6Jpu49t3q4UKAr4OWrVIZQ7htOiT/vVlbg0/hNXpBTpAqYCCWA
         zpnvmhW/Q2ovvdLGC9dFlCFnbf5T3RZ/nu7QUXbX3GszrfBltnw3v/lDBP9R7d9RlfO2
         eLr6kLzCbCWjDWxVDRo+4xP+C9vqWt0E2Bg2LDM4FIEtAFJtB5MfIa/J4tXtQczMCKUW
         ZRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955067; x=1702559867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7Lgx3Zbpr1E7puAaYjXgpPZvKd9rN9LGgZ0ZOsq1+M=;
        b=SQvhUgA9/4nJ1P4Re80Y5GOfhcZWNccBRmKW2DoErIZLcRZzpqp8QNH1AG3sJgrYU0
         8FZF6Uz8VajJBO+VT6rg0vXMQgM5UBW7v8R1oY747aIfKyoNJAcBj8gkgFRz3m9ZT1oe
         SSGkPlgAw9ujIGEHVLIJ6I9zyNFZKiVroKzelh6NFrL+HIvtpCnK+4j1IjggrTbjwJVn
         etH8eh35C7sqU5JE7jLojYn4sl5dxCC3z4B1OXkx+3y64xYBZrYNNoepbmfL38CXY4Pm
         g9/TvTNP8IU81VmiAjpwRFuza2FDJlnNrU3jfYNoYFJYTqNY258lRX+4qwTyuhi9/m5M
         vK6g==
X-Gm-Message-State: AOJu0YzkVFjvYoDbF8X2KPQRThXo45a4fcC5KXj31gOEpa6keik1vrh/
        EBgOowWzje9z80qeqmE1UHaAgDrs3kA=
X-Google-Smtp-Source: AGHT+IEwweuOJxA+9KyMUlZKgSvo80ecjWIIvp0YhzoQ4rCreecj9kBIUFe5CA6HRimihnqGwZlLNA==
X-Received: by 2002:a17:902:e88f:b0:1d0:6b95:9c0d with SMTP id w15-20020a170902e88f00b001d06b959c0dmr3370212plg.65.1701955066960;
        Thu, 07 Dec 2023 05:17:46 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id z2-20020a170902ee0200b001d071a305ecsm1365213plb.245.2023.12.07.05.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:17:45 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/mm: Optimize the for loop in numa_nodemask_from_meminfo()
Date:   Thu,  7 Dec 2023 21:16:58 +0800
Message-ID: <20231207131658.225815-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since only the first `mi->nr_blks` elements of the `mi->blk` array contain
valid data, we do not need to iterate over the entire array.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index b29ceb19e46e..e84f14a9462d 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -339,7 +339,7 @@ static void __init numa_nodemask_from_meminfo(nodemask_t *nodemask,
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mi->blk); i++)
+	for (i = 0; i < mi->nr_blks; i++)
 		if (mi->blk[i].start != mi->blk[i].end &&
 		    mi->blk[i].nid != NUMA_NO_NODE)
 			node_set(mi->blk[i].nid, *nodemask);
-- 
2.43.0

