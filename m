Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88621790880
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjIBPaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjIBPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:30:02 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF55C132
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:29:59 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a9b41ffe11so29503b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693668599; x=1694273399; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=94vGaJ39BVEqwQYt2X0XTeCa7BR+bq/679T/VBpfA0g=;
        b=sH9LlO8xFlSXq+4db8RvGHPCO/bA5E9nUQja9kjTUJWDEJrLz+8IHofCmwdGtOPKJZ
         tQ2Ka+YsTZS+eGGO5gWD4n1D0MLRtXxwNdv6f5Yd4JjoBXZS2iOlE3R6H6xqmlyRlk+X
         VlNbnJ/ixLerYirQOLxiZMdqfGZOqkcqQa2JPRyys5W31+ND5uzsanZmql0dhnxP5vf2
         /q9Vr+9/bO00gsda0PKjOevFazEQtSgKGc8JTGH+yJmSfJBRgmZP1JH8tLvhhhKomlGx
         KaSAWkAkDqisH4qu//CA3lkwdQwfpLVWLklOc/SAZx+UmACTMj3hzHcpmC5c2dRskare
         k+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693668599; x=1694273399;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94vGaJ39BVEqwQYt2X0XTeCa7BR+bq/679T/VBpfA0g=;
        b=g1qDlIO7VvTLDif9Rm1F8tD4P9OZhFciRbVhAVMCaXxYiMbIKBOZ4BZkWXKHsCj1XT
         KY4F/kOku9OrIyw3Yc/vIqsxteLsuzpcSZ1n9nZwIIY3i+6XXRrVEv0W4J+yukH0SeJu
         gXbDvfMakzPx6dd9PdjZe+U2QPl4BXEcDfq74ARIb+TdySyuAL4YHNbHQVJ4D9XXwm4m
         xltXq3G5uO7Zabz/xFMm7CMoxPYJYKLTDvE/kLbaEsSQ90iWnCGhbuN4uq51bpgfHpy8
         ekeQamo9kEAVGGsSH4t/73OTuP9sOPkablTf76/ZBLlwIR+sEyXW2PpKw6+cLxYd9358
         Buxg==
X-Gm-Message-State: AOJu0YzuRfb+VAobxK1FNBMW36xfTCZjPc43VRDi7rulEWtzKyUgPxNu
        +LYzIUEGdytPXI90Vg52T0T+IQ==
X-Google-Smtp-Source: AGHT+IHA0XTRV8+ro9PdmZKhn1UTJ+8ioIcr8KGiOrHgZfMCqzyTp/BRmG0aV3RaSUgLAN9vhIP00g==
X-Received: by 2002:a54:418c:0:b0:3a1:e85f:33c3 with SMTP id 12-20020a54418c000000b003a1e85f33c3mr5821810oiy.50.1693668599087;
        Sat, 02 Sep 2023 08:29:59 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t78-20020a25aad4000000b00bcd91bb300esm1448109ybi.54.2023.09.02.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 08:29:58 -0700 (PDT)
Date:   Sat, 2 Sep 2023 08:29:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@lists.linux.dev
Subject: [PATCH] mm/pagewalk: fix bootstopping regression from extra
 pte_unmap()
Message-ID: <8321a347-4a38-526c-97fb-5999ceaf6dd@google.com>
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

Mikhail reports early-6.6-based Fedora Rawhide not booting: "rcu_preempt
detected expedited stalls", minutes wait, and then hung_task splat while
kworker trying to synchronize_rcu_expedited().  Nothing logged to disk.

He bisected to my 6.6 a349d72fd9ef ("mm/pgtable: add rcu_read_lock() and
rcu_read_unlock()s"): but the one to blame is my 6.5 commit to fix the
espfix "bad pmd" warnings when booting x86_64 with CONFIG_EFI_PGT_DUMP=y.

Gaah, that added an "addr >= TASK_SIZE" check to avoid pte_offset_map(),
but failed to add the equivalent check when choosing to pte_unmap().

It's not a problem on 6.5 (for different reasons, it's harmless on both
64-bit and 32-bit), but becomes a bootstopper on 6.6 with the unbalanced
rcu_read_unlock() - RCU has a WARN_ON_ONCE for that, but it would have
scrolled off Mikhail's console too quickly.

Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/linux-mm/CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com/
Fixes: 8b1cb4a2e819 ("mm/pagewalk: fix EFI_PGT_DUMP of espfix area")
Fixes: a349d72fd9ef ("mm/pgtable: add rcu_read_lock() and rcu_read_unlock()s")
Signed-off-by: Hugh Dickins <hughd@google.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b2d23fbf4d3..b7d7e4fcfad7 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -58,7 +58,7 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			pte = pte_offset_map(pmd, addr);
 		if (pte) {
 			err = walk_pte_range_inner(pte, addr, end, walk);
-			if (walk->mm != &init_mm)
+			if (walk->mm != &init_mm && addr < TASK_SIZE)
 				pte_unmap(pte);
 		}
 	} else {
-- 
2.35.3
