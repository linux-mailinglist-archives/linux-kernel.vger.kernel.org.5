Return-Path: <linux-kernel+bounces-81075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F0E866FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334561C2596F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D85FBB5;
	Mon, 26 Feb 2024 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LqzbOPD/"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7565FBA8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940486; cv=none; b=adRiPtyPa4AloKPyMsmDKhjqWpmc/Bnil3TYkeWUXJnwnf0EaQgxZQ8OoWjNwBiwe+Iaw4JgMhkGkEJppsiG1thFLmfdfBAEUrECoU18yytFfdeUkk+rg0lIl3HjPCHDRxSKe6yY+FtBZU9IngX2Gh0RFcC+NP8JuMUWkep1FoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940486; c=relaxed/simple;
	bh=abhzLrMcAo73itQJFRf9PngJ2NfPzbHIHmMJXMFZsec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEy71go7Rq5y74AX7i35fQU+GmztIdTos+BLq3cxHwmpVSUpIRAbs7Lj+0HIIsHSoar/pwYfbk+CecyPMBy6y8bB4tT1GB1MVETyoLljhAaOvO0V76AHg30nIO9UdDGOHLgOpzdxuhEdHSmujW57Lumcegj+q5IaR3HfaMBZPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LqzbOPD/; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so1816667a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708940483; x=1709545283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Xvb2DA8xzihP7Mzi/v0EMpx+00b5U5crlo4mSn4zeU=;
        b=LqzbOPD/geiXW9SKp5UrBReGwTCs2wsrR1ZRwlWWtbeW+GNwBUDoVl3TVmP1Vx//YO
         b0imZLZHTKDL67tWI069AiCNkvJY4GEl/ZOAhf+QOCkeLE4SMltVBcM/B+sGfNsZdgb5
         IwTfp7SJft33FTLm4LVVZ28UN+hXf8JgajPNuRJ6daHNyEcrjVN4KmMf74VMbGVhCUDg
         fgFrdPJuyOvU6jaRgzsx20ws6NsjxtEJlFz+W3Q2eFQnPVXv+sVSEol5EF2tcjXjoo1k
         Ld/Mxh14DBL+AwADNCX/8hsmlD+yhbH186T7xdducMQaXyKay2T8Na+2cMO4mERbxLq5
         ELfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940483; x=1709545283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Xvb2DA8xzihP7Mzi/v0EMpx+00b5U5crlo4mSn4zeU=;
        b=cOHBPiWSxmZy4YaN41XThmY5cyieyBj0ZBJLIY8vQht2Yx4IKzHShCYkQq0dukdiRe
         +8u9eZmn2kw2JRyTkuf+jk9s8nNx4542gO7IwT+urAK0JgNynekqPU8Q8Q/7ev0JV8bD
         j7P6SVxQHy2IDDPX5Y+jbWkV8VmdoKRWZPrPibvm+GcgJXihOhIZm26CbpEJCWBF2tan
         9m+F/JwvBcEhXPSxHJ67I8HZSw3ZPg1KDdt04r/RDVookElTnD8NPP+VAdhjf2UY7/Vx
         BZw4H9hsFaCwUmsLhLDOUtvIKe8co4ymQJV3ciDowUBYrbAa0aP8gzrBjxL/rxlDxo2F
         0U5w==
X-Forwarded-Encrypted: i=1; AJvYcCWSpmrsjyziehBcbN5E5LLUmZVYoBrSzPnRu051E6GAMusgNBLcbHgittJuuJJB4ikzsK6H3W3iIsSb/IVMskkR+C8zvo6PJ+YWef6X
X-Gm-Message-State: AOJu0Yz+gcp6cKMPEwI92GgxL0ZLkxcURNvM67x8Nt6KnLru7FBhL6AC
	EIix5InUHGhtSdcF94nIr96DxCZV+r4q1I1jKWEUt15MGyLo21/VdL0phHlCASk=
X-Google-Smtp-Source: AGHT+IGfQH3eDmtSm+TZHerFWqD+F5k2hss2J92b+IgjpliujZb0EjkcMoryDu0xIJer86ULvMVwMA==
X-Received: by 2002:a05:6a21:6816:b0:1a1:55e:20ed with SMTP id wr22-20020a056a21681600b001a1055e20edmr413289pzb.24.1708940483445;
        Mon, 26 Feb 2024 01:41:23 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id ls22-20020a056a00741600b006e533caee00sm949194pfb.155.2024.02.26.01.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:41:23 -0800 (PST)
From: "$(name)" <qirui.001@bytedance.com>
X-Google-Original-From: "$(name)" <$(mail address)>
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
	qirui.001@bytedance.com
Subject: [PATCH 2/3] objtool: Add support for intra-function calls
Date: Mon, 26 Feb 2024 17:41:00 +0800
Message-Id: <20240226094101.95544-3-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240226094101.95544-1-qirui.001@bytedance.com>
References: <20240226094101.95544-1-qirui.001@bytedance.com>
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
2.39.2 (Apple Git-143)


