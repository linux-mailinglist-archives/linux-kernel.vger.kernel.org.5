Return-Path: <linux-kernel+bounces-133723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1401189A7C3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B337D1F21CF3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C6B1DDF5;
	Sat,  6 Apr 2024 00:01:51 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17205374E9;
	Sat,  6 Apr 2024 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361710; cv=none; b=QHIoht/tYkifOwk1N+n2GBvCe8VcU2ku+u7ISAZ/NsdBBMRwq9pl8+UugXUIEhTJtPK4Ph2LeNpumE6+hQQOEHhuibsorFYsIBFRjjNgpW1QQYT0Rrf+XIMcojLVl26A2g1l2KLDARiAa77amye0J9lQzl9DiNzdWA8dDk9JOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361710; c=relaxed/simple;
	bh=p6x8emMlb5sgZ91fMZ4D2Et3LnvjKvx11+hGtjrV5vM=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=blTpMWN/wcaxNlAR06a186HM+uk6I1kiTdgzM160/KrtG5wdTq57c+tI4B1Qp7I9xsJKUvSJJ2seQuJ97jP/pyviMK+BHDPwVBI5kuJD3b/fc/847moWVkSKkhblMQzN+icTAOpcPa0UKBVdkdg/6dc99LVUkE7FNJL35IuCaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69f53.dsl.pool.telekom.hu [::ffff:81.182.159.83])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F985.00000000661090EA.0025D55A; Sat, 06 Apr 2024 02:01:46 +0200
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
  Daniel Lezcano <daniel.lezcano@linaro.org>,
  =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v5 0/3] switch platform profiles with Lenovo laptops
Date: Sat,  6 Apr 2024 02:01:30 +0200
Message-ID: <cover.1712360639.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Hi All,

This patch series adds a platform_profile_cycle function to the platform 
profile module, which allows modules to easily switch between the 
enabled profiles.

Use it in ideapad-laptop and thinkpad-acpi modules.

Best regards,
Gergo

Changes in v5:
 - use find_next_bit_wrap function to find the next enabled profile 
 instead of multiple ffs calls

Changes in v4:
 - move the cycle to the platform profile module where it can switch 
 between the enabled profiles
 - add a patch to use it in the thinkpad-acpi module

Changes in v3:
 - add dytc_profile_cycle function

Changes in v2:
 - only switch platform profiles if supported, otherwise keep the 
   behavior.

[4]: https://lore.kernel.org/all/cover.1712282976.git.soyer@irl.hu/
[3]: https://lore.kernel.org/all/7c358ad8dd6de7889fa887954145a181501ac362.1712236099.git.soyer@irl.hu/
[2]: https://lore.kernel.org/all/797884d8cab030d3a2b656dba67f3c423cc58be7.1712174794.git.soyer@irl.hu/
[1]: https://lore.kernel.org/all/85254ce8e87570c05e7f04d6507701bef954ed75.1712149429.git.soyer@irl.hu/


Gergo Koteles (3):
  ACPI: platform-profile: add platform_profile_cycle()
  platform/x86: ideapad-laptop: switch platform profiles using thermal
    management key
  platform/x86: thinkpad_acpi: use platform_profile_cycle()

 drivers/acpi/platform_profile.c       | 39 +++++++++++++++++++++++++++
 drivers/platform/x86/ideapad-laptop.c |  7 +++--
 drivers/platform/x86/thinkpad_acpi.c  | 19 ++-----------
 include/linux/platform_profile.h      |  1 +
 4 files changed, 47 insertions(+), 19 deletions(-)


base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
-- 
2.44.0


