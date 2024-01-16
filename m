Return-Path: <linux-kernel+bounces-26637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5482E465
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F2928148D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883FD10A2E;
	Tue, 16 Jan 2024 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA5doQV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96410A11;
	Tue, 16 Jan 2024 00:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6525AC43390;
	Tue, 16 Jan 2024 00:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705363995;
	bh=LLyJjD2QweR+uisTga2oFdG6hn8MZCYA+bPuoZfmvcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bA5doQV7bOx3Py/jicZotrOv26NPQQ4eeuhS+JwdBHWBa6Nx+S3lllw+xeSfH7Z9P
	 GhlEr0VBSdcMuMHc/XXdpM6F4fM/ZiIoaQtZ3vQ0TKw+XU1t75nsCUgKREt3IwNAHB
	 bun5ATt8J6kqWo8hgRU3gSZchrHkGRb8oxpNwsV0c6F0UNIG3B5iSz2tslOTQH1RvZ
	 71AZ5fgbIhGGhGmrBc9T2K0m28filisfzFoGd3NneBJijkPKATzYh34SjDfRegUOiY
	 QO3Y6UU2CNc54w/7fA2XSxfg4KbKKJ4rpr5hCAArTwYkrzGsq3sViNFgfyAk2rsctS
	 tX78I5v09obEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuntao Wang <ytcoode@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 04/18] ACPI: tables: Correct and clean up the logic of acpi_parse_entries_array()
Date: Mon, 15 Jan 2024 19:12:46 -0500
Message-ID: <20240116001308.212917-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001308.212917-1-sashal@kernel.org>
References: <20240116001308.212917-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Yuntao Wang <ytcoode@gmail.com>

[ Upstream commit 4b3805daaacb2168665c6222f261e68accb120dc ]

The original intention of acpi_parse_entries_array() is to return the
number of all matching entries on success. This number may be greater than
the value of the max_entries parameter. When this happens, the function
will output a warning message, indicating that `count - max_entries`
matching entries remain unprocessed and have been ignored.

However, commit 4ceacd02f5a1 ("ACPI / table: Always count matched and
successfully parsed entries") changed this logic to return the number of
entries successfully processed by the handler. In this case, when the
max_entries parameter is not zero, the number of entries successfully
processed can never be greater than the value of max_entries. In other
words, the expression `count > max_entries` will always evaluate to false.
This means that the logic in the final if statement will never be executed.

Commit 99b0efd7c886 ("ACPI / tables: do not report the number of entries
ignored by acpi_parse_entries()") mentioned this issue, but it tried to fix
it by removing part of the warning message. This is meaningless because the
pr_warn statement will never be executed in the first place.

Commit 8726d4f44150 ("ACPI / tables: fix acpi_parse_entries_array() so it
traverses all subtables") introduced an errs variable, which is intended to
make acpi_parse_entries_array() always traverse all of the subtables,
calling as many of the callbacks as possible. However, it seems that the
commit does not achieve this goal. For example, when a handler returns an
error, none of the handlers will be called again in the subsequent
iterations. This result appears to be no different from before the change.

This patch corrects and cleans up the logic of acpi_parse_entries_array(),
making it return the number of all matching entries, rather than the number
of entries successfully processed by handlers. Additionally, if an error
occurs when executing a handler, the function will return -EINVAL immediately.

This patch should not affect existing users of acpi_parse_entries_array().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/fw_table.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/lib/fw_table.c b/lib/fw_table.c
index 294df54e33b6..c49a09ee3853 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -85,11 +85,6 @@ acpi_get_subtable_type(char *id)
 	return ACPI_SUBTABLE_COMMON;
 }
 
-static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
-{
-	return proc->handler || proc->handler_arg;
-}
-
 static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
 					  union acpi_subtable_headers *hdr,
 					  unsigned long end)
@@ -133,7 +128,6 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	unsigned long table_end, subtable_len, entry_len;
 	struct acpi_subtable_entry entry;
 	int count = 0;
-	int errs = 0;
 	int i;
 
 	table_end = (unsigned long)table_header + table_header->length;
@@ -145,25 +139,19 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	    ((unsigned long)table_header + table_size);
 	subtable_len = acpi_get_subtable_header_length(&entry);
 
-	while (((unsigned long)entry.hdr) + subtable_len  < table_end) {
-		if (max_entries && count >= max_entries)
-			break;
-
+	while (((unsigned long)entry.hdr) + subtable_len < table_end) {
 		for (i = 0; i < proc_num; i++) {
 			if (acpi_get_entry_type(&entry) != proc[i].id)
 				continue;
-			if (!has_handler(&proc[i]) ||
-			    (!errs &&
-			     call_handler(&proc[i], entry.hdr, table_end))) {
-				errs++;
-				continue;
-			}
+
+			if (!max_entries || count < max_entries)
+				if (call_handler(&proc[i], entry.hdr, table_end))
+					return -EINVAL;
 
 			proc[i].count++;
+			count++;
 			break;
 		}
-		if (i != proc_num)
-			count++;
 
 		/*
 		 * If entry->length is 0, break from this loop to avoid
@@ -180,9 +168,9 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	}
 
 	if (max_entries && count > max_entries) {
-		pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
-			id, proc->id, count);
+		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
+			id, proc->id, count - max_entries, count);
 	}
 
-	return errs ? -EINVAL : count;
+	return count;
 }
-- 
2.43.0


