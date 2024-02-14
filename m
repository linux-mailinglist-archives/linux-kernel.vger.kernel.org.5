Return-Path: <linux-kernel+bounces-65217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6AF8549A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39A61C21CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CC654BD9;
	Wed, 14 Feb 2024 12:50:09 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C936535B4;
	Wed, 14 Feb 2024 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915009; cv=none; b=U2jK7zzm0Fw9xg5MTFMmcnjR8DuVObFzsHDM67O5PXi63+d/iscKzzrR6Ou0dpX/5Cp/iaozYcvro+n774MopqzJXGDovqjI+g71junVBOttLhAo4IKxWK665uSHu07hc63RjyYnxmX8kmYT7IdlTjmUY9FWSijEHda6RBCfhGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915009; c=relaxed/simple;
	bh=E01dX0hF3D+HtqydAJ3tYA9NLjs5Y6+afi+6TvtZ2Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uOUsbV+LDgCT0cgy8fExZ6Na0vr8UBwkdmemB2MTVu+yr/BIWarCmNxi09dLv8mAklVSGTo7H4dfH9KSh5Z7I8//1Kiwte5O5OJ8QWx9gSgLWSg+ynPSmzcRTMmTcgqHSQmkpp4Es8/8qrUHOdvczPpoiSxuUTnQruIM+nesgwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id e7bea7f855a21fc7; Wed, 14 Feb 2024 13:49:59 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A6B8C669DB7;
	Wed, 14 Feb 2024 13:49:58 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Subject:
 [PATCH v2 0/6] thermal: Store trips table and ops in thermal_zone_device
Date: Wed, 14 Feb 2024 13:25:25 +0100
Message-ID: <4551531.LvFx2qVVIh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhg
 vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14

Hi Everyone,

This is an update of

https://lore.kernel.org/linux-pm/2728491.mvXUDI8C0e@kreacher/

that has been rebased on top of

https://lore.kernel.org/linux-pm/6017196.lOV4Wx5bFT@kreacher/

and includes some bug fixes.

The original series description still applies:

"This series changes the PM core to copy the trips and zone ops directly
 into struct thermal_zone_device so as to allow the callers of the zone
 registration function to discard their own copies of those things after
 zone registration and/or possibly allocate them as read-only.

 The first patch makes the thermal core create a copy of the trips table which
 is declared as a flex array to enable additional bounds checking on it.  The
 next two patches update the ACPI thermal driver and Intel thermal drivers to
 take benefit of that change.

 In a similar pattern, patch [4/6] makes the thermal core create an internal
 copy of the zone ops supplied by the zone creator, so as to allow the
 original ops structure to be discarded after zone registration or allocated
 as read-only, and the next two patches update the ACPI thermal driver and Intel
 thermal drivers to actually do that.

 The other thermal drivers need not be changed, although in principle they may
 be simplified a bit too in the future.

 As usual, please refer to the individual patch changelogs for details."

However, the imx thermal driver is modified by patch [1/6], because it uses its
local trips table and expects it to contain the current passive trip temperature
value (as set via sysfs), and the thermal_of driver is modified by patch [4/6],
because it uses the ops pointer from the thermal zone device to free the ops.

Thanks!




