Return-Path: <linux-kernel+bounces-89685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B61F686F427
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34D6B21EEF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E510B641;
	Sun,  3 Mar 2024 09:24:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879DAD35
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709457869; cv=none; b=HEWtwJmb1bZsD3LmNB4nmbrbfFtv5MbiUUVPvxmGW+wReSx+qVKSwcRdSgafxLaO3xFyeVtG8iOqeXZrjIn75KddgkozEKNwx+PPvfSaK0/su7sbwKHOy3cbEw6nfcdK0ATx/d3uGj6fRpaaL8Fxd7Zxsy2SY7bZLPxohcQ4tC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709457869; c=relaxed/simple;
	bh=LlKvoQRPABfKry/b2N2XpVfDUkyfRmoWcEJ2WI/dDZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KPb1sDRdUKx7xVbbinMpfjPiz/Wd1vA4XLJrSwe43Xqy1brNnaEYFevVSQXEwY5UQCJNfwuzwX6IS3ojZjmLHBj8O0BcNCJwKeLBoQZN1ny2LIf0q1hKC+dsKqjkWj8fmItGrxyxibkO61SvZJBl29/mINQOEW2C1/T9QveZOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rgi50-0007Gy-BM; Sun, 03 Mar 2024 10:24:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rgi4z-0048Ir-28; Sun, 03 Mar 2024 10:24:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rgi4y-00FrWU-39;
	Sun, 03 Mar 2024 10:24:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v2] mul_u64_u64_div_u64: Increase precision by conditionally swapping a and b
Date: Sun,  3 Mar 2024 10:24:09 +0100
Message-ID: <20240303092408.662449-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LlKvoQRPABfKry/b2N2XpVfDUkyfRmoWcEJ2WI/dDZI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl5EG4uHU+wgSThK8NbSrhs6DrOsbWCbBx4V9+s 36f5N6+XfGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeRBuAAKCRCPgPtYfRL+ TsujB/917hzWZmKaMffR1oaaoL9/J7Qz7ku+4cfOD4wKy+B3GPkeraqhFLV+sYzrcmHKjQ1eUWj uDFU/J0hDHFm5ZMlFxzb2/rltHIJIL3vb5R7kdaWpVN2DZ4ZRq8Jck0gmTL1PrETaxrizdxrvCG 0keL9teMrLm595r0gTBVsNGGTbp0tk3O/sIumbIuPQac466mNuZeDNGE0SJQiYZKUgYRNKZgHAf e/v1QsrUkRVTu6AQtxGqgB0ZDPoWTGl8cReZQfLw6ctZjlx8K0xTOjjo4zb52FmcGXuHgLWc5Gi Abegik2AB5jOZYwghMVPDylW3RvWF8ZrA2uovA9GRo/7R7Qx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

As indicated in the added comment, the algorithm works better if b is
big. As multiplication is commutative, a and b can be swapped. Do this
if a is bigger than b.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since v1:
 - Make use of swap() (Thanks Marc)
 - Fix a typo in a code comment (Thanks Randy)
 - Fix a typo in the commit log (s/If/if/; noticed myself)

v1 got a Tested-by from Biju; I didn't add it here as the patch changed.
I'm optimistic that this v2 would pass his tests, too, but I don't wanna
assume stuff when adding tags.

Best regards
Uwe

 lib/math/div64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index 55a81782e271..191761b1b623 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -22,6 +22,7 @@
 #include <linux/export.h>
 #include <linux/math.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/log2.h>
 
 /* Not needed on 64bit architectures */
@@ -190,6 +191,20 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
 
 	/* can a * b overflow ? */
 	if (ilog2(a) + ilog2(b) > 62) {
+		/*
+		 * Note that the algorithm after the if block below might lose
+		 * some precision and the result is more exact for b > a. So
+		 * exchange a and b if a is bigger than b.
+		 *
+		 * For example with a = 43980465100800, b = 100000000, c = 1000000000
+		 * the below calculation doesn't modify b at all because div == 0
+		 * and then shift becomes 45 + 26 - 62 = 9 and so the result
+		 * becomes 4398035251080. However with a and b swapped the exact
+		 * result is calculated (i.e. 4398046510080).
+		 */
+		if (a > b)
+			swap(a, b);
+
 		/*
 		 * (b * a) / c is equal to
 		 *

base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
-- 
2.43.0


