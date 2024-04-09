Return-Path: <linux-kernel+bounces-136571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2982C89D5A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2C3B23B23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C080027;
	Tue,  9 Apr 2024 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fFKQLJxF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FNABl6cJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KtPOUBoJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gkScyaKV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5CE7FBB7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655318; cv=none; b=PlGFYeOidpKECQKNQ52NFX3UTAFikCoG8Q1UZZRdS62bGRsQCs6Nun1FEOpcCunW9VWMSV8K6f1ZMhtNFSfaDI1W3IHLJmj70ODCCcxcq2HIuHQ+hnpSMlk5snEubZKgtjcHB6hOC/3xivubB6S3tAQZkuYT1209lfIMNwxl6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655318; c=relaxed/simple;
	bh=W4G1L4cCnOa4i8P36RJ4sjCMcziVLH98tb8WqTxnQiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9Q7BIP+rl5NAvoaSCZPpyLFKH+REH6EfgLh7LTtTjMD3J1MhzuC05VirzLENMIKFit1SplRKbeD9gW59gBrRk0sh1tyv4NUQE3Gf7iUcElKmKWCfr3ZMmHQZNRwA840tju8Cz03skVv1W79hinLxuW0Zu1jrVPWL6JjBB9Gi9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fFKQLJxF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FNABl6cJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KtPOUBoJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gkScyaKV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6A49338F0;
	Tue,  9 Apr 2024 09:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nUZ9ROs7tpTwP9jEjvqFK44yrx0e5Jmd5Sv60LZqK4I=;
	b=fFKQLJxF5Sx9Z3WCfDQGHeQqkPfTBdPiVS9uaQu0ZmROvDf6pGO6QcVstd2qYpEeiig+TK
	tEn2Ljx7YENoCfxW8C4ca+ikub6UBXlIWEnBHf1z/Zje83fX4MhLagrQTBpXIpTcWAubDp
	PcIhcq7CzWd7Ft3/V+WxC8HY/BFdkXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nUZ9ROs7tpTwP9jEjvqFK44yrx0e5Jmd5Sv60LZqK4I=;
	b=FNABl6cJGpeEBQlBU/K8Mm09lKZzNt788E9+9MYt1gI/5LQtNb/wyn3Jd2G6hJV6mIxIyD
	QO7xh8Oy1gBBsIAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nUZ9ROs7tpTwP9jEjvqFK44yrx0e5Jmd5Sv60LZqK4I=;
	b=KtPOUBoJmAiexeFmHfU8KA1zrBu/2kSzD5CRBSH7RJCFm2UYWKdvOaSFFxUzFAWTtLbWDB
	2NsOX2TOCeLJb2Ix4tY+tiXGYKWfWinE0Um4NWHszr6XHLmnzKMHYMwdqEuNjnFTf0FoA+
	Gb6moj7hScC1HYaLeRHqF2/cdfaN0sY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nUZ9ROs7tpTwP9jEjvqFK44yrx0e5Jmd5Sv60LZqK4I=;
	b=gkScyaKVjDdusLWMjbQaatRFk/hyna8IDDuS1PE+rgpQBinJu39SYTbW3Ellcyjj2u3Ktn
	qcNTy0jSMErfrhAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BF7A81332F;
	Tue,  9 Apr 2024 09:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +bcWLtILFWafRwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 09 Apr 2024 09:35:14 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 0/6]  nvme-fabrics: short-circuit connect retries
Date: Tue,  9 Apr 2024 11:35:04 +0200
Message-ID: <20240409093510.12321-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The first patch returns only kernel error codes now and avoids overwriting error
codes later. Thje newly introduced helper for deciding if a reconnect should be
attempted is the only place where we have the logic (and documentation).

On the target side I've separate the nvme status from the dhchap status handling
which made it a bit clearer. I was tempted to refactor the code in
nvmet_execute_auth_send to avoid hitting the 80 chars limit but didn't came up
with something nice yet. So let's keep this change at a minimum before any
refactoring attempts.

I've tested with blktests and also an real hardware for nvme-fc.

changes:
v5:
  - nvme: do not mix kernel error code with nvme status
  - nvmet: separate nvme status from dhchap status
  - https://lore.kernel.org/all/20240404154500.2101-1-dwagner@suse.de/

v4:
  - rebased
  - added 'nvme: fixes for authentication errors' series
    https://lore.kernel.org/linux-nvme/20240301112823.132570-1-hare@kernel.org/

v3:
  - added my SOB tag
  - fixed indention
  - https://lore.kernel.org/linux-nvme/20240305080005.3638-1-dwagner@suse.de/

v2:
  - refresh/rebase on current head
  - extended blktests (nvme/045) to cover this case
    (see separate post)
  - https://lore.kernel.org/linux-nvme/20240304161006.19328-1-dwagner@suse.de/
  
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20210623143250.82445-1-hare@suse.de/


Daniel Wagner (1):
  nvme-fc: use nvme_ctrl_reconnect to decide reconnect attempts

Hannes Reinecke (5):
  nvme: authentication error are always non-retryable
  nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
  nvme-tcp: short-circuit reconnect retries
  nvme-rdma: short-circuit reconnect retries
  nvmet: return DHCHAP status codes from nvmet_setup_auth()

 drivers/nvme/host/core.c               |  6 ++--
 drivers/nvme/host/fabrics.c            | 25 ++++++-------
 drivers/nvme/host/fc.c                 |  4 +--
 drivers/nvme/host/nvme.h               | 26 +++++++++++++-
 drivers/nvme/host/rdma.c               | 22 ++++++++----
 drivers/nvme/host/tcp.c                | 23 +++++++-----
 drivers/nvme/target/auth.c             | 22 ++++++------
 drivers/nvme/target/configfs.c         | 22 +++++++++---
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++++++-------------
 drivers/nvme/target/fabrics-cmd.c      | 11 +++---
 drivers/nvme/target/nvmet.h            |  8 ++---
 11 files changed, 134 insertions(+), 84 deletions(-)

-- 
2.44.0


