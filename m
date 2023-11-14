Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF5F7EA902
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjKNDQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKNDQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:16:13 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F228691
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:16:09 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d0f945893so43347796d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699931769; x=1700536569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3w4/XG+aeffoi7OUILSvtJfbbHtJ+I3FPPCWJDaC/+g=;
        b=AQV5PNI8vitkswZM03pQLKc+1qXP3Xlk44bNqOI89Rg2/c8pcpSyaDCchMqXU3nb6B
         +jJ2OXtAqHH3uwMr/DbIiVtTCDu8QdefkkKaXcaegz8FyGUfo+zBYSSrBR+PpxSQulBP
         dE74QefxqMopWxJcvS0APhX9gnlIklUe+020ajllZEU3K88Hk6LjSPw0vgqn9q0cspr7
         qHnHoWuI3e3+wOIJBDh3G+uPkDwvjtSwW9qNqFpPflT077HtmcTkxRBZmd8t3Nel2PNT
         /hr/JkpXok3vzqn8XkQlJ3HMBOaxcq031ugdfUzmk5Ko7huxHK5wLEhl3/kyxD9l+Ix7
         YBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699931769; x=1700536569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3w4/XG+aeffoi7OUILSvtJfbbHtJ+I3FPPCWJDaC/+g=;
        b=dA9txHpFZz/i+yzYeZycxwS4282XPN8CYRi5t6/dvXLT5KjxApyPlllVhet4EiN+p7
         ZYkHmIHHDb8ZDIlW/Qym0PGKi9XPrxajWVOYnji7B+ga/GucwvKp768F06GPgTsoJZvF
         4WdLRlSytHSjd4llXP8TQ5LD9TQDtIQ7M3jIEG5mNltrvUkTDpUUp/OHk+Mg+DQXypvm
         HsZnF7Kb9vDOtj0BEQXqhzg9topUAoaMnWTBbhdP34FU+ZLTF0tofsjwMkCUdVo2AlG0
         GvquwLu43UJ6gWPDTsx577DkFTkXI7daU47UMPpIupidVMU/PZY55Mxlvo7a+hSaUHLe
         sehw==
X-Gm-Message-State: AOJu0YzRT/qaNnQ87355sy7eBxkxUX4fdBTrz9KUMDa7EHOLY2sGo707
        tZqbbYzz3uwuBVZkjU60mBY=
X-Google-Smtp-Source: AGHT+IFHmPCxCJXDVEYmNeGRF85+PQ7lJSbERLpMiq0NiC77tUu/9UMBdfyJ+QrzC+Y1UEeUKDTvvw==
X-Received: by 2002:a05:6214:e4f:b0:675:ac72:f4ce with SMTP id o15-20020a0562140e4f00b00675ac72f4cemr1738052qvc.28.1699931769038;
        Mon, 13 Nov 2023 19:16:09 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id j16-20020a0cc350000000b00670867d7bdfsm2550355qvi.122.2023.11.13.19.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 19:16:08 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, Baoquan He <bhe@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/setup: Use a more concise memblock API
Date:   Tue, 14 Nov 2023 11:14:18 +0800
Message-ID: <20231114031418.60745-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.42.1
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

When executing relocate_initrd(), the memblock.current_limit field has
already been set to `max_pfn_mapped << PAGE_SHIFT`, so we can replace
memblock_phys_alloc_range() with memblock_phys_alloc(), which has the same
functionality but is more concise.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ec2c21a1844e..422497c17eec 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -259,8 +259,7 @@ static void __init relocate_initrd(void)
 	u64 area_size     = PAGE_ALIGN(ramdisk_size);
 
 	/* We need to move the initrd down into directly mapped mem */
-	u64 relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
-						      PFN_PHYS(max_pfn_mapped));
+	u64 relocated_ramdisk = memblock_phys_alloc(area_size, PAGE_SIZE);
 	if (!relocated_ramdisk)
 		panic("Cannot find place for new RAMDISK of size %lld\n",
 		      ramdisk_size);
-- 
2.42.1

