Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74B07C747B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379623AbjJLRWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379651AbjJLRWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:09 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B48118;
        Thu, 12 Oct 2023 10:21:56 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-79fe6da0049so49390739f.1;
        Thu, 12 Oct 2023 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131315; x=1697736115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2Hn5pT28/jZmYZLDxW0t8SHXvPdNDH+Olrk3yFtzgY=;
        b=gBoyYBQS6J2gSWNRsAS61KrHuSfrOSOAH/0zQqeW1h5aG1LW8wffKj6HnZFSdtDsw+
         0Hu9InHNnw3Cx56yT4eWp+fRD8MUCemYXz8f5WiPJk7DQnRHFU0DkxlsW0rYrWiQnayw
         LI6e8ZgIzfNqe6hN9LZSUnV20ENinvl0eGhSM+CCh1Kho2y150SQ9nmfnX8LRbJdnuQf
         7ExvViC8tN3QZApCKbTRTv+eWPNM84NrX89+yBkStVXBhK/2VvYRQCSEhfNKFmv28LQ7
         cAaF9taIVaCR8ozgQwhYvs8CvU9YBlTtToBILQikVoy1F4AFoSX4XfCJravSlTq6E9B/
         KSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131315; x=1697736115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2Hn5pT28/jZmYZLDxW0t8SHXvPdNDH+Olrk3yFtzgY=;
        b=EDZ39+Yi2I/2KBIRvzdRUrrfYYd3LcEGYeX6EjTKSxc15WTAVQKcw449minek5Krvu
         bjAWvLLGoTr9JzrvDmbFp3FLjxYwYmATW4Ur0qTZfsOvN1fOAZyo+TcgV9kZOf2sHmTI
         znp1H94h9xfXwlLFUCEYB6zVZyrzeARDebspqm3Po97iDeFDjjPcgAlzegnk3MMqrG1g
         Mp3S21GjPoS4R8SOTro9aiLwCslGWXQywXCUWPTKIs3AsdoiqFFS4xNT9RRvVUbX2Sft
         HPbb9R4RTLiPFaMO4VwwopdM3TAgdgc3+CFuYTAnn1Fz9ZSVWaPCLDTHVKT2jMgRUUZX
         FZqw==
X-Gm-Message-State: AOJu0YwiXY1Z8pDNOWnIRvvTTTD0dGolLNyGUdCD2Cil3dRxvPNxGhJC
        o8+yWP8R5Qj6aNbxZFDQMH1SKyWcr/7nQA==
X-Google-Smtp-Source: AGHT+IGdTcFiK6g1n4MsWov4T5md8KkZ4+Ar5bmmxOEjQ+pRBg2eB+R9NvTFAE3OrPxAOb8JxX8TgQ==
X-Received: by 2002:a6b:5908:0:b0:798:312a:5403 with SMTP id n8-20020a6b5908000000b00798312a5403mr27180775iob.19.1697131315143;
        Thu, 12 Oct 2023 10:21:55 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id r25-20020a028819000000b0043cef0711c1sm3992211jai.158.2023.10.12.10.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:21:54 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 08/25] dyndbg: reduce verbose/debug clutter
Date:   Thu, 12 Oct 2023 11:21:19 -0600
Message-ID: <20231012172137.3286566-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012172137.3286566-1-jim.cromie@gmail.com>
References: <20231012172137.3286566-1-jim.cromie@gmail.com>
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

currently, for verbose=3, these are logged (blank lines for clarity):

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"

 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff

 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

That is excessive, so this patch:
 - shrinks 3 lines of 2nd stanza to single line
 - drops 1st 2 lines of 3rd stanza
   3rd is like 1st, with result, not procedure.
   2nd is just status, retold in 4th, with more info.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b67c9b137447..b0e11f6bfaa2 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -266,9 +266,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -497,7 +494,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -511,7 +507,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -527,7 +522,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -537,7 +532,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -555,10 +550,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
-
-	return nfound;
+	return ddebug_change(&query, &modifiers);
 }
 
 /* handle multiple queries in query string, continue on error, return
-- 
2.41.0

