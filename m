Return-Path: <linux-kernel+bounces-1465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A24814F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08D61F24716
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24213671E5;
	Fri, 15 Dec 2023 17:45:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDAC66AC1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rECFt-00078x-RH; Fri, 15 Dec 2023 18:45:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rECFt-00G4sN-2I; Fri, 15 Dec 2023 18:45:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rECFs-003jeH-PP; Fri, 15 Dec 2023 18:45:44 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] driver core: Better advertise dev_err_probe()
Date: Fri, 15 Dec 2023 18:45:41 +0100
Message-ID: <20231215174540.2438601-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9nyC3qBbV3EnvPBE3VWr39wTOEdZ5bBIM7SZSN6E+Nc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfJDFtb2z0TS2epzNttDfkspZ9CB6UVzEyC7bO hY2NlaZb++JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXyQxQAKCRCPgPtYfRL+ ThrICACsNn0rrAtPsgnVcJ8gyfhCCMdsW63WMJMv3/s7rLcN/RUMbMudTA31KGvsc9Hr6L60kmj 52fVk+6gALEDEK9FREE5RysR6OQdS8BIne9D100cT2vFXMyMGzGPe8MNp2Csxs8u9FFvs32x72u 9HWwErAu8JfuTLjhHFKO+6fX8Q880SgKBpQwKeFizUhS3LS/FRqVHEVXZ52dqECxpPh2rGRL8Vl LcMfvkhbRzB/wI4AYE8lDyjEobmWt70YNhE0gN7il/QNsWYq1MwJ5OzhAto6ti4MzuhjSqWxz7Z PGPYnbrGkH92RZxli96w9k7u6C4Py4KSdXqJGqCrY5OvOV9q
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Describing the usage of dev_err_probe() as being (only?) "deemed
acceptable" has a bad connotation. In fact dev_err_probe() fulfills
three tasks:

 - handling of EPROBE_DEFER (even more than degrading to dev_dbg())
 - symbolic output of the error code
 - return err for compact error code paths

Advertise these better and claim the usage to be "fine" to get rid of
the bad connotation.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1:

 - Send it to a public mailing list (how embarrassing I failed to do
   that for v1 already)
 - Fix a wrong word in the commit log
 - Add Rafael's Ack.

 drivers/base/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6736c1de3ba4..14d46af40f9a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4944,13 +4944,14 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  *
  * 	return dev_err_probe(dev, err, ...);
  *
- * Note that it is deemed acceptable to use this function for error
- * prints during probe even if the @err is known to never be -EPROBE_DEFER.
+ * Using this helper in your probe function is totally fine even if @err is
+ * known to never be -EPROBE_DEFER.
  * The benefit compared to a normal dev_err() is the standardized format
- * of the error code and the fact that the error code is returned.
+ * of the error code, it being emitted symbolically (i.e. you get "EAGAIN"
+ * instead of "-35") and the fact that the error code is returned which allows
+ * more compact error paths.
  *
  * Returns @err.
- *
  */
 int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 {
-- 
2.42.0


