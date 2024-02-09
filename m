Return-Path: <linux-kernel+bounces-59433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449BD84F70A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CB01C2206B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0F974E22;
	Fri,  9 Feb 2024 14:14:47 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5365BBC;
	Fri,  9 Feb 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488087; cv=none; b=Cyd/WK9gvNF0td89ycBUC0a7PovpVOniSSf7N6Wd4T2VFwT1c5y5gUBb/FRYljRBquDNqapwMv3cDz95oSe6YDEt3UTAaRPMT5XKzn/qnngfbpG+nCUEQNxhAP6bxAAACJoHvK5QQoRPHdhOO5+6wvO5bR4WFnKXoLEMfC0VlC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488087; c=relaxed/simple;
	bh=0aV/S+3kFjqWSHlmNGQrAPqW+jmdMdKldoo/BBfTj9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUr1OKzlf9SFOxxDeeKZT20OMop/9Ace2DAAhanOH9v65hFXPmIR68EflJ9px+w807OyHia/YS6VUdmG30hp4qzrDjSmCU7ZQrala4RzBrkxiMkJclX5xQiMvX/kV4HvpIfH/CQPrmqjL6Qx2i3oBhu8hHYtXCNH0Ut2jRfDGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 3bbb5adbc2281c63; Fri, 9 Feb 2024 15:14:42 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6DA10669C4D;
	Fri,  9 Feb 2024 15:14:41 +0100 (CET)
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
Subject: [PATCH v1 8/9] thermal: of: Set THERMAL_TRIP_WRITABLE_TEMP directly
Date: Fri, 09 Feb 2024 15:12:55 +0100
Message-ID: <2209601.Icojqenx9y@kreacher>
In-Reply-To: <3232442.5fSG56mABF@kreacher>
References: <3232442.5fSG56mABF@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgr
 nhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is now possible to flag trip points with THERMAL_TRIP_WRITABLE_TEMP
to allow their temperature to be set from user space via sysfs instead
of using a nonzero writable trips mask during thermal zone registration,
so make the OF thermal code do that.

No intentional functional impact.

Note that this change is requisite for dropping the mask argument from
thermal_zone_device_register_with_trips() going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
 
+	trip->flags = THERMAL_TRIP_WRITABLE_TEMP;
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




