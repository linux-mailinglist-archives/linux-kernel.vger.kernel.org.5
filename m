Return-Path: <linux-kernel+bounces-107029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 855DF87F6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A898B1C217F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE67C6D5;
	Tue, 19 Mar 2024 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB9mEA4J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE7A7BAE2;
	Tue, 19 Mar 2024 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827479; cv=none; b=GcSTefz54OlAPUKzXoODufw2gOhX7nPtUds18C7Z/vy20ItQadyeVM6/U5HL/x/qXTP/F1KkGrmzNJjqmZOKJWzJLboPkj2lS0Hn1coC18WPBZP8WsKPpJFG8YNxTY+Sdin3doo1bIBQkw2iNbrDhCnjjjxReZS/ekVartBR8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827479; c=relaxed/simple;
	bh=D4wjM5/Vro/0+8JywfcuXi11ySFZtDEA5F2ZmXZ1Ue4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfQl0hJa1UwV33F1duawBHCyjf58+OiJ+pHOpBTyyVNkqhVlDmNwR3rXH93JIN79ACe9KnkROSCKfLjDl/NyO19xK7JSN46NXyQbCHA6OoDnjZ9qNeyHmEkbFq43sDNi6vNbNfq4DEGkez/ugqUIiqSldlfEzfEahgpLfl0a8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB9mEA4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF03BC4167E;
	Tue, 19 Mar 2024 05:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827479;
	bh=D4wjM5/Vro/0+8JywfcuXi11ySFZtDEA5F2ZmXZ1Ue4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nB9mEA4J/Ax61BWXfbJa+7gpFM8i4CTZOk19XhkshI1lg0tQqkHHUOtwP2fZMtIgw
	 QpuE3ogp+myRXaraE9BtjtteqICRp713lkIcannBve0nLkeql47BXMBxU0R/N7cMv6
	 sVCu4QjIkakpBU16fAhrbHEAD0rTn0U5oZI1NXxVeX/Sxmx/TryJwCEVhHqaklzlMM
	 2lJlIZIxJFty3JooojlomZaaiJZt/yJMbvPeWWt4KC/3sS5zzyURN28TYPKx7v4tLp
	 0AYUhYpiiQDnY3iq5mG9xfI1VimzfDmK8cNY70BQksSxqFbQCJa2tZaEvCZ85qaYOw
	 LyGTQDe+LHeQQ==
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
Subject: [PATCH 03/23] perf dwarf-aux: Handle type transfer for memory access
Date: Mon, 18 Mar 2024 22:50:55 -0700
Message-ID: <20240319055115.4063940-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>
References: <20240319055115.4063940-1-namhyung@kernel.org>
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
index 785aa7a3d725..cd9364d296b6 100644
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
index cd171b06fd4c..16c916311bc0 100644
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
2.44.0.291.gc1ea87d7ee-goog


