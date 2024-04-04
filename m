Return-Path: <linux-kernel+bounces-131008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E53F8981DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88E71F275C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063535C8EE;
	Thu,  4 Apr 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DTeAE4Cs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HFc2R9tS"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5215789F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214356; cv=none; b=LtlbbxxkMIO4Z9IK7H6PBPrncahFVipr6j3Qo8I6f2Hfu6LS+k/Cr5ETOs4dTBeuOEvDPi08Ge7jJRYhq9TkxhcUwsTdGAOB1FoK1wTR3AKPL7QoAw9r/8Ej/8/l58uXb5liRRaeX/i7kEE2RqFB195t9q7cUpq6sd206r0lZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214356; c=relaxed/simple;
	bh=TmkUOJgl1Ime8MjfobYwogu/TGMg3cnaOK7nLoRTJQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1HDRmRkKH+HcFYf/s8RDJ7+RPz+JjukOJowpaWi8X4Im9VkDGEAcj76J9mZ3tekQ/oNim6c0bYvhl03A5qF8F/0xCoi3k+hT2YoTq3mHU9Gb31ATeZPDUo28JSjP2vlDykzbw05S4Q62s+oaiykfi+biLMvpc4FqjfiiYBIABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DTeAE4Cs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HFc2R9tS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19D81378EF;
	Thu,  4 Apr 2024 07:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712214353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4wwG5jpQSOVuMqfScgmDBg4jiw7p8cJsBUm20LXaGw=;
	b=DTeAE4CsKqN3QlIzPAFEGEu264vov2pEAU74p3IMXEN0UUxbIwMY7WjLmpbOZI/Yo9i0f/
	QtgaatcX3RYl4TDQSmZunCCmnz4X6M34Ce28kpEhZl16noUIxaotEvf4ooVyaBYguu7C4F
	+dGOXk6kbkbeJrXe/sfi0bzMWkxarAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712214353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4wwG5jpQSOVuMqfScgmDBg4jiw7p8cJsBUm20LXaGw=;
	b=HFc2R9tSN3nHIpQ56020vRM6DlTy536CD43M5GHP2BJMk5Y7fnoGEi7KWMz5cJE1VSC8tc
	AulWxQIGEB4CsAAQ==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 838D0139E8;
	Thu,  4 Apr 2024 07:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kIhbHVBRDmY6cgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 04 Apr 2024 07:05:52 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 4/4] mm,page_owner: Fix printing of stack records
Date: Thu,  4 Apr 2024 09:07:02 +0200
Message-ID: <20240404070702.2744-5-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404070702.2744-1-osalvador@suse.de>
References: <20240404070702.2744-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.98 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-2.19)[96.13%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,rivosinc.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -4.98
X-Spam-Level: 
X-Spam-Flag: NO

When seq_* code sees that its buffer overflowed, it re-allocates a bigger
onecand calls seq_operations->start() callback again.
stack_start() naively though that if it got called again, it meant that the
old record got already printed so it returned the next object, but that is
not true.

The consequence of that is that every time stack_stop() -> stack_start()
get called because we needed a bigger buffer, stack_start() will skip
entries, and those will not be printed.

Fix it by not advancing to the next object in stack_start().

Fixes: 765973a09803 ("mm,page_owner: display all stacks and their count")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_owner.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index b4476f45b376..9bef0b442863 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -872,13 +872,11 @@ static void *stack_start(struct seq_file *m, loff_t *ppos)
 		 * value of stack_list.
 		 */
 		stack = smp_load_acquire(&stack_list);
+		m->private = stack;
 	} else {
 		stack = m->private;
-		stack = stack->next;
 	}
 
-	m->private = stack;
-
 	return stack;
 }
 
-- 
2.44.0


