Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B53A7D546A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjJXOx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjJXOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:53:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89097118
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:53:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so668571466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698159201; x=1698764001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGTgRMl8R0AO37IqkPzGKZezgxHG7P4IDM0GnQ1FQko=;
        b=fnjTQW5M4mNWpKB7awBz+WlKrUvcbQ6hc1GH1n24HGuwRK2g4WN0gN0kfgl6ZY9H5X
         KGI43jwozLTvNFy96gyEm3aGQgw009QFlkeAKIVKIbTrAEpKYpvUOp6URitp6ZvfY1TB
         S7xXniXSrxp6Q4PsI6gfKCwroqdnfbN0NPD/BFwG0kLz/wm58HD/y8XaQ0mMSsxnPnTu
         7fewbFzoQdzGxbzkMdLKRHXMKJbleVykNOvYgceCsFBzNU8I0jyB4CtC+uIYLsW0wJM1
         D9jsDtfeNfI5XUS9RNiR9KAGwSnh4NV7Ad4JC54tvavV57YbWSfOlUl6DQLTChrmpHv0
         vn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698159201; x=1698764001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGTgRMl8R0AO37IqkPzGKZezgxHG7P4IDM0GnQ1FQko=;
        b=MJlDkkv9I+V3ZZUq3zFsiM0frZqrlE9MWDKvl2gSUffB21ZiF2c/KZpxgT5pfUXG6o
         QzjgkOiXuSbo+CUmNtW9nv2XFhZhVdG9XBSm5aILpg5fc8ccXdTHQB7vD/a6uRnRfWU5
         OYjwwq2HPHey4czhDKNj+XN9wifREn9Rj9vPAjJlWjEKcbL6tj0B33Uacfgg014A4stS
         RhPjP3AbbI59ms3mtF3Y2J84yvVG/Q0wuTgxmtQTioFcR2FijA+/HeGZM/ZCyuZzN83r
         xytVCNZCFvcxWxjv2na05CK4CIGxDNj46YE96+/Zn6SBsMZEME0ngSk5yZjxOFLkRTpU
         ZKIg==
X-Gm-Message-State: AOJu0YxmfQFoyGnkSHUFwcg5yyAFpKCCP99oM7C9SmKu9K+6m96WcvML
        h1alrfisKeN743CchB7iI7RAah4VMTcmaQ==
X-Google-Smtp-Source: AGHT+IGLHpQjp1CaHBmA1Rrw56ih8gPfcRqdgZqas+st0LCfmeV4Z9+ZOd6WnfUp+zdQ6wsjgPmhKg==
X-Received: by 2002:a17:907:94c3:b0:9c3:bd63:4245 with SMTP id dn3-20020a17090794c300b009c3bd634245mr8864192ejc.47.1698159200756;
        Tue, 24 Oct 2023 07:53:20 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id x9-20020a170906148900b0099d45ed589csm8304952ejc.125.2023.10.24.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:53:20 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/traps: Use current_top_of_stack() helper in traps.c
Date:   Tue, 24 Oct 2023 16:52:53 +0200
Message-ID: <20231024145309.46756-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use current_top_of_stack() helper in sync_regs() and vc_switch_off_ist()
instead of reading top_of_stack percpu variable explicitly.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d36a81..78b1d1a6ed2c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -772,7 +772,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
  */
 asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 {
-	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(pcpu_hot.top_of_stack) - 1;
+	struct pt_regs *regs = (struct pt_regs *)current_top_of_stack() - 1;
 	if (regs != eregs)
 		*regs = *eregs;
 	return regs;
@@ -790,7 +790,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	 * trust it and switch to the current kernel stack
 	 */
 	if (ip_within_syscall_gap(regs)) {
-		sp = this_cpu_read(pcpu_hot.top_of_stack);
+		sp = current_top_of_stack();
 		goto sync;
 	}
 
-- 
2.41.0

