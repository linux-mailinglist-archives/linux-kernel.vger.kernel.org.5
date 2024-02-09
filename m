Return-Path: <linux-kernel+bounces-59764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6BD84FB86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408011F22D2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DB680BF2;
	Fri,  9 Feb 2024 18:07:49 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186B7EEE7;
	Fri,  9 Feb 2024 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502069; cv=none; b=TvrHhth7LXMArAVBjc2aISGEP9gmdeJrWeYFk91D7hNVc2XHF8o1De93VIYeJvTJqxOufKjTC4IaE1EdzKtDsCuyxrtjula2Nt2Z3gBCptf6V9/ORCkfB7hgMVyYS7bL/2QczMmi/wJQaJ7P31PDCkRBVTkgcLc70SJ87e2r8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502069; c=relaxed/simple;
	bh=MX0tzE8nnND6hj2IoJyHqla21d5eDqH6UJy0UtwJC/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TQvsTjPGIOoVM8BsvYZAodunsZGcrT2hqFj/6UxcJDFoFyiPUtKMM0aWX0fDaUVZFP9oTsUDExhrhBS5OLLe2NhAjg/PPOKFNYvxVy1ASetaZ5YAi9k2m1biTm+Zk1WlAjLCgWvfGaAIfMX/qYScmJyYNNZaGKUFaBOT03JzU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D283A1F821;
	Fri,  9 Feb 2024 18:07:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 098AC139E7;
	Fri,  9 Feb 2024 18:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jiAoM+9pxmVHNgAAD6G6ig
	(envelope-from <leeman.duncan@gmail.com>); Fri, 09 Feb 2024 18:07:43 +0000
From: Lee Duncan <leeman.duncan@gmail.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chengfeng Ye <dg573847474@gmail.com>,
	hare@suse.de,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Lee Duncan <lduncan@suse.com>
Subject: [PATCH v4 0/2] Ensure FCoE target interrupts work correctly
Date: Fri,  9 Feb 2024 10:07:33 -0800
Message-Id: <cover.1707500786.git.lduncan@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.39 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_FROM(0.50)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.989];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_ENVFROM(0.00)[gmail.com];
	 BAYES_HAM(-3.00)[100.00%];
	 TAGGED_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_DKIM_NA(2.20)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[gmail.com,suse.de,cisco.com,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 2.39
X-Rspamd-Queue-Id: D283A1F821
X-Spam-Flag: NO

From: Lee Duncan <lduncan@suse.com>

Commit 1a1975551943 "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"
changed locking for fnic/FCoE, but it did so by disabling interrupts
where they weren't disabled before, and this caused FCoE targets
to go offline. Reverting that patch fixed the issue.

But to handle the problem originally addressed by the commit,
instead of modifying the locking, move the work to be done
into a work queue.

Differences in v4:
  - Corrected "Fixes" attributes in both patches
  - Added identifier name in fnic_flush_tx() prototype, for checkpatch

Differences in v3:
  - Added "fixes" clause to the fnic patch, as requested by Hannes

Differences in V2:
  - Fix kerneldoc comments in fnic_flush_tx()

Lee Duncan (1):
  Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Hannes Reinecke (1):
  fnic: move fnic_fnic_flush_tx() to a work queue

 drivers/scsi/fcoe/fcoe_ctlr.c | 20 ++++++++------------
 drivers/scsi/fnic/fnic.h      |  3 ++-
 drivers/scsi/fnic/fnic_fcs.c  |  5 +++--
 drivers/scsi/fnic/fnic_main.c |  1 +
 drivers/scsi/fnic/fnic_scsi.c |  4 ++--
 5 files changed, 16 insertions(+), 17 deletions(-)

-- 
2.35.3


