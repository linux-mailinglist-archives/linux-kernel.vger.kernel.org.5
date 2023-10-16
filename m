Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94C37CA6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjJPLbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPLba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:31:30 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4AEE5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:31:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-577e62e2adfso2616936a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697455888; x=1698060688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EpO7UHWG7x+hFB0wfvrXA05ahh/RMkrbYcf924Z7adc=;
        b=npw0cjYe8ujWQ1eHG448e0zoYkPINS+EwOjEyDxNv/78VaD/gWNgA6bE03wTfU4Yvg
         eJ1pkqqamfCr6Us2wC4QsUpq0V/vYyUVsfAEpTEP9jvmrRACm3icHqhRwiaOqANjtaku
         uS06Lp9vqUXGy4Tja0RaKKjT/+ygoIJz6Ud7p1JKyS4BFTY7zH6Tu9WgICaizv53iABe
         ZolIbC8OuWJh8qbKAFYAqVY02NabJ39nSBn6QzadYuNNcTLl0nWZLzvszFr1jC0NfRXo
         dhW55lcXwaVp23n4I9rMaW+l12aAvqhGqjGWCDPg2Qpv2xTiQ2PCaGUhh0M4UuMWjbPB
         SNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697455888; x=1698060688;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpO7UHWG7x+hFB0wfvrXA05ahh/RMkrbYcf924Z7adc=;
        b=LWInelrgLq+BBhUz1WXt7X2K7IbpQzM6lZ4K/vs5qurp7pdo8agN4E4icYCII1ZrFm
         S2nNnyl5roZS7glQnWYSum5BRZ5s8bzs/z3siBiKX53LF551ADWb1WAUjqufp/dgIv+Z
         PstqiOLd5gRa72tyFIdGPa8YEsnaYEeDxwuI/z/Rdb7ghpio04ZUSb37VKy0V0SxZwJc
         GvO26elF1HaLqNqA7CHYjy9lTH8BLNt2njzjJZU5KFzzFOai4Eeuc4PbF+XM5xaQDpMa
         4O9uubN8TGlau5BkbpltDZtoS1r/cnuFdKL8rbywHJLX8lsO1GooD4mhRkd8SdGGTKgU
         MIFw==
X-Gm-Message-State: AOJu0YzBusdgL96dcViC0ooQ0cgsr5t6A0zZB/8lNB/ucMoFtTO6YJCx
        hEu+SUaAdZJsiResiAvZUhw=
X-Google-Smtp-Source: AGHT+IGsJwcM79xIzMPvgvu/0hugjG+89HhYNiH7N/zVvPvIm2thCm/8iFKgqbhaYhK4LAd00bMyXA==
X-Received: by 2002:a17:90a:17a8:b0:27d:52b:99ac with SMTP id q37-20020a17090a17a800b0027d052b99acmr11613237pja.7.1697455887828;
        Mon, 16 Oct 2023 04:31:27 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id nt3-20020a17090b248300b00262ca945cecsm4523868pjb.54.2023.10.16.04.31.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Oct 2023 04:31:27 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [PATCH] mm/oom_killer: simplify OOM killer info dump helper
Date:   Mon, 16 Oct 2023 19:31:03 +0800
Message-ID: <20231016113103.86477-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.42.0
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

There is only one caller wants to dump the kill victim info, so just let
it call the standalone helper, no need to make the generic info dump
helper take an extra argument for that.

Result of bloat-o-meter:
./scripts/bloat-o-meter ./mm/oom_kill.old.o ./mm/oom_kill.o
add/remove: 0/0 grow/shrink: 1/2 up/down: 131/-142 (-11)
Function                                     old     new   delta
oom_kill_process                             412     543    +131
out_of_memory                               1422    1418      -4
dump_header                                  562     424    -138
Total: Before=21514, After=21503, chg -0.05%

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/oom_kill.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 44bde56ecd02..9e6071fde34a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -437,7 +437,7 @@ static void dump_tasks(struct oom_control *oc)
 	}
 }
 
-static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
+static void dump_oom_victim(struct oom_control *oc, struct task_struct *victim)
 {
 	/* one line summary of the oom killer context. */
 	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
@@ -449,7 +449,7 @@ static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
 		from_kuid(&init_user_ns, task_uid(victim)));
 }
 
-static void dump_header(struct oom_control *oc, struct task_struct *p)
+static void dump_header(struct oom_control *oc)
 {
 	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
 		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
@@ -467,8 +467,6 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 	}
 	if (sysctl_oom_dump_tasks)
 		dump_tasks(oc);
-	if (p)
-		dump_oom_summary(oc, p);
 }
 
 /*
@@ -1029,8 +1027,10 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	}
 	task_unlock(victim);
 
-	if (__ratelimit(&oom_rs))
-		dump_header(oc, victim);
+	if (__ratelimit(&oom_rs)) {
+		dump_header(oc);
+		dump_oom_victim(oc, victim);
+	}
 
 	/*
 	 * Do we need to kill the entire memory cgroup?
@@ -1072,7 +1072,7 @@ static void check_panic_on_oom(struct oom_control *oc)
 	/* Do not panic for oom kills triggered by sysrq */
 	if (is_sysrq_oom(oc))
 		return;
-	dump_header(oc, NULL);
+	dump_header(oc);
 	panic("Out of memory: %s panic_on_oom is enabled\n",
 		sysctl_panic_on_oom == 2 ? "compulsory" : "system-wide");
 }
@@ -1155,7 +1155,7 @@ bool out_of_memory(struct oom_control *oc)
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
-		dump_header(oc, NULL);
+		dump_header(oc);
 		pr_warn("Out of memory and no killable processes...\n");
 		/*
 		 * If we got here due to an actual allocation at the
-- 
2.42.0

