Return-Path: <linux-kernel+bounces-72279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E678A85B190
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F154B231BD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C725056B8A;
	Tue, 20 Feb 2024 03:40:07 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80741535C9;
	Tue, 20 Feb 2024 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400407; cv=none; b=eknhn3RgsqkXrl52bn949c/0TOrzks++Hmltwx/CYc0taysIT6Q752dDiRJ1Y0luvKVgmWo1OJcSC6B4+VTfXkDKrmNg56UWk2V2SqIjkWwjs6qrGb8lymBnN7vEraZruz1vrGnilWSwvxvgJ08tqqkEkzELNn7njkfk8OZQaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400407; c=relaxed/simple;
	bh=7t9cqES8MSWTYHCLk+n76X7zRHHCvrwc6p/G92TYeZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eeaYrjqW1cXjqtnYzapeoCQ+h6Ml/nWa7kzt5EJlkIUcoPRuf9XnmJgG68gAQ7KLeZ5WH2jhgG8ecnVNiiWoBEb42j0pYl9tZVeVZU8/gfG8WShhJbEhKvHNHD0ZniEz5E3wxwWiDXo7RjY9bBCMoBgnmWVBoc2ijvT9SUJF8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68dc5.dsl.pool.telekom.hu [::ffff:81.182.141.197])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007458F.0000000065D41F13.001D1CBF; Tue, 20 Feb 2024 04:40:03 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Dmitry Torokhov <dmitry.torokhov@gmail.com>,
  Philipp Jungkamp <p.jungkamp@gmx.net>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 2/2] platform/x86: ideapad-laptop: map Fn + R key to KEY_FN_R
Date: Tue, 20 Feb 2024 04:39:36 +0100
Message-ID: <fbff2791d6d9b5e57d6ac9001717c21cee0296ce.1708399689.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1708399689.git.soyer@irl.hu>
References: <cover.1708399689.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Newer Lenovo Yogas (e.g. Yoga 7 14ARB7) and Legions with 60Hz/90Hz
displays send a wmi event when Fn + R is pressed. This is intended for
use to adjust refresh rate, but there is no silkscreen print on the R
key to indicate this.

The Fn + R key is incorrectly assigned to KEY_DISPLAYTOGGLE, as the
latter is used to toggle the display on and off.

Map the Fn + R key to a more generic KEY_FN_R event code, since the
refresh rate toggle feature is not common and is only used by a few
Lenovo laptops.

This commit depends on "platform/x86: ideapad-laptop: support Fn+R
dual-function key"

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/ideapad-laptop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 4c130957f80d..c31c96228912 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1092,7 +1092,7 @@ static const struct key_entry ideapad_keymap[] = {
 	{ KE_KEY,	0x0e | IDEAPAD_WMI_KEY, { KEY_PICKUP_PHONE } },
 	{ KE_KEY,	0x0f | IDEAPAD_WMI_KEY, { KEY_HANGUP_PHONE } },
 	/* Refresh Rate Toggle (Fn+R) */
-	{ KE_KEY,	0x10 | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
+	{ KE_KEY,	0x10 | IDEAPAD_WMI_KEY, { KEY_FN_R } },
 	/* Dark mode toggle */
 	{ KE_KEY,	0x13 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
 	/* Sound profile switch */
@@ -1102,7 +1102,7 @@ static const struct key_entry ideapad_keymap[] = {
 	/* Lenovo Support */
 	{ KE_KEY,	0x27 | IDEAPAD_WMI_KEY, { KEY_HELP } },
 	/* Refresh Rate Toggle */
-	{ KE_KEY,	0x0a | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
+	{ KE_KEY,	0x0a | IDEAPAD_WMI_KEY, { KEY_FN_R } },
 
 	{ KE_END },
 };
-- 
2.43.2


