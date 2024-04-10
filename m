Return-Path: <linux-kernel+bounces-138060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9EA89EBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE32CB216C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A0A13C9D7;
	Wed, 10 Apr 2024 07:17:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F8A13C911
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733448; cv=none; b=tbVCcByFp9zw84aTPu4HpG+HyBHHxUqU9/DBrM8tdUhANgQFw0dCTXBIxNnEguQX2dFwYvckOB7ixN2bMPj5B6fIOdtcvbk4+eC28f+PTj+bXbvm5I/x3GEmuRpcxXAvrVR83664F28eFBNpL5voBbaDWcmRFmBECm3VCkEfv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733448; c=relaxed/simple;
	bh=TKq5UBtpPE0gG8ynD2BqWK1DG47L4hILe+UKe7GaaRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kT2QX6NUhFEMcs5AaMSgTMIxqSkAfH3bcj0DeOGM4Xq3/ESwszxtzZtzlcAmKP1yA0EDNER6b3NytrUCczCCoYoYShkLhxZyfewmAyNJTVNZIrRZWgYdCLVPucOlK2ynljYRHHvtONayXrdROHgg9iZ5sCf6RBegfkZ/PsFfnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCk-0007Og-C6; Wed, 10 Apr 2024 09:17:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCi-00BRwK-Ol; Wed, 10 Apr 2024 09:17:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCi-00HPjN-2C;
	Wed, 10 Apr 2024 09:17:08 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 0/3] x86: platform: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 09:16:50 +0200
Message-ID: <cover.1712732665.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=TKq5UBtpPE0gG8ynD2BqWK1DG47L4hILe+UKe7GaaRo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFjzjL4QTEmIHs/qxt1FFyu5hkfJU2gNdShXR6 iJ/px5e6G+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhY84wAKCRCPgPtYfRL+ Tg67CACpFgkCubCMDImL4WePMfzWs+UNAK9SHDurPzmbMTd2PzHpWTvGa8LZ52HW9QRA/JHTR8U sbmbuVaRn1Ce66xFOZw/svJblBdTOJwdDZYWjfh2WLusiSLL+cCT7B/ZRVpxi9iDkHz5XIkcJdU UTtukgYibWhvKROAJ95Wv1hXMYrH3aOu5OE0NrzikJ4r3aq7cNrVPsk3AlayORCs0p3DUz8av+N R/sYFBlOF7qMG6oP0RZL47ShEQLU+yodWTUklCoTGViAEFe1ZhivYjJvshJfxmO0NSUr0dVQMLn bHmXxxGMbR8aKMrrigyu35K+ZT5eG/Y+TsvdbunYzFacjuHl
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts all platform drivers below arch/x86/ to not use
struct platform_device::remove() any more. See commit 5c5a7680e67b
("platform: Provide a remove callback that returns no value") for an
extended explanation and the eventual goal.

All conversations are trivial, because the driver's .remove() callbacks
returned zero unconditionally.

I don't know how maintenance of these drivers is organized, but
there are no interdependencies between these patches, so they can be
applied independently if needed. This is merge window material.

Best regards
Uwe

Uwe Kleine-König (3):
  x86: platform: iris: Convert to platform remove callback returning
    void
  x86: platform: olpc-x01-pm: Convert to platform remove callback
    returning void
  x86: platform: olpc-xo1-sci: Convert to platform remove callback
    returning void

 arch/x86/platform/iris/iris.c         | 5 ++---
 arch/x86/platform/olpc/olpc-xo1-pm.c  | 7 +++----
 arch/x86/platform/olpc/olpc-xo1-sci.c | 5 ++---
 3 files changed, 7 insertions(+), 10 deletions(-)

base-commit: 6ebf211bb11dfc004a2ff73a9de5386fa309c430
-- 
2.43.0


