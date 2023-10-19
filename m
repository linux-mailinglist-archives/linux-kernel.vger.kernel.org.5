Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485877CFD10
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbjJSOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346167AbjJSOkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:40:55 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D9E13A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:53 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-32da47641b5so3245201f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697726451; x=1698331251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4QoqI5aCHRTu5rG2YCshZg+f8V+cS7FPutmWA2GX1oY=;
        b=CnoX0fTEBnM/8OTj/QVqlnOkPTcOGQr4L1iLLknd6Mb7P/koITPgsZkYdFsvGa2W4d
         dSVerc22hA1rbGpZwhd277KWm3JtPahF7+u6qW+p7Rt2ZNmcIMwq6gCTsb+sSAFb3yFM
         nC61os6QBkdTAuHe1MX0mzndQDHGJvaIWvXLUlt+dcJ4MGykUmuYl7gG77IN0zPpuUry
         t8GRysSHeHdmt1YfmzhctBlssDQA2+yUqfw/V6a9fUed3fv/QXgC3CHLl6p8CsBDwNMq
         vh/kMtr1B+V5Gvr1zYCBWTz4QA89aNSqzylemRU0pEix5bHntohbKUF1fC5N0Xe/k5Cg
         HZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726451; x=1698331251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QoqI5aCHRTu5rG2YCshZg+f8V+cS7FPutmWA2GX1oY=;
        b=tg+yGz9MVpzP8ZWkg30ciljd1vFaEOYvYsd1FkpziFdHeGDfhZjBJh9kBIzfx4au6U
         dJUJPny0Dr8gCSgZiQXIBBixnnWZcZRz1yuwEQqM5Q+JPQgWd0DkEpOgSTmi6oB6+Mo4
         m/cXbs8S5GZll5I58CkU9Ru3pefbs2q9bV06G4VwYQTIQxmnm2UX3npIO9cNgFsPSmWW
         R6p7BNd9LCebHJSZ8qjUWHRfzuLXOxiPZtBy3eh5DhslThF+DTL8BOu/QOKId6FHKpgc
         6D0jpPLnyavMLnWjZftzN1HZoKbEGxvV2TEiszslo72WoTkNsgx76WGYKpDrB5b+U1ai
         7ysQ==
X-Gm-Message-State: AOJu0YxfXpo0PyHAwm+kvrUwRcExQx4ijn1AjRT+1Nxj/k+p0ybJA7i0
        gfqW5Et7/zfemmy7xjYl2Lib+s0J1qVsvVrvuLM=
X-Google-Smtp-Source: AGHT+IG9C3HVsTvdzZtREABIo9YGDHGNQe1R9a5yyUbc+k79HI9yZVVA3h5Q1vXZZF48rkbCBJ8b83q8/N5eW+9gmOE=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:adf:cd89:0:b0:32d:8a32:3b25 with SMTP
 id q9-20020adfcd89000000b0032d8a323b25mr20286wrj.5.1697726451553; Thu, 19 Oct
 2023 07:40:51 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:25 +0000
In-Reply-To: <20231019144032.2943044-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20231019144032.2943044-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019144032.2943044-5-sebastianene@google.com>
Subject: [PATCH v2 03/11] arm64: ptdump: Add the walker function to the ptdump
 info structure
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
2.42.0.655.g421f12c284-goog

