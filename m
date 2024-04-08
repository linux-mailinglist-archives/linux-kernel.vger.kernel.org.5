Return-Path: <linux-kernel+bounces-135759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D939C89CAE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79AB21F2636C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CB31448E8;
	Mon,  8 Apr 2024 17:35:22 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC8143C57;
	Mon,  8 Apr 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597721; cv=none; b=VOth/WDy9TEIQqmmt+8AeJDVvi4Y/4x3TgncH98j0UVbOOeaP7xKLQ+5pqhy3KwS++ucLRs+00A7O+QvR7EIIv+zWFOcmWVB8ZTyixHvDUTOA6ZIvvWY3jr4sKOtHf4aTtQv4ZNksHf9tgUvqVm/VJ2WanZY7WKgPffXP6XqcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597721; c=relaxed/simple;
	bh=6qiGJbqO0axJqokE3cSx8ptwlaLpdUXwcMyA+0RsNKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qKYNYGqdZj6s9jc8Bc1qHRgVB4KTHOoOSNJkP/9e0578aCiWVcHHGq9L81v0TQWHosSU7Z+NbIwAFTGk7Fbt3lE/fp4hSLHOVxsjlVgTl5gdRFkmTV2OdxPTKT29taYezKeuZyP3X6I9waEmnKD/yJQEzmWuFbvghMxF4/1jWbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69f53.dsl.pool.telekom.hu [::ffff:81.182.159.83])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000706EB.0000000066142AD5.00264601; Mon, 08 Apr 2024 19:35:17 +0200
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
  Daniel Lezcano <daniel.lezcano@linaro.org>,
  =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v6 2/3] platform/x86: ideapad-laptop: switch platform profiles using thermal management key
Date: Mon,  8 Apr 2024 19:35:11 +0200
Message-ID: <e5cf301ef731b037e211d468fe1d362fe3ea40ad.1712597199.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712597199.git.soyer@irl.hu>
References: <cover.1712597199.git.soyer@irl.hu>
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
(Fn + Q). They report KEY_PROG4.

If supported, cycle between platform profiles instead.

Tested on Yoga7 14ARB7.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/ideapad-laptop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 901849810ce2..4893b1aef696 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1181,8 +1181,11 @@ static void ideapad_check_special_buttons(struct ideapad_private *priv)
 		switch (bit) {
 		case 6:	/* Z570 */
 		case 0:	/* Z580 */
-			/* Thermal Management button */
-			ideapad_input_report(priv, 65);
+			/* Thermal Management / Performance Mode button */
+			if (priv->dytc)
+				platform_profile_cycle();
+			else
+				ideapad_input_report(priv, 65);
 			break;
 		case 1:
 			/* OneKey Theater button */
-- 
2.44.0


