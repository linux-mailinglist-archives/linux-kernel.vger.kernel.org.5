Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C527E756E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbjKJAAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345456AbjKJAAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA1346AD;
        Thu,  9 Nov 2023 16:00:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2809fb0027cso1296222a91.2;
        Thu, 09 Nov 2023 16:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574428; x=1700179228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9f6IvIGwymLkdOL1VpLPLvQfPskawajHqhT5uorupU=;
        b=UCdg3e68NYEq57mahG9/zkSU9YMBeP7Fcu0gDadBbRx5BmblawvIJvbMJBhGF1BVay
         6RBPvTPYdQDb1uKDQ4SVuAzO+Y7Uyew2MFhhNNQ9OKfe5pvlB4zliIhSgNVq8rR+ZXAB
         6/q7X3IPYbmac4H96Oz+gcuhzYopqDr7CjcyrfCzFMzXP79Fs8PFQwZDdUAeMrpKuu/O
         4Tt+uJPzkhkYV/A+kTaNk+1ABR93SAypDNIVsgPL4jiLmCt24PvzjAU/8CH8OmWPW1c1
         f8IdxaFTffyuWkrdsZEh6TprrjWlYKpeDUSAV3wbi3Uis4/vg3uf7is/CHiYH5ceZvxD
         9asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574428; x=1700179228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9f6IvIGwymLkdOL1VpLPLvQfPskawajHqhT5uorupU=;
        b=vesNb6W5MHdj91ovOuLx4mXO1Shx9mNjF4PHl+YoBdurvJMU5DBn1P4A6j6Zm+twX/
         TJTo6r04h7cYbJ4+1lpP/4WkKMspzZfRbxXwx8VI58GXlLNNw62tLr2h/aYD32zjnlM3
         LYAYeZToYw5Hcsqp8QbGIlg3BEpoiipNNsAWvgeqaQP2NvBz2kVpjuxk3kNIFNXR5XSp
         d7ndYrhqp4Um3bfMhZoZlNgu1fVo/3TkjjccX/qR95S6RDT24Ju9F6ziwhB3BbZd5EO+
         OEVuRhftIlyJ/Ken4u1dzvIwfk+wxpxq2HsvS+UCkwhZfCORiTEnUCKUR8wjim8uwJl8
         9/Hw==
X-Gm-Message-State: AOJu0Yz3KcSRvtZh6TNC7HTNwHr0MGG/nlDbJ/5io+uaYIn97YsI7XeQ
        EvDk6P3axYMaJi1GQ8qgrmo=
X-Google-Smtp-Source: AGHT+IF1NAQhLh0Co6ml9PpkL9EAkduXrR3OwA0e3PBB9zj5VsdjZpAJI29AnNpmoYHl2M2vtwtUaA==
X-Received: by 2002:a17:90b:4f88:b0:27d:75f2:a3ee with SMTP id qe8-20020a17090b4f8800b0027d75f2a3eemr3118306pjb.10.1699574428251;
        Thu, 09 Nov 2023 16:00:28 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:27 -0800 (PST)
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
Subject: [PATCH 08/52] perf build: Add feature check for dwarf_getcfi()
Date:   Thu,  9 Nov 2023 15:59:27 -0800
Message-ID: <20231110000012.3538610-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwarf_getcfi() is available on libdw 0.142+.  Instead of just
checking the version number, it'd be nice to have a config item to check
the feature at build time.

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/build/Makefile.feature            | 1 +
 tools/build/feature/Makefile            | 4 ++++
 tools/build/feature/test-dwarf_getcfi.c | 9 +++++++++
 3 files changed, 14 insertions(+)
 create mode 100644 tools/build/feature/test-dwarf_getcfi.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 934e2777a2db..64df118376df 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -32,6 +32,7 @@ FEATURE_TESTS_BASIC :=                  \
         backtrace                       \
         dwarf                           \
         dwarf_getlocations              \
+        dwarf_getcfi                    \
         eventfd                         \
         fortify-source                  \
         get_current_dir_name            \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index dad79ede4e0a..37722e509eb9 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -7,6 +7,7 @@ FILES=                                          \
          test-bionic.bin                        \
          test-dwarf.bin                         \
          test-dwarf_getlocations.bin            \
+         test-dwarf_getcfi.bin                  \
          test-eventfd.bin                       \
          test-fortify-source.bin                \
          test-get_current_dir_name.bin          \
@@ -154,6 +155,9 @@ endif
 $(OUTPUT)test-dwarf_getlocations.bin:
 	$(BUILD) $(DWARFLIBS)
 
+$(OUTPUT)test-dwarf_getcfi.bin:
+	$(BUILD) $(DWARFLIBS)
+
 $(OUTPUT)test-libelf-getphdrnum.bin:
 	$(BUILD) -lelf
 
diff --git a/tools/build/feature/test-dwarf_getcfi.c b/tools/build/feature/test-dwarf_getcfi.c
new file mode 100644
index 000000000000..50e7d7cb7bdf
--- /dev/null
+++ b/tools/build/feature/test-dwarf_getcfi.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <elfutils/libdw.h>
+
+int main(void)
+{
+	Dwarf *dwarf = NULL;
+	return dwarf_getcfi(dwarf) == NULL;
+}
-- 
2.42.0.869.gea05f2083d-goog

