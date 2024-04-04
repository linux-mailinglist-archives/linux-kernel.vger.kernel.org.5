Return-Path: <linux-kernel+bounces-131004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A25398981D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0F2B22DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA8954905;
	Thu,  4 Apr 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a2sy4Lpd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jU2BC5iJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F25479F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214349; cv=none; b=YPYGQWLzgtyXt/yD8aHMWVkDQ2Bd2qQIC8Ae/wE+wiRTUDW98UkWpuyCuP+kxAeHFNP9GOGqfoItRnqPwhGWkf7XAVsGJi4Se+hEpdhrs0zw5/MO4TeSZ/F7ACNo93+UkuK11AMqzHaho4ce7AgAPmvt8O79rL0VoxDGd58O+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214349; c=relaxed/simple;
	bh=BFlBCR2vzm2uN3HsXQmPGWb1uuz6m6jbTzeYRtN63p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZz0ohYP0mO/ecFBTcEveKQvLliPJ/RWnJaDRSbiVtX/ut19E4cJuFYYOJsnkxc8AcCSra5GLFkcUjVDxZqSMIusvYZ3wEFLKOfPii02D0BmQNFDqk6lMGeYkk5vhrokRhHm39AIWE5JEo7KGqngJ53RBtd1IOCX0zPAEKY6fcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a2sy4Lpd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jU2BC5iJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2375F378EA;
	Thu,  4 Apr 2024 07:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712214346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V+X2zDngmnqBx7vb2axjhrZvkwG5Ojv0GhbbisDc+TE=;
	b=a2sy4LpdrcGHXlY/ws736AcZg2Xx1Nira5CoDEycy+ARED6CME6GaFKs9oHeMJiR4q1hi+
	m+fOz81PKsYrFYNK3shJ2Bheauarzd42+x8meN6hwrnClAh2b1vrEciR78Xve2XFK4bfRO
	qe4/SmXnKdGx75XgZTOO3G/apya5r7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712214346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V+X2zDngmnqBx7vb2axjhrZvkwG5Ojv0GhbbisDc+TE=;
	b=jU2BC5iJyShvhJebsqC1bWXteQblxHBHgJ67z9nPkOCLbHx+7hMXf1L/SOWN3oMikuenWP
	e9pOOS4CQYcOmeBg==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 871E6139E8;
	Thu,  4 Apr 2024 07:05:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gfHSHUlRDmY6cgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 04 Apr 2024 07:05:45 +0000
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
Subject: [PATCH v4 0/4] page_owner: Fix refcount imbalance and print fixup
Date: Thu,  4 Apr 2024 09:06:58 +0200
Message-ID: <20240404070702.2744-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.13 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.07)[62.57%];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,rivosinc.com,suse.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: 1.13
X-Spam-Level: *
X-Spam-Flag: NO

This series consists of a refactoring/correctness of updating the metadata
of tail pages, a couple of fixups for the refcounting part and a fixup for
the stack_start() function.

From this series on, instead of counting the stacks, we count the outstanding
nr_base_pages each stack has, which gives us a much better memory overview.
The other fixup is for the migration part.

A more detailed explanation can be found in the changelog of the respective
patches.

v3 -> v4:
 - Fix some typos remarked by Vlastimil
 - Add Reviewed-by tag from Vlastimil and Tested-by tag from Alexandre Ghiti
   (closed a syzbot report for RISC)

Oscar Salvador (4):
  mm,page_owner: Update metadata for tail pages
  mm,page_owner: Fix refcount imbalance
  mm,page_owner: Fix accounting of pages when migrating
  mm,page_owner: Fix printing of stack records

 Documentation/mm/page_owner.rst |  73 +++++++------
 mm/page_owner.c                 | 188 ++++++++++++++++++--------------
 2 files changed, 147 insertions(+), 114 deletions(-)

-- 
2.44.0


