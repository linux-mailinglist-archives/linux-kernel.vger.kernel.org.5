Return-Path: <linux-kernel+bounces-62209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78DB851D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DA22825B3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22C246544;
	Mon, 12 Feb 2024 18:42:34 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23CF3FE36;
	Mon, 12 Feb 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763354; cv=none; b=c8ZZycxkYQ+g0ZOla0f+i8uiNngM8E4elzkdP1UMKwJDh+xrjQlxfIzbQ0KbBKz1QBlsK01KFeECRxmsCNWTKzws4EN0am3Tx/MkXP0W8D7P9zThemKQQHsB45MweeWNFBjY9E+NqW3iw/5UolNfqylCvK4zGRivSaJMGjPRPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763354; c=relaxed/simple;
	bh=L3NRX4YCC5wAmVuFoBGeSlDkUFlbjD5+xbxslNXvKy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJUkBZLxTH+lo/cDoOv3pgz0wnyWw2ycPO1VqOtY1LiwGwFrkzb0Z9bX9te75zH++AY0RQ4whXlJopHSM8fyy8LtcyqCwUZb+7ZwWIxoEeuac54owHBwQSQxbqXDEV6vJecfNjdcTJyJLMITNS/JjRreDRd5Li9IAogg/ektEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 0f78f23c5a53093c; Mon, 12 Feb 2024 19:42:29 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9385C669CF2;
	Mon, 12 Feb 2024 19:42:28 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: [PATCH v2 8/9] thermal: of: Set THERMAL_TRIP_FLAG_RW_TEMP directly
Date: Mon, 12 Feb 2024 19:40:34 +0100
Message-ID: <9235101.CDJkKcVGEf@kreacher>
In-Reply-To: <6017196.lOV4Wx5bFT@kreacher>
References: <6017196.lOV4Wx5bFT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshht
 rghnihhslhgrfidrghhruhhsiihkrgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
to allow their temperature to be set from user space via sysfs instead
of using a nonzero writable trips mask during thermal zone registration,
so make the OF thermal code do that.

No intentional functional impact.

Note that this change is requisite for dropping the mask argument from
thermal_zone_device_register_with_trips() going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rename trip flag (Stanislaw).

---
 drivers/thermal/thermal_of.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/thermal_of.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_of.c
+++ linux-pm/drivers/thermal/thermal_of.c
@@ -117,6 +117,8 @@ static int thermal_of_populate_trip(stru
 		return ret;
 	}
 
+	trip->flags = THERMAL_TRIP_FLAG_RW_TEMP;
+
 	return 0;
 }
 
@@ -477,7 +479,7 @@ static struct thermal_zone_device *therm
 	struct device_node *np;
 	const char *action;
 	int delay, pdelay;
-	int ntrips, mask;
+	int ntrips;
 	int ret;
 
 	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
@@ -510,15 +512,13 @@ static struct thermal_zone_device *therm
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
 
-	mask = GENMASK_ULL((ntrips) - 1, 0);
-
 	ret = of_property_read_string(np, "critical-action", &action);
 	if (!ret)
 		if (!of_ops->critical && !strcasecmp(action, "reboot"))
 			of_ops->critical = thermal_zone_device_critical_reboot;
 
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
-						     mask, data, of_ops, &tzp,
+						     0, data, of_ops, &tzp,
 						     pdelay, delay);
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);




