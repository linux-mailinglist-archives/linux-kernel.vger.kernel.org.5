Return-Path: <linux-kernel+bounces-123021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A05890124
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDBEB238A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B9482880;
	Thu, 28 Mar 2024 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btfiU8CF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB144C67;
	Thu, 28 Mar 2024 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634802; cv=none; b=iuqU66yZziqBqZaBasle+gitOlFquTCJa4K/osWIRCNtEv1WEt8rzedFy9IIE9BSd+Ch3SFFDe0N7q4rHRFSA45o6ih3RfVVX9+NNZe5liAX0RGAoVHMXLf+CTankTm9i4ZobwhwTQlIJ9yxzl3t0bNnm2N0cd7vBM+dUS4+KmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634802; c=relaxed/simple;
	bh=lezpFM2DFivksVBQ+jcGXE6ARZQR+zJugCRJ8LauAOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctiy9Iy530Gmzxzvd/8dGkKT3zv2Gyte7QOrIMGIbNZ/CljMyS7TQ7KLy3k4avNl06uoL02Tp6dhFQFaBgraIDgt4hUay2HfY5nrctnegf03FYeAbvSBQLJ23CIC3emwG632VJNg7PNh7YE2PX6ucAsy+8JlocQTMtL7Dq241zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btfiU8CF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD52BC433C7;
	Thu, 28 Mar 2024 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634802;
	bh=lezpFM2DFivksVBQ+jcGXE6ARZQR+zJugCRJ8LauAOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btfiU8CFi3ZJpE6YEYkrNSnkajZh5p/OPkCeQtqKmhP61Z3AbzPlRLr1vqjRGWgUv
	 4NYQxyuOXQf/UOtzHaXO+vVcXaQd9eI57v/nK4ubYyfaUR2zYLM1QftIWpy+XGNRNH
	 swbYRDzNe3lyoL8ahTFBq+VT18N3dRNB02b+LE0+li5tYVSiO/GWzL8UjqlQsNADle
	 oRarDv9hUrzmtQkCNacsLuTQZ5EfKu7MGIeak/pjJw/L+OWFjGMnrYvOjMn8/V8X9K
	 jemp4ib7rMMWMLjcgQ3sci6hfss19XYHNtQDyIFwaX/u56L+Ih+NWY9xDpx/C1m6B2
	 6CY0kLzc2Fa3A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Alexey Starikovskiy <astarikovskiy@suse.de>,
	Lin Ming <ming.m.lin@intel.com>,
	Len Brown <len.brown@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 06/11] acpi: avoid warning for truncated string copy
Date: Thu, 28 Mar 2024 15:04:50 +0100
Message-Id: <20240328140512.4148825-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140512.4148825-1-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wstringop-truncation warns about copying a string that results in a
missing nul termination:

drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified bound 6 equals destination size [-Werror=stringop-truncation]
   60 |         strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/acpica/tbfind.c:61:9: error: 'strncpy' specified bound 8 equals destination size [-Werror=stringop-truncation]
   61 |         strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This one is intentional, so rewrite the code in a way that avoids the
warning. Since there is already an extra strlen() and an overflow check,
the actual size to be copied is already known here.

Fixes: 47c08729bf1c ("ACPICA: Fix for LoadTable operator, input strings")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/acpica/tbfind.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 1c1b2e284bd9..472ce2a6624b 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -36,7 +36,7 @@ acpi_tb_find_table(char *signature,
 {
 	acpi_status status = AE_OK;
 	struct acpi_table_header header;
-	u32 i;
+	u32 len, i;
 
 	ACPI_FUNCTION_TRACE(tb_find_table);
 
@@ -46,19 +46,18 @@ acpi_tb_find_table(char *signature,
 		return_ACPI_STATUS(AE_BAD_SIGNATURE);
 	}
 
-	/* Don't allow the OEM strings to be too long */
-
-	if ((strlen(oem_id) > ACPI_OEM_ID_SIZE) ||
-	    (strlen(oem_table_id) > ACPI_OEM_TABLE_ID_SIZE)) {
-		return_ACPI_STATUS(AE_AML_STRING_LIMIT);
-	}
-
 	/* Normalize the input strings */
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
 	ACPI_COPY_NAMESEG(header.signature, signature);
-	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
-	strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	len = strlen(oem_id);
+	if (len > ACPI_OEM_ID_SIZE)
+		return_ACPI_STATUS(AE_AML_STRING_LIMIT);
+	memcpy(header.oem_id, oem_id, len);
+	len = strlen(oem_table_id);
+	if (len > ACPI_OEM_TABLE_ID_SIZE)
+		return_ACPI_STATUS(AE_AML_STRING_LIMIT);
+	memcpy(header.oem_table_id, oem_table_id, len);
 
 	/* Search for the table */
 
-- 
2.39.2


