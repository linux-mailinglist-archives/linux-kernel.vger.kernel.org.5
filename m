Return-Path: <linux-kernel+bounces-104956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DCA87D684
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164DA1C20DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC856B8C;
	Fri, 15 Mar 2024 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OlWzbO94";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZOiLfmSy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dkDMcRMo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4JJKeYSa"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD256B63
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541498; cv=none; b=aoy+Bc0Tr7gCdpK7krDth44jahtBT7nsq1pJ5DbtXs/XPSoUid6kw+jJKpRnpnYPpgKNtJonpFZFBX4Bpw5Ev4/XKhbZ4+J4tRirg+nyABCAHQg0gxheGX9sy6oQRjSxiSNLo0QNbndQGBSv7I0ivEBdoYWesjyroQ0NIrJHe7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541498; c=relaxed/simple;
	bh=Zb8k/H9l47yaWYaS96SpvUd67yqQg6btc0pNdL5WLO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P8+RpzEpCsoB/jQ4T+wHeR4D8raChdJ86SjvvG8Dh89OnC2iMIEuIR7U4zy/Ay7TPTGlQN4MgD9DynztjNzbZEI2Z8+ZqonwZcon0Bs2Q2PfyIl3kP8cjG3meBWD1N20iUgL5MtYM4y/8Lm6H3urs0Z76GqoKS7o60QyVtzRdVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OlWzbO94; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZOiLfmSy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dkDMcRMo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4JJKeYSa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F01941FB89;
	Fri, 15 Mar 2024 22:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710541488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h+O85a7jNdi3cYiNUyNI4tzZVgdpHXmiNpkwneSX0QM=;
	b=OlWzbO94ZrwkTjd69vykRSIT2EtsMBAh0Vh/UGkK9r4MTWTFb1g82GQFr1EofbkiPp7ZI9
	jJ4UD0acmOAGj4akicTIR+ukr/m5AlBMOt/rMIsjcgkDUkk1TwL27LaDv8t+NL/xf/zNuh
	fzJgpOCTW43jNXBOApC0/1wo2d9/bj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710541488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h+O85a7jNdi3cYiNUyNI4tzZVgdpHXmiNpkwneSX0QM=;
	b=ZOiLfmSy2bjjMG2wokL+zxJ/0wwisDfGsfivX82jEfZEAi3m4Hlw/8x9NYOSDZJnKeAZHv
	xp3+PWnr7csdNgBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710541487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h+O85a7jNdi3cYiNUyNI4tzZVgdpHXmiNpkwneSX0QM=;
	b=dkDMcRModR5lmkDMl2u65IsWvSdy1eTntdoE++IgZsdgokXM7Ou7b+tjhidDKKn9v9esPp
	wXwpx4NY3PjRX9sih+umSF/f1zqbAxGNgj3p/d127JdX132ZXKdgFRYB9e/vJoRAezCNnm
	PNjx/xDl42ACb9Mhg/sTZViEOZD/H3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710541487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h+O85a7jNdi3cYiNUyNI4tzZVgdpHXmiNpkwneSX0QM=;
	b=4JJKeYSaa5twd8m9bstWkO1UyJpJSo+aew9hURgNXFrEe7fNMFeZjFmM/w1s8DonaV7uTA
	f1aFKeP1YlafnpDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EBC013460;
	Fri, 15 Mar 2024 22:24:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4NwGGK/K9GXkSwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 15 Mar 2024 22:24:47 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2] mm,page_owner: Fix recursion
Date: Fri, 15 Mar 2024 23:26:10 +0100
Message-ID: <20240315222610.6870-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.51
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dkDMcRMo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4JJKeYSa
X-Rspamd-Queue-Id: F01941FB89

Prior to 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
the only place where page_owner could potentially go into recursion due to
its need of allocating more memory was in save_stack(), which ends up calling
into stackdepot code with the possibility of allocating memory.

We made sure to guard against that by signaling that the current task was
already in page_owner code, so in case a recursion attempt was made, we
could catch that and return dummy_handle.

After above commit, a new place in page_owner code was introduced where we
could allocate memory, meaning we could go into recursion would we take that
path.

Make sure to signal that we are in page_owner in that codepath as well.
Move the guard code into two helpers {un}set_current_in_page_owner()
and use them prior to calling in the two functions that might allocate
memory.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
---
Changes from v1 -> v2:
 Wrap {un}set_current_in_page_owner directly around kmalloc call
 (Vlastimil feedback)
---
 mm/page_owner.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index e96dd9092658..cde1ee0f9005 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -54,6 +54,22 @@ static depot_stack_handle_t early_handle;
 
 static void init_early_allocated_pages(void);
 
+static inline void set_current_in_page_owner(void)
+{
+	/*
+	 * Avoid recursion.
+	 *
+	 * We might need to allocate more memory from page_owner code, so make
+	 * sure to signal it in order to avoid recursion.
+	 */
+	current->in_page_owner = 1;
+}
+
+static inline void unset_current_in_page_owner(void)
+{
+	current->in_page_owner = 0;
+}
+
 static int __init early_page_owner_param(char *buf)
 {
 	int ret = kstrtobool(buf, &page_owner_enabled);
@@ -133,23 +149,16 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
 	depot_stack_handle_t handle;
 	unsigned int nr_entries;
 
-	/*
-	 * Avoid recursion.
-	 *
-	 * Sometimes page metadata allocation tracking requires more
-	 * memory to be allocated:
-	 * - when new stack trace is saved to stack depot
-	 */
 	if (current->in_page_owner)
 		return dummy_handle;
-	current->in_page_owner = 1;
 
+	set_current_in_page_owner();
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
 	handle = stack_depot_save(entries, nr_entries, flags);
 	if (!handle)
 		handle = failure_handle;
+	unset_current_in_page_owner();
 
-	current->in_page_owner = 0;
 	return handle;
 }
 
@@ -164,9 +173,13 @@ static void add_stack_record_to_list(struct stack_record *stack_record,
 	gfp_mask &= (GFP_ATOMIC | GFP_KERNEL);
 	gfp_mask |= __GFP_NOWARN;
 
+	set_current_in_page_owner();
 	stack = kmalloc(sizeof(*stack), gfp_mask);
-	if (!stack)
+	if (!stack) {
+		unset_current_in_page_owner();
 		return;
+	}
+	unset_current_in_page_owner();
 
 	stack->stack_record = stack_record;
 	stack->next = NULL;
-- 
2.44.0


