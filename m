Return-Path: <linux-kernel+bounces-98193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C8B877650
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CF51C20979
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93922208C8;
	Sun, 10 Mar 2024 11:32:05 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D331EB42;
	Sun, 10 Mar 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710070325; cv=none; b=M46LF/x4xKFwZbe+ZBrmrOqTgsxHcJjP3V0jjylNoiRN2mlZ9oRlhVQsgeLpX5RXLTyu4f1dEn/Zv2agU9j/gSgmUnnIdiAP6OtKnesoT63g3+3Je7lxKmda+BBOWcLJygIjFvXAj440+Grc89c1SoqqqA3bJIMNTvgiCKvkPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710070325; c=relaxed/simple;
	bh=ahQ+dUubnLbuzl1m1Uxd3EFT/dTYsu0b9bYX0mThnAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fIye4yllWiE6rxRp9vykyXAm83RzYkkLqKHTSLIJt4YbF5IUlZOI0O5XsNJc2SW/udSUwxpCrci4nBTJrhzGnRZSklD4D2iPL21Iw7HfNnRymIJ/7eu9EpqYvJditoX2aHVIQrjG7sS+m3IIXKe3Ij/bhPjaRofiYv5QOtFpTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693e7.dsl.pool.telekom.hu [::ffff:81.182.147.231])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000076A0E.0000000065ED9A2C.0020EFD7; Sun, 10 Mar 2024 12:31:55 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 2/2] platform/x86: ideapad-laptop: map Fn + R key to KEY_REFRESH_RATE_TOGGLE
Date: Sun, 10 Mar 2024 12:31:42 +0100
Message-ID: <8fd36f0f016dde700396d8afaba1979d5dbc30a1.1710065750.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710065750.git.soyer@irl.hu>
References: <cover.1710065750.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Newer Lenovo Yogas and Legions with 60Hz/90Hz displays send a wmi event
when Fn + R is pressed. This is intended for use to switch between the
two refresh rates.

The Fn + R key was incorrectly assigned to KEY_DISPLAYTOGGLE because it
is used to toggle the display on and off.

Map Fn + R key to the KEY_REFRESH_RATE_TOGGLE event code.

This commit depends on "platform/x86: ideapad-laptop: support Fn+R
dual-function key"

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/ideapad-laptop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 4c130957f80d..901849810ce2 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1092,7 +1092,7 @@ static const struct key_entry ideapad_keymap[] = {
 	{ KE_KEY,	0x0e | IDEAPAD_WMI_KEY, { KEY_PICKUP_PHONE } },
 	{ KE_KEY,	0x0f | IDEAPAD_WMI_KEY, { KEY_HANGUP_PHONE } },
 	/* Refresh Rate Toggle (Fn+R) */
-	{ KE_KEY,	0x10 | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
+	{ KE_KEY,	0x10 | IDEAPAD_WMI_KEY, { KEY_REFRESH_RATE_TOGGLE } },
 	/* Dark mode toggle */
 	{ KE_KEY,	0x13 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
 	/* Sound profile switch */
@@ -1102,7 +1102,7 @@ static const struct key_entry ideapad_keymap[] = {
 	/* Lenovo Support */
 	{ KE_KEY,	0x27 | IDEAPAD_WMI_KEY, { KEY_HELP } },
 	/* Refresh Rate Toggle */
-	{ KE_KEY,	0x0a | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
+	{ KE_KEY,	0x0a | IDEAPAD_WMI_KEY, { KEY_REFRESH_RATE_TOGGLE } },
 
 	{ KE_END },
 };
-- 
2.44.0


