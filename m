Return-Path: <linux-kernel+bounces-27362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E182EEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E70C1C20FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D1F1B978;
	Tue, 16 Jan 2024 12:08:32 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445718EB4;
	Tue, 16 Jan 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59584f41f1eso841986eaf.1;
        Tue, 16 Jan 2024 04:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705406910; x=1706011710;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QruqD5hduNzd94C2ksyeMaDZDm2JrVFVFdIyp5RJ9mA=;
        b=aadhuc08Phl1P5W463JVPcrmN5d7q6l86Fs2Ieb1+3zHjysfEZY5jB/blALE5ONQe5
         Ux+LshrUFRhlh19ePDjfLPZhgWGbsvxr/FoNd2EaGkEgt4pOKijdrGLQIkKYrK4w2We+
         fQFEn8vO0WxBcVMEjn0RrfQMsEKg+K8+I51sYpG/NLWHUSKaBlmSb7gy5ldpzdWK3pO/
         ew8c3lDO5u1ZF4Hnm/+HR0EmPU+jVgQgcBH0d6gmvY8jNVbO7NG5f8bmMMq6K0j66MET
         d9sKPLA3sBfdowLuLsEBaKAHRjPG1sw8hdt/VGjsst3FXEcGjdUyjbepB4PUbKFGBtvY
         QoBA==
X-Gm-Message-State: AOJu0Yz5ffXF7vPG9aovcHhxsudvacUuwVk5HSKz4uE/n2CcniNxP/1g
	ZVLn5BHpegExuqkVYuDlLb2o/vWgx1X6u+P1V0X7aJp6ZE8=
X-Google-Smtp-Source: AGHT+IG7B6OBei7Cxtss92swB49Fb3UqDmPcZzPvNLER8i15WI81CmWn6VjN3hUbvwo0bSprnAYyvOEXDeFCZbufId4=
X-Received: by 2002:a4a:d68a:0:b0:598:e013:676d with SMTP id
 i10-20020a4ad68a000000b00598e013676dmr6073596oot.0.1705406909850; Tue, 16 Jan
 2024 04:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jan 2024 13:08:18 +0100
Message-ID: <CAJZ5v0hSZRrS7+aeqCJek5APiObgo3BW04cS0Circreb0JpJTA@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.8-rc1-2

with top-most commit 9223614ea760a77873c7061875cb91963e6f79b7

 Merge branches 'pm-sleep', 'pm-cpufreq' and 'pm-qos' into pm

on top of commit 7da71072e1d6967c0482abcbb5991ffb5953fdf2

 Merge tag 'pm-6.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 6.8-rc1.

These restore the asynchronous device resume optimization removed by the
previous PM merge, make the intel_pstate driver work better on Meteor
Lake systems, optimize the PM QoS core code slightly and fix up typos
in admin-guide.

Specifics:

 - Restore the system-wide asynchronous device resume optimization
   removed by a recent concurrency fix (Rafael J. Wysocki).

 - Make the intel_pstate cpufreq driver allow Meteor Lake systems to run
   at somewhat higher frequencies (Srinivas Pandruvada).

 - Make the PM QoS core code use kcalloc() for array allocation (Erick
   Archer).

 - Fix two PM-related typos in admin-guide (Erwan Velu).

Thanks!


---------------

Erick Archer (1):
      PM: QoS: Use kcalloc() instead of kzalloc()

Erwan Velu (1):
      Documentation: admin-guide: PM: Fix two typos

Rafael J. Wysocki (1):
      PM: sleep: Restore asynchronous device resume optimization

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Update hybrid scaling factor for Meteor Lake

---------------

 Documentation/admin-guide/acpi/cppc_sysfs.rst |   2 +-
 Documentation/admin-guide/pm/amd-pstate.rst   |   2 +-
 drivers/base/power/main.c                     | 117 ++++++++++++++------------
 drivers/base/power/qos.c                      |   2 +-
 drivers/cpufreq/intel_pstate.c                |  21 ++++-
 include/linux/pm.h                            |   1 +
 6 files changed, 86 insertions(+), 59 deletions(-)

