Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92327C636B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377051AbjJLDvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376855AbjJLDvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:51:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D57B6;
        Wed, 11 Oct 2023 20:51:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdf4752c3cso4011205ad.2;
        Wed, 11 Oct 2023 20:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082681; x=1697687481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPOXjwmN3ZMMh06n/p0NGkvvVnZrqkqOb37OFAMvoL8=;
        b=hJlN7VF5lkojISEEEE6JFzje5Q47d3eIQggM9OIUaVWObmzB4vkNaqkL4VgJj742wO
         S27+8AvdrQYQnRDjhhbaYM8TdXCKq4zBBXtnWRbTnO47uj6FkoaW6F92XoxoEUa6w/Qp
         HybNbypvFinrzXbqcOgBnLXY90Vm73C4GuLAadcXYLjCcMoPzf75ttS5vkvybjDFzUK5
         lkCJhxCK5f5bIHjjppHjWcM+Tapv6ULUOA6N0jAaxdjYUjonUzcSnLK7G4gMVXeasq+/
         yzRW+oiUcua5J2JcQAlL5/pMF2fF5QS0crlb1gQxVJIKSh3UHWU9GtqhWD9A8qqA1j5T
         Otqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082681; x=1697687481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPOXjwmN3ZMMh06n/p0NGkvvVnZrqkqOb37OFAMvoL8=;
        b=Od9VgrU0q22XG0PFokq41TZbbhl+ahO0m/j1UkbqtQ7ZExuO0s7uc86cMjgHwgKWM/
         rGuNrXFOJ2anQuzDyS/yd1InOr9mR0O3pcGuIItkW1YXTrmyyhO/7kScq7fjeJs8Qlo+
         vRPQRkAq43begNmXr9UhR8Ztyzu+/r6aZvcLRhBH9sZf4YhFIGYNP+loXu6kcQP1x72I
         6IGMnMnVoshbGniZnsCz1rcBT2xvUnW0myZzh01yaJprPqhlP2YrViN3kgc5vdobP9kL
         jmh5+3F3hznke58EopsYXT5eeK/S9YQrUNTp5TBLvAqpMUVClqERxCoHFhEftC46s5u2
         n70g==
X-Gm-Message-State: AOJu0Yzo6OHIZpySHRuSi2lG3F8rBoRgT9jsXktMmsaUcLACYzi7VCHT
        TpKg7nb273stfkfLXf7dNws=
X-Google-Smtp-Source: AGHT+IE4CgDyywX74RJCXXMuhTOVqCARwR6R15YcE3PND7DYtjgY7/8K/ip2EFBFfMLWNx0PDchnUQ==
X-Received: by 2002:a17:902:dacd:b0:1c0:c174:3695 with SMTP id q13-20020a170902dacd00b001c0c1743695mr23283409plx.13.1697082681229;
        Wed, 11 Oct 2023 20:51:21 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:20 -0700 (PDT)
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
Subject: [PATCH 05/48] perf dwarf-aux: Move #ifdef code to the header file
Date:   Wed, 11 Oct 2023 20:50:28 -0700
Message-ID: <20231012035111.676789-6-namhyung@kernel.org>
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

It's a usual convention that the conditional code is handled in a header
file.  As I'm planning to add some more of them, let's move the current
code to the header first.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
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
2.42.0.655.g421f12c284-goog

