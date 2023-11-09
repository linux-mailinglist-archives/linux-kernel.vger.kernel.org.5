Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58B97E758D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbjKJADh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345642AbjKJAC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:02:59 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B0447AE;
        Thu,  9 Nov 2023 16:01:16 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5be24d41bb8so162466a12.0;
        Thu, 09 Nov 2023 16:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574475; x=1700179275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0dxuEbR5jZqtd2BZmTVNrG3auPejdj7FpqX+DTGvcY=;
        b=BUVnHbZGmi+uO/b+nNeOxmtkpuUrU6OZkMF+l5hOuiKBBqyk2JIwT8q3YI47TrkwEi
         Y7mNNVRwhHS7tnBmCrfjgxbMoOnVSG64lLSGqRQRF6aVr4tIoQ8fzLlxyGZBUo6pXknK
         4Azgr9W8HTpdfKbfSR5BmnDsKD5kcPXGb71hHNdSZIESWFvfD/y4cPytV1lw0BB8SFrp
         +22Yt1RRLtzSvuuiEaiodHDWLCRp+i1ypAHaprxu7SexYVoJceCFBl8/yAKbiFIWYfNL
         sRSvqw+oA609GcoYGL0cP9P4vCCsQrwsWone+lBi0ZWpaWm98h+wK7kpX+07iaIsWdxK
         V8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574475; x=1700179275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m0dxuEbR5jZqtd2BZmTVNrG3auPejdj7FpqX+DTGvcY=;
        b=BwueXOl6evZg3RqiUV4ZH7YGV9k7S2vK/DA7uuOmUdXG1AZ27eJ/CkCIF3Qvp5IAiU
         LqW2CNIibVlygWtmtqIeGoCgkpbc+kd7LE7VU4N/rAPPqJQdQBHW7LYDbjPzpWQP830T
         MQMwGauCbq0jtjfO9wI7OmcKbXeef4W/RS4EqaZ14MyKRuHZEj7PUZqnp59m9tUjr1Fe
         RluX8Ql12Aa28a3H4eZ4lghSsSAtRFe2ZxBlOrQ+mksk5uYf4f+0O4BU4vYUKRPo0AGM
         Q+mwcXDJHarhGflmAYVVXKfVUim7+exrJHsQaSIbmlfUIaxGIPMSz7vgJxjm7fM6jI+I
         zV+w==
X-Gm-Message-State: AOJu0YyDPDOb+8o5nIjjcdppIXLUnhvEZho+sd9eQzYMDy34cRFtx9aD
        SH5n+mW3Nqx0OON+AiDqGZbGCj4262w=
X-Google-Smtp-Source: AGHT+IGrAF9hEktqUyOvfsnTKTIzu6+ZaZ6dDMZZZh3UJUErCS54lmHI3Q9hYCg+zcZBmapjxKK9RA==
X-Received: by 2002:a17:90b:1e09:b0:280:4af4:1a41 with SMTP id pg9-20020a17090b1e0900b002804af41a41mr1208908pjb.15.1699574475552;
        Thu, 09 Nov 2023 16:01:15 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:15 -0800 (PST)
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
Subject: [PATCH 39/52] perf dwarf-aux: Handle type transfer for memory access
Date:   Thu,  9 Nov 2023 15:59:58 -0800
Message-ID: <20231110000012.3538610-40-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 110 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |   6 ++
 2 files changed, 116 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index f878014c9e27..39851ff1d5c4 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1841,3 +1841,113 @@ int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes)
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
index efafd3a1f5b6..ad4d7322fcbf 100644
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
2.42.0.869.gea05f2083d-goog

