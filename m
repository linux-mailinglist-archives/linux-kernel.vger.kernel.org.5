Return-Path: <linux-kernel+bounces-71386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1CA85A475
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B15AB2251A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3DD36129;
	Mon, 19 Feb 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yJY5W4nP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PHvv8t4+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yJY5W4nP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PHvv8t4+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3F2D05E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348537; cv=none; b=OpR+3C712xHRvSYPNrbBvbWFRGLFpf3spCMzsR/88Egs0U+YEhFP7TRHIIicAXwSnoCY++xHo7/zB+Qt0bh25RMvKiRZ1NKkyEOugbppMx7O9t8kfvguUxbXeAU2b2FQ8frpbMb4HB7kx5eF88ViXRqM1KEzKM0RIRl582sgB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348537; c=relaxed/simple;
	bh=RHCe6FPajqwF7Q8uYBoEBW4Yd8S9mGO+uwC+YSsnYFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pM+sPTE79ZKx6x4kMchFJK6BOnO9xBr7s9hGMcFY34E7vF1pBFIUnRywNzBgZ2QWEAgPGNfRZVeqxjPAIJWz0dChgSpE4JC48Rw1ucnZZ/EWkCwp5vdNF7iiK4zc2F347DX/ETIojQ3jWUYDPALlQfpOcK0xGxqmCYqbw1ecwFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yJY5W4nP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PHvv8t4+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yJY5W4nP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PHvv8t4+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FAF821DF1;
	Mon, 19 Feb 2024 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5EyMVdXXxhNc2ezMbCFmBs8mUlofzAqan8kAI7uhmc=;
	b=yJY5W4nPGU6Ze3DkQHAD9GkzYwPrLXb1xk0AAyzz5CKEqxycKCnd4Dy/9w3vn/eF2fhz46
	zcVlFUSVZCNaiRlTCG+jTTouKYpuTlmThhWzZyEY7KnPatCsUYczud1QQoDH02hhZnJ32z
	W/SRDvyHMuaH+4u90AZrvTo6sCpwR0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5EyMVdXXxhNc2ezMbCFmBs8mUlofzAqan8kAI7uhmc=;
	b=PHvv8t4+rHhV9q790jaKpq03kTYi9g+bod7oVrzpcXGOxx3EXBUeT973h2X+Y9O4OoHmYu
	CANxfNFTuoDlBzDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5EyMVdXXxhNc2ezMbCFmBs8mUlofzAqan8kAI7uhmc=;
	b=yJY5W4nPGU6Ze3DkQHAD9GkzYwPrLXb1xk0AAyzz5CKEqxycKCnd4Dy/9w3vn/eF2fhz46
	zcVlFUSVZCNaiRlTCG+jTTouKYpuTlmThhWzZyEY7KnPatCsUYczud1QQoDH02hhZnJ32z
	W/SRDvyHMuaH+4u90AZrvTo6sCpwR0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5EyMVdXXxhNc2ezMbCFmBs8mUlofzAqan8kAI7uhmc=;
	b=PHvv8t4+rHhV9q790jaKpq03kTYi9g+bod7oVrzpcXGOxx3EXBUeT973h2X+Y9O4OoHmYu
	CANxfNFTuoDlBzDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BC7F139C6;
	Mon, 19 Feb 2024 13:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id bOXGHHVU02X2AgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 19 Feb 2024 13:15:33 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 0/6] nvme-fc: fix blktests nvme/041
Date: Mon, 19 Feb 2024 14:15:25 +0100
Message-ID: <20240219131531.15134-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yJY5W4nP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PHvv8t4+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.86)[94.17%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: 1.63
X-Rspamd-Queue-Id: 8FAF821DF1
X-Spam-Flag: NO

I've dropped the rport ref counting change in the main patch and gave it another
round of testing. This time with dev_loss_tmo active with SCSI and NVME enabled
on the same rport. Nothing exploded, all resources were released correctly.

I am not so happy with the 'connect_sync' name yet (patch #1) but we still have
to agree on that offloading the initial connect attemp is correct. James and
Hannes are strongly in favour for this approach as far I can tell.

changes:
v1:
 - renamed 'nvme-fc: redesign locking and refcounting'
   to 'nvme-fc: reorder ctrl ref counting and cleanup code path'
 - testing with scsi/nvme dev_loss_tmo on real hw
 - removed rport ref counting part
 - collected RB tags
v0:
 - initial version
 - https://lore.kernel.org/linux-nvme/20240216084526.14133-1-dwagner@suse.de/

Daniel Wagner (6):
  nvme-fabrics: introduce connect_sync option
  nvme-fc: rename free_ctrl callback to match name pattern
  nvme-fc: do not retry when auth fails or connection is refused
  nvme-fabrics: introduce ref counting for nvmf_ctrl_options
  nvme-fc: reorder ctrl ref counting and cleanup code path
  nvme-fc: wait for connect attempt to finish

 drivers/nvme/host/fabrics.c |  28 ++++++-
 drivers/nvme/host/fabrics.h |   9 ++-
 drivers/nvme/host/fc.c      | 145 +++++++++++++++++-------------------
 drivers/nvme/host/rdma.c    |  18 +++--
 drivers/nvme/host/tcp.c     |  21 ++++--
 drivers/nvme/target/loop.c  |  19 +++--
 6 files changed, 141 insertions(+), 99 deletions(-)

-- 
2.43.1


