Return-Path: <linux-kernel+bounces-76391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CC285F698
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD00284335
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0072841760;
	Thu, 22 Feb 2024 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l+JLbPaq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l+JLbPaq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC8208A2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600613; cv=none; b=Ia6yN5VGozqaf7PNNwIorEO8PMMBsxlVWJEhOSZ3Pkr7Sy06YEVrUDQ8R6iGlZdk5i8tbOfwIJ2BCtOiP0NNB2Hlp1vT89F+4r8nizasd+BK1iXkIJIfAwOI95NOZ5oUwVEWd3ePaDBUdF/75eUHCwsTGZvC//dkJRW2NyYUNdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600613; c=relaxed/simple;
	bh=UudV8mpjkdJ5wQfiRKfqyLU7x/qxGZ9m5FYON9r4mo0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qOY+RTt9JwqLtwZzXs5O+p/LwWDPb1qDX056SZtJ1HAw7NxKiPpR/PiEMX2p9MWB9chjeYqHPCrDYo42CpmswrrhjC2M9o7ASAUhUaSvZ3rL2KJGy6Rme23sScjtss5l/uCpH3BpnHDB09oMq8JELjiGp7eND6LAVGE72rN0CJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l+JLbPaq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l+JLbPaq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E890C1F457;
	Thu, 22 Feb 2024 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708600609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f0WDjPpBEd8T8+uDymIvKTcUlaDMEk2bJipS39+mDFQ=;
	b=l+JLbPaq25ao+vDyscSAN90wt2Aj42HDL+FaXFFMt4hW2273hPfd0iN73ptpstUP/cXm1c
	iLvx8Kz9gsDrAjp1DTbTI5CaQFWUOax43segG2JJYyQDsDQBzcpVWjrHNgLyZhRta6j05T
	nAC2Zz9Zc51CcZXPyLLKaYtyVpZ/RmI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708600609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f0WDjPpBEd8T8+uDymIvKTcUlaDMEk2bJipS39+mDFQ=;
	b=l+JLbPaq25ao+vDyscSAN90wt2Aj42HDL+FaXFFMt4hW2273hPfd0iN73ptpstUP/cXm1c
	iLvx8Kz9gsDrAjp1DTbTI5CaQFWUOax43segG2JJYyQDsDQBzcpVWjrHNgLyZhRta6j05T
	nAC2Zz9Zc51CcZXPyLLKaYtyVpZ/RmI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A174313A8C;
	Thu, 22 Feb 2024 11:16:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pn8BJSEt12VrGgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Thu, 22 Feb 2024 11:16:49 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 0/2] Cleanup x86 instruction decoder
Date: Thu, 22 Feb 2024 13:16:34 +0200
Message-Id: <20240222111636.2214523-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(0.00)[41.09%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

First patch removes some duplicated checks in caller/callee second one is
trivial to remove a check in init_ins()

Nikolay Borisov (2):
  x86/insn: Remove superfluous checks from instruction decoding routines
  x86/insn: Directly assign x86_64 state in init_ins

 arch/x86/lib/insn.c       | 58 +++++++++++++++------------------------
 tools/arch/x86/lib/insn.c | 58 +++++++++++++++------------------------
 2 files changed, 44 insertions(+), 72 deletions(-)

--
2.34.1


