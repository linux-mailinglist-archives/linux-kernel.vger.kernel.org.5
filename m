Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80BB7CFD0F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbjJSOk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346147AbjJSOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:40:53 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B25138
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:50 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-407da05ee50so19098955e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697726449; x=1698331249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VveSIU8JYKB/5xEaudWcBTfyzaRnPWmMG3dfs8XdtD8=;
        b=0yf2MI1KTBTaYixTt5PY5GTlUkMFURkHEySHpGCaAPdibV+69YujKo/7bkF08oSXYQ
         CaaLB6yMjA+UQU7KH5w2E0uAiXmIrs72D7plM23oY/v32YEWC3WO8anywFQKFy0YdkOG
         rUwH82R3dwle4oq/4qS9k0cye7KLjkWw3COQp46a1QPW2uo1Wx1QQFUPbiViJsgEPpHZ
         j/A3IUOdWD00OafltgrYSZSw/zuqAHTzT4KsFVDbVevU+fghPZunjnjK4uLUuGcH/XOU
         7xrPU7wGgr0PiMYiaGQcvPon6+/nLoaWpDJka1D+H2S3lFQyJhw0JnDDK2H29ODFOVy/
         X5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726449; x=1698331249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VveSIU8JYKB/5xEaudWcBTfyzaRnPWmMG3dfs8XdtD8=;
        b=nGCW7LNJL5qm6neAuGDRjn72xBMi4s1l28xwT/svW2Us7DxJkJZrrfTgSB1/eeHB7E
         zq960fOVtTneXUMJf+LOCKzDjpGTFEMckHLYPSK8jPeO7oTU3szTpEtY7PthU4LTGfQQ
         nJe1G3+Ocjr1nd+1WR6kzBae+gC6Dqi46s0v71XM3KPdzYe+dANTPQ4IiOtt8KbcmSQX
         g9SRpCD2SzHLeVeJCOvrDhLCIjVlLKRcNxEINoWQ0r4BHVkfatxRwJyWnzWSzawOVY3s
         WCfZWYG2cWkwISsREYvT2qCV1YFthP2meDFEy1tUGosNb8jYdOfcYTibMJUsUuax1IK/
         tTBA==
X-Gm-Message-State: AOJu0Yz8NiS2SkJSaQWmU0KCJlmkjVChJl+p26oyGWWKMnO7SyavHIok
        CsxQ4p3rIuE4BXot2wcYhLVavI/8fSLKW2buWKU=
X-Google-Smtp-Source: AGHT+IFqK8L1G2PrWrUkVEFgks/xU9XIe7Fi7Mf6EMwliRg4fKVtpO97kPUB2tKYc4VoRxZAAgOHvgA1f+Ug30MC3us=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a5d:54d0:0:b0:32d:9a30:4d79 with SMTP
 id x16-20020a5d54d0000000b0032d9a304d79mr20981wrv.3.1697726449420; Thu, 19
 Oct 2023 07:40:49 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:24 +0000
In-Reply-To: <20231019144032.2943044-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20231019144032.2943044-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019144032.2943044-4-sebastianene@google.com>
Subject: [PATCH v2 02/11] arm64: ptdump: Use the mask from the state structure
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
2.42.0.655.g421f12c284-goog

