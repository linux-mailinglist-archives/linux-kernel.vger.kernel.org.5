Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8437C638B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377543AbjJLDzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376855AbjJLDx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:53:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC69B1701;
        Wed, 11 Oct 2023 20:52:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-577fff1cae6so371555a12.1;
        Wed, 11 Oct 2023 20:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082721; x=1697687521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fScxRg9rCJRGXzRKFXZYIJ1+B/7O2DI4+C7sBTfd7FY=;
        b=lJiWKU8AtS4NCexm+dP94oZiBZ/Q4xH5lY3ICVkrpqZ+JXlq4RLbbkuqAo8u7OipsI
         hwY4j48BIH/NxjWLnizb8KPPQSp7pCXJK5u7v9L6o07spCCy3OHUX2EHpGOEc0snl91G
         l2WL3LYhsZIGQ4mb7rX7f4fxYqTlAagRtnwjIwpvsB2XVyU3FJbNfbiAB1QOcIl0wBaw
         ZeUXTlNow7LSxHhhUM0XgAQX26B1Y8/5fDrlhqawLqiWhWT4CtMP2PJXQSgYeQAeuyHO
         AMmGh4kV7lWZoC/z24z5wJ9k4+gKGD6Kky8VCgoHvYDFwVPvNNiFTh1/xk+iFcRLLPlT
         em6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082721; x=1697687521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fScxRg9rCJRGXzRKFXZYIJ1+B/7O2DI4+C7sBTfd7FY=;
        b=Iosg88YQSs5GB5bJ+j7P/vVY44ajLhlPVuc2CFr4sKeI9iRlQ5YdFgNsiNQzbQkUUn
         eVZOnxFvUQSWBmyjnyXw2lqm7MCcoboD/nSUoWOJS+QWOqtgzAFDSZax3BKQc4MKqPB+
         TnANHai0A9axMmbf8enwPUqL8r+kYt8nVtkoWP+Lqnkl+Hm9EVyEi4i/r2HPU8Aq06ql
         2G+ryIV+HlrnFegXTSQjCg18UnVjoUtmnHFBuLnbDAliHT0aLgJfZDazgSCGOmMUQGn9
         VWxVSNRkxFSVU2kM57OT7Dg9EwevCLAIakkDTfXGvzP7Dp00UVu173WPDSpEX0ztFKbH
         QgSQ==
X-Gm-Message-State: AOJu0Yxs/HeMcAqEkqAeqwPaVH9YEfl9Dns/OfcFwx6e3Uf7OmM7wXdz
        Aoc6AY2BRGEBsV9JQRVQ4Eo=
X-Google-Smtp-Source: AGHT+IHlhdGSnXOOgE8Fj1pHBsqk3Wj5iiDiVTxZw1yj2XVcJ2yWDY1lVsJdvA1R+hqunadrwDVrcQ==
X-Received: by 2002:a17:903:2352:b0:1b8:8682:62fb with SMTP id c18-20020a170903235200b001b8868262fbmr30826465plh.4.1697082720631;
        Wed, 11 Oct 2023 20:52:00 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:00 -0700 (PDT)
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
Subject: [PATCH 35/48] perf dwarf-aux: Handle type transfer for memory access
Date:   Wed, 11 Oct 2023 20:50:58 -0700
Message-ID: <20231012035111.676789-36-namhyung@kernel.org>
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

We want to track type states as instructions are executed.  Each
instruction can access compound types like struct or union and load/
store its members to a different location.

The die_deref_ptr_type() is to find a type of memory access with a
pointer variable.  If it points to a compound type like struct, the
target memory is a member in the struct.  The access will happen
with an offset indicating which member it refers.  Let's follow the
DWARF info to figure out the type of the pointer target.

For example, say we have the following code.

  struct foo {
    int a;
    int b;
  };

  struct foo *p = malloc(sizeof(*p));
  p->b = 0;

The last pointer access should produce x86 asm like below:

  mov  0x0, 4(%rbx)

And we know %rbx register has a pointer to struct foo.  Then offset 4
should return the debug info of member 'b'.

Also variables of compound types can be accessed directly without a
pointer.  The die_get_member_type() is to handle a such case.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 110 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |   6 ++
 2 files changed, 116 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 16e63d8caf83..5ec895e0a069 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1838,3 +1838,113 @@ int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes)
 	*scopes = data.scopes;
 	return data.nr;
 }
+
+static int __die_find_member_offset_cb(Dwarf_Die *die_mem, void *arg)
+{
+	Dwarf_Die type_die;
+	Dwarf_Word size, loc;
+	Dwarf_Word offset = (long)arg;
+	int tag = dwarf_tag(die_mem);
+
+	if (tag != DW_TAG_member)
+		return DIE_FIND_CB_SIBLING;
+
+	/* Unions might not have location */
+	if (die_get_data_member_location(die_mem, &loc) < 0)
+		loc = 0;
+
+	if (offset == loc)
+		return DIE_FIND_CB_END;
+
+	die_get_real_type(die_mem, &type_die);
+
+	if (dwarf_aggregate_size(&type_die, &size) < 0)
+		size = 0;
+
+	if (loc < offset && offset < (loc + size))
+		return DIE_FIND_CB_END;
+
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_get_member_type - Return type info of struct member
+ * @type_die: a type DIE
+ * @offset: offset in the type
+ * @die_mem: a buffer to save the resulting DIE
+ *
+ * This function returns a type of a member in @type_die where it's located at
+ * @offset if it's a struct.  For now, it just returns the first matching
+ * member in a union.  For other types, it'd return the given type directly
+ * if it's within the size of the type or NULL otherwise.
+ */
+Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
+			       Dwarf_Die *die_mem)
+{
+	Dwarf_Die *member;
+	Dwarf_Die mb_type;
+	int tag;
+
+	tag = dwarf_tag(type_die);
+	/* If it's not a compound type, return the type directly */
+	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
+		Dwarf_Word size;
+
+		if (dwarf_aggregate_size(type_die, &size) < 0)
+			size = 0;
+
+		if ((unsigned)offset >= size)
+			return NULL;
+
+		*die_mem = *type_die;
+		return die_mem;
+	}
+
+	mb_type = *type_die;
+	/* TODO: Handle union types better? */
+	while (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
+		member = die_find_child(&mb_type, __die_find_member_offset_cb,
+					(void *)(long)offset, die_mem);
+		if (member == NULL)
+			return NULL;
+
+		if (die_get_real_type(member, &mb_type) == NULL)
+			return NULL;
+
+		tag = dwarf_tag(&mb_type);
+
+		if (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
+			Dwarf_Word loc;
+
+			/* Update offset for the start of the member struct */
+			if (die_get_data_member_location(member, &loc) == 0)
+				offset -= loc;
+		}
+	}
+	*die_mem = mb_type;
+	return die_mem;
+}
+
+/**
+ * die_deref_ptr_type - Return type info for pointer access
+ * @ptr_die: a pointer type DIE
+ * @offset: access offset for the pointer
+ * @die_mem: a buffer to save the resulting DIE
+ *
+ * This function follows the pointer in @ptr_die with given @offset
+ * and saves the resulting type in @die_mem.  If the pointer points
+ * a struct type, actual member at the offset would be returned.
+ */
+Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
+			      Dwarf_Die *die_mem)
+{
+	Dwarf_Die type_die;
+
+	if (dwarf_tag(ptr_die) != DW_TAG_pointer_type)
+		return NULL;
+
+	if (die_get_real_type(ptr_die, &type_die) == NULL)
+		return NULL;
+
+	return die_get_member_type(&type_die, offset, die_mem);
+}
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index d0ef41738abd..df846bd30134 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -144,6 +144,12 @@ struct die_var_type {
 	int offset;
 };
 
+/* Return type info of a member at offset */
+Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset, Dwarf_Die *die_mem);
+
+/* Return type info where the pointer and offset point to */
+Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset, Dwarf_Die *die_mem);
+
 #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 
 /* Get byte offset range of given variable DIE */
-- 
2.42.0.655.g421f12c284-goog

