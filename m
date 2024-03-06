Return-Path: <linux-kernel+bounces-93898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04FB87367D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481231F24707
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B309F8563E;
	Wed,  6 Mar 2024 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zkKuuijP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yol0huDH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zkKuuijP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yol0huDH"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED384FC4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728273; cv=none; b=paVdTgyoMoRUal3Eua8iHjCoZjLeVu9DCmfNhm+CXvxWM+fc9uGrPIFVsgxfjHNVOAXBqFt5waBlW5NOMoFv1d2A0lDQ/DdkvojLxgDH/xZZFnNk49Uuj+pkRULxGYqQnL+NY4kdb11KSC6fFMdwU/K2fXDxWWU5mQi0Bp+6aAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728273; c=relaxed/simple;
	bh=pkGnmJQ/2pBzk5rj4EVaNuLlwwgXwzwrSPkoY4ScGjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtnotkYL99ewY4a1yVpm5K7cUXBrfU0AwUmp6q0qB/JcJ3a04BTyjki/agNcie6sqjcm6+NNrtiS6+9WpOKQwlo9Wx6VUOeTj1G78HTTKRJJ0cF0QWIw8bME80Sh5JHgZAa60XsPQpBrPc5R5+C2RZ/vh1AzKC6SbQ2MI7g40Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zkKuuijP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yol0huDH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zkKuuijP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yol0huDH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF4A0759C3;
	Wed,  6 Mar 2024 12:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709728269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMF4QDA/BIIwL+kdUSy1E5oYvYlaroCGSWt9+J3am6I=;
	b=zkKuuijPtkX3+HRHmbSvRGQBMjgF+6ket/HA3Smww4iLnhtgAZlQQfuL/JJ/dWrE+xXjRu
	QCZAg7b1kMx1Yu/WNaMSka4dNR7vLJhPP7jtJ1jzpP1pcoJOxXo4aj5rUxN0j8UEJG/KuC
	K7tJ6dXo3m5zI7bzctnDO4tUtU5CxWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709728269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMF4QDA/BIIwL+kdUSy1E5oYvYlaroCGSWt9+J3am6I=;
	b=Yol0huDHb0VY+oMPN3hvChYMwd7AcGe8W7vBXgQ6s67q9g2lDhCyf5oZTlfcoho+IhYlmX
	LW/dNK8fE0YGPuDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709728269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMF4QDA/BIIwL+kdUSy1E5oYvYlaroCGSWt9+J3am6I=;
	b=zkKuuijPtkX3+HRHmbSvRGQBMjgF+6ket/HA3Smww4iLnhtgAZlQQfuL/JJ/dWrE+xXjRu
	QCZAg7b1kMx1Yu/WNaMSka4dNR7vLJhPP7jtJ1jzpP1pcoJOxXo4aj5rUxN0j8UEJG/KuC
	K7tJ6dXo3m5zI7bzctnDO4tUtU5CxWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709728269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMF4QDA/BIIwL+kdUSy1E5oYvYlaroCGSWt9+J3am6I=;
	b=Yol0huDHb0VY+oMPN3hvChYMwd7AcGe8W7vBXgQ6s67q9g2lDhCyf5oZTlfcoho+IhYlmX
	LW/dNK8fE0YGPuDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 302E71377D;
	Wed,  6 Mar 2024 12:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AJEaCQ1i6GUaTwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 06 Mar 2024 12:31:09 +0000
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
Subject: [PATCH 2/2] mm,page_owner: Drop unnecesary check
Date: Wed,  6 Mar 2024 13:32:17 +0100
Message-ID: <20240306123217.29774-3-osalvador@suse.de>
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
X-Spam-Level: 
X-Spam-Score: 0.98
X-Spamd-Result: default: False [0.98 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.72)[98.78%]
X-Spam-Flag: NO

stackdepot only saves stack_records which size is greather than 0,
so we cannot possibly have empty stack_records.
Drop the check.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_owner.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 7163a1c44ccf..e7139952ffd9 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -865,8 +865,7 @@ static int stack_print(struct seq_file *m, void *v)
 	entries = stack_record->entries;
 	stack_count = refcount_read(&stack_record->count) - 1;
 
-	if (!nr_entries || nr_entries < 0 || stack_count < 1 ||
-	    stack_count < page_owner_stack_threshold)
+	if (stack_count < 1 || stack_count < page_owner_stack_threshold)
 		return 0;
 
 	for (i = 0; i < nr_entries; i++)
-- 
2.44.0


