Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A1D7F124F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjKTLmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjKTLmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:42:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE119C;
        Mon, 20 Nov 2023 03:42:19 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc68c1fac2so37381845ad.0;
        Mon, 20 Nov 2023 03:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700480539; x=1701085339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V1guMx9hj3Dnab92EYIslORuUgAICHvH5VtGffdWtLk=;
        b=gIFZwA0K5/MKAb7JICdh1SolFlR47t9EKgWqcM7cUTLt3GvLsdUhOMj1NqA5ph/5XC
         Ith7vnud1hAaHuU09S0pfHYSh3/r/DWNaN4VwIFTMurRkhddgIEzobMwo8CQpZOYm3Il
         ZAALo2qK01nOohng+0zEsZ8xQuQd8dbJja6V3eXpaCw+ENjxElmOyMpgvQ1IjsWbCRRT
         lBq/XAV9OXm4uH4BR5pVzAHugfpVkbbDHtw1oNNqS1ZHZZZhTo08Wz67ys0gfloj6VM5
         eqAFLyr7mwNGGhHSYFS9Ljcef70lMTYfREAViHocifGI2VBCKe6tDi7MKu7AyiParKJh
         SH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700480539; x=1701085339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1guMx9hj3Dnab92EYIslORuUgAICHvH5VtGffdWtLk=;
        b=WyGngqxauHllOPKsHEcTSfbkbplB9f+LJZ4uEUW7fdWwJ3sM27SEe9bCryvCaL1IFR
         vtlEbVPHCAdH5rOIX07M9tHNH6c/l70sMi7tmx6SJOiBncjM6RlwoU5iHugymD05OZDh
         fVBMPW8GwYK1kr4jQaIABFHs7zG79Buy1+bWE6B1uU/NSsFHoC51IaO0yC5/lsQwDjWX
         EEGfvxB8kBhzigvWq55/RR6st5t6B75Gj4q1lDyD4Ie12zCYgePMaHBv3ma1c3beWJo5
         oq4jYy3V1H5Z9VdKa0YCAxg+JUxcW8sezpsYdFHVT5/j4lumknyz33a3cWa8lF4kvHJj
         9q3w==
X-Gm-Message-State: AOJu0YwT7NNkA5bTzTk6l35eA4SHTnEscjyzrTOp59yz4jSs/AwFrz91
        zrP1cJoz1zDN0Bt8DxFUbCw=
X-Google-Smtp-Source: AGHT+IHnFn0gexQ4iJb2xsKsrldOEdmuTbLbqDJD82pzS1/M00ua6MO0mkTjSdTGeEHzD535ggVjcA==
X-Received: by 2002:a17:902:d4cb:b0:1cc:29b5:a2b7 with SMTP id o11-20020a170902d4cb00b001cc29b5a2b7mr10115355plg.51.1700480539081;
        Mon, 20 Nov 2023 03:42:19 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902dacf00b001cf57827d69sm3024922plx.87.2023.11.20.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:42:18 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] ACPI: Correct and clean up the logic of acpi_parse_entries_array()
Date:   Mon, 20 Nov 2023 19:41:43 +0800
Message-ID: <20231120114143.95305-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 lib/fw_table.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/lib/fw_table.c b/lib/fw_table.c
index b51f30a28e47..b655e6f4b647 100644
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
2.42.1

