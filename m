Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2B07C6387
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377441AbjJLDy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343511AbjJLDxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:53:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0881B10FE;
        Wed, 11 Oct 2023 20:51:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9daca2b85so3889955ad.1;
        Wed, 11 Oct 2023 20:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082718; x=1697687518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0uukPGLNEM1tQxhVgCDG+pFph2Ypn/ZDoH5IEqzJ3I=;
        b=jeNudOb1UFmXpW89hxAkI3WSiEB6zlvZNbAm5Que5kBkvID8hDLLLKCOiQLA/hBXfS
         NCbWDJrizyD2dHCeQ9TaQlO78OWvFi7tvOvpd9kBdLPJ24N0d3wtq0nCl3NwvXG5oS+7
         hSmqaTQ6r8mZw67GNIlKGMbSVcB+iJUIGXiAVayU9q6eDu22XDNxExiJNVwrlUpfD/Id
         P4XYlZS3fSwTbXx7CPBz7Q0rO13TRIHfVDBngzD4pm4/xJ7YF01yEkjIioiJdI/B1pzc
         IVh5kQPiJgN2ViKeI6zPO7oxdYABRC6xL2cuDxi+WwO/0bGalc3G8pnoQa5PmrHs/YZY
         ROeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082718; x=1697687518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0uukPGLNEM1tQxhVgCDG+pFph2Ypn/ZDoH5IEqzJ3I=;
        b=wA71cMn91nK+ya4aySVgXJIYw3kwqWv/EGQ5rko8RspoDU9qHsG+zBPHCHG50tVkuI
         r9ggxOFXyCsLE3/FUsHPPqjFqBSWE0mes6x0Ev76gVEVCCm0l2PvkVqOL0Bp2wNc7iDR
         rlM4kutFSB6PjI3nqZN3rGfQwSXN3zykiGEYJKKkw4OIPGrv7vVZAGuiuoIfcg5B9c4Q
         NOedrqi042YAqGQFicjFMhRRAGigD75xS1pu1cLzaSsYHHcO5weu0+giDz9uiPndbnDc
         nTEEUMGCIPQdBzRp/gunfgplHl6e1VBDVYjFFOXpiZTjoucd+KNG9kiuvy601CR2zIOl
         uPfA==
X-Gm-Message-State: AOJu0YylSRkGZ+VNS1rrKKcgQDvlot2EOUqJWwLWyPwxG9vzP9ER2OMT
        8TDnJy36r2FOlL2bDveRAoM=
X-Google-Smtp-Source: AGHT+IEclYaWjsPPKcKoo/WLvGVTPPpcj9luv3OfJd0T5zaVimdTR2Sng9+6xF99eXfZeJP14Uworg==
X-Received: by 2002:a17:902:e852:b0:1c5:59dc:6e93 with SMTP id t18-20020a170902e85200b001c559dc6e93mr34503545plg.3.1697082718091;
        Wed, 11 Oct 2023 20:51:58 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:57 -0700 (PDT)
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
Subject: [PATCH 33/48] perf dwarf-aux: Check allowed DWARF Ops
Date:   Wed, 11 Oct 2023 20:50:56 -0700
Message-ID: <20231012035111.676789-34-namhyung@kernel.org>
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

The DWARF location expression can be fairly complex and it'd be hard
to match it with the condition correctly.  So let's be conservative
and only allow simple expressions.  For now it just checks the first
operation in the list.  The following operations looks ok:

 * DW_OP_stack_value
 * DW_OP_deref_size
 * DW_OP_deref
 * DW_OP_piece

To refuse complex (and unsupported) location expressions, add
check_allowed_ops() to compare the rest of the list.  It seems earlier
result contained those unsupported expressions.  For example, I found
some local struct variable is placed like below.

 <2><43d1517>: Abbrev Number: 62 (DW_TAG_variable)
    <43d1518>   DW_AT_location    : 15 byte block: 91 50 93 8 91 78 93 4 93 84 8 91 68 93 4
        (DW_OP_fbreg: -48; DW_OP_piece: 8;
         DW_OP_fbreg: -8; DW_OP_piece: 4;
         DW_OP_piece: 1028;
         DW_OP_fbreg: -24; DW_OP_piece: 4)

Another example is something like this.

    0057c8be ffffffffffffffff ffffffff812109f0 (base address)
    0057c8ce ffffffff812112b5 ffffffff812112c8 (DW_OP_breg3 (rbx): 0;
                                                DW_OP_constu: 18446744073709551612;
                                                DW_OP_and;
                                                DW_OP_stack_value)

It should refuse them.  After the change, the stat shows:

  Annotate data type stats:
  total 294, ok 158 (53.7%), bad 136 (46.3%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          53 : no_var
          14 : no_typeinfo
           7 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 7f3822d08ab7..093d7e82b333 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1305,6 +1305,34 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	return true;
 }
 
+static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
+{
+	/* The first op is checked separately */
+	ops++;
+	nops--;
+
+	/*
+	 * It needs to make sure if the location expression matches to the given
+	 * register and offset exactly.  Thus it rejects any complex expressions
+	 * and only allows a few of selected operators that doesn't change the
+	 * location.
+	 */
+	while (nops) {
+		switch (ops->atom) {
+		case DW_OP_stack_value:
+		case DW_OP_deref_size:
+		case DW_OP_deref:
+		case DW_OP_piece:
+			break;
+		default:
+			return false;
+		}
+		ops++;
+		nops--;
+	}
+	return true;
+}
+
 /* Only checks direct child DIEs in the given scope. */
 static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 {
@@ -1332,25 +1360,31 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 		/* Local variables accessed using frame base register */
 		if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
 		    data->offset >= (int)ops->number &&
+		    check_allowed_ops(ops, nops) &&
 		    match_var_offset(die_mem, data, data->offset, ops->number))
 			return DIE_FIND_CB_END;
 
 		/* Only match with a simple case */
 		if (data->reg < DWARF_OP_DIRECT_REGS) {
-			if (ops->atom == (DW_OP_reg0 + data->reg) && nops == 1)
+			/* pointer variables saved in a register 0 to 31 */
+			if (ops->atom == (DW_OP_reg0 + data->reg) &&
+			    check_allowed_ops(ops, nops))
 				return DIE_FIND_CB_END;
 
 			/* Local variables accessed by a register + offset */
 			if (ops->atom == (DW_OP_breg0 + data->reg) &&
+			    check_allowed_ops(ops, nops) &&
 			    match_var_offset(die_mem, data, data->offset, ops->number))
 				return DIE_FIND_CB_END;
 		} else {
+			/* pointer variables saved in a register 32 or above */
 			if (ops->atom == DW_OP_regx && ops->number == data->reg &&
-			    nops == 1)
+			    check_allowed_ops(ops, nops))
 				return DIE_FIND_CB_END;
 
 			/* Local variables accessed by a register + offset */
 			if (ops->atom == DW_OP_bregx && data->reg == ops->number &&
+			    check_allowed_ops(ops, nops) &&
 			    match_var_offset(die_mem, data, data->offset, ops->number2))
 				return DIE_FIND_CB_END;
 		}
@@ -1412,7 +1446,8 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 		if (data->addr < ops->number)
 			continue;
 
-		if (match_var_offset(die_mem, data, data->addr, ops->number))
+		if (check_allowed_ops(ops, nops) &&
+		    match_var_offset(die_mem, data, data->addr, ops->number))
 			return DIE_FIND_CB_END;
 	}
 	return DIE_FIND_CB_SIBLING;
@@ -1501,7 +1536,8 @@ int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset)
 		return -1;
 
 	if (!dwarf_cfi_addrframe(cfi, pc, &frame) &&
-	    !dwarf_frame_cfa(frame, &ops, &nops) && nops == 1) {
+	    !dwarf_frame_cfa(frame, &ops, &nops) &&
+	    check_allowed_ops(ops, nops)) {
 		*preg = reg_from_dwarf_op(ops);
 		*poffset = offset_from_dwarf_op(ops);
 		return 0;
-- 
2.42.0.655.g421f12c284-goog

