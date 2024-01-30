Return-Path: <linux-kernel+bounces-44970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201158429CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07EC28CEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB201272CA;
	Tue, 30 Jan 2024 16:44:24 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D18612C;
	Tue, 30 Jan 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633064; cv=none; b=FhPviy5DH9frOus/+4166bIHrGEq8scv3aDhgyi+HXB8otSsksi/RNXVeNqp/6D2pAQQb7BhY5bYia7Z4jNwq/LG4fYiDw/7gnHTnzi8g9gje3GUAbBfZPPkRNZrjoZPyrisWppdypcoHIAZQ6r0A1FcUPP5h6dFMv20v09RvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633064; c=relaxed/simple;
	bh=EPy2DHEQ00iX2uFBc2R24LC3RbnhR02Iau7wKPjhTc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z6Ax20lsVb6A86M6Iozauy11gVSHVkTqayk5anDl+zvFhXPJm8qnhqjCHNKglUU780O194JvhhX/lEebd0FVOIB3VhSCNKhFU62yt5KyaxvzLgLKWaJHB60XAdh25jk2IUFaU2i84iU/8GnWxwrhEhEMLkXq2zW7id5qHecLO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1E53222E1;
	Tue, 30 Jan 2024 16:44:20 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CABEA13212;
	Tue, 30 Jan 2024 16:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /nLCJmMnuWXKWwAAn2gu4w
	(envelope-from <leeman.duncan@gmail.com>); Tue, 30 Jan 2024 16:44:19 +0000
From: Lee Duncan <leeman.duncan@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	Lee Duncan <lduncan@suse.com>
Subject: [PATCH 0/2] Ensure FCoE target interrupts work
Date: Tue, 30 Jan 2024 08:42:20 -0800
Message-Id: <cover.1706632031.git.lduncan@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_FROM(0.50)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_ENVFROM(0.00)[gmail.com];
	 TAGGED_FROM(0.00)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.40
X-Spam-Flag: NO

From: Lee Duncan <lduncan@suse.com>

Commit 1a1975551943 "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"
changed locking for fnic/FCoE, but it did so by disabling interrupts
where they weren't disabled before, and this caused FCoE targets
to go offline. Reverting that patch fixed the issue.

But to handle the problem originally addressed by the commit,
instead of modifying the locking, move the work to be done
into a work queue.

Lee Duncan (1):
  Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Hannes Reinecke (1):
  fnic: move fnic_fnic_flush_tx() to a work queue

 drivers/scsi/fcoe/fcoe_ctlr.c | 20 ++++++++------------
 drivers/scsi/fnic/fnic.h      |  3 ++-
 drivers/scsi/fnic/fnic_fcs.c  |  3 ++-
 drivers/scsi/fnic/fnic_main.c |  1 +
 drivers/scsi/fnic/fnic_scsi.c |  4 ++--
 5 files changed, 15 insertions(+), 16 deletions(-)

-- 
2.43.0


