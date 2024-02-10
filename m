Return-Path: <linux-kernel+bounces-60572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC58506E4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16CD1F220F4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA655FEE7;
	Sat, 10 Feb 2024 22:52:36 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8537259B;
	Sat, 10 Feb 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707605556; cv=none; b=Qhf0W1sfQGux31OXxYgcCuBSwJpnmH+N36KtVfoaMD8VwvEIt7CrDbJ+uhDbgyDD01p/JvuCzk0YMI817xwTuQK4w1PwV9YAFyYrgMFjFeOgvLhL/fKfXkZjf5ndtWjjwYBXQmeHkGf7arzq30/D3YFmPC5iU8g9BQuFOffGG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707605556; c=relaxed/simple;
	bh=ojCfonPmi+t4owjCpF349H1y/yURgoI1T78Bd83+Cw0=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=DUoMLq2avw8VI0ip55xPUbId0KIHqGKHye2YTeFlJLzYqhftoEiwuNzr9Ma/4mmKgNeqOBFVEglj3SFgulgBKsov6VhSl8OBZabW7zKzn9VREyQNRZTdH9TYbvqwZlcPdgU/um/rIe8QNB9tWrPrNIOCADpIaucwIZxIXfydb8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69e54.dsl.pool.telekom.hu [::ffff:81.182.158.84])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000073C1E.0000000065C7FE2F.001B7FDB; Sat, 10 Feb 2024 23:52:31 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH] platform/x86: ideapad-laptop: support Fn+R dual-function key
Date: Sat, 10 Feb 2024 23:51:57 +0100
Message-ID: <0cdbc0e6eb65e160384ae0ed152e7de3ded1d9d5.1707604991.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

According to the manual, Fn+R adjusts the display refresh rate.
Map Fn+R to KEY_DISPLAYTOGGLE.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/ideapad-laptop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 88eefccb6ed2..4c130957f80d 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1091,6 +1091,8 @@ static const struct key_entry ideapad_keymap[] = {
 	{ KE_KEY,	0x07 | IDEAPAD_WMI_KEY, { KEY_HELP } },
 	{ KE_KEY,	0x0e | IDEAPAD_WMI_KEY, { KEY_PICKUP_PHONE } },
 	{ KE_KEY,	0x0f | IDEAPAD_WMI_KEY, { KEY_HANGUP_PHONE } },
+	/* Refresh Rate Toggle (Fn+R) */
+	{ KE_KEY,	0x10 | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
 	/* Dark mode toggle */
 	{ KE_KEY,	0x13 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
 	/* Sound profile switch */
-- 
2.43.0


