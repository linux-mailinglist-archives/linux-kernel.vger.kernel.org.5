Return-Path: <linux-kernel+bounces-50635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7366D847BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BD328AEB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0498595B;
	Fri,  2 Feb 2024 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/QlBZOV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4CC85935;
	Fri,  2 Feb 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911503; cv=none; b=p38cHaLGICu61442RyIBsVwb425sigdTe4Rqw6/eJcZFYp+YS/XS68Gmzh9DRwKFxChtC3aK9aWq4VeQLVrmPyWoLtE+mrrt3YIgkBh4U9gPep3gI69DPbhFCqiPPKOY+aw+lOE2p4dGPkbmQwtgwBgNIqpE68PrZw+qbvxk9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911503; c=relaxed/simple;
	bh=jmdfikaTg6ynLFAg/Mk8pHeUzgNbVHrf3IL/djBhCOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aULANspnAOHviM3ZwXldvbCxw6RMnyBrBcjfNOlhqDsfIPs+wJoRvUnXmuxDXtlx7kIGP+uH4qzFyvFedYparS3H1HtannLf7wyBESzw2VizL4KmSrDQEshjrpbOPqr7413mHTplF/h4Qg2zXuJ3t866Z9icw7t9PDBkVTmcSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/QlBZOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72704C43390;
	Fri,  2 Feb 2024 22:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706911502;
	bh=jmdfikaTg6ynLFAg/Mk8pHeUzgNbVHrf3IL/djBhCOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/QlBZOVURwJt2W/TTEwL1Dvui8C5poLRMPdhqanzuhMTyxGyNpoIidnOWhm774cC
	 D8EhZH5bODyzLHfCDSHvgzbdqQQnk2Oz0qE5uEhp3jhx8/21TyVAH9foX5SuWTOXY4
	 XwlY/acsoBI7vPjTSOEZk8SW1sUm2p8a31KAY8QX8dsOBPLLgQ8T+s8wZv+mIlMFlP
	 DldTqmONWIWvdSzH6j5TCbx+1d3lvY78BQcWcMlMA4liRCJ36Lxn1tMb0dqgY4+yyV
	 LXyHM+gYg2uf2or0IJJ6MZmsJpqSZ0l1uCH0q+tWyxXfNrmGULnlBjyf1KW9mkqh1R
	 pqiUhm12vR1dg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
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
Subject: [PATCH 02/14] perf dwarf-aux: Handle type transfer for memory access
Date: Fri,  2 Feb 2024 14:04:47 -0800
Message-ID: <20240202220459.527138-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202220459.527138-1-namhyung@kernel.org>
References: <20240202220459.527138-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.43.0.594.gd9cf4e227d-goog


