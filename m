Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0894C8136F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjLNQwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjLNQkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:40:42 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236F8125
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:40:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d350dff621so18684135ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572046; x=1703176846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti6fJ0q7IpNfuWyKxmP8PV98iLP1/8o/ewhA7a4SgUI=;
        b=kDUTLDbMf9yklFs28/jCpfaXoCirUi+aiVu4oVMZxOVnMMFyYbyUrzCS8KCSe5+cR0
         osvkqoCl5e73DiFqpoG3zDseVorsMzZZqeYfeD9w/dJ2e68NYyFS5O+34ASOGgNqpKDj
         ZI4hBg9W9MGcOH7wYmQ9NE4JMHeBhQtD1zHDRtusrKZUmb8OLghhGv2KmCem/iIasFem
         7fVulnsSyU25i0RYGKcsp7+YIXJSPp+NvVsJKXs1zVf2Vv37LYT0a2Tw+RPZAlD4qKTH
         ENPcFPZ7Fq88w+0HekZSZaOUqUifnAT1Iq/FNNuD9s6nmg2bE0VfC22QspOPGEnl8qya
         wC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572046; x=1703176846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti6fJ0q7IpNfuWyKxmP8PV98iLP1/8o/ewhA7a4SgUI=;
        b=vYVzLAlMS1yGCZwuFVP/3fDPDTMXQmOQu0LcDgko7ps0Wi7jA1RNkcQyGs//z0vLwM
         TpSKXNQntE62bLnjB7px8xQfKVGqC9k+Jit1bjxhUBKnYcnlfLSloWubXeT0JcVBCCA9
         n4g79UE3sE/SIUCx+DfpNEVJgbGyP02pXqALvpPb0Z1vyxl7FcOF9rhC88jiBihB2VOZ
         qU50K84zcUQy8lcPEby/MuqYsRsduhO51x2PxvdfN0bfkkoOcLGlKdCMDAPQZcEAatU/
         jniR5ttb7qB6LG3K5yh07LtyEgDeAnZImx6APJJB1oNdxbA+ZP/Y5B0qeiqAGEG9ubAp
         J6WA==
X-Gm-Message-State: AOJu0YwN/pDX3NQRzBlDLk7zn736jv5ogXlu0BOI/eLofmL8JD9n1LVS
        KctZVzP7aIBnneJqg9FsXKaF7YSGO4g=
X-Google-Smtp-Source: AGHT+IHQ4qZPIQ2nZd+rqHbw2B+B5GXKKrM1wuoCjHBF9nDKZgAuS+1Z+WxnRl2QvHLLFKAZWGBD/w==
X-Received: by 2002:a17:902:7ecf:b0:1d3:3c35:81b5 with SMTP id p15-20020a1709027ecf00b001d33c3581b5mr3669073plb.46.1702572046197;
        Thu, 14 Dec 2023 08:40:46 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm12595897plf.79.2023.12.14.08.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:40:45 -0800 (PST)
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
Subject: [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
Date:   Fri, 15 Dec 2023 00:38:42 +0800
Message-ID: <20231214163842.129139-4-ytcoode@gmail.com>
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

The purpose of crash_exclude_mem_range() is to remove all memory ranges
that overlap with [mstart-mend]. However, the current logic only removes
the first overlapping memory range.

Commit a2e9a95d2190 ("kexec: Improve & fix crash_exclude_mem_range() to
handle overlapping ranges") attempted to address this issue, but it did not
fix all error cases.

Let's fix and simplify the logic of crash_exclude_mem_range().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/crash_core.c | 70 ++++++++++++---------------------------------
 1 file changed, 19 insertions(+), 51 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..0292a4c8bb2f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -565,9 +565,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 int crash_exclude_mem_range(struct crash_mem *mem,
 			    unsigned long long mstart, unsigned long long mend)
 {
-	int i, j;
+	int i;
 	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
 
 	for (i = 0; i < mem->nr_ranges; i++) {
 		start = mem->ranges[i].start;
@@ -575,72 +574,41 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		p_start = mstart;
 		p_end = mend;
 
-		if (mstart > end || mend < start)
+		if (p_start > end || p_end < start)
 			continue;
 
 		/* Truncate any area outside of range */
-		if (mstart < start)
+		if (p_start < start)
 			p_start = start;
-		if (mend > end)
+		if (p_end > end)
 			p_end = end;
 
 		/* Found completely overlapping range */
 		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
+			memmove(&mem->ranges[i], &mem->ranges[i + 1],
+				(mem->nr_ranges - (i + 1)) * sizeof(mem->ranges[i]));
+			i--;
 			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
+		} else if (p_start > start && p_end < end) {
 			/* Split original range */
+			if (mem->nr_ranges >= mem->max_nr_ranges)
+				return -ENOMEM;
+
+			memmove(&mem->ranges[i + 2], &mem->ranges[i + 1],
+				(mem->nr_ranges - (i + 1)) * sizeof(mem->ranges[i]));
+
 			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
+			mem->ranges[i + 1].start = p_end + 1;
+			mem->ranges[i + 1].end = end;
+
+			i++;
+			mem->nr_ranges++;
 		} else if (p_start != start)
 			mem->ranges[i].end = p_start - 1;
 		else
 			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
 	}
 
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
 	return 0;
 }
 
-- 
2.43.0

