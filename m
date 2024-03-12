Return-Path: <linux-kernel+bounces-100005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E7E87908F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2773E1F23443
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6570D7AE4A;
	Tue, 12 Mar 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iEMB7xDZ"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518997A15A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235056; cv=none; b=kax37p7XhqY022f38YihhdHhkTgdZ66HPW20rvbwEKZUXfB8cTeg1Ck5KJjLLd72nv9UCJpJLYgdmkxsC44f53icM2ixKITjrTrpnKXUwAgGKSi4EHCBeswgVp0uArP+Unk3do/+M3oqltWLdwilk0PAKDVsw53LGwFH+SmsswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235056; c=relaxed/simple;
	bh=96gu/HF0E/TqgKrIVV5r7UQM0Lg+1Xe5Ztq6xGJ0d8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QKom9KRMvluvb56kDP23EX1fK0vbRuicg16etGcbEwFsi9CC+BYuQAuGEk5nyj9mDC51PfvZ68i72y79o82E6TPSx0D3QYmqNBA3GOQMhthYNIYswTy0zjgO6ifUzWb+QxIA8uomCiUvWnENid86i3HLsBvwlM9lnaPJ3+BW+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iEMB7xDZ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2D4F1BF20A;
	Tue, 12 Mar 2024 09:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710235046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NLQUNOLqCOUn2wdFP82EZjhVPZ0pd7rP48tSbRo2xXM=;
	b=iEMB7xDZHZg+RIx3cNrgdZUXBvVhD1jDSy0HKUHSL49fNiYgqr8MqsOk/+9FpEoCASyRI0
	Q+wlFk/QM5fvMF0nL865qkyoUGy8IqdFPVYyF2PTpaOeysDF8Uc2/2B61v3a4gvknIK9yS
	N4rDPTDEfl/bnKNB+5LcsmqRLdfd20Gzc7sIq5kDX6TmG4JyFbqsVDBgS6UC2E0FMQwicO
	VWf74WLvQ377NiAFDHlPslbyfX60PdKXFINQb+CtAhT+ATOFr8egTSMXJawbo+ybtZ2Dv2
	C4XoUeHpgDnjsexamJjNsyDPvSxv0OSsv2pQ2/ccvjigxWdFr3u6cxj3p/fMHw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: linux-kernel@vger.kernel.org
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: core: Propagate the regulator state in case of exclusive get
Date: Tue, 12 Mar 2024 10:16:38 +0100
Message-Id: <20240312091638.1266167-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

Previously, performing an exclusive get on an already-enabled regulator
resulted in inconsistent state initialization between child and parent
regulators. While the child's counts were updated, its parent's counters
remained unaffected.

Consequently, attempting to disable an already-enabled exclusive regulator
triggered unbalanced disables warnings from its parent regulator.

This commit addresses the issue by propagating the enable state to the
parent regulator using a regulator_enable call. This ensures consistent
state management across the regulator hierarchy, preventing warnings!

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/regulator/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a968dabb48f5..3f499761f8b0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2274,6 +2274,17 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		if (ret > 0) {
 			rdev->use_count = 1;
 			regulator->enable_count = 1;
+
+			/* Propagate the regulator state to its supply */
+			if (rdev->supply) {
+				ret = regulator_enable(rdev->supply);
+				if (ret < 0) {
+					destroy_regulator(regulator);
+					module_put(rdev->owner);
+					put_device(&rdev->dev);
+					return ERR_PTR(ret);
+				}
+			}
 		} else {
 			rdev->use_count = 0;
 			regulator->enable_count = 0;
-- 
2.25.1


