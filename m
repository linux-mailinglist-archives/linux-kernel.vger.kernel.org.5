Return-Path: <linux-kernel+bounces-167631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194118BAC39
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D8A1C22153
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E341534E0;
	Fri,  3 May 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IChCKY5t";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IChCKY5t"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3C219EB
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738833; cv=none; b=RjqlGhfPbrOJsRS7blMJmdERfxJSpj+KeY2zEN1OlHW+jzLs5X/WTE+Ss+jANFkFJal2Z0ZNRU3GJtGvjCEnvHHZgmD7fWw1gQ0UIFB612tVQkREBm3LTCzmEXUa5hkqe2MUt3S+NyOKxz3os/zZYRcATjol3Q/sxzcaICwf68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738833; c=relaxed/simple;
	bh=E+/cECiiPvGgfMopiQuKkU83Wbxmf5UDXkAl12lTk00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cPConLsP8UFBtvMkjs+ddZJD2cNQbhjqemIRMfqfWz24qmj4EH4Vs5/HGDhWRqrB89K0gceqZEUiyuSmQsC+WHU60mNB7N1luuezMv8PV5LtPn+ikDvTae5uL/ZvZIDGR3tjfAlea8k48LKbifUFs6a1COOXOmPUy5IqrB1keJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IChCKY5t; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IChCKY5t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C743B20359;
	Fri,  3 May 2024 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714738828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ut+JW89x87VZepZnO2x2XzUTpzW28xGmJv03rNS6b4A=;
	b=IChCKY5tWm5MO4ZrqNegxopgfKarmL+AoRo62F1aGEhECBlAjh5e05TZZsjxEo/DQfWPQe
	Da2XiUWsxBGIlm35Nbx9WSQolWOk5hQClMYWL56KBqChfWIxh3GTaQR5x7D/AQ6TfnOpIY
	KNVFeHHrjQIQeMePtkp97hCiregmZYs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IChCKY5t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714738828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ut+JW89x87VZepZnO2x2XzUTpzW28xGmJv03rNS6b4A=;
	b=IChCKY5tWm5MO4ZrqNegxopgfKarmL+AoRo62F1aGEhECBlAjh5e05TZZsjxEo/DQfWPQe
	Da2XiUWsxBGIlm35Nbx9WSQolWOk5hQClMYWL56KBqChfWIxh3GTaQR5x7D/AQ6TfnOpIY
	KNVFeHHrjQIQeMePtkp97hCiregmZYs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9334613991;
	Fri,  3 May 2024 12:20:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id axdxIozWNGbmagAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 03 May 2024 12:20:28 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.9-rc7
Date: Fri,  3 May 2024 14:20:28 +0200
Message-Id: <20240503122028.16437-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C743B20359
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.9a-rc7-tag

xen: branch for v6.9-rc7

It contains two fixes when running as Xen PV guests for issues
introduced in the 6.9 merge window, both related to apic id handling.


Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c | 11 ++++++++++-
 arch/x86/xen/smp_pv.c       |  4 ++--
 2 files changed, 12 insertions(+), 3 deletions(-)

Juergen Gross (1):
      x86/xen: return a sane initial apic id when running as PV guest

Thomas Gleixner (1):
      x86/xen/smp_pv: Register the boot CPU APIC properly

