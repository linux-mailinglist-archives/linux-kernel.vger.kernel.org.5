Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42C37E7590
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbjKJADm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345706AbjKJACy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:02:54 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3587C558E;
        Thu,  9 Nov 2023 16:01:13 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-28035cf6a30so1362058a91.3;
        Thu, 09 Nov 2023 16:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574472; x=1700179272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+ZW371zrAQmL/YEw25gnL0bJ3efAAYgDERy3nsHpt4=;
        b=HmjcQBy/5Bei5ZI/kPXDfHvQo9tZOOwY7XubHzqe3rvg8UqcU8kFuZhwIkAjVYhRp9
         X3MuylRlp9wzGU2/c4MnguOXhArhP39XQU20TJh5r4lyBlsqVtRhm01BL0cAJbM6+R8t
         Azct0dK38yrYmRUl0lJNZrVcdk2P24OimoT5/78eoMMnKNsneSB3KWRQDuA0gghXF1tF
         OaKOVuEnkSWQlGf8eAUecGdIzNypbvjvInCZ0VZFVvDmNmdpoeqpuTOp97RTB4zbD/hn
         7dNIHOxJm0Mnbj6A3kWF3ahcsiMffmZuZrFecCwu+a+18bxX1D6k9yQRrHIVlw20rfP0
         1DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574472; x=1700179272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+ZW371zrAQmL/YEw25gnL0bJ3efAAYgDERy3nsHpt4=;
        b=rBdT7bgNn1E+M9VmwMuhhdMT6g0nD6DBSlE50Qbpt3Mnit/Zk+f+9dZIOm92RR0opf
         j7ymnHr6e04rUyLiKM4UpvMP5KbCjKcpqpAZYoB+XiG75pYZ+x5s3alvpt9esirjMqj+
         R1D/Cz+rjU6AaRv3xbiIoGFS5I1Hgsp3InJUZ218C0rP6P8/hcTapHFWy79c8Alm8tnt
         6P8OEa2QUtFyZiNXOgh+UXxdqRg/dffPoOmMQAp2Chl6ePyvVKKT20EK6U9B7Gv9yzCa
         iV/V70IyZbmOwcesENONnV3JPFw9QZfyru9OxAk6hm3hnrqxH6IFepv7oEznh2cIQT7C
         Mskw==
X-Gm-Message-State: AOJu0YyvQJ+HTzx62JwyDHQJzhCg6pgWGDKZLAh7Olnt5WvY8HtjlsOz
        OoKMQe3xwksCmzKt9vQJvGA=
X-Google-Smtp-Source: AGHT+IHnzIzsFJ4cRt1Hhz1BOfUl9ub+emNl3QoYKdLz0QKEvX7n/t0ubzYKS2dCVqI0V+EHgXiubA==
X-Received: by 2002:a17:90a:e54f:b0:27c:efe3:89dc with SMTP id ei15-20020a17090ae54f00b0027cefe389dcmr3014391pjb.14.1699574472581;
        Thu, 09 Nov 2023 16:01:12 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:12 -0800 (PST)
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
Subject: [PATCH 37/52] perf dwarf-aux: Check allowed DWARF Ops
Date:   Thu,  9 Nov 2023 15:59:56 -0800
Message-ID: <20231110000012.3538610-38-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 7caf52fdc255..2791126069b4 100644
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
@@ -1503,7 +1538,8 @@ int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset)
 		return -1;
 
 	if (!dwarf_cfi_addrframe(cfi, pc, &frame) &&
-	    !dwarf_frame_cfa(frame, &ops, &nops) && nops == 1) {
+	    !dwarf_frame_cfa(frame, &ops, &nops) &&
+	    check_allowed_ops(ops, nops)) {
 		*preg = reg_from_dwarf_op(ops);
 		*poffset = offset_from_dwarf_op(ops);
 		return 0;
-- 
2.42.0.869.gea05f2083d-goog

