Return-Path: <linux-kernel+bounces-91857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAAE871783
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4876288D46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE77E7EEF8;
	Tue,  5 Mar 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ErCAgTyZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ydUnvDrl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ErCAgTyZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ydUnvDrl"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629027E112
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625613; cv=none; b=VoX2PRjRs5VW9rZCQsTSohsUvm8JsQ4O6z9q+jGdc/hom5l4N0713jlOakAenD6tIu8YaAQl07U3mXANn7B4kNNLeptU39NBwrkLdiVa/2hKWXgzXiyr3Mze2GRVyC38kfKZGVyWjpHcyUPfVoUCZGt4ACOH4aYRLjxsFW/usN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625613; c=relaxed/simple;
	bh=E3ZdWQOv8NqX78M7lCfxK9sqyigsipCJUOCaDqYMdio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJU2fQvg1QXJLsI+5w+np002O2rrMTxuSVPC4ALOnUEXvP+GXVlBU2xgujkQyVl9VgHgI73jLyr40Ig6j9nAa5S/N+TdhEzCUwEEqf/qB+jE0KdZbvWdY1gYa0xWh+2lJ+sJm6MmU64Sgx/ivckPGsXQfExMkB67Vf5tbbnHBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ErCAgTyZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ydUnvDrl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ErCAgTyZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ydUnvDrl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68A233F43B;
	Tue,  5 Mar 2024 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709625609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyH7PV9Y+HU6YteN7n/jOhE0Tv1Rk9CDVFNqMbqJmnM=;
	b=ErCAgTyZpz4FpeJ3QMYYYx3CgqYSjF8Y20d61DWBcnYOwIYQylS4UFWDsrKF6q0Y+Df+qU
	pso82TAmA3c2DM8lxanaxAxHhlrNa1B+LYdHDNiB88hIAwFgCXfN+gje7gPSajfY7WmlMC
	l3JlGkafoNZ75IZF3jZ7mLCnwPLfGKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709625609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyH7PV9Y+HU6YteN7n/jOhE0Tv1Rk9CDVFNqMbqJmnM=;
	b=ydUnvDrlzBbBfLyN+NLQ3muK0ZhGfLQgNscsYM11TtqubEV12eQxWA7EgKOFCPBLzEIPUL
	TI/97O0P9yginIAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709625609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyH7PV9Y+HU6YteN7n/jOhE0Tv1Rk9CDVFNqMbqJmnM=;
	b=ErCAgTyZpz4FpeJ3QMYYYx3CgqYSjF8Y20d61DWBcnYOwIYQylS4UFWDsrKF6q0Y+Df+qU
	pso82TAmA3c2DM8lxanaxAxHhlrNa1B+LYdHDNiB88hIAwFgCXfN+gje7gPSajfY7WmlMC
	l3JlGkafoNZ75IZF3jZ7mLCnwPLfGKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709625609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyH7PV9Y+HU6YteN7n/jOhE0Tv1Rk9CDVFNqMbqJmnM=;
	b=ydUnvDrlzBbBfLyN+NLQ3muK0ZhGfLQgNscsYM11TtqubEV12eQxWA7EgKOFCPBLzEIPUL
	TI/97O0P9yginIAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E8CC13A5D;
	Tue,  5 Mar 2024 08:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1ROaEgnR5mW1UQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 05 Mar 2024 08:00:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 0/2] nvme-fabrics: short-circuit connect retries 
Date: Tue,  5 Mar 2024 09:00:03 +0100
Message-ID: <20240305080005.3638-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: **
X-Spam-Score: 2.81
X-Spamd-Result: default: False [2.81 / 50.00];
	 ARC_NA(0.00)[];
	 SUBJECT_ENDS_SPACES(0.50)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.39)[90.79%]
X-Spam-Flag: NO

I've picked up Hannes' DNR patches. In short the make the transports behave the
same way when the DNR bit set on a re-connect attempt. We had a discussion this
topic in the past and if I got this right we all agreed is that the host should
honor the DNR bit on a connect attempt [1]

The nvme/045 test case (authentication tests) in blktests is a good test case
for this after extending it slightly. TCP and RDMA try to reconnect with an
invalid key over and over again, while loop and FC stop after the first fail.

[1] https://lore.kernel.org/linux-nvme/20220927143157.3659-1-dwagner@suse.de/

changes:
v3:
  - added my SOB tag
  - fixed indention

v2:
  - refresh/rebase on current head
  - extended blktests (nvme/045) to cover this case
    (see separate post)
  - https://lore.kernel.org/linux-nvme/20240304161006.19328-1-dwagner@suse.de/
  
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20210623143250.82445-1-hare@suse.de/

Hannes Reinecke (2):
  nvme-tcp: short-circuit reconnect retries
  nvme-rdma: short-circuit reconnect retries

 drivers/nvme/host/rdma.c | 22 +++++++++++++++-------
 drivers/nvme/host/tcp.c  | 23 +++++++++++++++--------
 2 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.44.0


