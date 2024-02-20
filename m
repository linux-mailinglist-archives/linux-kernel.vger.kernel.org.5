Return-Path: <linux-kernel+bounces-72280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A485B18F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D5B1F221C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73EA56B8B;
	Tue, 20 Feb 2024 03:40:07 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04934C610;
	Tue, 20 Feb 2024 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400407; cv=none; b=Q9RV+T0bum7OP6YSHPihnw1ttWlj0YeJy7Y4xCqEJYny3mKsub3SJ/apstEVRyQgTGF37jHc1thzv7RJsBYfKDW+eYEVwsa+gq+zIdUKe4XvJ6P2A60iIKeDUhPFUnv+bjajQ/lY/LWaOuC82Jpv0/NtcyZY/tgN0HGNl4J+2nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400407; c=relaxed/simple;
	bh=O/ojOjVV0gYF/ou8HJynE4YQaLnUsBVUv9Cd5InHGSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WQ/9klmp6imCWwt7Fh29ZMIIKF3YrWnvP1bpSAoAnwnxFep9/aE185CbBlajNka24FFx4Gisa/En9YmoB+6Tc3nSpKQvauODrFcl4vwIzGB+4t1dKHdNxPmrjr/eDGfl2tT8mW/UrzNZ5sjrEuiyD2rF7RRlypDFl1Lk8SujZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68dc5.dsl.pool.telekom.hu [::ffff:81.182.141.197])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000742C8.0000000065D41F12.001D1CAD; Tue, 20 Feb 2024 04:40:02 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Dmitry Torokhov <dmitry.torokhov@gmail.com>,
  Philipp Jungkamp <p.jungkamp@gmx.net>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 1/2] Input: allocate keycode for Fn + R
Date: Tue, 20 Feb 2024 04:39:35 +0100
Message-ID: <6af6b923fb73ca9ed5b89f29ca2b8f35730d5cda.1708399689.git.soyer@irl.hu>
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

Newer Lenovo Yogas and Legions with 60Hz/90Hz displays send a wmi event
when Fn + R is pressed. This is intended for use to adjust refresh rate.

But there is no silkscreen print on the R key to indicate this,
so add a KEY_FN_R keycode define to use for this key-combo.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 include/uapi/linux/input-event-codes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 022a520e31fc..ba40af25943a 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -547,6 +547,7 @@
 #define KEY_FN_S		0x1e3
 #define KEY_FN_B		0x1e4
 #define KEY_FN_RIGHT_SHIFT	0x1e5
+#define KEY_FN_R		0x1e6
 
 #define KEY_BRL_DOT1		0x1f1
 #define KEY_BRL_DOT2		0x1f2
-- 
2.43.2


