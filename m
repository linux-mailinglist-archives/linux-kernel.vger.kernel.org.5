Return-Path: <linux-kernel+bounces-163981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9558B76CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6DA9B2367B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886A171E70;
	Tue, 30 Apr 2024 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XqKNPmxV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+cGZ9RCy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XqKNPmxV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+cGZ9RCy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDFC171E40
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483178; cv=none; b=S3i11OwJ8aUwulVlZmnzUi7OZr+6bm7AyiGcDK0nJ+GgRfsoy1vmamTe2Lhgg0/8F2N3LDNl5EwATIh2MZCCyrnEw/Y92d2hd8rIsfAYfnpkzpj2Dz3xzPQbyktOSzRUXafYZgtkHYE5YVXq75WFOlmvU18ttTNEx8nuXujJtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483178; c=relaxed/simple;
	bh=fqXn07NJ7GE3yV1s+ytTihFNdpEBLH0EaqCNH1hPBtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4p0fApxORDbX/cWpYpZj0KXROZhnsJ0wWsRSVvOA2hhOMrRG1ZCMdBI13BC5xak1MFKfMqTsQlmGikAwfKObrsCorfvWp49a7vFvgumhp0xeicBmynLPW//9/a6eOKwwLQLt3ozq8foQMhri6ZRTEDgjKuOr6hm9f2pGYmQ+BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XqKNPmxV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+cGZ9RCy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XqKNPmxV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+cGZ9RCy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 622C91F7E3;
	Tue, 30 Apr 2024 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714483175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hP3+rSE6dC1kyvM4PrsVsdM9kaG51YId12Fi+b44hcM=;
	b=XqKNPmxVbiW1ma3f5nSK4ojPJovfZdxxRlSBljL6bzxex075dvFUL81+hYyCV2/K5fX50p
	bSvWcfzVFIWL+FKEljz5p9Tl4h6c2B+nsEh1tT7rUXJoZDOhmllHDm3u8ZWtdq1F+fSvuk
	Fnp9nyoAofBsaEOTR4X+P0N1BXqAQgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714483175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hP3+rSE6dC1kyvM4PrsVsdM9kaG51YId12Fi+b44hcM=;
	b=+cGZ9RCyuylUPb1e/HJB/Z2fU/Ssz7jqsHk54J1+9nZr8CC0WoAvquxQe90Gv/d/HFtqld
	BfG9U2yIejIiGgAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XqKNPmxV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+cGZ9RCy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714483175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hP3+rSE6dC1kyvM4PrsVsdM9kaG51YId12Fi+b44hcM=;
	b=XqKNPmxVbiW1ma3f5nSK4ojPJovfZdxxRlSBljL6bzxex075dvFUL81+hYyCV2/K5fX50p
	bSvWcfzVFIWL+FKEljz5p9Tl4h6c2B+nsEh1tT7rUXJoZDOhmllHDm3u8ZWtdq1F+fSvuk
	Fnp9nyoAofBsaEOTR4X+P0N1BXqAQgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714483175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hP3+rSE6dC1kyvM4PrsVsdM9kaG51YId12Fi+b44hcM=;
	b=+cGZ9RCyuylUPb1e/HJB/Z2fU/Ssz7jqsHk54J1+9nZr8CC0WoAvquxQe90Gv/d/HFtqld
	BfG9U2yIejIiGgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F747133A7;
	Tue, 30 Apr 2024 13:19:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gyT2EefvMGZgMAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 30 Apr 2024 13:19:35 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 0/5] nvme-fabrics: short-circuit connect retries
Date: Tue, 30 Apr 2024 15:19:23 +0200
Message-ID: <20240430131928.29766-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 622C91F7E3
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]

I've splitted the last patch into the hopefully non controversial part 'do not
retry when DNR is set' and the 'don't retry auth failures'. I hope we can get at
least the first few patches in and have a lively discussion on the final patch
at LSF.

changes:
v7:
 - updated commit message patch #3
 - split last patch so that only the DNR checks
   are added first and then the auth reconnect failure test

v6:
  - reorder series
  - extended nvmf_should_reconnect
  - added auth retry logic
  - https://lore.kernel.org/linux-nvme/20240415124220.5433-1-dwagner@suse.de/
  
v5:
  - nvme: do not mix kernel error code with nvme status
  - nvmet: separate nvme status from dhchap status
  - https://lore.kernel.org/linux-nvme/20240409093510.12321-1-dwagner@suse.de/

v4:
  - rebased
  - added 'nvme: fixes for authentication errors' series
  - https://lore.kernel.org/all/20240404154500.2101-1-dwagner@suse.de/

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
  nvme: do not retry authentication failures

Hannes Reinecke (4):
  nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
  nvmet: return DHCHAP status codes from nvmet_setup_auth()
  nvme: return kernel error codes for admin queue connect
  nvme-fabrics: short-circuit reconnect retries

 drivers/nvme/host/auth.c               |  6 +--
 drivers/nvme/host/core.c               |  6 +--
 drivers/nvme/host/fabrics.c            | 51 ++++++++++++++++----------
 drivers/nvme/host/fabrics.h            |  2 +-
 drivers/nvme/host/fc.c                 |  4 +-
 drivers/nvme/host/nvme.h               |  2 +-
 drivers/nvme/host/rdma.c               | 19 ++++++----
 drivers/nvme/host/tcp.c                | 22 +++++++----
 drivers/nvme/target/auth.c             | 22 +++++------
 drivers/nvme/target/configfs.c         | 22 ++++++++---
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++++++------------
 drivers/nvme/target/fabrics-cmd.c      | 11 +++---
 drivers/nvme/target/nvmet.h            |  8 ++--
 13 files changed, 129 insertions(+), 95 deletions(-)

-- 
2.44.0


