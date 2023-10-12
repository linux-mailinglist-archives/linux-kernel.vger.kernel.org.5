Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D27C636C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377018AbjJLDv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376873AbjJLDvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:51:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1569EC6;
        Wed, 11 Oct 2023 20:51:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c871a095ceso4549055ad.2;
        Wed, 11 Oct 2023 20:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082682; x=1697687482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDCRLN//GDrGJp7khI5N6nKLZqiZJEAgcyWXlKtsgWI=;
        b=ITRuwuGQsdVJsSJtABcm3Elp0k/+SOu+TjSj5C20R+F1Y1EikCShpvWvMtYIIEiDQS
         EaJ3djTVa9vO8UFQKZVP+M4SOSTjiJdNgN2XpUmfQ+l17jpKaws297C+8j4uCkvSqFC9
         BMGFYHoRt09gyftMoELYY45ZGAkM/8kI0P7NuYprsgrr5BE8JAWKBmGvWQriDbXb6AjX
         Sif4ZIlcIVYBEvx+1GBRk6DxUQUP5E0T19Ki9ToSX7qm5stLrK4HICA2gblmW8yk23He
         2Jxnmt8XDXxuFCNsvQMZHzucHo9bUCj3IC06iWgMQHX6BnO4tMvKhXUbB5THEsm/Qi4M
         fe9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082682; x=1697687482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDCRLN//GDrGJp7khI5N6nKLZqiZJEAgcyWXlKtsgWI=;
        b=CU3SXSjivXCt/rKBVsZslvhlpGq9h3lb6m1TuRnMHsfTmOQ8FQQo6Bdt0PMaQKReHP
         sbt32EBnkMb1B2mBZAPD1vzDVl3zbGgE1T/vPXl40H8im8CuLVsphw3R4b8MwFPLgy2f
         Osgi+zrlWXRpcMGEMgfL85LM1+8opG9g9yEluM5lBKqchC+kxSCifo2KRDG63kgrdUHb
         +NT+4gYBsG18V7KgcBvlAPlQTlJXnc6mLDbvsjVEwz/jmKGTPZZNMgYbhQRU4wRB6U0g
         bH4yEqNXyB/Y6A9+5y9/o40Q9KszEhG0kQy9gFfB+YxgMXTJoVj9+qkbZnkkqdjSzOj7
         TmkA==
X-Gm-Message-State: AOJu0YzDFVClPfRWpT8LJ1a8sgN7X9BOTqPZISzIeLJdHbVDRL37YN/1
        7s4nkGX7wkEXKnwBWaTc5s8=
X-Google-Smtp-Source: AGHT+IHdYZPZ7jxW9iCz5UaWHuPYiF5gqvs27HuXcrwTz+rGQzDjAb2lw+Tki39iGPe9p1g2++2Meg==
X-Received: by 2002:a17:903:41c9:b0:1c5:f1fd:5da with SMTP id u9-20020a17090341c900b001c5f1fd05damr24713893ple.2.1697082682477;
        Wed, 11 Oct 2023 20:51:22 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:22 -0700 (PDT)
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
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 06/48] perf dwarf-aux: Add die_get_scopes() helper
Date:   Wed, 11 Oct 2023 20:50:29 -0700
Message-ID: <20231012035111.676789-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The die_get_scopes() would return the number of enclosing DIEs for the
given address and it fills an array of DIEs like dwarf_getscopes().
But it doesn't follow the abstract origin of inlined functions as we
want information of the concrete instance.  This is needed to check the
location of parameters and local variables properly.  Users can check
the origin separately if needed.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 53 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  3 +++
 2 files changed, 56 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index adef2635587d..10aa32334d6f 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1425,3 +1425,56 @@ void die_skip_prologue(Dwarf_Die *sp_die, Dwarf_Die *cu_die,
 
 	*entrypc = postprologue_addr;
 }
+
+/* Internal parameters for __die_find_scope_cb() */
+struct find_scope_data {
+	/* Target instruction address */
+	Dwarf_Addr pc;
+	/* Number of scopes found [output] */
+	int nr;
+	/* Array of scopes found, 0 for the outermost one. [output] */
+	Dwarf_Die *scopes;
+};
+
+static int __die_find_scope_cb(Dwarf_Die *die_mem, void *arg)
+{
+	struct find_scope_data *data = arg;
+
+	if (dwarf_haspc(die_mem, data->pc)) {
+		Dwarf_Die *tmp;
+
+		tmp = realloc(data->scopes, (data->nr + 1) * sizeof(*tmp));
+		if (tmp == NULL)
+			return DIE_FIND_CB_END;
+
+		memcpy(tmp + data->nr, die_mem, sizeof(*die_mem));
+		data->scopes = tmp;
+		data->nr++;
+		return DIE_FIND_CB_CHILD;
+	}
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_get_scopes - Return a list of scopes including the address
+ * @cu_die: a compile unit DIE
+ * @pc: the address to find
+ * @scopes: the array of DIEs for scopes (result)
+ *
+ * This function does the same as the dwarf_getscopes() but doesn't follow
+ * the origins of inlined functions.  It returns the number of scopes saved
+ * in the @scopes argument.  The outer scope will be saved first (index 0) and
+ * the last one is the innermost scope at the @pc.
+ */
+int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes)
+{
+	struct find_scope_data data = {
+		.pc = pc,
+	};
+	Dwarf_Die die_mem;
+
+	die_find_child(cu_die, __die_find_scope_cb, &data, &die_mem);
+
+	*scopes = data.scopes;
+	return data.nr;
+}
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 4f5d0211ee4f..f9d765f80fb0 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -129,6 +129,9 @@ bool die_is_optimized_target(Dwarf_Die *cu_die);
 void die_skip_prologue(Dwarf_Die *sp_die, Dwarf_Die *cu_die,
 		       Dwarf_Addr *entrypc);
 
+/* Get the list of including scopes */
+int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes);
+
 #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 
 /* Get byte offset range of given variable DIE */
-- 
2.42.0.655.g421f12c284-goog

