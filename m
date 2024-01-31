Return-Path: <linux-kernel+bounces-46067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB08439F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1377B1F2DA40
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F4379DB5;
	Wed, 31 Jan 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tpqXDcZO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YqrkzlGg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tpqXDcZO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YqrkzlGg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E579929
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691085; cv=none; b=mUmJ70eH0jWqgWLClJ3r4XN1IKdZRKu3hhgrmK6Rx1IUCfrlJU62ckDH8gMX/heE1RFCJU1t24cEBfZqZPr+4wkk9z7pt6n1bduIhexyO01FdKRMjmCWaTTW4DOef/OQ+S7N2/djv40Vpk8LpNTY+7+YJOPaqCpdxRJL6uhiYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691085; c=relaxed/simple;
	bh=Rg9m14I/ih8Is5+xPcKnsSH5vfPSYydeTSQvRrbWICo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gXYFhr71zQOFKC9qHyTDEK8UvfG2bSVvqZ5MxLXLglBCZ2VP0mLTHLd+p1Hk880HUGKuGREZjdwQIbDo6hc0BQcjOQ0Bw5G/NV4okiM9LGvzJKC7Jxa/WVQK9VIAS+lShytLG5oePnADh8BueedzHoC7gwr62yCkIeQodokOW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tpqXDcZO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YqrkzlGg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tpqXDcZO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YqrkzlGg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 594C71FB67;
	Wed, 31 Jan 2024 08:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BieBWsCtqWyH4j5VyGe8g8zojEt5iSUI/+4ITuzN+GQ=;
	b=tpqXDcZOMYq/ZnMQGDJq8Zoxieup1+2cyTIyHs4Yj8CVYV7v3YaXK1eQ7O3U90ot/pVhgO
	UmaAvddGScIE3KEqSyV+kPxk6tZrOgOeQnOXUe2qLAofx7F6cQ91i6o+rGNiJpMdMLHQqq
	uqJJTz7A6t3l3YYL6PMdg7tSa5HWvJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BieBWsCtqWyH4j5VyGe8g8zojEt5iSUI/+4ITuzN+GQ=;
	b=YqrkzlGgpAa96MWgdBi3KNUpoDBKCpEORT8ptgePtOdbjodHwBqOOUbjV8cckD7UKvzqjy
	nQohjhkYUJEeXoCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BieBWsCtqWyH4j5VyGe8g8zojEt5iSUI/+4ITuzN+GQ=;
	b=tpqXDcZOMYq/ZnMQGDJq8Zoxieup1+2cyTIyHs4Yj8CVYV7v3YaXK1eQ7O3U90ot/pVhgO
	UmaAvddGScIE3KEqSyV+kPxk6tZrOgOeQnOXUe2qLAofx7F6cQ91i6o+rGNiJpMdMLHQqq
	uqJJTz7A6t3l3YYL6PMdg7tSa5HWvJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BieBWsCtqWyH4j5VyGe8g8zojEt5iSUI/+4ITuzN+GQ=;
	b=YqrkzlGgpAa96MWgdBi3KNUpoDBKCpEORT8ptgePtOdbjodHwBqOOUbjV8cckD7UKvzqjy
	nQohjhkYUJEeXoCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 42801132FA;
	Wed, 31 Jan 2024 08:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3YaJDwkKumVyHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:21 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 00/12] enable nvmet-fc for blktests
Date: Wed, 31 Jan 2024 09:51:00 +0100
Message-ID: <20240131085112.21668-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tpqXDcZO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YqrkzlGg
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 594C71FB67
X-Spam-Flag: NO

I've added Christophs' RBs and refactored the last patch as suggested. IMO, it
makes it more readable, so a win :)

Also I'd run some more tests, e.g. with KASAN dissabled to see if we hit some
other races but all looks good. There are still a bunch of fallouts (e.g. my
test systems seems to be broken for the AUTH tests). But as said, it doesn't
hang or produces any crahses anymore.

nvme/002 (create many subsystems and test discovery)         [not run]
    nvme_trtype=fc is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller)
    runtime  11.470s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  11.470s  ...  11.399s
nvme/004 (test nvme and nvmet UUID NS descriptors)          
    runtime  0.580s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  0.580s  ...  0.467s
nvme/005 (reset local loopback target)                      
    runtime  0.653s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/005 (reset local loopback target)                       [passed]
    runtime  0.653s  ...  0.574s
nvme/006 (create an NVMeOF target with a block device-backed ns)
    runtime  0.187s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.187s  ...  0.133s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.146s  ...  0.089s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.576s  ...  0.429s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  0.515s  ...  0.411s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns)
    runtime  8.543s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  8.543s  ...  4.541s
nvme/011 (run data verification fio job on NVMeOF file-backed ns)
    runtime  26.668s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  26.668s  ...  8.701s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns)
    runtime  16.517s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  16.517s  ...  5.739s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns)
    runtime  28.152s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  28.152s  ...  8.771s
nvme/014 (flush a NVMeOF block device-backed ns)            
    runtime  3.492s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  3.492s  ...  2.401s
nvme/015 (unit test for NVMe flush for file backed ns)      
    runtime  2.952s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  2.952s  ...  1.962s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    nvme_trtype=fc is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    nvme_trtype=fc is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend)
    runtime  0.607s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  0.607s  ...  0.468s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns)
    runtime  0.613s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  0.613s  ...  0.534s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns)
    runtime  0.583s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  0.583s  ...  0.495s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)  
    runtime  0.559s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  0.559s  ...  0.486s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns) 
    runtime  0.726s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  0.726s  ...  0.618s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns)
    runtime  0.637s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  0.637s  ...  0.504s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns)
    runtime  0.635s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  0.635s  ...  0.490s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns)
    runtime  0.581s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  0.581s  ...  0.479s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns)
    runtime  0.576s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  0.576s  ...  0.463s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns)
    runtime  0.663s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  0.663s  ...  0.492s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns)
    runtime  0.577s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  0.577s  ...  0.501s
nvme/029 (test userspace IO via nvme-cli read/write interface)
    runtime  0.885s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  0.885s  ...  0.653s
nvme/030 (ensure the discovery generation counter is updated appropriately)
nvme/030 (ensure the discovery generation counter is updated appropriately) [failed]
    runtime  0.677s  ...  0.505sc device: nvme0
    --- tests/nvme/030.out      2023-08-30 10:39:08.428409596 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/030.out.bad 2024-01-31 09:40:26.552302587 +0100
    @@ -1,2 +1,7 @@
     Running nvme/030
    +warning: use generated hostid instead of hostid file
    +warning: use generated hostid instead of hostid file
    +warning: use generated hostid instead of hostid file
    +warning: use generated hostid instead of hostid file
    +warning: use generated hostid instead of hostid file
     Test complete
nvme/031 (test deletion of NVMeOF controllers immediately after setup)
    runtime  3.622s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  3.622s  ...  2.907s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.085s  ...  0.036s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O)
    runtime  6.757s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  6.757s  ...  6.555s
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
nvme/041 (Create authenticated connections)                  [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
nvme/042 (Test dhchap key types for authenticated connections) [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
nvme/043 (Test hash and DH group variations for authenticated connections) [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
nvme/044 (Test bi-directional authentication)                [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 286: /usr/bin/grep: Permission denied
/usr/bin/zgrep: line 271: /usr/bin/gzip: Permission denied
nvme/045 (Test re-authentication)                            [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
nvme/047 (test different queue types for fabric transports)  [not run]
    nvme_trtype=fc is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [failed]
    runtime  0.549s  ...  0.378s
    --- tests/nvme/048.out      2023-11-28 12:59:52.711505550 +0100
    +++ /home/wagi/work/blktests/results/nodev/nvme/048.out.bad 2024-01-31 09:40:47.502748168 +0100
    @@ -1,3 +1,7 @@
     Running nvme/048
    +expected queue count 2 not set
    +FAIL
    +expected queue count 3 not set
    +FAIL
     disconnected 1 controller(s)
     Test complete

changes:
v5:
 - collected RBs
 - refactored 'nvmet-fc: use RCU list iterator for assoc_list'
 
v4:
 - dropped patches which got applied
 - dropped 'nvmet-fc: free hostport after release reference to tgtport'
 - reworked commit message of 'nvmet-fc: untangle cross refcounting objects'
   and renamed it to 'nvmet-fc: defer cleanup using RCU properly'
 - added 'nvmet-fcloop: swap the list_add_tail arguments'
   and 'nvmet-fc: use RCU list iterator for assoc_list'
 - added RBs
 - https://lore.kernel.org/linux-nvme/20240130094938.1575-1-dwagner@suse.de/
 
v3:
 - collected all patches into one series
 - updated ref counting in nvmet-fc
 - https://lore.kernel.org/linux-nvme/20231218153105.12717-1-dwagner@suse.de/

v2:
 - added RBs
 - added new patches
 - https://lore.kernel.org/linux-nvme/20230620133711.22840-1-dwagner@suse.de/
  
v1:
 - https://lore.kernel.org/linux-nvme/20230615094356.14878-1-dwagner@suse.de/ 


*** BLURB HERE ***

Daniel Wagner (12):
  nvme-fc: do not wait in vain when unloading module
  nvmet-fcloop: swap the list_add_tail arguments
  nvmet-fc: release reference on target port
  nvmet-fc: defer cleanup using RCU properly
  nvmet-fc: free queue and assoc directly
  nvmet-fc: hold reference on hostport match
  nvmet-fc: remove null hostport pointer check
  nvmet-fc: do not tack refs on tgtports from assoc
  nvmet-fc: abort command when there is no binding
  nvmet-fc: avoid deadlock on delete association path
  nvmet-fc: take ref count on tgtport before delete assoc
  nvmet-fc: use RCU list iterator for assoc_list

 drivers/nvme/host/fc.c       |  47 ++-------
 drivers/nvme/target/fc.c     | 185 +++++++++++++++++++----------------
 drivers/nvme/target/fcloop.c |   6 +-
 3 files changed, 111 insertions(+), 127 deletions(-)

-- 
2.43.0


