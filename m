Return-Path: <linux-kernel+bounces-93897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB1E87367C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22961C239B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D78529B;
	Wed,  6 Mar 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GeEEvH7o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="byNP0X5z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GeEEvH7o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="byNP0X5z"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9884FAD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728271; cv=none; b=ANWqMj5y46nWJ/kS4qE0fE7fv2oAcY6VrmZg+sfQgmiBmlYidxODcqvwRsvpnLuwUq9ZjIjWQCnCQG3sp5YQ5q6vz+LOi5APLHX69CIpNSGSOrT0DOWueoeM5wtF9nece+lJCk8VjUd7WIfLwBMShInGPHlVdkZYoNQbGNSYxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728271; c=relaxed/simple;
	bh=kOcsz5u7FPBLTJgum4Kbn4ncNOHyMsdG29cQnUuXgf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ8Esiz+1ZGHCq7fl7VKJRQHvv+ZiJpGgokbj1fbHf7H+55ndjBz8Ri9Z/bTHmNiUt60+fAjzlYELaC1u4nXLz60KWpFqrxcg2FNPkSZnX8k1rmrTwGtiB7sTwkxK85Q363IFyxyZ/gsgTJ0bTMDE4X0+KEW4u+sJT0vbhznkaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GeEEvH7o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=byNP0X5z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GeEEvH7o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=byNP0X5z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34DD7759A5;
	Wed,  6 Mar 2024 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709728268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBlJtVja81KFeI8Jp6o410PFrC90a2K0vJckbpWhMBc=;
	b=GeEEvH7oKsaX6wN4AhpJKQ+b+OL817lZzSZEp8PpiEfVk2AyHlRcWIZ6nzYzy94FmbjdWB
	22LQWNk+j7Rp3cZQSiqoaG7Ox2oEe6/GUdiATcLPr715wlWLkbHwkf4a8/2lmPw39hBhEN
	wMpw4TCBkafldEp3gXZMM6MAJvW074Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709728268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBlJtVja81KFeI8Jp6o410PFrC90a2K0vJckbpWhMBc=;
	b=byNP0X5z1ajkB68ZoOPJL5oehbqo35x5Oo4zLvow9uSs5KH9AuBSFzcsSu6i+WcQSPlpl/
	Q7doAaJd3ptnLzDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709728268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBlJtVja81KFeI8Jp6o410PFrC90a2K0vJckbpWhMBc=;
	b=GeEEvH7oKsaX6wN4AhpJKQ+b+OL817lZzSZEp8PpiEfVk2AyHlRcWIZ6nzYzy94FmbjdWB
	22LQWNk+j7Rp3cZQSiqoaG7Ox2oEe6/GUdiATcLPr715wlWLkbHwkf4a8/2lmPw39hBhEN
	wMpw4TCBkafldEp3gXZMM6MAJvW074Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709728268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBlJtVja81KFeI8Jp6o410PFrC90a2K0vJckbpWhMBc=;
	b=byNP0X5z1ajkB68ZoOPJL5oehbqo35x5Oo4zLvow9uSs5KH9AuBSFzcsSu6i+WcQSPlpl/
	Q7doAaJd3ptnLzDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A03F1377D;
	Wed,  6 Mar 2024 12:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CJLKIgti6GUaTwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 06 Mar 2024 12:31:07 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 1/2] mm,page_owner: Check for null stack_record before bumping its refcount
Date: Wed,  6 Mar 2024 13:32:16 +0100
Message-ID: <20240306123217.29774-2-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306123217.29774-1-osalvador@suse.de>
References: <20240306123217.29774-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de,intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.10)[95.61%]
X-Spam-Level: **
X-Spam-Score: 2.80
X-Spam-Flag: NO

Although the retrieval of the stack_records for {dummy,failure}_handle
happen when page_owner gets initialized, there seems to be some situations
where stackdepot space has been already depleted by then, so we get
0-handles which make stack_records being NULL for those cases.

Be careful to 1) only bump stack_records refcount and 2) only access
stack_record fields if we actually have a non-null stack_record between
hands.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202403051032.e2f865a-lkp@intel.com
Fixes: 4bedfb314bdd ("mm,page_owner: implement the tracking of the stacks count")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_owner.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 033e349f6479..7163a1c44ccf 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -107,8 +107,10 @@ static __init void init_page_owner(void)
 	/* Initialize dummy and failure stacks and link them to stack_list */
 	dummy_stack.stack_record = __stack_depot_get_stack_record(dummy_handle);
 	failure_stack.stack_record = __stack_depot_get_stack_record(failure_handle);
-	refcount_set(&dummy_stack.stack_record->count, 1);
-	refcount_set(&failure_stack.stack_record->count, 1);
+	if (dummy_stack.stack_record)
+		refcount_set(&dummy_stack.stack_record->count, 1);
+	if (failure_stack.stack_record)
+		refcount_set(&failure_stack.stack_record->count, 1);
 	dummy_stack.next = &failure_stack;
 	stack_list = &dummy_stack;
 }
@@ -856,6 +858,9 @@ static int stack_print(struct seq_file *m, void *v)
 	unsigned long nr_entries;
 	struct stack_record *stack_record = stack->stack_record;
 
+	if (!stack->stack_record)
+		return 0;
+
 	nr_entries = stack_record->size;
 	entries = stack_record->entries;
 	stack_count = refcount_read(&stack_record->count) - 1;
-- 
2.44.0


