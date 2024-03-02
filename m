Return-Path: <linux-kernel+bounces-89593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68B686F26D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA91F21664
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8759F2747B;
	Sat,  2 Mar 2024 20:54:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58726290A
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709412885; cv=none; b=MiUIGmYgTRXrjVvt93hUcDm16J0zNxgBtyqaPskq3ymKbaAHSme4SN7KBm6kFKJFSQ/bv5SVso6v/qu0hP7wHQ4qm2/nc4Cx34H5tmrCGtJTF7A4u5xPq/TCVotGgNGmI2pL7LcXDAnrq17+c1/crar+SRD3RgNyC5sw8bh2QUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709412885; c=relaxed/simple;
	bh=IKmYdj4+qwMGZYBGOtYVBzb4vztcCuUi25hMBgKz6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EyyQeU83xkUU3Cj3bMxiVQisbRJ18ii5yl5BaSQKtioM8+IUnYzDzGK87rPz6XCeSxObjpc8/RAcrARlU7pxajH0ovVCaPkgiQjohD+Et0IbCXlP+zXoISharaORrfMFZxMhqVj0gmzzY51+YezTFxmfPiuSm+Sk2GYAlbu/Twc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rgWNT-0003qv-1O; Sat, 02 Mar 2024 21:54:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rgWNR-0042FP-MN; Sat, 02 Mar 2024 21:54:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rgWNR-00FZke-1w;
	Sat, 02 Mar 2024 21:54:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	kernel@pengutronix.de
Subject: [PATCH] mul_u64_u64_div_u64: Increase precision by conditionally swapping a and b
Date: Sat,  2 Mar 2024 21:54:27 +0100
Message-ID: <20240302205426.639205-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IKmYdj4+qwMGZYBGOtYVBzb4vztcCuUi25hMBgKz6lQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl45IDwOnSs0mCE9Etx3kFkYz2Ja/J+WPkdYdy2 fK8RnVLafOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeOSAwAKCRCPgPtYfRL+ TniMB/4gJTFXWZ47C2ialXL+jfKEZz9eqpGDo/hrlIIu9XmOVAbSNNMV/LNALdRiTukt5/0iuyY caa2L454igWD7Tb9jHAevyhASgBay/WwrNHPTVDPFhPhdCGB/wdDCtqClX8bOhtFn/KJU9cJmQ+ yVx0TRNVuMuck34uPVx4xBhVF/StG3Kz5woK1b7QsdYeYEj+tXbTGxzvzophta1J+c8i7zj5R1W 9cfEYd9hkAdqecIfTm8cTx+yC8rrVIAZ7LdA4odTobDKbVZ3bZfiMegBryHFkHIyDc4xjRpmkRZ KmsxVNgDjRx/7UajH+g5WqbKxhx9w05bqP2NYftw0tHnLP9W
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

As indicated in the added comment, the algorithm works better if b is
big. As multiplication is commutative, a and b can be swapped. Do this
If a is bigger than b.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 lib/math/div64.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index 55a81782e271..baf6f8681907 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -190,6 +190,23 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
 
 	/* can a * b overflow ? */
 	if (ilog2(a) + ilog2(b) > 62) {
+		/*
+		 * Note that the algorithm after the if block below might loose
+		 * some precision and the result is more exact for b > a. So
+		 * exchange a and b if a is bigger than b.
+		 *
+		 * For example with a = 43980465100800, b = 100000000, c = 1000000000
+		 * the below calculation doesn't modify b at all because div == 0
+		 * and then shift becomes 45 + 26 - 62 = 9 and so the result
+		 * becomes 4398035251080. However with a and b swapped the exact
+		 * result is calculated (i.e. 4398046510080).
+		 */
+		if (a > b) {
+			u64 tmp = a;
+			a = b;
+			b = tmp;
+		}
+
 		/*
 		 * (b * a) / c is equal to
 		 *

base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
-- 
2.43.0


