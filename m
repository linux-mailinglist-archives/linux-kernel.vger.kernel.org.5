Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5BF7E758B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjKJADU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjKJACl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:02:41 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E744BC;
        Thu,  9 Nov 2023 16:01:10 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-280200949c3so1314752a91.0;
        Thu, 09 Nov 2023 16:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574469; x=1700179269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea03R/KMOWK9jWm9N2N4NwL8Qridb15kzrUrffJWfOA=;
        b=BvvqvxGmiPLRjvVpuOt5oXUjstaaAm2NM3qZS9WVE87uKLEvGHYBQzX3qD0ychvSv6
         n4w9lCq1tXomjrP6l6Uk4LDHOWjDN8nnypAOJP+3b+ruQ/Qa4TZ7t/levDeLfjnwMGU4
         hgw0Rz/mxCzc7yifTo9BBWb1aSYjSi0NgJObvYEqjC6DvVkdUtrw00GRnI72r//Yk7Rs
         nTxbCtnm67e1uzh308eN11R11NSydxeGWwB/zxOwOSyB1bVZrjrhqmUqq33x5s3UL9Ln
         URooexM0zfySHbwY/ElC0XJgppNRll5QCPSc5Hyz/S7lSkpyV7W2bXp4PaONsx/2Ehp+
         Ow7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574469; x=1700179269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ea03R/KMOWK9jWm9N2N4NwL8Qridb15kzrUrffJWfOA=;
        b=eqb4iXeH3G8eQ70hi3KVGdtSPWMDxV3WfXwbv5jrbvGVCu0AopN8iGdEFPHHr2G6Yj
         lre+rG16o1kMzQfRPnWL1S4c9SGWdSvQmkz55qso+antFoWsQZaNICNSJItF94g6B/WX
         Kl3y7zpp6YJaFV/VjU89qYmrMWjswlGFmWy+tlNNqgSGmdG1QYhIN0ot+uMbsa+HiKo+
         wQafA3V+L2YxlxrNeevoYWzflY3cfKXqbmx8//y3LrLzXU+9GIHqFYqJ/3IcIRWSJRIb
         914jkYqxNJH2UHtWMail4B6Jm5YI589GzUS0QYU/s3bvBfT9aCWLOuF4PV9JaD4HjTQS
         qebA==
X-Gm-Message-State: AOJu0Yy5S8NsHUaDh+3QiKVVPuLSfbRfD5XHVXV/50Y4DCSAF/4fFDaP
        Zqz3YVT91rsCqZd+5DOKN6k=
X-Google-Smtp-Source: AGHT+IECt0YJd4231LO+X66sGFsIH17Oo36mO+fy8ihhV7GbKGQI2qP7XBBdTxVN4KOudH6rgYujPA==
X-Received: by 2002:a17:90b:4b0f:b0:27d:46e5:2d7c with SMTP id lx15-20020a17090b4b0f00b0027d46e52d7cmr3380378pjb.26.1699574469540;
        Thu, 09 Nov 2023 16:01:09 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:09 -0800 (PST)
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
Subject: [PATCH 35/52] perf dwarf-aux: Add die_get_cfa()
Date:   Thu,  9 Nov 2023 15:59:54 -0800
Message-ID: <20231110000012.3538610-36-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The die_get_cfa() is to get frame base register and offset at the given
instruction address (pc).  This info will be used to locate stack
variables which have location expression using DW_OP_fbreg.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 68 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/dwarf-aux.h | 15 ++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 7aa5fee0da19..3d42a8613869 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1407,7 +1407,73 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
 		*offset = data.offset;
 	return result;
 }
-#endif
+#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
+
+#ifdef HAVE_DWARF_CFI_SUPPORT
+static int reg_from_dwarf_op(Dwarf_Op *op)
+{
+	switch (op->atom) {
+	case DW_OP_reg0 ... DW_OP_reg31:
+		return op->atom - DW_OP_reg0;
+	case DW_OP_breg0 ... DW_OP_breg31:
+		return op->atom - DW_OP_breg0;
+	case DW_OP_regx:
+	case DW_OP_bregx:
+		return op->number;
+	default:
+		break;
+	}
+	return -1;
+}
+
+static int offset_from_dwarf_op(Dwarf_Op *op)
+{
+	switch (op->atom) {
+	case DW_OP_reg0 ... DW_OP_reg31:
+	case DW_OP_regx:
+		return 0;
+	case DW_OP_breg0 ... DW_OP_breg31:
+		return op->number;
+	case DW_OP_bregx:
+		return op->number2;
+	default:
+		break;
+	}
+	return -1;
+}
+
+/**
+ * die_get_cfa - Get frame base information
+ * @dwarf: a Dwarf info
+ * @pc: program address
+ * @preg: pointer for saved register
+ * @poffset: pointer for saved offset
+ *
+ * This function gets register and offset for CFA (Canonical Frame Address)
+ * by searching the CIE/FDE info.  The CFA usually points to the start address
+ * of the current stack frame and local variables can be located using an offset
+ * from the CFA.  The @preg and @poffset will be updated if it returns 0.
+ */
+int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset)
+{
+	Dwarf_CFI *cfi;
+	Dwarf_Frame *frame = NULL;
+	Dwarf_Op *ops = NULL;
+	size_t nops;
+
+	cfi = dwarf_getcfi(dwarf);
+	if (cfi == NULL)
+		return -1;
+
+	if (!dwarf_cfi_addrframe(cfi, pc, &frame) &&
+	    !dwarf_frame_cfa(frame, &ops, &nops) && nops == 1) {
+		*preg = reg_from_dwarf_op(ops);
+		*poffset = offset_from_dwarf_op(ops);
+		return 0;
+	}
+	return -1;
+}
+#endif /* HAVE_DWARF_CFI_SUPPORT */
 
 /*
  * die_has_loclist - Check if DW_AT_location of @vr_die is a location list
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 4e64caac6df8..f209f9162908 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -177,4 +177,19 @@ static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unu
 
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
+#ifdef HAVE_DWARF_CFI_SUPPORT
+
+/* Get the frame base information from CFA */
+int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset);
+
+#else /* HAVE_DWARF_CFI_SUPPORT */
+
+static inline int die_get_cfa(Dwarf *dwarf __maybe_unused, u64 pc __maybe_unused,
+			      int *preg __maybe_unused, int *poffset __maybe_unused)
+{
+	return -1;
+}
+
+#endif /* HAVE_DWARF_CFI_SUPPORT */
+
 #endif /* _DWARF_AUX_H */
-- 
2.42.0.869.gea05f2083d-goog

