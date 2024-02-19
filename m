Return-Path: <linux-kernel+bounces-70862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F95859D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3AB1F214E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6A22309;
	Mon, 19 Feb 2024 07:46:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753C20DC3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328802; cv=none; b=hd3RTLJuPv18c0uzimDjAIKPX3XdqsbBeqetFh1Ik1h6hdskJzRXYjn4u6pbzX4fLuVikyUjSsZTtGthcHeSXupjeLNN3K050spMnX3O93FvCxmSCHDDKYquZCwAzCYpqz3UD68aH+y27y9bHrGnIFjWv+m58Vp+5MTBQ2lotW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328802; c=relaxed/simple;
	bh=m49ew6tZDWmkpcYRR5eY0qxk5vXybz95BmqhredgINc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQOva2PeUrpVmOJoeF1DLHce6tmCgSgrc2OiJ/Zwww91mvMAjWLc4JOnEC9mcAOxXBYNkaR8AMHTGjDFpirQ+d1y/+4b55aQSyT3oWDmq9+rVqWzrx+kXy1za9V75P357jHCPewE2kneQg5q0VjD+Uts0/L4O6gWk6xXVEtXiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMI-0000QL-3c; Mon, 19 Feb 2024 08:46:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMH-001bHx-MP; Mon, 19 Feb 2024 08:46:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMH-007bvZ-1v;
	Mon, 19 Feb 2024 08:46:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thorsten Scherer <t.scherer@eckelmann.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] siox: Provide a devm variant of siox_master_alloc()
Date: Mon, 19 Feb 2024 08:46:30 +0100
Message-ID:  <ad141dd22c7d95ad0bd347f257ce586e1afb22a4.1708328466.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=m49ew6tZDWmkpcYRR5eY0qxk5vXybz95BmqhredgINc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtTL7OF+bGLK5TNznuVIxMWvfO/Iy1z88lvj5NopNl8nL Dh67/qqTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAm0qzL/s+S8dgEt9XVrFZf 7rGm/5n71kR59Zwba40iCsptfeTfne9aUci9ctvZvRJq25PjmJ+Y5YdO+PjqhgJr/seDu0y01BY H1xd0Z9V9Ez9fwhwR25ap51KYs9g3X/hA3wSeuNTi+QGORox8s+7Jebj2Ot5U4k7yU0hhiZnKso X3tNUqXkXLk5xlzyM6Ns+4fWLqGl83heutwnMlpmdXyLHPt1LITBERNY/at75z5SXbzb4NgvqvF yzivjg1UnizatiHVwdmmWY3f9tvwaM5pVSjpeT5a2FbTpbFc17JLZ7K7igWl53Tns1U12jCc8M4 +cjupROv/w/4uMk4aaX1xbts+/5ZWs98teLAiqMt5ltbAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This allows to simplify siox master drivers in the next step.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/siox/siox-core.c | 24 ++++++++++++++++++++++++
 drivers/siox/siox.h      |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index d4acab7036d6..9dd0bda03db3 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -707,6 +707,30 @@ struct siox_master *siox_master_alloc(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(siox_master_alloc);
 
+static void devm_siox_master_put(void *data)
+{
+	struct siox_master *smaster = data;
+
+	siox_master_put(smaster);
+}
+
+struct siox_master *devm_siox_master_alloc(struct device *dev,
+					   size_t size)
+{
+	struct siox_master *smaster;
+	int ret;
+
+	smaster = siox_master_alloc(dev, size);
+	if (!smaster)
+		return NULL;
+
+	ret = devm_add_action_or_reset(dev, devm_siox_master_put, smaster);
+	if (ret)
+		return NULL;
+
+	return smaster;
+}
+
 int siox_master_register(struct siox_master *smaster)
 {
 	int ret;
diff --git a/drivers/siox/siox.h b/drivers/siox/siox.h
index f08b43b713c5..b227e18b697a 100644
--- a/drivers/siox/siox.h
+++ b/drivers/siox/siox.h
@@ -45,5 +45,7 @@ static inline void siox_master_put(struct siox_master *smaster)
 	put_device(&smaster->dev);
 }
 
+struct siox_master *devm_siox_master_alloc(struct device *dev, size_t size);
+
 int siox_master_register(struct siox_master *smaster);
 void siox_master_unregister(struct siox_master *smaster);
-- 
2.43.0


