Return-Path: <linux-kernel+bounces-133000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E60899D1D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4FA28AE40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAD516C859;
	Fri,  5 Apr 2024 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AubcmXMI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AubcmXMI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1381649DF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320491; cv=none; b=ncMeE+MpYeJyhSCQNiab9FSdPvM2GQsdQ1WU/bNJ8ZWWQEMqGgu2ldsflfLYvNqXFPraF4pLC69zmHyPCPkGHUeWJnU1YOh67rBFgKRrBvHGJFjNZo4sponRAufuxCsNbgTl0OrDkSdgVuf63no9trFnmBT0DpF98YXHZsbOwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320491; c=relaxed/simple;
	bh=BXQyPFPv0NM5RDtg/91lIFxeN5FaeuVD8cD23jfuqKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8USK9+6O2UswinqWqLk2MKjsLB1Qqs6LG9xV/CFlj1h87oiGzrI904g/ioUlZLFFxlD35i6zhtbftUqvTrXHf3u3X1N3lCAsOjk7RVGlhgXc0BIl4fC30ywqZ29qgcBGhn87FIGaazDNtmgnhL1YfrF8XP1z8IlY6FQdP4GblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AubcmXMI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AubcmXMI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51D5821A42;
	Fri,  5 Apr 2024 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712320488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0jyNvKTHax+A0LD2eIp7A6uzmXI0s1Z7nkLE2AaG4I=;
	b=AubcmXMIMx2JuozlxaVZ6aoO1vmLMUD9McUXagcomdrknSUs72w/jRG5+BoqixzGF0Ynsw
	cmF67Yy8MEYjggWpzTKsZzIbF3YbDaUtLurvHF8BAWTkjzVGze/+nrAloogUfDHSOItTDP
	iSROy7dI6S/oknWyfBY5jJI1PiOF/E4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712320488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0jyNvKTHax+A0LD2eIp7A6uzmXI0s1Z7nkLE2AaG4I=;
	b=AubcmXMIMx2JuozlxaVZ6aoO1vmLMUD9McUXagcomdrknSUs72w/jRG5+BoqixzGF0Ynsw
	cmF67Yy8MEYjggWpzTKsZzIbF3YbDaUtLurvHF8BAWTkjzVGze/+nrAloogUfDHSOItTDP
	iSROy7dI6S/oknWyfBY5jJI1PiOF/E4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E9EF1139E8;
	Fri,  5 Apr 2024 12:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VZuqN+fvD2adGgAAn2gu4w
	(envelope-from <jgross@suse.com>); Fri, 05 Apr 2024 12:34:47 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 2/2] x86/xen: return a sane initial apic id when running as PV guest
Date: Fri,  5 Apr 2024 14:34:34 +0200
Message-Id: <20240405123434.24822-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240405123434.24822-1-jgross@suse.com>
References: <20240405123434.24822-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email]

With recent sanity checks for topology information added, there are now
warnings issued for APs when running as a Xen PV guest:

  [Firmware Bug]: CPU   1: APIC ID mismatch. CPUID: 0x0000 APIC: 0x0001

This is due to the initial APIC ID obtained via CPUID for PV guests is
always 0.

Avoid the warnings by synthesizing the CPUID data to contain the same
initial APIC ID as xen_pv_smp_config() is using for registering the
APIC IDs of all CPUs.

Fixes: 52128a7a21f7 ("86/cpu/topology: Make the APIC mismatch warnings complete")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index ace2eb054053..965e4ca36024 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -219,13 +219,20 @@ static __read_mostly unsigned int cpuid_leaf5_edx_val;
 static void xen_cpuid(unsigned int *ax, unsigned int *bx,
 		      unsigned int *cx, unsigned int *dx)
 {
-	unsigned maskebx = ~0;
+	unsigned int maskebx = ~0;
+	unsigned int or_ebx = 0;
 
 	/*
 	 * Mask out inconvenient features, to try and disable as many
 	 * unsupported kernel subsystems as possible.
 	 */
 	switch (*ax) {
+	case 0x1:
+		/* Replace initial APIC ID in bits 24-31 of EBX. */
+		maskebx = 0x00ffffff;
+		or_ebx = smp_processor_id() << 24;
+		break;
+
 	case CPUID_MWAIT_LEAF:
 		/* Synthesize the values.. */
 		*ax = 0;
@@ -248,6 +255,7 @@ static void xen_cpuid(unsigned int *ax, unsigned int *bx,
 		: "0" (*ax), "2" (*cx));
 
 	*bx &= maskebx;
+	*bx |= or_ebx;
 }
 
 static bool __init xen_check_mwait(void)
-- 
2.35.3


