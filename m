Return-Path: <linux-kernel+bounces-166575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC28B9C97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B938282873
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7BB153819;
	Thu,  2 May 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RBgzHykz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7PFZsli"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C7153560
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660796; cv=none; b=Gf6JsUpmc/NavTtCQLEB71DBjuZsL6t/wgsnZE1wfj+OfQKbzP18gJ/oirD1pOQ2wOr5FeHAQTEk70dcBTiDnk23kvMxDFqdLLnujzNTN5QEujgvG44/4ONnSu6ogUgJwhwLjv4WmsHqA1CNK0rS/Rp+T1+JdQo5M3cjR7xTVts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660796; c=relaxed/simple;
	bh=ZUZUTAJq5dPNqRY6+11fwZMAQEiNtY+sAbNFVNlRN7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+5aLqBJuMLFu9YAFPpsr151wqkM8ukwz3uFL4MRwDa1IcpG4SK8nngJ/CLawGDGX/eKnqcchzNwCvCc2Wrqy+nE74NdxSz1LXP3Sy0TNqtELAJJqXvJNblG9LE3yx5s1+Y9AGU5QYLqBA8xL1veZydODeZnGy2vpcwqgUzNrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RBgzHykz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7PFZsli; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714660792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEzQM+tS5Uz2jefzA/3tKvK2FghDZ0VWvE54GTzqNVw=;
	b=RBgzHykzBq8O505ee+KnkX/VPfzCaKIysXBczACsDHPYk/knQl2fdpnppuHUEfxBOxrkGH
	x8EIorE6PgZXV1JOFK3LhgS9JgC12O1E/M4Og5zRsu+mj8ak3oH0bjjT/EEYzv8keu/T0b
	dLoLVGYI0PldVBLqOtOgNCsj/FZ8F79TnHvrtG6cSVb+4O9iq8IaLnEGwDRKOJAzKnR464
	/2gtRJpI7m7B8sadedA1ohDTmolaXJpB8xanYZ/pCp7GryuEJZ4fWVrX3LJBk2qAUH51q/
	iRSPLmk/LWZQymmiECXbFGcK32DpvIsSLkCa2jrjBbzdeaDfYbu63daWMSz/Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714660792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEzQM+tS5Uz2jefzA/3tKvK2FghDZ0VWvE54GTzqNVw=;
	b=Q7PFZsliuQfsac7PnVg+9tk43S3Aie4Jtg/T37VuM5XFKhbVBR+en7ttJjRmr9FhUkRnEJ
	A43vdg8Se77g01CA==
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH] x86/xen/smp_pv: Register the boot CPU APIC properly
In-Reply-To: <27de9ba0-cbe9-4256-b378-45ede5d29517@suse.com>
References: <20240405123434.24822-1-jgross@suse.com>
 <20240405123434.24822-2-jgross@suse.com> <87ttjisu9l.ffs@tglx>
 <27de9ba0-cbe9-4256-b378-45ede5d29517@suse.com>
Date: Thu, 02 May 2024 16:39:47 +0200
Message-ID: <87a5l8s2fg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The topology core expects the boot APIC to be registered from earhy APIC
detection first and then again when the firmware tables are evaluated. This
is used for detecting the real BSP CPU on a kexec kernel.

The recent conversion of XEN/PV to register fake APIC IDs failed to
register the boot CPU APIC correctly as it only registers it once. This
causes the BSP detection mechanism to trigger wrongly:

   CPU topo: Boot CPU APIC ID not the first enumerated APIC ID: 0 > 1

Additionally this results in one CPU being ignored.

Register the boot CPU APIC twice so that the XEN/PV fake enumeration
behaves like real firmware.

Reported-by: Juergen Gross <jgross@suse.com>
Fixes: e75307023466 ("x86/xen/smp_pv: Register fake APICs")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/smp_pv.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -154,9 +154,9 @@ static void __init xen_pv_smp_config(voi
 	u32 apicid = 0;
 	int i;
 
-	topology_register_boot_apic(apicid++);
+	topology_register_boot_apic(apicid);
 
-	for (i = 1; i < nr_cpu_ids; i++)
+	for (i = 0; i < nr_cpu_ids; i++)
 		topology_register_apic(apicid++, CPU_ACPIID_INVALID, true);
 
 	/* Pretend to be a proper enumerated system */

