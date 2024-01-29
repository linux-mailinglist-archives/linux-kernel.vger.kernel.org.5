Return-Path: <linux-kernel+bounces-43482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E914841471
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A010F1F213C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BB31552F2;
	Mon, 29 Jan 2024 20:41:01 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226C604C5;
	Mon, 29 Jan 2024 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560860; cv=none; b=AVJI+tHPw9Sp8cx/Q/4E2I1+xBymubPZuz5NPHi336DWA+8Ax5n2323Eo7rx+5YaGHBjWnyt6MYL5LM9V5kYr/TECnRIcRcizYQNfoVSPgLBTaE3MDT5rQt/kFeHWlS4eOozp5WVrgjwcubN/tkQhafbI5rUjcv3GvWYkXp7Ar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560860; c=relaxed/simple;
	bh=bgKBzEUJGevs+03viKCGW7Vn/kvA4V7Wl7NnMIBDmXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rZ7f4oP6CNmY4H3oYB451QU4C6Qpj8deUXrr+Ej97rKOY953a7aFoHLBZYPOqGfjwnfBo4CItRi04QdyK0fAWQ0Rjnw0jR7jool9ghDvaDVwcmTZw4mPc8RqxBbklaYqybyRfIvuHLAa5DUTb1Ctiz5/p+sr8cuUiG+rvpcAfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id da105db8dd8b6701; Mon, 29 Jan 2024 21:40:54 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4F993669776;
	Mon, 29 Jan 2024 21:40:54 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: [PATCH v1] thermal: sysfs: Make trip hysteresis writable along with trip temperature
Date: Mon, 29 Jan 2024 21:40:54 +0100
Message-ID: <4565526.LvFx2qVVIh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrges
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

Notes:

 * I don't think that CONFIG_THERMAL_WRITABLE_TRIPS is very useful.
   The only thing controlled by it is whether or not the writable trip
   mask used during registration will have any effect and this is quite
   confusing.  Some drivers select it for this reason which seems a bit
   odd to me.

   Maybe it can be dropped after the patch below?

 * IMO the writable trips mask itself is quite cumbersome and it would be
   better to mark individual trips as writable in the trips table passed
   during registration.  This would be less prone to mistakes and it
   would allow the code to check whether or not the given trip should
   be writable (root can change sysfs file modes after all).  If I'm not
   mistaken, this change should not be very hard to make, although it may
   take some time to switch over all of the relevant drivers from using
   the mask.

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
+		if (IS_ENABLED(v) &&
+		    mask & (1 << indx)) {
 			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
 			tz->trip_hyst_attrs[indx].attr.store =
 					trip_point_hyst_store;




