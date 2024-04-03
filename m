Return-Path: <linux-kernel+bounces-130542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCAF8979BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25217B25322
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CB0155A46;
	Wed,  3 Apr 2024 20:23:28 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A0EA31;
	Wed,  3 Apr 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175807; cv=none; b=gUG3ioRILlil4ESUR7KYCMwO4jW0v/fhiXITuU7vbZWMuvZqBBF2ff/q+6DtKYuR3Y6XkVn1XwrkBCm+2C+WHoDnrV83zxWFze0qb04qKxJ7GuZ8ZMb5qehL8QJAEmH75H0wn94dWcJoa8+NI8CHXzaoDA0lJhN4rh6e/GRNOcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175807; c=relaxed/simple;
	bh=MPsU28H2POUdiVS1YuPmiLhg1Rt8kKEk7jcvZln4UP8=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=hQYNo0ZdH/05eDYhzv13kkbO31ICAjd0od6mDZjF3erpg7Z0B5CqgNTnS2/2zJc+lkBgRShoj0NIemc7lHIGRqvzK4ZTmdK8NqqfRLHjDwzwIcB/6ZaV1o8R4jATf68Ye2HtMJvAgwJYE1S+Kgo85sAwHQB6zUfIRSxUuvXrwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006DFF9.00000000660DBABA.00256B88; Wed, 03 Apr 2024 22:23:22 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2] platform/x86: ideapad-laptop: switch platform profiles using thermal management key
Date: Wed,  3 Apr 2024 22:23:15 +0200
Message-ID: <797884d8cab030d3a2b656dba67f3c423cc58be7.1712174794.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Ideapad laptops have thermal management or performance mode switch key
(Fn + Q). Now it sends KEY_PROG4.

If supported, switch platform profiles instead.

Tested on Yoga7 14ARB7.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
Changes in v2:
 - only switch platform profiles if supported, otherwise keep the 
   behavior.

[1]: https://lore.kernel.org/all/85254ce8e87570c05e7f04d6507701bef954ed75.1712149429.git.soyer@irl.hu/
---
 drivers/platform/x86/ideapad-laptop.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 901849810ce2..dba43c2d244b 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1181,8 +1181,31 @@ static void ideapad_check_special_buttons(struct ideapad_private *priv)
 		switch (bit) {
 		case 6:	/* Z570 */
 		case 0:	/* Z580 */
-			/* Thermal Management button */
-			ideapad_input_report(priv, 65);
+			/* Thermal Management / Performance Mode button */
+			if (!priv->dytc) {
+				ideapad_input_report(priv, 65);
+				break;
+			}
+			switch (priv->dytc->current_profile) {
+			case PLATFORM_PROFILE_LOW_POWER:
+				dytc_profile_set(&priv->dytc->pprof,
+						 PLATFORM_PROFILE_BALANCED);
+				break;
+			case PLATFORM_PROFILE_BALANCED:
+				dytc_profile_set(&priv->dytc->pprof,
+						 PLATFORM_PROFILE_PERFORMANCE);
+				break;
+			case PLATFORM_PROFILE_PERFORMANCE:
+				dytc_profile_set(&priv->dytc->pprof,
+						 PLATFORM_PROFILE_LOW_POWER);
+				break;
+			default:
+				dev_warn(&priv->platform_device->dev,
+					 "Unexpected platform profile %d",
+					 priv->dytc->current_profile);
+			}
+			/* Notify user space the profile changed */
+			platform_profile_notify();
 			break;
 		case 1:
 			/* OneKey Theater button */

base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
-- 
2.44.0


