Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA537EC97E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjKORRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjKORRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:17:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E715127
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:16:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da307fb7752so8929774276.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700068618; x=1700673418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y0A/JzsGt28jdcT80BavCxCwKvAhE81Bu7nGud0PArE=;
        b=WWo5FwtPlJqJm5DvQ3UAKpvrkNXOxnLvErKLqK7nAaEjDyqK8WG2nKPnBsRgUWWgk4
         JJpqpr8+5NvPaLXK3spIW68zcfV6GMVb4KXgzggr/PR0pw3eU9XgSmH9XdNRoCmZiang
         vIVhuLhmMeOJMpFnaCg1Nw2A4D6yJYS/7ytD7+WVWxZ+55c9eQZPQffjEO1NamHYwcJw
         SHGwQDizgPSSemTLQk31jv++6LlXuh8nAUrIyCEXFwxWBceg4ThWfrlh8e0TVBq0JRDP
         DP0sStsjpLIK3rSDeNBFycQwAFKguEJDiVsdAPR3slmHrdppj+ewIz08DV6E/5vgp+8v
         OlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068618; x=1700673418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0A/JzsGt28jdcT80BavCxCwKvAhE81Bu7nGud0PArE=;
        b=dXeAOqdBOYt+JxEH23fnVA1viHuzqe/XBtkGwal5Ga8k5kKPklJJ2Rr/sAcsfduVmN
         7BvhtRtkpMw9WBP1FLq8UchjpG5Te4ykETohV331DttW/zo+jVt/mPIXJ6vzGV2wtH+l
         94vkZevMNrrQXBj0B3IgHVUtsEcBQB0GekP0Qzq08f5Dcq7m5DJ37ofeJftKcaYvHqhQ
         5/BVNV6aldVqTHM6VYl2Y/k4a8I4nUoC8hMfJHEP2udheQEdF0S+PBcmggRUB6FLgTgk
         tbGI8g69vFINF5vz0gmTlDMcq0iPr/hxVQJVtwNM6ek0DefJa7fdq3VG5XafIQWH9MwR
         Xvww==
X-Gm-Message-State: AOJu0Yx13j9EKTDqRPZgvXtf3Xn3BaLAhESYnoN8/3/nxXsIks0VNsfc
        rjEhCRNBwnvuWqxj/9ArT0DI5xlYdxv+jUhCbgQ=
X-Google-Smtp-Source: AGHT+IHvlCAUAQ7rynEQW7WXWvObMDPO+YBhC2cqr0pMjotcdPVLuo899EzI/e2mZHuLUOn3sEwympOD+yO+Oto2Btk=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a25:3206:0:b0:da0:3da9:ce08 with SMTP
 id y6-20020a253206000000b00da03da9ce08mr324716yby.10.1700068618426; Wed, 15
 Nov 2023 09:16:58 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:16:32 +0000
In-Reply-To: <20231115171639.2852644-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20231115171639.2852644-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115171639.2852644-4-sebastianene@google.com>
Subject: [PATCH v3 02/10] arm64: ptdump: Use the mask from the state structure
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

Printing the descriptor attributes requires accessing a mask which has a
different set of attributes for stage-2. In preparation for adding support
for the stage-2 pagetables dumping, use the mask from the local context
and not from the globally defined pg_level array. Store a pointer to
the pg_level array in the ptdump state structure. This will allow us to
extract the mask which is wrapped in the pg_level array and use it for
descriptor parsing in the note_page.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index e305b6593c4e..8761a70f916f 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -75,6 +75,7 @@ static struct addr_marker address_markers[] = {
 struct pg_state {
 	struct ptdump_state ptdump;
 	struct seq_file *seq;
+	struct pg_level *pg_level;
 	const struct addr_marker *marker;
 	unsigned long start_address;
 	int level;
@@ -252,11 +253,12 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		      u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
+	struct pg_level *pg_info = st->pg_level;
 	static const char units[] = "KMGTPE";
 	u64 prot = 0;
 
 	if (level >= 0)
-		prot = val & pg_level[level].mask;
+		prot = val & pg_info[level].mask;
 
 	if (st->level == -1) {
 		st->level = level;
@@ -282,10 +284,10 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 			unit++;
 		}
 		pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
-				   pg_level[st->level].name);
-		if (st->current_prot && pg_level[st->level].bits)
-			dump_prot(st, pg_level[st->level].bits,
-				  pg_level[st->level].num);
+				   pg_info[st->level].name);
+		if (st->current_prot && pg_info[st->level].bits)
+			dump_prot(st, pg_info[st->level].bits,
+				  pg_info[st->level].num);
 		pt_dump_seq_puts(st->seq, "\n");
 
 		if (addr >= st->marker[1].start_address) {
@@ -316,6 +318,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 	st = (struct pg_state){
 		.seq = s,
 		.marker = info->markers,
+		.pg_level = &pg_level[0],
 		.level = -1,
 		.ptdump = {
 			.note_page = note_page,
@@ -353,6 +356,7 @@ void ptdump_check_wx(void)
 			{ 0, NULL},
 			{ -1, NULL},
 		},
+		.pg_level = &pg_level[0],
 		.level = -1,
 		.check_wx = true,
 		.ptdump = {
-- 
2.43.0.rc0.421.g78406f8d94-goog

