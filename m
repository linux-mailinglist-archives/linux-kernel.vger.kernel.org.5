Return-Path: <linux-kernel+bounces-96458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A73875C70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F80F283CA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA7F2C848;
	Fri,  8 Mar 2024 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YqTuX8z9"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48342C6BA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865957; cv=none; b=WYS9+tWlach3BydbyY4A7ceI8W6eLnFl/llhhxakH6UKH6X/gdbrN9z2dcOQm8xZXsWxc6zLDkaY+cncYh1NBKEuVimnIx+74mdJ0SseMkdpWrbXzkwBeaK4TLf9qgH3XBr2/x+P9bKeEWvtl3NLuTr7PNO0m0dib7yHaJ66ozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865957; c=relaxed/simple;
	bh=mz+bosMKw7JEpeaxuTDFds5WFr4SLDM7h7W8b2VLQOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mY2xkWy0zhNqGXNQ3WNh/dox+DpKk+5EEMy9bW3HBNYaNNzVG4R+H4mhlccrcTcE/YTfQFLtdCrWhgFk7oDKKrAvYfF0LSOQo2o1blBOseqAvr3BFFDQmNArXgVm6e9aBACz1Ay+3Yn5tdpt5YkLvGLaBfxB5aGypw/uejmSNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YqTuX8z9; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so258113a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 18:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709865955; x=1710470755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSpDjbqI0gNW8wl9pMQX51obps/WN2ZG0m8/65kcflw=;
        b=YqTuX8z9xHkFz2QCy8WnaD1vSz7nSPEJ3hX28YF8V4UtzDvNDwJhAe/Le6In7vUnn6
         BFMyAOT4HoZyj+Qy7WLSqvMV6wzyxBAdUCFsUCbsUSKlUdQMhzP4FQQ+9QOM/GvUCBkU
         IbLbFfhlnYo2TBo1h2+qX7KUTT9Yc5Vid9gLIBcT/KSXKJ4LKa4xkF1vg9bMlWPZmr5a
         F9YZmcSG7BYkUBz1i7jEQ6nNQ+jw78EVVdI7rD6eCE+6Z43MoAXXMDxew9G04QcBjhSr
         8fX38cX5GfFCSAlXRJAnYg38Cc/Bpg8DIEeX5mRUQMEgQhE3SxNdvfl8q5xNJLiM3Rvs
         MAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709865955; x=1710470755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSpDjbqI0gNW8wl9pMQX51obps/WN2ZG0m8/65kcflw=;
        b=IPsM9QYKm3eO0pk9syr9zrl54Cnyb19Vzu2TFtSpyTK5LCNba+5HTf78clq7hpSmw/
         +AeecWhTWYrROVTgnsBXHtL6NFdSt39ZFeErrGM/WtJFVseubg9n3vpeAXqd7t/J/13p
         W8sYlCnZ0V2nCavrOneyO+8s5sqLjizdfmxoiNfXvIXzDYDBIizLRghxw0wY6HbKmgQs
         ZF3WS9tet23JeQeZ2Qi2cugq4tZleGzL5nr3Yb6T9S4WD+xQk+yUQsU59HA4nMlmhIsv
         H5Ff12c/rc3S7gWvaLgIO0j4MJ5BDEH26Ok3Z9oKUNU/SWgpy4zB9JuUUx3sKrR4QDn9
         m+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU+wabS1z8vyMS4xpxoLoBHtpbTUS2iCtqs0Ox6gBHsYtiyXGXauLfzO6+vgeRUcsIqWFfQeoHFYSHdvHkFAKxtzfKwwQEYWjY9fJcy
X-Gm-Message-State: AOJu0YxYaGn924De9CXOn3Su+oLotmsDxKI7+ks9A/JEg1Uz8fV8D3Ux
	jNjIHtkZoX3C/haBgSk9xEysM/oOnaHIuDbB2ZsUJtcDxuIVRBtvlwFbp7J9zxQ=
X-Google-Smtp-Source: AGHT+IFB4r2cubJXEhC25w0CZruD70/PPODADSzF0jy4Q63MjOnCL0Ndt4sjV8zxbalugefbZA+8Sg==
X-Received: by 2002:a17:902:bc86:b0:1da:1c72:2ca7 with SMTP id bb6-20020a170902bc8600b001da1c722ca7mr9782633plb.29.1709865955391;
        Thu, 07 Mar 2024 18:45:55 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([2001:c10:ff04:0:1000:0:1:4])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902b10900b001d8a93fa5b1sm15244360plr.131.2024.03.07.18.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 18:45:55 -0800 (PST)
From: Rui Qi <qirui.001@bytedance.com>
To: bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	peterz@infradead.org,
	mbenes@suse.cz,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alexandre.chartre@oracle.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	yuanzhu@bytedance.com,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH v3 2/3] objtool: Add support for intra-function calls
Date: Fri,  8 Mar 2024 10:45:17 +0800
Message-Id: <20240308024518.19294-3-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240308024518.19294-1-qirui.001@bytedance.com>
References: <20240308024518.19294-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandre Chartre <alexandre.chartre@oracle.com>

commit 8aa8eb2a8f5b3305a95f39957dd2b715fa668e21 upstream.

Change objtool to support intra-function calls. On x86, an intra-function
call is represented in objtool as a push onto the stack (of the return
address), and a jump to the destination address. That way the stack
information is correctly updated and the call flow is still accurate.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200414103618.12657-4-alexandre.chartre@oracle.com
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 include/linux/frame.h                         | 11 ++++
 .../Documentation/stack-validation.txt        |  8 +++
 tools/objtool/arch/x86/decode.c               |  6 ++
 tools/objtool/check.c                         | 62 +++++++++++++++++--
 4 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/include/linux/frame.h b/include/linux/frame.h
index 02d3ca2d9598..303cda600e56 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -15,9 +15,20 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue a warning.
+ */
+#define ANNOTATE_INTRA_FUNCTION_CALL				\
+	999:							\
+	.pushsection .discard.intra_function_calls;		\
+	.long 999b;						\
+	.popsection;
+
 #else /* !CONFIG_STACK_VALIDATION */
 
 #define STACK_FRAME_NON_STANDARD(func)
+#define ANNOTATE_INTRA_FUNCTION_CALL
 
 #endif /* CONFIG_STACK_VALIDATION */
 
diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index de094670050b..ee26bb382b70 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -290,6 +290,14 @@ they mean, and suggestions for how to fix them.
       https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
 
 
+11. file.o: warning: unannotated intra-function call
+
+   This warning means that a direct call is done to a destination which
+   is not at the beginning of a function. If this is a legit call, you
+   can remove this warning by putting the ANNOTATE_INTRA_FUNCTION_CALL
+   directive right before the call.
+
+
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
 
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index a62e032863a8..c3ff62c085c8 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -437,6 +437,12 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 	case 0xe8:
 		*type = INSN_CALL;
+		/*
+		 * For the impact on the stack, a CALL behaves like
+		 * a PUSH of an immediate value (the return address).
+		 */
+			op->src.type = OP_SRC_CONST;
+			op->dest.type = OP_DEST_PUSH;
 		break;
 
 	case 0xfc:
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 71a24fd46dbd..0fa414869f45 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -645,6 +645,7 @@ static int add_jump_destinations(struct objtool_file *file)
 	return 0;
 }
 
+
 /*
  * Find the destination instructions for all calls.
  */
@@ -666,10 +667,7 @@ static int add_call_destinations(struct objtool_file *file)
 								dest_off);
 
 			if (!insn->call_dest && !insn->ignore) {
-				WARN_FUNC("unsupported intra-function call",
-					  insn->sec, insn->offset);
-				if (retpoline)
-					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
+				WARN_FUNC("unannotated intra-function call", insn->sec, insn->offset);
 				return -1;
 			}
 
@@ -1291,6 +1289,58 @@ static int read_retpoline_hints(struct objtool_file *file)
 	return 0;
 }
 
+
+static int read_intra_function_calls(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	struct rela *rela;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.intra_function_calls");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		unsigned long dest_off;
+
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s",
+			     sec->name);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("bad .discard.intra_function_call entry");
+			return -1;
+		}
+
+		if (insn->type != INSN_CALL) {
+			WARN_FUNC("intra_function_call not a direct call",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
+		/*
+		 * Treat intra-function CALLs as JMPs, but with a stack_op.
+		 * See add_call_destinations(), which strips stack_ops from
+		 * normal CALLs.
+		 */
+		insn->type = INSN_JUMP_UNCONDITIONAL;
+
+		dest_off = insn->offset + insn->len + insn->immediate;
+		insn->jump_dest = find_insn(file, insn->sec, dest_off);
+		if (!insn->jump_dest) {
+			WARN_FUNC("can't find call dest at %s+0x%lx",
+				  insn->sec, insn->offset,
+				  insn->sec->name, dest_off);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static void mark_rodata(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1346,6 +1396,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_intra_function_calls(file);
+	if (ret)
+		return ret;
+
 	ret = add_call_destinations(file);
 	if (ret)
 		return ret;
-- 
2.20.1


