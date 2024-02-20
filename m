Return-Path: <linux-kernel+bounces-73205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A5985BF49
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72B1B22920
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E96BB38;
	Tue, 20 Feb 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CxXPKZVX"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68556745F1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441198; cv=none; b=ah/E56XeH5svEZKIB1p/dk5ULcKTkrN3Ph/NEi7iNEvyfH3gPx8N282DvAmA2tLHiEA4Tkv5wPNpOH+0xkrBCQEnDdmQjN48Mm2dZE60C+bmB/wzgYYDyDl10GWjx3OKEubcpcuqaldpbykjzAj/Fc9pjIiCxE4KuRrZ3u6fTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441198; c=relaxed/simple;
	bh=2g9LcPnH5YAZ/S+PepurIxIGpLcMskvJDuA7mDjT8Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NGV2dTsq48FpPNqLYVYIUTZRnSjCIlesKyQ25BwYP7CrFfeBWHAc+IVuOI8LYO0EcGITzcGEJZ1CAoZBZZDKixuZGHtgBz2mq612BxJJkxK8oFiuH9WTHSptZW1p47m+ykClsWX/if80gKGxpXQpKYbZ7Kxw7QQuv4Bs2CHbe/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CxXPKZVX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410e820a4feso37286125e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708441195; x=1709045995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=srxTKj/NUZFuJQko8D1JWG1zd/3QbRcjQ+DRmUNuvH0=;
        b=CxXPKZVXkB9FCZJKhasVsCrmPXq5NwYbbQy61Dekpegv8A5FcatzPQpJgXhBzG+apF
         er8JAo1bFra1Nf6hOyZB2sxB7FJjBnWM0Jxs8n66X56R9iotaKlI/Aktu4apXgmz5q+H
         B2NnaDKGXozrBgWJ3c5B8VGXhfCoOEZsoe3wJUDTVnWDmmFSES8fwfwiN2czZzm1AFsr
         rDL0LnNwR7pTb3lb1BvqX+O7DTKYVdsHyHkLeH4P94lTfMq8q5EAUvXhF/ZS9X+SFB8E
         S5MWMi9TEtmukh2IHwa6CEEG53U1diKAedNC6x+aPizob/oRwK8gjIuD5Yc2AXaEVlIv
         ssfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441195; x=1709045995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srxTKj/NUZFuJQko8D1JWG1zd/3QbRcjQ+DRmUNuvH0=;
        b=o0E3k1/t6hPO4eUK6B7L4YHe4QV7jlQp6kAPFjwXKEXirkA58aOAy9bYqhkdYT+gHK
         48KLWaETuINkbOoJM3MLI5B4eMUazdGNknovQi2BThcVen0QwWmyg6PdE+e6cY53nSNg
         99H/8/EX350YzHlMjTun2kMfOOyUsByvyahYsAWwPdmHdn9aPrm++oTZR5EEQA6CmFqI
         W2DkNd4RzZTduDCaUpWVqtUbPS2mUfYr++P7r+vmqJjZxPtWPi4UUT+UfcwENYGHb+Il
         r2N7wG+BCEyENjZmQQ94DcqPG9FvHthWUPjJrzK9Zy64U3hlamMbldpJrQVFg+Jf3a4c
         uZnA==
X-Forwarded-Encrypted: i=1; AJvYcCX4x3g0GYaCyMHp3p5GJnHG5BKAibnQohPYAXzvoRGW0TEVeQkPNPND+Mk8fGOHHReMBIc9ar4GRVv8BkH+7JmO7WtLjvhEmehAZzy6
X-Gm-Message-State: AOJu0YxADV/tCP2nPzxx6TofzIvDbw54MgtI8EJf0Jthr1GBctXKFAmy
	vMt+4LEi61tK9aOxSYlWakWhC82IxLgYBShYW7DiTXZM7OWHqEnPAnfKu3i/7us=
X-Google-Smtp-Source: AGHT+IGoZ12/HJdh5JXOFNK3u7cPShEpcGd/MlU9rkqxFoq73RjSNBz88He/+s6YAv8PPsc7Ti7I7w==
X-Received: by 2002:a05:600c:1d1a:b0:411:db41:687c with SMTP id l26-20020a05600c1d1a00b00411db41687cmr15174599wms.13.1708441194664;
        Tue, 20 Feb 2024 06:59:54 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:8deb:bfb9:b028:6d5c])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0033d39626c27sm9304405wru.76.2024.02.20.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:59:53 -0800 (PST)
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
Subject: [PATCH v5 0/5] Rework system pressure interface to the scheduler
Date: Tue, 20 Feb 2024 15:59:42 +0100
Message-Id: <20240220145947.1107937-1-vincent.guittot@linaro.org>
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


