Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D247CFD14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346340AbjJSOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346253AbjJSOlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:41:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7834F1AC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9c4ae201e0so763923276.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697726458; x=1698331258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xM59NTfupiUDLHnq4Q6FLBD9y4loLd8ebx5nbjkuBV4=;
        b=bz21T66uxR9MeF2ke4RlDSoO4aD0YRWDmX9rcdXkXewElXhORVd+iwza0sYAqeIoR+
         VU+ocHF590WqXTFOK0aYDaW5H9xKAaDG5oN0WjBLG+t7hAyUS9f9QtOyS7W6E2dMHVs7
         KRmeG+BBPagPQEfMcK6vapvcjGVIpzwv/FoPt+xGnQJM66ullp1GMjhmr4+SMf02IbEC
         f6nBEryH3R8rQBZRH0aHAfpDIvAgCpUNWnNO8a7F/d0k7w/2BR9vxJ5wpBiW0G+jhW8O
         HQ52xUAFLlyPkOTrt77+JGsnJ10cAcrrI60HbgNjBoCOKiLbZTr5HJG69wNaOWTuWCkI
         Kc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726458; x=1698331258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xM59NTfupiUDLHnq4Q6FLBD9y4loLd8ebx5nbjkuBV4=;
        b=PTV1DC6U8KUwC/ba9xVBES1R6W9G3BIYXI/PKfbWwwrQ3IbFCCDWQuaIOWksUTZ78w
         ck+UbdTtNcT93lujOq9opIZCL4K7V2Xok5VYI6/vjy0KAn2spxGGR6iDXUSwdVLCE62D
         5CrSob3/n2uwxK/7jvkgr8qyPg/6SzYEsu+i5V30bTsyiXcPeAWY4hMXPvqBJZGTueNX
         TzHaVZ54lFgaeOdnso6UUpI/LKMGNNWtZxp1PbuAD9Iy3M2xQaTRa+L/Qh+SQ/0UIn14
         nOSkIUrLgfn2vaaq5l4OLD89Td9WWnhit4HzAODR+nB+OB9NGnrcn/b6lL9gXcLRPx4m
         /pDw==
X-Gm-Message-State: AOJu0YyfOnIBlUqilb78pOjjER7HqLjGcHv4o/fWSAY8cy78OoPxbIzr
        9OwAnKit9bad5fp/x1BhPBBqBD+GLHN2iIEIME4=
X-Google-Smtp-Source: AGHT+IG8PnUAgdVOzgFJnXSouFnnC8HLG+an2r3K1uH0YuVQiR/aIH437YP18wYS6/QUlklnP1Kr3S2Yt4L3/KAbUeU=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:691:b0:d9a:fd4d:d536 with
 SMTP id i17-20020a056902069100b00d9afd4dd536mr51027ybt.3.1697726458604; Thu,
 19 Oct 2023 07:40:58 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:28 +0000
In-Reply-To: <20231019144032.2943044-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20231019144032.2943044-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019144032.2943044-8-sebastianene@google.com>
Subject: [PATCH v2 06/11] arm64: ptdump: Add hooks on debugfs file operations
From:   Sebastian Ene <sebastianene@google.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vdonnefort@google.com, qperret@google.com,
        smostafa@google.com, Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce callbacks invoked when the debugfs entry is accessed from
userspace. This hooks will allow us to allocate and prepare the memory
resources used by ptdump when the debugfs file is opened/closed.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h |  3 +++
 arch/arm64/mm/ptdump.c          |  1 +
 arch/arm64/mm/ptdump_debugfs.c  | 34 ++++++++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 1f6e0aabf16a..88dcab1dab97 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -19,7 +19,10 @@ struct ptdump_info {
 	struct mm_struct		*mm;
 	const struct addr_marker	*markers;
 	unsigned long			base_addr;
+	void (*ptdump_prepare_walk)(struct ptdump_info *info);
 	void (*ptdump_walk)(struct seq_file *s, struct ptdump_info *info);
+	void (*ptdump_end_walk)(struct ptdump_info *info);
+	struct mutex			file_lock;
 };
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 58a4ea975497..fe239b9af50c 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -24,6 +24,7 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
+#include <asm/kvm_pkvm.h>
 #include <asm/kvm_pgtable.h>
 
 
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 7564519db1e6..14619452dd8d 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -15,7 +15,39 @@ static int ptdump_show(struct seq_file *m, void *v)
 	put_online_mems();
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(ptdump);
+
+static int ptdump_open(struct inode *inode, struct file *file)
+{
+	int ret;
+	struct ptdump_info *info = inode->i_private;
+
+	ret = single_open(file, ptdump_show, inode->i_private);
+	if (!ret && info->ptdump_prepare_walk) {
+		mutex_lock(&info->file_lock);
+		info->ptdump_prepare_walk(info);
+	}
+	return ret;
+}
+
+static int ptdump_release(struct inode *inode, struct file *file)
+{
+	struct ptdump_info *info = inode->i_private;
+
+	if (info->ptdump_end_walk) {
+		info->ptdump_end_walk(info);
+		mutex_unlock(&info->file_lock);
+	}
+
+	return single_release(inode, file);
+}
+
+static const struct file_operations ptdump_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ptdump_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= ptdump_release,
+};
 
 void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-- 
2.42.0.655.g421f12c284-goog

