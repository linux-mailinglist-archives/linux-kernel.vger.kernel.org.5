Return-Path: <linux-kernel+bounces-46981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21033844767
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B631F2765D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF72134F;
	Wed, 31 Jan 2024 18:44:53 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27515210E2;
	Wed, 31 Jan 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726692; cv=none; b=A+lZQ5sXBkxA6cHG+PBnwL8xp/qSUtg8JeQDXJRzz8lo4JKLZ664HbSNRVyccWp77vhIrF0IAjG1xZQImTkuoj+WgQh8oI5SkOiuiWhwW3lYq30RMSAghMJUGPeMirl7jBk1T0GyHaMpgQ4bMHs14bNbAVZkvL3RW+KDz44geY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726692; c=relaxed/simple;
	bh=SJZuasp/X4n93SOO7Po6QJRn7g8k6HYJr2z+rfpIdK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ejg9w8oMqztPv0E5ckJNJc0EAy3Ylox6WuO2SoRfyI6dXmPPBC4NoZdvl/J6UQer2724SaNYYJ3/F0GAkfu6VHE5RqnEweUeZbwkpInoxmtF1YvpbeKMQU5TlLrY3J3bfZ7mprRWVYYr5yLKU0AIRvY4Ej8cAvXeZFNaGhGsPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 1bfd71f8478315fd; Wed, 31 Jan 2024 19:44:41 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1AEA266982B;
	Wed, 31 Jan 2024 19:44:41 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject:
 [PATCH v2] thermal: sysfs: Make trip hysteresis writable along with trip
 temperature
Date: Wed, 31 Jan 2024 19:44:40 +0100
Message-ID: <2731410.mvXUDI8C0e@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrges
 rghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Trip point temperature can be modified via sysfs if
CONFIG_THERMAL_WRITABLE_TRIPS is enabled and the thermal
zone creator requested that the given trip be writable
in the writable trips mask passed to the registration
function.

However, trip point hysteresis is treated differently - it is only
writable if the thermal zone has a .set_trip_hyst() operation defined
and neither CONFIG_THERMAL_WRITABLE_TRIPS, nor the writable trips mask
supplied by the zone creator has any bearing on this.  That is
inconsistent and confusing, and it generally does not meet user
expectations.

For this reason, modify create_trip_attrs() to handle trip point
hysteresis in the same way as trip point temperature, so they both
are writable at the same time regardless of what trip point operations
are defined for the thermal zone.

Link: https://lore.kernel.org/linux-pm/20240106191502.29126-1-quic_manafm@quicinc.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Fix patch corruption (Daniel).

---
 drivers/thermal/thermal_sysfs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -474,7 +474,8 @@ static int create_trip_attrs(struct ther
 					tz->trip_hyst_attrs[indx].name;
 		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
 		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
-		if (tz->ops->set_trip_hyst) {
+		if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
+		    mask & (1 << indx)) {
 			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
 			tz->trip_hyst_attrs[indx].attr.store =
 					trip_point_hyst_store;




