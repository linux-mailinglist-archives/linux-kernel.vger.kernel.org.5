Return-Path: <linux-kernel+bounces-59441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC3884F72B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B61F21D6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1B7F493;
	Fri,  9 Feb 2024 14:14:55 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6967AE4A;
	Fri,  9 Feb 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488094; cv=none; b=LgHLn2rTK/gkS/22ClL3IsXyKR4ekiDKK2nVjlRL9bSkseBFpPcxAag/wEonezkuVL+AA4+jsRHcYVOV+51euABvvrUhF2UWS4R4wwegfoU5AET1P8THerocx/P9zy1J5e/SorbYlHKZzBsPY7LaeL4wVDschJEXpQitH4Xzq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488094; c=relaxed/simple;
	bh=Fdyr0vbCOxxml792JxhFekjDRwIaFLknFjO9gt91Sd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hAYGNcokSn3KVqZR4vovQg9xynfSn2/zVBBN+xunvX8vENhtyciQpyJG34OVcev5bHGNCDzAnD6gMm720RI3mf4I8AJ2EXXgRsryKQj7xRp3nZ9jKOkM/39RDLbmLI1VlsbsbKo1//wn0wEbY5xJbvvO/2qDBHBk+4hYSFYgeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id c430e78c73a3d589; Fri, 9 Feb 2024 15:14:49 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 04D75669C4D;
	Fri,  9 Feb 2024 15:14:49 +0100 (CET)
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
Subject: [PATCH v1 0/9] thermal: Writable trip points handling rework
Date: Fri, 09 Feb 2024 15:02:23 +0100
Message-ID: <3232442.5fSG56mABF@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgr
 rhhordhorhhgpdhrtghpthhtohepshhtrghnihhslhgrfidrghhruhhsiihkrgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

Hi Everyone,

The purpose of this patch series is to allow thermal zone creators
to specify which properties (temperature or hysteresis) of which
trip points can be set from user space via sysfs on a per-trip basis
instead of passing writable trips masks to the thermal zone registration
function which is both cumbersome and error prone and it doesn't even
allow to request different treatment of different trip properties.

The writable trip masks used today only affect trip temperatures (that is, if
a trip point is in a writable trips mask, its temperature can be set via
sysfs) and they only take effect if the CONFIG_THERMAL_WRITABLE_TRIPS kernel
configuration option is set, which appears to be assumed by at least some
of the drivers using writable trips masks.  Some other drivers using them
simply select CONFIG_THERMAL_WRITABLE_TRIPS which pretty much defeats its
purpose (and imx even sets this option in its defconfig).

For this reasons, patch [1/9] removes CONFIG_THERMAL_WRITABLE_TRIPS and makes
the writable trips masks always work.

Moreover, trip hysteresis, which is not affected either by the writable trips
masks or by CONFIG_THERMAL_WRITABLE_TRIPS, can only be set via sysfs if the
set_trip_hyst() operation is provided by the given thermal zone, but currently
this thermal zone operation is used by no one, so effectively trip hysteresis
cannot be set via sysfs at all.  This is not a problem for the majority of
drivers that want trip temperatures to be set via sysfs, because they also
don't want trip hysteresis to be changed for any trips (at least as far as I
can say), but there are use cases in which it is desirable to be able to
update trip hysteresis as well as trip temperature (for example see
https://lore.kernel.org/linux-pm/20240106191502.29126-1-quic_manafm@quicinc.com/).
Those use cases are not addressed here directly, but after this series
addressing them should be relatively straightforward.

Namely, patch [2/9] adds flags to struct thermal_trip and defines two of them
to indicate whether or not setting the temperature or hysteresis of the given
trip via sysfs is allowed.  If a writable trips mask is passed to
thermal_zone_device_register_with_trips(), is it is used to set the
"writable temperature" flag for the trips covered by it and that flag is
then consulted by the thermal sysfs code.  The "writable hysteresis" trip
flag is also taken into account by the thermal sysfs code, but it is not set
automatically in any case.

Patch [3/9] is based on the observation that the .set_trip_hyst() thermal zone
operation is never used - it simply drops that callback from struct
thermal_zone_device_ops and adjusts the code checking its presence.

Patches [4-8/9] update drivers using writable trips masks to set the new
"writable temperature" flag directly instead and some of them are simplified
a bit as a result.  After these patches, all of the callers of
thermal_zone_device_register_with_trips() pass a zero writable trips mask
to it, so patch [9/9] drops that mask from the functions argument list and
adjusts all of its callers accordingly.

After all of the changes in this series, allowing the hysteresis value to be
set via sysfs for a given trip is a matter of setting its "writable
hysteresis" flag (and analogously for trip temperature).

Thanks!




