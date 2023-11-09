Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094457E756B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345443AbjKJAAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345450AbjKJAAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:36 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E1B4689;
        Thu,  9 Nov 2023 16:00:24 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so1390619b3a.2;
        Thu, 09 Nov 2023 16:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574424; x=1700179224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBFPY4pW04M2sgJecsy3kFli8IglhnnPsjX6xiP+Dlg=;
        b=AjF20uFKQi1cHWGqvw1DKTEmQ5rTmfFuJjUR2OWT2Y+2IYSFbXwkA2pWIbrknqOemL
         1caI36D22RZr2TCDWojbPe61NtCz764bLpxXBNaD5TyQH5qPft66jbBXZgmXNBerdrn4
         xX1AlHUeUygAfK9CLJdKNCOGfu9Ba1QWc1WmqF3+Si8XUBztGk9EQXdjsZFjYauRetea
         v5fGo+r6EUQtJPYZcHQN71ayLPwJd/K6N3EUaiWHo6koNzkyDVAUtmpVQJPnO4diD1/1
         PAQ0yrATm2jGBMhm8g23ryWDrjWcmCSW6XbMhwLrYE7/UGq7B/LlWNKHJ6P6kegDKbft
         J8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574424; x=1700179224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gBFPY4pW04M2sgJecsy3kFli8IglhnnPsjX6xiP+Dlg=;
        b=IDxo4JQgeh4f56EzBWYKBVB2p0eMxc6VqfYRPhInmeXLhSBlYMWqPggtQLAqJ6Wbid
         dfBgb1bBiXK4I2prFsYP3wb2ptl8JzcOprHY1rJRynuAfb6oH9jqbwOht4mLyQjd0S9f
         MxrQooEPpbqm5+Z4mf/rjD/yCe0VEASvDSlJb94pMYvuzpPN1BeXBbRWHkVhQQPN3lgO
         qXdRm4fJN+BNfvXTGyLjJxq9rwakg/9lF4382fC1CJ/4CizXDhTeMCyIEVx5i8FzYiwq
         SV2Vf4kZio/CNnIirQLB+Os1Fy2J0UbDBrCCdyIdhAsRG1+7zBjlr6QBwytwBkBx+wFK
         L2SQ==
X-Gm-Message-State: AOJu0Yylx352mBaN86SZq/h2M3jcgn7meIUdGQNiztNyH+xD/Euq31Jp
        rWYjKtPnK+TPK9HvntRaMvY=
X-Google-Smtp-Source: AGHT+IGh5xp75WCSAqGUum6l9xwGOp3SEtjtW8b9M3Z96gpo14k1fTr8mUXAKHiQIx0W+urxCOggFw==
X-Received: by 2002:a05:6a20:9143:b0:182:11b2:b982 with SMTP id x3-20020a056a20914300b0018211b2b982mr6536454pzc.27.1699574424018;
        Thu, 09 Nov 2023 16:00:24 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:23 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 05/52] perf dwarf-aux: Move #ifdef code to the header file
Date:   Thu,  9 Nov 2023 15:59:24 -0800
Message-ID: <20231110000012.3538610-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a usual convention that the conditional code is handled in a header
file.  As I'm planning to add some more of them, let's move the current
code to the header first.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c |  7 -------
 tools/perf/util/dwarf-aux.h | 19 +++++++++++++++++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 4849c3bbfd95..adef2635587d 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1245,13 +1245,6 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
 out:
 	return ret;
 }
-#else
-int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
-		      Dwarf_Die *vr_die __maybe_unused,
-		      struct strbuf *buf __maybe_unused)
-{
-	return -ENOTSUP;
-}
 #endif
 
 /*
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 7ec8bc1083bb..4f5d0211ee4f 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -121,7 +121,6 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf);
 
 /* Get the name and type of given variable DIE, stored as "type\tname" */
 int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf);
-int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
 /* Check if target program is compiled with optimization */
 bool die_is_optimized_target(Dwarf_Die *cu_die);
@@ -130,4 +129,20 @@ bool die_is_optimized_target(Dwarf_Die *cu_die);
 void die_skip_prologue(Dwarf_Die *sp_die, Dwarf_Die *cu_die,
 		       Dwarf_Addr *entrypc);
 
-#endif
+#ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
+
+/* Get byte offset range of given variable DIE */
+int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
+
+#else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
+
+static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
+				    Dwarf_Die *vr_die __maybe_unused,
+				    struct strbuf *buf __maybe_unused)
+{
+	return -ENOTSUP;
+}
+
+#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
+
+#endif /* _DWARF_AUX_H */
-- 
2.42.0.869.gea05f2083d-goog

