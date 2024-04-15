Return-Path: <linux-kernel+bounces-145449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373C68A564B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692AE1C21F70
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748876F17;
	Mon, 15 Apr 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="ZGStnL2w"
Received: from outbound0.mail.transip.nl (outbound0.mail.transip.nl [149.210.149.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80042047;
	Mon, 15 Apr 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.210.149.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194730; cv=none; b=ps025EluOXExbUInAaaXqjopH/j8QmyxzL7+VxNLh4Qp97iUuAaPFeFpA+W0HWuVJmb6RRV6L+D/rgEVcBT6vmdALZhH7DPx2W7K8VGuoDC/QyfIa7Ks1htKfavvI0+kJI5VgIueZLjPfWemW4mvjRXHZJuTXEzWV+CEgXNH5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194730; c=relaxed/simple;
	bh=HhAOHciiKTqEWbCIi1HnWqOda20cBLCp/JpI2EcL/Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oiw6Nf7qvZx4Mj6IOTaMAKoTdzF2cZVfLyk0HULF2Ft5oNPpFyDO8rhEoRiSyTo7Cv+JQujIHv9yGr3J1mp6TsSyJbsyA1u52oVVVANehuW2eI2lSR4IpMUu6tjns6WnGITyMpBSdwUsieMu1NCWelJADvTX8AihWWIQnV5mT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=ZGStnL2w; arc=none smtp.client-ip=149.210.149.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission12.mail.transip.nl (unknown [10.103.8.163])
	by outbound0.mail.transip.nl (Postfix) with ESMTP id 4VJ9lQ2zntzxNrr;
	Mon, 15 Apr 2024 17:17:38 +0200 (CEST)
Received: from herrie-desktop.. (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission12.mail.transip.nl (Postfix) with ESMTPA id 4VJ9lP2DHnz1BFcM;
	Mon, 15 Apr 2024 17:17:37 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: sre@kernel.org
Cc: benwolsieffer@gmail.com,
	chris.chapuis@gmail.com,
	Herman van Hazendonk <github.com@herrie.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: supply: max8903: configure USUS as output
Date: Mon, 15 Apr 2024 17:17:33 +0200
Message-Id: <20240415151733.1986047-1-github.com@herrie.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission12.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713194257; h=from:subject:to:cc:date:
 mime-version; bh=1MGoLH5b+KzBc3k0I/E6VKO47//qQEYgqkirtXpEYX8=;
 b=ZGStnL2wflzGE8xbCYgByDjGk2hqQ2LdV6CYsU8URz2rC7mzTYqLalZgdnPgz7h+Ks902J
 X28kY/o7Ny44KwEQPgo2KywlKa9rHjn1f6To1y+zAQutk2Ru/qicdX6JB3CscvHz/ahM1w
 HaeLA0M4Q0FbvB3rIgbrEiVFb3NwkhC+xot6bqCfZx4YScVOOlmrPwKzz8A5p76WyOZ59g
 uLByw/zu9B+dqS8OrLL3uLWtgeWNkQfR/8w3juODgzioZoSJQJJQvf+2ms+C63qvEzkBLh
 RmmpfCgkKm9gAIWetAVk3RSymwjdKFL+0LwAtkb2fWf2xi4y22Zsx4J0m8WY+A==
X-Report-Abuse-To: abuse@transip.nl

The USUS pin was mistakenly configured as an input, when it should be an
output that specifies whether the USB power input is suspended. In addition
to fixing the pin mode, this patch also suspends the USB input when a DC
charger is connected, which should result in a slight reduction in USB
quiescent current.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 drivers/power/supply/max8903_charger.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/supply/max8903_charger.c
index e65d0141f260..dd1cf77b101d 100644
--- a/drivers/power/supply/max8903_charger.c
+++ b/drivers/power/supply/max8903_charger.c
@@ -102,6 +102,11 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
 	if (data->dcm)
 		gpiod_set_value(data->dcm, ta_in);
 
+	/* Set USB-Suspend 1:Suspended 0:Active */
+	if (data->usus)
+		gpiod_set_value(data->usus, ta_in);
+
+
 	/* Charger Enable / Disable */
 	if (data->cen) {
 		int val;
@@ -310,7 +315,15 @@ static int max8903_setup_gpios(struct platform_device *pdev)
 				     "failed to get FLT GPIO");
 	gpiod_set_consumer_name(data->flt, data->psy_desc.name);
 
-	data->usus = devm_gpiod_get_optional(dev, "usus", GPIOD_IN);
+	/*
+	 * Suspend the USB input if the DC charger is connected.
+	 *
+	 * The USUS line should be marked GPIO_ACTIVE_HIGH in the
+	 * device tree. Driving it low will enable the USB charger
+	 * input.
+	 */
+	flags = ta_in ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	data->usus = devm_gpiod_get_optional(dev, "usus", flags);
 	if (IS_ERR(data->usus))
 		return dev_err_probe(dev, PTR_ERR(data->usus),
 				     "failed to get USUS GPIO");

