Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF881367C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443547AbjLNQki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjLNQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:40:34 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF2F131
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:40:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so50125525ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572038; x=1703176838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRn1DTbbmWGLB1nxG36xstbG89fQMD3XiAVHtLkUKlI=;
        b=dOC8w8ZkjgYsSIKHdseod5HSGGz2xSe09FURQkBUmu+B5bBO8x+3T6QUOEZ4Y/K9Xi
         hnynuV/qS6f/A8//ztca9zirppl1oaW7uJ0iEUIka+q9U2bLOAR1HKKExNA2z4eDSU5G
         xUT8T31E3N0KuMr8f8S03nZEvHO/rhToBYtbHEQJYb+gGi0E/lqdtZd0TaTH91bra5+C
         XBc5Fj7GZEJ05Ce8dTipbjMrCVMB/OdQACs/euGG2Bff+XrDxVKS6v+QGwfMXb4/NHfT
         xCIa6VPNz3ICPCnlhQbKW8X/cpTXg3AwXTl6RUw25D64umwc2g0qvc7BSi6eq8wwvSuW
         cIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572038; x=1703176838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRn1DTbbmWGLB1nxG36xstbG89fQMD3XiAVHtLkUKlI=;
        b=wTjFm54nyDXxCt+CoffqtuaUutCE7Df8MV77YRrWP2obi123adEhzVctfCfk3AXYsS
         ObN8763wMWOADvgo1OD3eMz4sBgF97ItLi8x66VC/a512m7pArf74Fa7s5T3mqOgX/ri
         QLsERUbR0qgNn6Dvu+8s9wrM4pwGvG3+h02myDT0/RxxQOEvunkLOYf2uh4NmhzrHIYm
         qOpDwDlokSUxbUV7k6/Oc5p7gx7/w1yAH8Eu6wvWty5YMMImhVITfqOt0zohI3nEG93i
         VZN152xgA+T/+GWghgHV2KdbyEiZUURXQlErFqE3WzITZ/e9Qx7I6cNctFux5O6cI5Pz
         veCA==
X-Gm-Message-State: AOJu0Yx5kHLrHtw8ZMkfdl9fIeP326vZsLPOR0M5+wAqXPoHpE/ZYncq
        DMQbL+DQwTcVZ8WZjq9s1pgt+geH9GI=
X-Google-Smtp-Source: AGHT+IESkQlL7JhHRaVr6xofo//eAXSa64RW84yr+T6FldHHTCobQXcxJcnZQDwsiYeR88Wr3ZnhTQ==
X-Received: by 2002:a17:902:c3c5:b0:1d3:64dc:e9d0 with SMTP id j5-20020a170902c3c500b001d364dce9d0mr848917plj.26.1702572038411;
        Thu, 14 Dec 2023 08:40:38 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm12595897plf.79.2023.12.14.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:40:38 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Lianbo Jiang <lijiang@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 2/3] x86/crash: use SZ_1M macro instead of hardcoded value
Date:   Fri, 15 Dec 2023 00:38:41 +0800
Message-ID: <20231214163842.129139-3-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214163842.129139-1-ytcoode@gmail.com>
References: <20231214163842.129139-1-ytcoode@gmail.com>
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

Use SZ_1M macro instead of hardcoded 1<<20 to make code more readable.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 792231a56d11..249b5876e7ec 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -170,7 +170,7 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	int ret = 0;
 
 	/* Exclude the low 1M because it is always reserved */
-	ret = crash_exclude_mem_range(cmem, 0, (1<<20)-1);
+	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
 	if (ret)
 		return ret;
 
-- 
2.43.0

