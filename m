Return-Path: <linux-kernel+bounces-132998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC1899D13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C24EB23763
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6213C679;
	Fri,  5 Apr 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O+PU4oLg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WZX5xUa5"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CE1E87F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320480; cv=none; b=r4O9Or50okBVtvQjDgJ75C8Vr6JpPfdDH/RuDYKhqxUFRYeLL3lRFn0XBGZmPmI+6o6MBDi3YsW/LeL9kj45RS7/ij/R37GUSNSpYtx3knBzNuMrXT/q06Blvw4DzijzaPmJBfJaMYCeAwFKVc32SCUELfSJj7usEtRdZUR0vbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320480; c=relaxed/simple;
	bh=zpFrzBzFTAziPvaF3nn0Hd6sS0IY/k2kAfaNoOIlbko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NUWp6fyYuFdhcKq5u47Kj+dEnBeW7Bmv53s5U0Gqk2ACpGB1VRIzhZdydPT0NxJp00xl9TYf/VgVJtKPLbSlS+kb11zxgVn1rxAaHezMY9c2E7mNe+p1lu6qB900+PUfdBn7w+6sAjqUCheR06KjpxPAfHGxksufgdQ4XnfXq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O+PU4oLg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WZX5xUa5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E95B921A41;
	Fri,  5 Apr 2024 12:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712320477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VqNA5Y/xBRyL+e1bT5top3t6My101/ZhLt7zIZIlphg=;
	b=O+PU4oLghfVlWdlh3NhIkqh0c3pkoddQgyKwOfYuKB6f2NP47euEpQ4ZO21fdaKOvR2VK1
	LYnLqRSvXfhMYCu7NA1zsnaYGFjNp7z1RYv7dkFASzgLeO64gNK1bxlhGrIzV+DsMBcvVA
	8rHtut0WmAq/SU+sqJoDGDoRuymKukM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712320476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VqNA5Y/xBRyL+e1bT5top3t6My101/ZhLt7zIZIlphg=;
	b=WZX5xUa5SG4XnY8crJF2mCiSBDBxA88vl3w6/RFyw7Tb2Q1Yihf9VvV57t7jD1C10qPyNo
	FgtjOSG0rwVq0bA6QOaqfJIW9UhVRlpGPnEJtrcylLWTptoENvfx8phqqOAEX7kr7QYDhl
	Qh6WVvXABMC9GOaRb2Zj2epu2IOu5/E=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8591F139E8;
	Fri,  5 Apr 2024 12:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Wiq9HtzvD2Z8GgAAn2gu4w
	(envelope-from <jgross@suse.com>); Fri, 05 Apr 2024 12:34:36 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 0/2] x86: Two fixes related to Xen PV guest mode
Date: Fri,  5 Apr 2024 14:34:32 +0200
Message-Id: <20240405123434.24822-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.14 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.06)[60.95%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.14
X-Spam-Flag: NO

These are 2 fixes for issues introduced by topology related changes
added in the 6.9 merge window.

Juergen Gross (2):
  x86/cpu: fix BSP detection when running as Xen PV guest
  x86/xen: return a sane initial apic id when running as PV guest

 arch/x86/kernel/cpu/topology.c |  2 +-
 arch/x86/xen/enlighten_pv.c    | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.35.3


