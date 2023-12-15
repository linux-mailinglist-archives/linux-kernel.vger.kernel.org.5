Return-Path: <linux-kernel+bounces-1098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB19814A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24321C236A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3745030CED;
	Fri, 15 Dec 2023 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ofh53ErB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="38+mkE00"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F322E65C;
	Fri, 15 Dec 2023 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702649973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+ur53cIUdj33ok3eBL+Esj2uZivDHkdKlUPrUz0hIA=;
	b=Ofh53ErBL17sEf0hiRZv9yXnchYe2Spj4pmB6hfISduS6dhb+CSrrrnKQJkM1Ne++UXOaW
	SUUOENQLXQgkFy89HZ4DTEJZFdkeAVkvm9xwD+ZVv1yy4xRUnMs0H85YVhiftwF4UV4VKZ
	3OtuDhC85EtERbAqdwAT4FJlOogUB0VRqOi6YMv2vHwBFBfbjNT8PYcySnJsGhFLKltjGm
	uqNhUkGbXSlt7QIzHP9Ry5D1zEalVBJwjO7yNjPS7nnhHg95QcCblXTXpoA68eWTY9Sm4N
	fuyU5rVqNOtyxSD9yfIccenA3gcebJNrjVibBwZq4vi8mBNHKCLQ2XcfAxX0uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702649973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+ur53cIUdj33ok3eBL+Esj2uZivDHkdKlUPrUz0hIA=;
	b=38+mkE00xZtcq4NGXsFNW0cII7dp6Qgxd09zOo2CsTyeh9NZkjcbF7CO00zjkCEHBdhVZv
	rJ26/eWdmwPnIaCg==
To: "Zhang, Rui" <rui.zhang@intel.com>, "jsperbeck@google.com"
 <jsperbeck@google.com>, "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Andres Freund <andres@anarazel.de>
Subject: [PATCH] x86/acpi: Handle bogus MADT APIC tables gracefully
In-Reply-To: <87ttonpbnr.ffs@tglx>
References: <87ttonpbnr.ffs@tglx>
Date: Fri, 15 Dec 2023 15:19:32 +0100
Message-ID: <8734w3o8ej.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The recent fix to ignore invalid x2APIC entries inadvertently broke systems
with creative MADT APIC tables. The affected systems have APIC MADT tables
where all entries have invalid APIC IDs (0xFF), which means they register
exactly zero CPUs.

But the condition to ignore the entries of APIC IDs < 255 in the X2APIC
MADT table is solely based on the count of MADT APIC table entries.

As a consequence the affected machines enumerate no secondary CPUs at
all because the APIC table has entries and therefore the X2APIC table
entries with APIC IDs < 255 are ignored.

Change the condition so that the APIC table preference for APIC IDs <
255 only becomes effective when the APIC table has valid APIC ID
entries. IOW a APIC table full of invalid APIC IDs is considered to be
empty which in consequence enables the X2APIC table entries with a APIC
ID < 255 and restores the expected behaviour.

Fixes: ec9aedb2aa1a ("x86/acpi: Ignore invalid x2APIC entries")
Reported-by: John Sperbeck <jsperbeck@google.com>
Reported-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/acpi/boot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -293,6 +293,7 @@ acpi_parse_lapic(union acpi_subtable_hea
 			    processor->processor_id, /* ACPI ID */
 			    processor->lapic_flags & ACPI_MADT_ENABLED);
 
+	has_lapic_cpus = true;
 	return 0;
 }
 
@@ -1134,7 +1135,6 @@ static int __init acpi_parse_madt_lapic_
 	if (!count) {
 		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
 					acpi_parse_lapic, MAX_LOCAL_APIC);
-		has_lapic_cpus = count > 0;
 		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
 					acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}

