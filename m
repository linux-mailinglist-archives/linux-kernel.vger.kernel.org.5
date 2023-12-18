Return-Path: <linux-kernel+bounces-3783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE3A81716C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415881C23FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AE31D13A;
	Mon, 18 Dec 2023 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Koy+b1tW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L1HYhKO1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50201D12D;
	Mon, 18 Dec 2023 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Dec 2023 13:57:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702907851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKPUIu+lrMG4DdNJrTfiWU7oV+1Ny7jpFBIodEJ0jHU=;
	b=Koy+b1tWCioaVB26LsGUFhpec+L3stlEEs/vVbfrkEg0DlnmeO28o3N6DYUSKgmOR/Ujxg
	tUHI9UAPghpOakAbnr1wZWKQA2wpiH+JRYIYez6xpznmzztskSeMQZZJ9iYxQnTkpCI+kt
	iUG/vB9fvVvJtt5P2j6acuuj/tIfsiqaQTAPYaGQFo3XuT+UA3zv6gZY+xal6N03xlRhgp
	Ec4m8iVo3Mg5JLabWjiJu9J9f9y6GkCr1cktnClqfKpA73Vwupv1Vb1rU5V0N2MVIQaBpn
	cF7HPphuSRcsop0dBMJiFJRbkUACXyNDVMfcMWrTbXKjrMZ7KwlrlNEvYN0O5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702907851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKPUIu+lrMG4DdNJrTfiWU7oV+1Ny7jpFBIodEJ0jHU=;
	b=L1HYhKO1IYKtcqT3JOxxA710NVhz9JwcIehqqr0VaLPuQd5sRs9WPi9fBiyP4TdwRA0OnE
	90xp/KMQFj9iN1Aw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/acpi: Handle bogus MADT APIC tables gracefully
Cc: John Sperbeck <jsperbeck@google.com>, Andres Freund <andres@anarazel.de>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170290785069.398.7593700357199640901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d5a10b976ecb77fa49b95f3f1016ca2997c122cb
Gitweb:        https://git.kernel.org/tip/d5a10b976ecb77fa49b95f3f1016ca2997c122cb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Dec 2023 15:19:32 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 18 Dec 2023 14:21:44 +01:00

x86/acpi: Handle bogus MADT APIC tables gracefully

The recent fix to ignore invalid x2APIC entries inadvertently broke
systems with creative MADT APIC tables. The affected systems have APIC
MADT tables where all entries have invalid APIC IDs (0xFF), which means
they register exactly zero CPUs.

But the condition to ignore the entries of APIC IDs < 255 in the X2APIC
MADT table is solely based on the count of MADT APIC table entries.

As a consequence, the affected machines enumerate no secondary CPUs at
all because the APIC table has entries and therefore the X2APIC table
entries with APIC IDs < 255 are ignored.

Change the condition so that the APIC table preference for APIC IDs <
255 only becomes effective when the APIC table has valid APIC ID
entries.

IOW, an APIC table full of invalid APIC IDs is considered to be empty
which in consequence enables the X2APIC table entries with a APIC ID
< 255 and restores the expected behaviour.

Fixes: ec9aedb2aa1a ("x86/acpi: Ignore invalid x2APIC entries")
Reported-by: John Sperbeck <jsperbeck@google.com>
Reported-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/169953729188.3135.6804572126118798018.tip-bot2@tip-bot2
---
 arch/x86/kernel/acpi/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1a0dd80..85a3ce2 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -293,6 +293,7 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 			    processor->processor_id, /* ACPI ID */
 			    processor->lapic_flags & ACPI_MADT_ENABLED);
 
+	has_lapic_cpus = true;
 	return 0;
 }
 
@@ -1134,7 +1135,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	if (!count) {
 		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
 					acpi_parse_lapic, MAX_LOCAL_APIC);
-		has_lapic_cpus = count > 0;
 		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
 					acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}

