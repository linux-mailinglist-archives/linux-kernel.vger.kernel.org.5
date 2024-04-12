Return-Path: <linux-kernel+bounces-143091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF578A33FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031871C20E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EB314AD31;
	Fri, 12 Apr 2024 16:44:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5282C60
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940266; cv=none; b=NNrK5T0H70TqzfRGZndXz52CU1utYFQX1aOyH5cQRMKfqgZbccoIt3bZw0M6UrdvX2grHeVheskyRW+qe2H+nJxEHCOkbID1yAVkOLaiF/ROUOdUyzl9bYe6zcCdUqsfyNqsTz9vq2oO4HJ47XOTNaf+yLUWU3J3itBRZlnYRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940266; c=relaxed/simple;
	bh=PvyKfVWllgQGZr/dfeKzFG//s8ySvJWao6OY6g4kPs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NI48Dqlv7ymmJ0k9QXuHIhaNIQ1qCsrUEiK6BtUn454xFeqoETVSiQ+RFqyGUhB0U9NOPKM0TVQcbH5x9PEpLcV7erE5F2d/EGEH/Fj/gYqOiAGTcYyG7woRgN5n2l8V6nMfj4EQXe6Xa+rj4PHnKyKTtX5UFY3AMJd0TJUekjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvK0c-0005vG-47; Fri, 12 Apr 2024 18:44:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvK0a-00BuUQ-K1; Fri, 12 Apr 2024 18:44:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvK0a-000HtE-1h;
	Fri, 12 Apr 2024 18:44:12 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: Make dev_err_probe() silent for -ENOMEM
Date: Fri, 12 Apr 2024 18:44:05 +0200
Message-ID: <20240412164405.335657-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4770; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PvyKfVWllgQGZr/dfeKzFG//s8ySvJWao6OY6g4kPs8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmGWTWEZnGJxWQ2Vu3mBBFM/2kzByXuf0paJN7B ebA5pQ1BLyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhlk1gAKCRCPgPtYfRL+ TmCzB/4zz7NR2ixmR5CM1FszM/T0qofmZr5FnZU7l4aQRaRZ79iPxVQp90P4Wa8+Zn05iX7dqu3 di1xl2JXPMYtE2nHTF0OlyBDIBSHVC3o0IthEltnZzvXCCFxlefNrDB7Q8Ah44VQTO+udvxSrT4 jFeOOEgULtUo8npnUshzR4IUkAO01tliYW9o+W2IgDVKu/m1h6Vkxi6CLgtiO2mdpovWQ2JKGN+ tTnAdfuHSLAUIIGTgfK2yB+0qGJq0MCudwWiDCi6+07ER950k1tVbLy8GJL4zVsQ2tiO6u0//+i jrXgOkSiYOAYoViMXQ4NI5EruRdvXwaWDn9dNRErucyCR4GW
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

For an out-of-memory error there should be no additional output. Adapt
dev_err_probe() to not emit the error message when err is -ENOMEM.
This simplifies handling errors that might among others be -ENOMEM.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I had the idea to make dev_err_probe() silent for -ENOMEM for a while now. 
Triggered by https://lore.kernel.org/all/ZhleDwUJLDEG5QwH@black.fi.intel.com I
finally implemented this idea.

Best regards
Uwe

 drivers/base/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d51928c4088..8f1914ca6b6e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5054,11 +5054,22 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (err != -EPROBE_DEFER) {
-		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
-	} else {
+	switch (err) {
+	case -EPROBE_DEFER:
 		device_set_deferred_probe_reason(dev, &vaf);
 		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
+
+	case -ENOMEM:
+		/*
+		 * We don't print anything on -ENOMEM, there is already enough
+		 * output.
+		 */
+		break;
+
+	default:
+		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
 	}
 
 	va_end(args);

base-commit: 4118d9533ff3a5d16efb476a0d00afceecd92cf5
prerequisite-patch-id: 950b86247f1ba5dfc0396d9777d83e641ff62c35
prerequisite-patch-id: 59206f0661ac45767ecf89a11ee57a0f9ee26b3c
prerequisite-patch-id: a3ca2b5359cf23a48ca505280d967f02d9ce356c
prerequisite-patch-id: 2b7c70d39b660d374794bac26e7b5e9a7f26da8f
prerequisite-patch-id: 569cb54f9b2390be8d51979045722462e0b63f2d
prerequisite-patch-id: edc1f62b9d5c0e658c7283bd3353d2004a0c1fbf
prerequisite-patch-id: 8201835ed22aa6956d219d84299f9226fb8254c1
prerequisite-patch-id: 07772cf036deb3150560629bc287510901e90f24
prerequisite-patch-id: d84360cad6a23ccbadc1205541ffb218fa589ba7
prerequisite-patch-id: 79e7647450348ef0cca53af2bc5e5a0033dcec57
prerequisite-patch-id: 45568b19e28a0cb3f46699ff945adc654eda07d2
prerequisite-patch-id: 7daf4547e4b3785959e0c024ce95141cd1d936da
prerequisite-patch-id: f3c1f5b72e3b503760d4b70bb661ceb8381c4822
prerequisite-patch-id: 5e0cca8fff7c73448710f42e711eff5a863b8a31
prerequisite-patch-id: 188bb3126861dc5027e5a0af78370ef8bb66fd8a
prerequisite-patch-id: afaee9f242fa90b29a3b8e971d0cbfd00269ad2d
prerequisite-patch-id: 5e815580f4d875d8720236fc016f6848d75b3cc9
prerequisite-patch-id: 0fd48f45bc44d66c9ca01b03d570fea876fc4abb
prerequisite-patch-id: b63f367f8354d56916d33c4236c79cf8e1c7d67a
prerequisite-patch-id: ea68cb08a89ece1fb288f08d8c72ee7bdc378e79
prerequisite-patch-id: 0fa92154ed986e765a41079f5aa441ae0ab4683b
prerequisite-patch-id: 8eca4420a223355531ddfc5331729feb5fff9812
prerequisite-patch-id: d72dbdaa1f3f12e970341277e7e5bbb8da15f228
prerequisite-patch-id: 7699990bf345e9551251211ee798f3b93c257d24
prerequisite-patch-id: 168172f0fec6fcf334cd6cc600749afd57ade8a1
prerequisite-patch-id: 96a01bb6af22da23b4e7acb5897117db959e8a08
prerequisite-patch-id: 82222b0c579003169bcc1f1d84bb34956655cfb0
prerequisite-patch-id: 075db535154891b70ed4e659588e9294e06a5f38
prerequisite-patch-id: 83c646c3aa4ef3578e0fcd86ffc395b51cc47763
prerequisite-patch-id: 4b8d2995e96ae290599d752cf1c1d2537e47bfab
prerequisite-patch-id: 5915e9d3dd78f832ab0017c81df770f443b32169
prerequisite-patch-id: dba378294fcb0aa72ee6bbace049c3ecc2b97bcb
prerequisite-patch-id: 712d0c765bdecbc60d72e62b10b329b525dfd16f
prerequisite-patch-id: 85e037f468c34b7a904f926e0cc555d7863c2cc7
prerequisite-patch-id: 4e475984306a28ba367a171a6450bcfb07d0eb3c
prerequisite-patch-id: 40b6db6c8d4e5bcaab64ce1afd53a79586f3df0b
prerequisite-patch-id: fd4da5ff37eba383f7de7dd219cfcb297155b654
prerequisite-patch-id: b076059966b15d0bf1c8282f48502299987b628a
prerequisite-patch-id: 6b4540ea605fc3feb59128abee429c870b506da5
prerequisite-patch-id: b98d4896c4dbc26adb898815c3e10722796bc9ca
prerequisite-patch-id: f82322e104e3194c77b66a2ab2e465dd2a162d65
prerequisite-patch-id: 3c719132de0cc72d3e548b5f3623cccb28a74ab5
prerequisite-patch-id: d23e9aef7476d7f0976a9d8919c8474a5f91c20c
prerequisite-patch-id: e725b9cf221da371b19d5aef5d1b4a5e813a19ee
prerequisite-patch-id: 932d88887d4028aee27a809eeb89d1dc7835acc8
prerequisite-patch-id: 48554c57f1d06553af3ded861ebf9b88ee6b03c4
prerequisite-patch-id: c26315d8be3a746b04dea921d41c903d054b774f
prerequisite-patch-id: fc598d2febb873efbaf53d4abfba4fe9c27aee52
prerequisite-patch-id: 77b58bda743a1fde9b0b040f7832ec3d5853ea75
prerequisite-patch-id: a64b4850058cd9189ccca081847f8908dbf91ae3
prerequisite-patch-id: 73a6bb8ed4e20eb90127f1c2e6361d52ae17791c
-- 
2.43.0


