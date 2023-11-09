Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C425A7E756F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbjKJAA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345502AbjKJAAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E23246B2;
        Thu,  9 Nov 2023 16:00:30 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28023eadc70so1291767a91.2;
        Thu, 09 Nov 2023 16:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574430; x=1700179230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X4K8d8Dew6reLn4C0dstRYrhu2d/Re9BWl7Yzp4hOo=;
        b=fc+0U4Gy18sRK/DkuJub7OLhE5u9XNZ9Y+wievEjZg8ShRmRC50Rpw3/o0YO/SuLK8
         WHm4i7vw2FEkCQDnDx3LxTdnp4yS10p2GuFycCK8kwMKJcpdrNXqKsbvOaGfORLjwrN7
         uU4JNfPpuKTeP+5fy6Mo/p9n8JA2zC8e2OAN6ERwl4+Ij7B3vWNGOC0XrbJVqNYntrDp
         bY0hRK2aJBi2wRSNkN0ixByHQgq3UvZ48uuzyglHZ/CMOWYDbzJbSYG59wSMkMqo4Eqr
         Z35a/FTmuvcMejv5w1FCJrD+4qNBAAYve7keLNNTstJZ4dp8x4PvQAssJAweIheY/1So
         qF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574430; x=1700179230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+X4K8d8Dew6reLn4C0dstRYrhu2d/Re9BWl7Yzp4hOo=;
        b=Xb55HhLdCEexIoXSXF7phdpjvy9tfXkxrJybItYVH8ULWrNGiRYiNq0kUfFav04aPv
         awLVRZqKLgZFCsLyJ0MUoL4H32Vq7tJ8FKKBL4lLzsg2DiMTL2/ebqtJk32umwY91+dd
         pCMU/xAK0Xni4SO/vyKxholVUBA71OptPXsvJNOoB25kJfxMObptc0kIjWSP3XVj3kdp
         3db2seZ+944CT+VNMEtWc+FzhVzTQuufL6DYU/2v28tjljVMRTikRvPh2ZqcFHVNzkz9
         1gqlO8jx1SMnijeVstPgkWqrJAnqP84VfY4sbsQUCP+VVIdx841rv1xOrW9zbtO9C8BI
         vAZA==
X-Gm-Message-State: AOJu0YyjBzOFKoOIEGN2e3H8GwEBW3FkynBZ4L+8ESGF0YOaY80Zfjz+
        BUEN26SGd9m3JbrThGsIFVc=
X-Google-Smtp-Source: AGHT+IFuj0VFdBbVA2ARzozLQpDa3u3jgJF4Egr2pmAoU4tq/yDacLFFrbHVbVYvgHfRIEfm9YXbaA==
X-Received: by 2002:a17:90b:33c3:b0:27d:839:52ae with SMTP id lk3-20020a17090b33c300b0027d083952aemr3235984pjb.32.1699574429713;
        Thu, 09 Nov 2023 16:00:29 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:29 -0800 (PST)
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
Subject: [PATCH 09/52] perf probe: Convert to check dwarf_getcfi feature
Date:   Thu,  9 Nov 2023 15:59:28 -0800
Message-ID: <20231110000012.3538610-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now it has a feature check for the dwarf_getcfi(), use it and convert
the code to check HAVE_DWARF_CFI_SUPPORT definition.

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.config     | 5 +++++
 tools/perf/util/probe-finder.c | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 8b6cffbc4858..aa55850fbc21 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -476,6 +476,11 @@ else
       else
         CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
       endif # dwarf_getlocations
+      ifneq ($(feature-dwarf_getcfi), 1)
+        msg := $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.142);
+      else
+        CFLAGS += -DHAVE_DWARF_CFI_SUPPORT
+      endif # dwarf_getcfi
     endif # Dwarf support
   endif # libelf support
 endif # NO_LIBELF
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 8d3dd85f9ff4..c8923375e30d 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -604,7 +604,7 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
 	ret = dwarf_getlocation_addr(&fb_attr, pf->addr, &pf->fb_ops, &nops, 1);
 	if (ret <= 0 || nops == 0) {
 		pf->fb_ops = NULL;
-#if _ELFUTILS_PREREQ(0, 142)
+#ifdef HAVE_DWARF_CFI_SUPPORT
 	} else if (nops == 1 && pf->fb_ops[0].atom == DW_OP_call_frame_cfa &&
 		   (pf->cfi_eh != NULL || pf->cfi_dbg != NULL)) {
 		if ((dwarf_cfi_addrframe(pf->cfi_eh, pf->addr, &frame) != 0 &&
@@ -615,7 +615,7 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
 			free(frame);
 			return -ENOENT;
 		}
-#endif
+#endif /* HAVE_DWARF_CFI_SUPPORT */
 	}
 
 	/* Call finder's callback handler */
@@ -1140,7 +1140,7 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
 
 	pf->machine = ehdr.e_machine;
 
-#if _ELFUTILS_PREREQ(0, 142)
+#ifdef HAVE_DWARF_CFI_SUPPORT
 	do {
 		GElf_Shdr shdr;
 
@@ -1150,7 +1150,7 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
 
 		pf->cfi_dbg = dwarf_getcfi(dbg->dbg);
 	} while (0);
-#endif
+#endif /* HAVE_DWARF_CFI_SUPPORT */
 
 	ret = debuginfo__find_probe_location(dbg, pf);
 	return ret;
-- 
2.42.0.869.gea05f2083d-goog

