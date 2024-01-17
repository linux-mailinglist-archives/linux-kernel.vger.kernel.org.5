Return-Path: <linux-kernel+bounces-28565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8CB83001F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304321C233D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B9A14270;
	Wed, 17 Jan 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AblR1sSJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460513AED;
	Wed, 17 Jan 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472824; cv=none; b=Dvn9JTbs83Vpq1BIVS8vODhyFEchBRe69B6hZSae5LXRTSi7I7sJYeHybbOY/WYRk4F/HvdNjBzOCMVvgdIRVaJK8WDkmj9zE4b0bPucFhBy60RgxA9ML4vlaFM0w18jujMlvIBEfFiimksdjvHrJ71Y+0rqdv7V+9GsNeCuXcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472824; c=relaxed/simple;
	bh=oqE6RRilrlBxi3Az7/gK9Ol1VjDj+ZnIJvf3vPqF1vE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=OB4Z5UOUuaREToXvQjCQE+6p2I2uamDmjDSDuoFrfEPvEn1AEJiczYUPaXY423AHpwGynj1vmaQW1zHZkJe6TkcXQLaJ4evmmgKn8fxa8Kyq1wCjVjOfBVxTGSMvx17Zepdh/5iDtRcOYw+5F+bzPDjwGIjjShW+BqD0tBAUPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AblR1sSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462E1C4160D;
	Wed, 17 Jan 2024 06:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705472823;
	bh=oqE6RRilrlBxi3Az7/gK9Ol1VjDj+ZnIJvf3vPqF1vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AblR1sSJ4uoPdV5cRhg/AIQSfi3EJHaqJBcvdALQCSrUI/fGrLwZZ9jokIrgA7IV8
	 dIDth1stc6VF2HVBcLFSSOY5jlHEDQnxwrBwg9skNdh0uytiD/RI3uCh64yvd7Abfu
	 7S1YtMCTzs8hzZq9pkbqLP7gUIURKHh64wQTHWQpTLTGqypvEvxyniYiVdNrIPDGxp
	 pHIHQBK4e7lxnGqxFhdiFx/3sdkZIU/2m4dRY20ydB9V/1vPyoENghHy/QEwQ3nqHp
	 839vN3klMn667Un9b+QZIlDfXNE4/6UKLvWxvQext0vfg/vw3GWdt1WxCvN5KkH2+F
	 FzOAlSOyD2MVw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org,
	linux-trace-devel@vger.kernel.org
Subject: [PATCH 7/9] perf dwarf-aux: Add die_get_cfa()
Date: Tue, 16 Jan 2024 22:26:55 -0800
Message-ID: <20240117062657.985479-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
In-Reply-To: <20240117062657.985479-1-namhyung@kernel.org>
References: <20240117062657.985479-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.43.0.381.gb435a96ce8-goog


