Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7367EC97F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjKORRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjKORRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:17:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E75197
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da2b8af7e89so8334817276.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700068620; x=1700673420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ancG5BntywgLYEtvolLfMGCRB6TUL9+Qsz3r5K1PW+Y=;
        b=xrWsTiyCHBiwz7mSj9bK7ctp7FaEseGHYVltxpTbsvsJ4EkO8ejqyPyA25FFtQ2kPC
         lRc8zKpqCSq+dTp7K8XgCFgIQbiAy7lRV11KtDDlqqCKU1NPlqKA/Ex6FySx8Oh1Cbrm
         w6OCt/xSgzdSrD6NgF59v7NEjkcVirfui50mPgdly6Rc04JPt2Qh750gsWJLhZ95G5/S
         AoA4LsXGCkRAKalKlnkEylI/d0o/N5spOyjtWl4Ep6cFNNOBhvKj0DmRiNn9e1+m7rvR
         nswgOvw0vuM8IOJFPwVptBjK8HiKiGkJdGGbsNktRhNhnG0SUw2M2MMTI7YW9/BPGtOl
         vCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068620; x=1700673420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ancG5BntywgLYEtvolLfMGCRB6TUL9+Qsz3r5K1PW+Y=;
        b=IHydyqEkdiRytYXIMG4hOmlBVCjtA5UWYSEzDiKleE2LucU+yRXUDSahb3LTwBT/FQ
         ppUZ1r7/lbQiiCKoeU1+zwaxaGI1yEKP55Ow7Rh2PCKRr8IlCMEFJHXl7JLTvowVkVFp
         qBgSg5u7mjZE8bld222iF84bnTAcw2Mb9Ue+OOLO+Z6siXgP1OwbJG0s5NSRUsRAuzA5
         9vcl20WceH4c6j5ZSAcEOLjV7bcUuXgQUV6e3oyUNHZ+noZHexI9YbeCTgWEGSu1hXCU
         HzQ1330uzXuChkgdUsO0lX0OB0VbrHevNyfUystqzX/8gicmVKhffzM6qw1YKO6RQdu5
         EsqA==
X-Gm-Message-State: AOJu0Yy3RXBYuJxjolvlNyxsZVUkNbcPA1W9wVn2+FFag4Id+kqBrtPy
        5YWRXY7yBGmCkUa4wYnaBLwMaeZ+MxyWAlDOdaA=
X-Google-Smtp-Source: AGHT+IGj2sqWbMdL/6D9g7CRzAYqqT3mXvwK0Hse86EHkE+8SGctzk4vkst4vCcjMP9s+i6Vnuewpw1qh5ywF521RY0=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a25:dcc3:0:b0:d9a:4fb2:16a2 with SMTP
 id y186-20020a25dcc3000000b00d9a4fb216a2mr310123ybe.12.1700068620695; Wed, 15
 Nov 2023 09:17:00 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:16:33 +0000
In-Reply-To: <20231115171639.2852644-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20231115171639.2852644-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115171639.2852644-5-sebastianene@google.com>
Subject: [PATCH v3 03/10] arm64: ptdump: Add the walker function to the ptdump
 info structure
From:   Sebastian Ene <sebastianene@google.com>
To:     will@kernel.org, Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org
Cc:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vdonnefort@google.com, qperret@google.com, smostafa@google.com,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stage-2 needs a dedicated walk function to be able to parse concatenated
pagetables. The ptdump info structure is used to hold different
configuration options for the walker. This structure is registered with
the debugfs entry and is stored in the argument for the debugfs file.
Hence, in preparation for parsing the stage-2 pagetables add the walk
function as an argument for the debugfs file.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h | 1 +
 arch/arm64/mm/ptdump.c          | 1 +
 arch/arm64/mm/ptdump_debugfs.c  | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 581caac525b0..1f6e0aabf16a 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -19,6 +19,7 @@ struct ptdump_info {
 	struct mm_struct		*mm;
 	const struct addr_marker	*markers;
 	unsigned long			base_addr;
+	void (*ptdump_walk)(struct seq_file *s, struct ptdump_info *info);
 };
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 8761a70f916f..d531e24ea0b2 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -346,6 +346,7 @@ static struct ptdump_info kernel_ptdump_info = {
 	.mm		= &init_mm,
 	.markers	= address_markers,
 	.base_addr	= PAGE_OFFSET,
+	.ptdump_walk	= &ptdump_walk,
 };
 
 void ptdump_check_wx(void)
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 68bf1a125502..7564519db1e6 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -10,7 +10,8 @@ static int ptdump_show(struct seq_file *m, void *v)
 	struct ptdump_info *info = m->private;
 
 	get_online_mems();
-	ptdump_walk(m, info);
+	if (info->ptdump_walk)
+		info->ptdump_walk(m, info);
 	put_online_mems();
 	return 0;
 }
-- 
2.43.0.rc0.421.g78406f8d94-goog

