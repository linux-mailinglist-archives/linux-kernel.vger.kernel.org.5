Return-Path: <linux-kernel+bounces-19731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B06A82720E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C5C1F2350A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4A047780;
	Mon,  8 Jan 2024 15:03:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4579B4777C;
	Mon,  8 Jan 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb7e50679bso223476b6e.0;
        Mon, 08 Jan 2024 07:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704726183; x=1705330983;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9JyEXfT6jEk1OohZvyCKkji4/UiuSeEyA0R4Ybp9cA=;
        b=NSv/QpnE8mCA4LPMoGKSq52CD0NdxskHJC3OeH2FXu/sVr7GM0etGRgU/rdJt2yY7E
         1zM9EMNC16bVSa6xd2Xbj9O3UJm+t6QJW/WhnZ6s1OTiBc1mHz3h8fvLENdW08kzIWG9
         o8lfjSoPRtgfSl+u1WmL1C7tJusJIy+6L/LBd3nihbgl/5DDaV0lY+U8JWLtnTce0ajB
         30qzOOCTHhmSG9K+iNv0Qc9NYGBeY3YmC+dgBYtpZmwVZWcS/LVkSNfqOytMjSv9tRhJ
         I/+tjrRCOfWtFj2dbXWY2RFP+uJMPYzoUNHbUyVUMScEtr2ZwgAZRNEzXVZF7dpiyJ7x
         Y+Jw==
X-Gm-Message-State: AOJu0YyGOGfbqOZeV1Vv2eLcjG25rccjA4Mya3gZtiixev2SGxJqDR88
	FFkySq6qZ5UNDDl+6o4z/Zp/1yGs7nc/pTvumpsTYtCwmCA=
X-Google-Smtp-Source: AGHT+IHB7Zirjd8hwWN6rwHYKs4XmEbhrznNBmeqdFDs2kubRuMwyC8W/yvUZCKDrcT9RaMcktO96hn0yAfC1Kj+oHA=
X-Received: by 2002:a05:6808:6296:b0:3bd:26c1:54e5 with SMTP id
 du22-20020a056808629600b003bd26c154e5mr4076748oib.1.1704726182997; Mon, 08
 Jan 2024 07:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jan 2024 16:02:51 +0100
Message-ID: <CAJZ5v0h91BzSHFd9XnV-yq72WNiJBcYTqtKnZWTgkuzGhVvvRw@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.8-rc1

with top-most commit f1e5e4639781724d05d90309900321baaecfde74

 Merge branch 'pm-sleep'

on top of commit 610a9b8f49fbcf1100716370d3b5f6f884a2835a

 Linux 6.7-rc8

to receive power management updates for 6.8-rc1.

These add support for new processors (Sierra Forest, Grand Ridge and
Meteor Lake) to the intel_idle driver, make intel_pstate run on
Emerald Rapids without HWP support and adjust it to utilize EPP values
supplied by the platform firmware, fix issues, clean up code and improve
documentation.

The most significant fix addresses deadlocks in the core system-wide
resume code that occur if async_schedule_dev() attempts to run its
argument function synchronously (for example, due to a memory allocation
failure).  It rearranges the code in question which may increase the
system resume time in some cases, but this basically is a removal of a
premature optimization.  That optimization will be added back later, but
properly this time.

Specifics:

 - Add support for the Sierra Forest, Grand Ridge and Meteorlake SoCs to
   the intel_idle cpuidle driver (Artem Bityutskiy, Zhang Rui).

 - Do not enable interrupts when entering idle in the haltpoll cpuidle
   driver (Borislav Petkov).

 - Add Emerald Rapids support in no-HWP mode to the intel_pstate cpufreq
   driver (Zhenguo Yao).

 - Use EPP values programmed by the platform firmware as balanced
   performance ones by default in intel_pstate (Srinivas Pandruvada).

 - Add a missing function return value check to the SCMI cpufreq driver
   to avoid unexpected behavior (Alexandra Diupina).

 - Fix parameter type warning in the armada-8k cpufreq driver (Gregory
   CLEMENT).

 - Rework trans_stat_show() in the devfreq core code to avoid buffer
   overflows (Christian Marangi).

 - Synchronize devfreq_monitor_[start/stop] so as to prevent a timer
   list corruption from occurring when devfreq governors are switched
   frequently (Mukesh Ojha).

 - Fix possible deadlocks in the core system-wide PM code that occur if
   device-handling functions cannot be executed asynchronously during
   resume from system-wide suspend (Rafael J. Wysocki).

 - Clean up unnecessary local variable initializations in multiple
   places in the hibernation code (Wang chaodong, Li zeming).

 - Adjust core hibernation code to avoid missing wakeup events that
   occur after saving an image to persistent storage (Chris Feng).

 - Update hibernation code to enforce correct ordering during image
   compression and decompression (Hongchen Zhang).

 - Use kmap_local_page() instead of kmap_atomic() in copy_data_page()
   during hibernation and restore (Chen Haonan).

 - Adjust documentation and code comments to reflect recent tasks freezer
   changes (Kevin Hao).

 - Repair excess function parameter description warning in the
   hibernation image-saving code (Randy Dunlap).

 - Fix _set_required_opps when opp is NULL (Bryan O'Donoghue).

 - Use device_get_match_data() in the OPP code for TI (Rob Herring).

 - Clean up OPP level and other parts and call dev_pm_opp_set_opp()
   recursively for required OPPs (Viresh Kumar).

Thanks!


---------------

Alexandra Diupina (1):
      cpufreq: scmi: process the result of devm_of_clk_add_hw_provider()

Artem Bityutskiy (2):
      intel_idle: add Grand Ridge SoC support
      intel_idle: add Sierra Forest SoC support

Borislav Petkov (AMD) (1):
      cpuidle: haltpoll: Do not enable interrupts when entering idle

Bryan O'Donoghue (1):
      OPP: Fix _set_required_opps when opp is NULL

Chen Haonan (1):
      PM: hibernate: Use kmap_local_page() in copy_data_page()

Chris Feng (1):
      PM: hibernate: Avoid missing wakeup events during hibernation

Christian Marangi (2):
      PM / devfreq: Fix buffer overflow in trans_stat_show
      PM / devfreq: Convert to use sysfs_emit_at() API

Gregory CLEMENT (1):
      cpufreq: armada-8k: Fix parameter type warning

Hongchen Zhang (1):
      PM: hibernate: Enforce ordering during image compression/decompression

Kevin Hao (2):
      Documentation: PM: Adjust freezing-of-tasks.rst to the freezer changes
      PM: sleep: Remove obsolete comment from unlock_system_sleep()

Li zeming (2):
      PM: hibernate: Do not initialize error in swap_write_page()
      PM: hibernate: Do not initialize error in snapshot_write_next()

Mukesh Ojha (1):
      PM / devfreq: Synchronize devfreq_monitor_[start/stop]

Rafael J. Wysocki (3):
      async: Split async_schedule_node_domain()
      async: Introduce async_schedule_dev_nocall()
      PM: sleep: Fix possible deadlocks in core system-wide PM code

Randy Dunlap (1):
      PM: hibernate: Repair excess function parameter description warning

Rob Herring (1):
      opp: ti: Use device_get_match_data()

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Prioritize firmware-provided balance
performance EPP

Viresh Kumar (10):
      OPP: Level zero is valid
      OPP: Use _set_opp_level() for single genpd case
      OPP: Call dev_pm_opp_set_opp() for required OPPs
      OPP: Don't set OPP recursively for a parent genpd
      OPP: Check for invalid OPP in dev_pm_opp_find_level_ceil()
      OPP: The level field is always of unsigned int type
      OPP: Move dev_pm_opp_icc_bw to internal opp.h
      OPP: Relocate dev_pm_opp_sync_regulators()
      OPP: Pass rounded rate to _set_opp()
      OPP: Rename 'rate_clk_single'

Wang chaodong (1):
      PM: hibernate: Drop unnecessary local variable initialization

Zhang Rui (1):
      intel_idle: Add Meteorlake support

Zhenguo Yao (1):
      cpufreq: intel_pstate: Add Emerald Rapids support in no-HWP mode

---------------

 Documentation/ABI/testing/sysfs-class-devfreq |   3 +
 Documentation/power/freezing-of-tasks.rst     |  85 ++++----
 drivers/base/power/main.c                     | 148 ++++++-------
 drivers/cpufreq/armada-8k-cpufreq.c           |   4 +-
 drivers/cpufreq/intel_pstate.c                |  15 +-
 drivers/cpufreq/scmi-cpufreq.c                |   7 +-
 drivers/cpuidle/cpuidle-haltpoll.c            |   9 +-
 drivers/devfreq/devfreq.c                     |  80 +++++--
 drivers/idle/intel_idle.c                     | 114 ++++++++++
 drivers/opp/core.c                            | 294 +++++++++++++++-----------
 drivers/opp/of.c                              |  57 ++++-
 drivers/opp/opp.h                             |  24 ++-
 drivers/opp/ti-opp-supply.c                   |  13 +-
 include/linux/async.h                         |   2 +
 include/linux/pm_opp.h                        |  28 +--
 kernel/async.c                                |  85 ++++++--
 kernel/power/hibernate.c                      |  10 +-
 kernel/power/main.c                           |  16 --
 kernel/power/power.h                          |   2 +
 kernel/power/snapshot.c                       |  16 +-
 kernel/power/swap.c                           |  41 ++--
 21 files changed, 658 insertions(+), 395 deletions(-)

