Return-Path: <linux-kernel+bounces-142509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC3C8A2C95
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E705B240AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2542B4C624;
	Fri, 12 Apr 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="DHq3woNR"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8C446DC;
	Fri, 12 Apr 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918342; cv=none; b=QD4JZ6v1ZcIzD99vxDXY6BxpGHFXLaKi9Ln4SPhEKNFH9UhxXCYWWyyGNGj9tljPmYFLBuiaOKYzxO9qv8aPCGuHpkoEaAcOLC/obd6nXs0EPxNx38dFX1f52lS2V378HNSVr5k/qWIYf9Jmp2v2FtBP7+YnM87jBsnB3JPGGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918342; c=relaxed/simple;
	bh=u4aUA6NcMnVUvYddJfCG+2UiNKu6Ga4o67L0/zLDAFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GHMYSToweeoG04S+k6mPM7tBZo2pSHd4Jas3IRVM6IkRWQMRvaLsFqVrDx/xtXIk2j8QNOFOl0c0AQpzCWeIcDeZY03MK4/pTdn/AHJVnQJxlY0w0fdFrqkbhhRVs87S2F3dYo7Xc6oGPwKnW6RptRbcrZJ7sXFlqrJvwz1qqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=DHq3woNR; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 0B841100002;
	Fri, 12 Apr 2024 13:38:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712918321; bh=rYWnZbFlUffRYhsJkJp9tuIBEkLFSWBjZgHCW4zBdKs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=DHq3woNRIwGSc/UkbIaiPcVqKYEvvBCkOVTLL4kGivRHl/YGupV4lLaq2pYlBfiL3
	 jqPoilbQOp+6yXLl67xtXYSdoNxB70tY7krGtj51UI9kEhUGqDtotWtl4pk4SCGxoY
	 mtYx63rSHDEpZEnjUR7LwsholWBw0JBULtNqmtpOsSF4P985oYPuXaE6+5bCoV+mKI
	 SLQ0v7msR3kvzwk56g71vqQC3It1SvTgLpiBDTRE8F6dteJdvyojABfRwjPT02cJWj
	 rMc/4Y6Ix9XlTDUOl6CpOaiXopFgPnju1YqBoHnDQoAeKY0E72HDxnoSMPS3Bueuik
	 un/qN1Fnk6LZg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri, 12 Apr 2024 13:37:52 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 13:37:31 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Lv Zheng <lv.zheng@intel.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Robert Moore
	<robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] ACPICA: Handle memory allocation error
Date: Fri, 12 Apr 2024 13:37:23 +0300
Message-ID: <20240412103723.16943-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184684 [Apr 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/12 08:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/12 08:56:00 #24754366
X-KSMG-AntiVirus-Status: Clean, skipped

In acpi_db_add_to_history() acpi_os_allocate() may return NULL
in case of memory allocation error. This will lead to NULL pointer
dereference.
Fix this bug by adding NULL return check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/acpi/acpica/dbhistry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
index e874c1dddefa..8366631d457f 100644
--- a/drivers/acpi/acpica/dbhistry.c
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -69,6 +69,8 @@ void acpi_db_add_to_history(char *command_line)
 		acpi_gbl_history_buffer[acpi_gbl_next_history_index].command =
 		    acpi_os_allocate(cmd_len + 1);
 	}
+	if (!acpi_gbl_history_buffer[acpi_gbl_next_history_index].command)
+		return;
 
 	strcpy(acpi_gbl_history_buffer[acpi_gbl_next_history_index].command,
 	       command_line);
-- 
2.30.2


