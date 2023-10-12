Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5617C636D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377057AbjJLDwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376898AbjJLDvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:51:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D35BCC;
        Wed, 11 Oct 2023 20:51:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c60f1a2652so4037085ad.0;
        Wed, 11 Oct 2023 20:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082684; x=1697687484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJAPgps5vTes2Y2qx7RQDKoRh92FtNMtdWH/CZXcwx0=;
        b=bWvj/1R3SWPRqd2i3KlTv8jDqSzj9TljduYQGyEpLscC8Lk2nwEuyTPxggWCk2IhmW
         rqeCeztkeqAfvkNV9jI2TZM35d7OKUJEyYxcMG8Cwc6WZC3o3vxapoI6lFaU6RoZyQXj
         YxIMR33ul3z4xRa1PjEUhXnWDCDP6Q5XLFjlRwzeKszIDyPhdOodZdDQEMJVzXcjcTlt
         CXwZBHkkzX0dmEu56tm6QVXZ9LRJHXw0GJK2fGg2qmBS3+fMoYdOVqIdQFT5rlFXlvKD
         vjKfAgO9QbGJ1r5WRSkWHCu/J3BatqTVMgZ0AYxhQ31xr0+UaMyfXqzd/OusbwX8XuM9
         2K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082684; x=1697687484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iJAPgps5vTes2Y2qx7RQDKoRh92FtNMtdWH/CZXcwx0=;
        b=wcvcXDZ1WDEd9T6PE2EaI1CQjpNcTT11emSn4yu486T37YfIkoOigNPKQiR+4nla4D
         dBCMbcwhJOnmzjRoHIBLu+ZrmRNDAohwXLErRA4rSXMBsRN1DvB7ksgMiD9NGdivCdzQ
         65Oz3RdeJiI+V8o2m6S3VQTARP1J5uSh1uMf2C8VRtg5uS7lq4iuyHKv2WRNN+i6NA4/
         Nk7l4xD7KBU7bKVRB8xy1HGOlcr+WFoNXjoUFMLwVEGI0CzFEm/K76vPHUOauFQIIvJD
         6EpCMEXRlvGPS4hho8XM4XXYX5PrBvB6sIfaZu7puJnHQqXiUmNAlCjXVmAZs7mHkJ5O
         mmuA==
X-Gm-Message-State: AOJu0YwuaDuXvqh/qENHpDeiaiXhMG0xX5e7kEvIie8QouS2+5cvKaN0
        fl9EmK2Fp2SDy35WfQlRnb0=
X-Google-Smtp-Source: AGHT+IHA2NlxKsGKl2muwRYeArO/59rj3wAkwqkfeISU9JvT2XBOHWaXkyl4VroGUHqIQaihm5Lruw==
X-Received: by 2002:a17:903:2449:b0:1b6:a37a:65b7 with SMTP id l9-20020a170903244900b001b6a37a65b7mr31662151pls.23.1697082683762;
        Wed, 11 Oct 2023 20:51:23 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:23 -0700 (PDT)
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
Subject: [PATCH 07/48] perf dwarf-aux: Add die_find_variable_by_reg() helper
Date:   Wed, 11 Oct 2023 20:50:30 -0700
Message-ID: <20231012035111.676789-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The die_find_variable_by_reg() will search for a variable or a parameter
sub-DIE in the given scope DIE where the location matches to the given
register.

For the simpliest and most common case, memory access usually happens
with a base register and an offset to the field so the register would
hold a pointer in a variable or function parameter.  Then we can find
one if it has a location expression at the (instruction) address.  So
this function only handles such a simple case for now.

In this case, the expression would have a DW_OP_regN operation where
N < 32.  If the register index (N) is greater than or equal to 32,
DW_OP_regx operation with an operand which saves the value for the N
would be used.  It would reject expressions with more operations.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 67 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h | 12 +++++++
 2 files changed, 79 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 10aa32334d6f..652e6e7368a2 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1245,6 +1245,73 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
 out:
 	return ret;
 }
+
+/* Interval parameters for __die_find_var_reg_cb() */
+struct find_var_data {
+	/* Target instruction address */
+	Dwarf_Addr pc;
+	/* Target register */
+	unsigned reg;
+};
+
+/* Max number of registers DW_OP_regN supports */
+#define DWARF_OP_DIRECT_REGS  32
+
+/* Only checks direct child DIEs in the given scope. */
+static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
+{
+	struct find_var_data *data = arg;
+	int tag = dwarf_tag(die_mem);
+	ptrdiff_t off = 0;
+	Dwarf_Attribute attr;
+	Dwarf_Addr base, start, end;
+	Dwarf_Op *ops;
+	size_t nops;
+
+	if (tag != DW_TAG_variable && tag != DW_TAG_formal_parameter)
+		return DIE_FIND_CB_SIBLING;
+
+	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
+		/* Assuming the location list is sorted by address */
+		if (end < data->pc)
+			continue;
+		if (start > data->pc)
+			break;
+
+		/* Only match with a simple case */
+		if (data->reg < DWARF_OP_DIRECT_REGS) {
+			if (ops->atom == (DW_OP_reg0 + data->reg) && nops == 1)
+				return DIE_FIND_CB_END;
+		} else {
+			if (ops->atom == DW_OP_regx && ops->number == data->reg &&
+			    nops == 1)
+				return DIE_FIND_CB_END;
+		}
+	}
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_find_variable_by_reg - Find a variable saved in a register
+ * @sc_die: a scope DIE
+ * @pc: the program address to find
+ * @reg: the register number to find
+ * @die_mem: a buffer to save the resulting DIE
+ *
+ * Find the variable DIE accessed by the given register.
+ */
+Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
+				    Dwarf_Die *die_mem)
+{
+	struct find_var_data data = {
+		.pc = pc,
+		.reg = reg,
+	};
+	return die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
+}
 #endif
 
 /*
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index f9d765f80fb0..b6f430730bd1 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -137,6 +137,10 @@ int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes);
 /* Get byte offset range of given variable DIE */
 int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
+/* Find a variable saved in the 'reg' at given address */
+Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
+				    Dwarf_Die *die_mem);
+
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
@@ -146,6 +150,14 @@ static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
 	return -ENOTSUP;
 }
 
+static inline Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die __maybe_unused,
+						  Dwarf_Addr pc __maybe_unused,
+						  int reg __maybe_unused,
+						  Dwarf_Die *die_mem __maybe_unused)
+{
+	return NULL;
+}
+
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 #endif /* _DWARF_AUX_H */
-- 
2.42.0.655.g421f12c284-goog

