Return-Path: <linux-kernel+bounces-118625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44AA88BD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163051F3D959
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B8A4C60B;
	Tue, 26 Mar 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FToa3iYj"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24113524A5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444584; cv=none; b=VyluruA0oFVvBMp3jxgzbTzqGOhF/haFNFDx8/k+8g1an5RFCciCLT6y5R4P07hTtb7TEGu9OOpyBsRZo2wm2bTwz5Xzem/e+mNDE/cmchRaqI9gTdHNc1ezAYLPLxBLEyWb47PyDpaoEMR06VQF/laeb3DcZjWaJ5y4iD4dYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444584; c=relaxed/simple;
	bh=MK7HHUtMiaa9A53g7A9QIOnjiYLOXvRotsPfgJa1LLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZFiCSKk2e94SIlRJ01/W92wdOrz1wLy19jo8oewzhr2sT203KSW4MRkoVjaveLpoBCanFTOn57BGui7gRc+mtj/CpKdRRJiHz03rDOcnmTG8VGfdmInpnaD4f7inPoGYkgNiTloX0etGfKQpPwMJubU3UVRaEGva/KfMc/sURiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FToa3iYj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-341c9926f98so1588337f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711444580; x=1712049380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QcCk2kfNGvdaBITkM75nEhX5qGXp7x44gB568VCUt38=;
        b=FToa3iYj8JRQTmy1rpESbBA7faZXvO04UFhRCPB/VRuCcNHsSbZXfVj+77rghPv6jV
         qUEjI3W8Ea9exwRmtaXZSBnxsPZt5QmGSslG0XVOZmf08BnNrvuD46cl9jbtRYV0eJdk
         lnzPQoPYJiQ9xYZ4OJQLrzdTaqgLZ+n9jGiV6+QT6xxrZ9X0TMJb/8fICqn/MGzAHd7u
         E5di2fyrCFSdEqRNOTdTKz6P2+gh1Ao0PTpBTr5lhCKmca+n1GAUS5JRKeQZMHhLpP1+
         3IDiAOKPo+kbD2H3oqFOrXNidlZzhQiqibvLkfsG1qsg8RAP9nkyp7R+Tsf/432IJb06
         J+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711444580; x=1712049380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcCk2kfNGvdaBITkM75nEhX5qGXp7x44gB568VCUt38=;
        b=Ojf68y6fMO1cV+0AnVPYTiX7YWSDoc04qygDBrv5WgZMLGREow7RG0XX5Y+C+akj18
         1IuBxdoNfRjvTPyVuGHqPJEgH4ezl/fjhwqPDPb8vF6Q4RouzFR2Xvx0heD9MeHzfc4o
         kOXAwspHvI662Crl+jA6fCDtj5yg5m7DNFR/bxgK2LeZ7LOF3zZtfCUwiUJ7E9ME4utf
         OvS5UoQZC6/ujkD9+wQqnEFlTaKeyz8YxBK69SbHIsAT9UJ6jlA0uHfjjsfGbeCmFqSb
         /eDW1duDNnGP4g7tBXXQ/euGnYEbdepPql864Yrfz4E+W9Txmqcyb+LJZ1G4cff3cY+W
         dMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBfISL/01PWEo02Jn6Q9vFfuZwce28vKLuqHbYUZfLTFe339VHm40js3oxECakEo7PsmtEFfCcYiRhVawX/0HH3JD29BCTWWZpImku
X-Gm-Message-State: AOJu0YzSMGSecbwBIyz4hiGN4VZ4ehaJBERzedUOa2MtwOl5zs/TV3AF
	gy3o7WNUieZS3zmsVZ2EmaIDuYe5e4e3QuxwIh1tZXUvhMQL3VDq7Qj63x2W+K0=
X-Google-Smtp-Source: AGHT+IHPIOfByqNHi3u6ysUFuyRgD6rr0wqWolqBcmXXpi2X6rqRrQrQay0Z+FRtQsOrVs94hogLgg==
X-Received: by 2002:adf:f3c9:0:b0:33e:7f51:c2fa with SMTP id g9-20020adff3c9000000b0033e7f51c2famr6482511wrp.47.1711444580402;
        Tue, 26 Mar 2024 02:16:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e6b6:c92e:43ff:71d7])
        by smtp.gmail.com with ESMTPSA id m15-20020adffe4f000000b0033e5c54d0d9sm11647606wrs.38.2024.03.26.02.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:16:19 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rui.zhang@intel.com,
	mhiramat@kernel.org,
	daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 0/5] Rework system pressure interface to the scheduler
Date: Tue, 26 Mar 2024 10:16:11 +0100
Message-Id: <20240326091616.3696851-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the consolidation and cleanup of CPU capacity in [1], this serie
reworks how the scheduler gets the pressures on CPUs. We need to take into
account all pressures applied by cpufreq on the compute capacity of a CPU
for dozens of ms or more and not only cpufreq cooling device or HW
mitigiations. We split the pressure applied on CPU's capacity in 2 parts:
- one from cpufreq and freq_qos
- one from HW high freq mitigiation.

The next step will be to add a dedicated interface for long standing
capping of the CPU capacity (i.e. for seconds or more) like the
scaling_max_freq of cpufreq sysfs. The latter is already taken into
account by this serie but as a temporary pressure which is not always the
best choice when we know that it will happen for seconds or more.

[1] https://lore.kernel.org/lkml/20231211104855.558096-1-vincent.guittot@linaro.org/

Change since v5:
- Rebase to fix a conflict in include/linux/cpufreq.h
- Add few more tested and reviewed tags

Change since v4:
- Add READ_ONCE() in cpufreq_get_pressure()
- Add ack and reviewed tags

Change since v3:
- Fix uninitialized variables in cpufreq_update_pressure()

Change since v2:
- Rework cpufreq_update_pressure()

Change since v1:
- Use struct cpufreq_policy as parameter of cpufreq_update_pressure()
- Fix typos and comments
- Make sched_thermal_decay_shift boot param as deprecated

Vincent Guittot (5):
  cpufreq: Add a cpufreq pressure feedback for the scheduler
  sched: Take cpufreq feedback into account
  thermal/cpufreq: Remove arch_update_thermal_pressure()
  sched: Rename arch_update_thermal_pressure into
    arch_update_hw_pressure
  sched/pelt: Remove shift of thermal clock

 .../admin-guide/kernel-parameters.txt         |  1 +
 arch/arm/include/asm/topology.h               |  6 +-
 arch/arm64/include/asm/topology.h             |  6 +-
 drivers/base/arch_topology.c                  | 26 ++++----
 drivers/cpufreq/cpufreq.c                     | 36 +++++++++++
 drivers/cpufreq/qcom-cpufreq-hw.c             |  4 +-
 drivers/thermal/cpufreq_cooling.c             |  3 -
 include/linux/arch_topology.h                 |  8 +--
 include/linux/cpufreq.h                       | 10 +++
 include/linux/sched/topology.h                |  8 +--
 .../{thermal_pressure.h => hw_pressure.h}     | 14 ++---
 include/trace/events/sched.h                  |  2 +-
 init/Kconfig                                  | 12 ++--
 kernel/sched/core.c                           |  8 +--
 kernel/sched/fair.c                           | 63 +++++++++----------
 kernel/sched/pelt.c                           | 18 +++---
 kernel/sched/pelt.h                           | 16 ++---
 kernel/sched/sched.h                          | 22 +------
 18 files changed, 144 insertions(+), 119 deletions(-)
 rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)

-- 
2.34.1


