Return-Path: <linux-kernel+bounces-7622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24A81AAEB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607081C229E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B54A9B9;
	Wed, 20 Dec 2023 23:16:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05839FE1;
	Wed, 20 Dec 2023 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFA1D2F4;
	Wed, 20 Dec 2023 15:17:38 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D2853F64C;
	Wed, 20 Dec 2023 15:16:52 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v3 0/9] Add callback for cooling list update to speed-up IPA
Date: Wed, 20 Dec 2023 23:17:44 +0000
Message-Id: <20231220231753.1824364-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

The patch set adds a new callback for thermal governors and implementation for
Intelligent Power Allocator.

The goal is to move some heavy operations like the memory allocations and heavy
computations (multiplications) out of throttle() callback hot path.

The new callback is generic enough to handle other important update events.
It re-uses existing thermal_notify_event definitions.

In addition there are some small clean-ups for IPA code.

The patch set is based on current pm/bleeding-edge branch (20 Dec).

changes:
v3:
- changed helper name to thermal_governor_update_tz() with also
  "reason" argument (Rafael)
- added thermal_governor_update_tz() to thermal_core.h for use from sysfs
  functions 
- changed names of the events (THERMAL_TZ_BIND_CDEV) (Rafael)
- patch 2/9 changed header and comment for function (Rafael)
- patch 3/9: used unsigned types for num_actors, buffer_size (Rafael)
- changed trace functions and added new patch 4/9 to be prepare tracing for
  different internal IPA array; it also drops dynamic array inside trace event
- used new structure power_actor and changed the code in patch 5/9 (Rafael)
- keept the local num_actors variable (Rafael)
- patch 6/9 skipped redundant parens and changed the header desc. (Rafael)
- patch 7/9 changed header and used instance->tz->lock (Rafael)
- patch 8/9 removed handle_weight_update() and renamed new event to
  THERMAL_INSTANCE_WEIGHT_CHANGE (Rafael)
- patch 9/9 aliged to use THERMAL_INSTANCE_WEIGHT_CHANGE is switch (Rafael)
  
v2 can be found here [1]

Regards,
Lukasz

[1] https://lore.kernel.org/lkml/20231212134844.1213381-1-lukasz.luba@arm.com/

Lukasz Luba (9):
  thermal: core: Add governor callback for thermal zone change
  thermal: gov_power_allocator: Refactor check_power_actors()
  thermal: gov_power_allocator: Refactor checks in divvy_up_power()
  thermal: gov_power_allocator: Change trace functions
  thermal: gov_power_allocator: Move memory allocation out of throttle()
  thermal: gov_power_allocator: Simplify checks for valid power actor
  thermal/sysfs: Update instance->weight under tz lock
  thermal/sysfs: Update governors when the 'weight' has changed
  thermal: gov_power_allocator: Support new update callback of weights

 drivers/thermal/gov_power_allocator.c | 269 ++++++++++++++++----------
 drivers/thermal/thermal_core.c        |  14 ++
 drivers/thermal/thermal_core.h        |   2 +
 drivers/thermal/thermal_sysfs.c       |   7 +
 drivers/thermal/thermal_trace_ipa.h   |  50 +++--
 include/linux/thermal.h               |   7 +
 6 files changed, 226 insertions(+), 123 deletions(-)

-- 
2.25.1


