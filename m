Return-Path: <linux-kernel+bounces-56977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98D384D217
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D551F25BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A3E1272BC;
	Wed,  7 Feb 2024 19:13:02 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9185954;
	Wed,  7 Feb 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333182; cv=none; b=mXZaUPWeqoyVRPYy7RRGKDA3aVqAGHB6xcsGjgcvk13edL3mfUZdcrO7Y+vWWgqQJulqO8PzDFZDjfUHqFsJiKmuK+RqgXjtgWavAhS7Micfsn2d/mDUk68NWr9q6R8IjbcyQ3DoM7enQsKug9S2j39VLlH/tHE3A5qYHB33PRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333182; c=relaxed/simple;
	bh=mrBbjhTnXeyV6fjV83s22Ro95nfA5WuWbc6HKUQTVrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j++aIRA9daJ1bsDfPA68OYEC1bLsCPPx+5gy0yQkToypzbl3iJN+mQ7dT2b8WTHwPX0NAgJ/E954uU4gprpuSjQeiSvyPIRQC5E5AaUTo5p+ZY8HF2TgyutT6uAv4+9e6PZpUcOvxJSsWIvhzHbXPm5f048tC3qXbS/9BDR4XgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id f148895491a4f1fa; Wed, 7 Feb 2024 20:12:51 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B4C9D669B2E;
	Wed,  7 Feb 2024 20:12:50 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Gregory Greenman <gregory.greenman@intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v1 0/3] iwlwifi: mvm: Thermal management fixes
Date: Wed, 07 Feb 2024 20:08:18 +0100
Message-ID: <1892445.tdWV9SEqCh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtddvgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgohhrhidrghhrvggvnhhmrghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhhirhhirghmrdhrrggthhgvlhdrkhhorhgvnhgslhhithesihhnthgvlhdrtghomhdprhgtphhtthhopehkvhgrlhhosehk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrsggvrhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

Hi Everyone,

There are a few thermal management shortcomings in the iwlwifi driver that are
addressed by this series.

First off, the fw_trips_index[] array field in struct iwl_mvm_thermal_device
is only populated and never read, and the code populating it has problems,
so patch [1/3] removes it.

Second, iwl_mvm_thermal_zone_register() populates the trip table after passing
it to thermal_zone_device_register_with_trips() which is too late, because it
can get used before it is populated.  It also may as well use THERMAL_TEMP_INVALID
as the "invalid temperature" value.  Both these issues are addressed by patch [2/3].

Finally, iwl_mvm_send_temp_report_ths_cmd() accesses the trip tables used during
thermal zone registration directly in order to obtain the current trip point
temperature values, which is not guaranteed to work in the future, because the
core will store the trips information in its own copy of the trip table - see
this patch series:

https://lore.kernel.org/linux-pm/2728491.mvXUDI8C0e@kreacher/

If possible, I'd like to route the $subject series through the thermal tree,
it is requisite for the above one.

Thanks!




