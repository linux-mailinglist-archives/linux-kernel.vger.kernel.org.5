Return-Path: <linux-kernel+bounces-131749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568FD898B67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DD6B22797
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8E812B159;
	Thu,  4 Apr 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YvCd9a4x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3anlJ1K2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OXCfHVUq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a/3xHjsv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41448129E66
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245511; cv=none; b=ctfO+0FTfsp2MTmfIoGTaPDLJ23twK6tB0gi8puS801lSb7F6l60U97IkmSduklLI78+gSd0yNA9AurzyfmusPkVFS3yIe0ZbMDefZQ4zCBeUmzbKTx7II14A9437ItRKlVWwLgEhOj0AvK1CFdfeqUkafyL3YptmfuAxazREiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245511; c=relaxed/simple;
	bh=konrS3PhfztvIx3bEw+f451qghlpR6Cm4TFvysrJ9Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vm9Ib+3xdEAAwVysrwKvcO/aebYlb3xOUIxvyirpeZrWjJ+4DSYooda+R7GhUWMAqfHiIHVROSeXJMffoQQBrD9Bm/6PtaUBzsYi28vhOmRU6SKmJ7xIpVvgFwN9N1P36jXjJggVmUkb/I+XHUpa4ZyztBXGzQTzWeLuQT8e3Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YvCd9a4x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3anlJ1K2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OXCfHVUq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a/3xHjsv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD0CB5F8A6;
	Thu,  4 Apr 2024 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712245507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uVo10kz89o1MerHSNdsoxdo91ntoYyDbukfjJjRlFvM=;
	b=YvCd9a4xXD4Vfov9r8Hq/a09gIv7ND3DZeVqCvuGHiOsvn45N6lVey2c1fq8fG1I2J1kWR
	9Yc8gBtLYhL0l9nkwrv7O/RytBxXmTWjZZZYIDWcCWX/KyHs07xeavNsbETSFUxYWsdscN
	8LmPpqOVVs7sGWYHYJAGdp09Qp18opw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712245507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uVo10kz89o1MerHSNdsoxdo91ntoYyDbukfjJjRlFvM=;
	b=3anlJ1K2pPehBf/PVAnF4VSmLBGHNd/155UW7lTBliD0LudBmZG0mNgcO+UlL7dQCHlmVU
	Roiwfy1k+VOWqrBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712245506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uVo10kz89o1MerHSNdsoxdo91ntoYyDbukfjJjRlFvM=;
	b=OXCfHVUqZHTTeGijXRik7Trbt3v7bD/tE9ZIEhZOfGTvs3w1qLOIOkQ2+7F74OoRd8+rzQ
	EWucDOogsycPxpoJ4RSbKKiBzVysvxCpRexJshj+ruYvEz4s/YQm87WUinAye+3dTBl2zU
	14HnvaMhlQv7faFlm9mpX6Qcy34Emv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712245506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uVo10kz89o1MerHSNdsoxdo91ntoYyDbukfjJjRlFvM=;
	b=a/3xHjsvgxYfRiqVMA2E3yjdTVbS9K5mrJsudmsDZG8g2yX8aL+2ODz90oA7xeC+r7tfyY
	6shryOt7sl9nuMDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B31A139E8;
	Thu,  4 Apr 2024 15:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id E9mSJALLDmYAIgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 15:45:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 0/5] nvme-fabrics: short-circuit connect retries
Date: Thu,  4 Apr 2024 17:44:55 +0200
Message-ID: <20240404154500.2101-1-dwagner@suse.de>
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
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.80
X-Spam-Flag: NO

An rebase of Hannes two series which fix the TCP and RDMA transport to handle
the DNR bit on connect attempts.

For testing I extended the nvme/045 test case. I'll update the test case later
when the current batch of blktest changes are done. Also this change depends on
the extension of the debugfs interface of nvmet, which is also not yet merged.

	echo "Renew host key on the controller and force reconnect"

	new_hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"

	_set_nvmet_hostkey "${def_hostnqn}" "${new_hostkey}"

	# Force a reconnect
	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
	cntlid="$(nvme id-ctrl "/dev/${nvmedev}" | grep cntlid | awk '{print $3}')"
	echo "fatal" > /sys/kernel/debug/nvmet/"${def_subsysnqn}/ctrl$((${cntlid}))"/state
	nvmf_wait_for_ctrl_delete "${nvmedev}"


baseline:

run 1 loop (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  2.690s  ...  2.777s
run 1 tcp (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [failed]
    runtime  2.777s  ...  8.030s
    --- tests/nvme/045.out      2024-04-04 16:14:22.547250311 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/045.out.bad 2024-04-04 17:29:03.427799336 +0200
    @@ -9,5 +9,6 @@
     Change hash to hmac(sha512)
     Re-authenticate with changed hash
     Renew host key on the controller and force reconnect
    -disconnected 0 controller(s)
    +controller "nvme2" not deleted within 5 seconds
    +disconnected 1 controller(s)
     Test complete
run 1 rdma (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [failed]
    runtime  8.030s  ...  9.632s
    --- tests/nvme/045.out      2024-04-04 16:14:22.547250311 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/045.out.bad 2024-04-04 17:29:15.017745115 +0200
    @@ -9,5 +9,6 @@
     Change hash to hmac(sha512)
     Re-authenticate with changed hash
     Renew host key on the controller and force reconnect
    -disconnected 0 controller(s)
    +controller "nvme2" not deleted within 5 seconds
    +disconnected 1 controller(s)
     Test complete
run 1 fc (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  9.632s  ...  3.588s


patched:

run 1 loop (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  6.816s  ...  2.492s
run 1 tcp (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  2.492s  ...  3.663s
run 1 rdma (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  3.663s  ...  3.795s
run 1 fc (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  3.795s  ...  2.690s



changes:
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


*** BLURB HERE ***

Hannes Reinecke (5):
  nvme: authentication error are always non-retryable
  nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
  nvmet: return DHCHAP status codes from nvmet_setup_auth()
  nvme-tcp: short-circuit reconnect retries
  nvme-rdma: short-circuit reconnect retries

 drivers/nvme/host/core.c               |  6 +++---
 drivers/nvme/host/fabrics.c            | 29 +++++++++++++++-----------
 drivers/nvme/host/nvme.h               | 19 ++++++++++++++++-
 drivers/nvme/host/rdma.c               | 22 ++++++++++++-------
 drivers/nvme/host/tcp.c                | 23 +++++++++++++-------
 drivers/nvme/target/auth.c             | 20 ++++++++----------
 drivers/nvme/target/configfs.c         | 22 ++++++++++++++-----
 drivers/nvme/target/fabrics-cmd-auth.c | 11 +++++-----
 8 files changed, 100 insertions(+), 52 deletions(-)

-- 
2.44.0


