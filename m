Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078C17C6386
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377383AbjJLDyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377514AbjJLDxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:53:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F97A10E3;
        Wed, 11 Oct 2023 20:51:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c88b467ef8so4754815ad.0;
        Wed, 11 Oct 2023 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082715; x=1697687515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpeT682jXo8zHQtou6ZhNNKzbowV2y0VimL5UVLWBn8=;
        b=Bt1cO1HK3G6coroGMGSCNYFwRd4qnfdCkfYk8pVezNvlkWhh0NHgFq/+qFLKFSa/q2
         otz+wwWidkFSHfUj4CUGzJJMXvh/mWy+NZKDI+gzld25vKdKhZ2TkOsjqZljYl4qOo/v
         l7jwqmFbLweTcEgZ5Yxw3g7+PwFBY+ukFg9xO4dKAT2reVP4X1HKKb1g7/BqLpGqFM49
         7NXcN1k2si/iuL2IrUwrb/1pmNEhUzTXFbu6XulCIA7j/NzByyvJbgmUi4IKUZL5PEnA
         z4zIiM1YzbZmlEE56cK7/4dAcjFeZ32IhbdBj+uvLanCTjAX8e7a16u5kkouhQv/+C9c
         5Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082715; x=1697687515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IpeT682jXo8zHQtou6ZhNNKzbowV2y0VimL5UVLWBn8=;
        b=Q6O3eVVPCyN3IehfXfvgMz+RORUSJWBnZ0oJbLwn04L1Tj1jahV5sjhrZZmSehUqv7
         lRnko1M3aXjI1yDqBn+sJ9+Yw9lAA56cD7ocXwGPiEm1Q97nBJdrWYPD/Dl/2kY3A8vA
         o+EBAk3izt/HDGGEGQg9phPt8SZKHMqcfkSoAmXF30R4kizGY/p6e5v8IjiyEe7SBRP4
         vwmukVyO5GQU/E9mU9GDuvs4wvY4xLyp5PADQTvD2tgjOu9g7B6qjcVe3qx0BnEJvX0J
         ndpfzDc1VNEQNer7z2bkBmkKyJPD8GfWfRAszcQO/YoFJqQ6F+10uKXx+GugJ3JNvMmy
         Ys5Q==
X-Gm-Message-State: AOJu0YzEYa1s3i6IfzTWhfPwjgiv6A4gw75Dh0h2JBd5SqxgkyFK7kLa
        OdNP++AaczFVylFhM/ptinhmf3dhGoo=
X-Google-Smtp-Source: AGHT+IGObjCpXIRGXvxG2XeisCJpHRn7826etev5dtkSoj7pISBW7/J+f91nhwI9aX8oEoEP+26kOg==
X-Received: by 2002:a17:902:c947:b0:1c7:4a8a:32d1 with SMTP id i7-20020a170902c94700b001c74a8a32d1mr24944285pla.28.1697082715545;
        Wed, 11 Oct 2023 20:51:55 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:55 -0700 (PDT)
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
Subject: [PATCH 31/48] perf dwarf-aux: Add die_get_cfa()
Date:   Wed, 11 Oct 2023 20:50:54 -0700
Message-ID: <20231012035111.676789-32-namhyung@kernel.org>
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

The die_get_cfa() is to get frame base register and offset at the given
instruction address (pc).  This info will be used to locate stack
variables which have location expression using DW_OP_fbreg.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 64 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  9 ++++++
 2 files changed, 73 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 97d9ae56350e..796413eb4e8f 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1408,6 +1408,70 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
 	return result;
 }
 
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
+
 #endif
 
 /*
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 742098e3ee7e..29a7243b1a45 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -149,6 +149,9 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
 				     Dwarf_Addr addr, Dwarf_Die *die_mem,
 				     int *offset);
 
+/* Get the frame base information from CFA */
+int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset);
+
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
@@ -175,6 +178,12 @@ static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unu
 	return NULL;
 }
 
+static inline int die_get_cfa(Dwarf *dwarf __maybe_unused, u64 pc __maybe_unused,
+			      int *preg __maybe_unused, int *poffset __maybe_unused)
+{
+	return -1;
+}
+
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 #endif /* _DWARF_AUX_H */
-- 
2.42.0.655.g421f12c284-goog

