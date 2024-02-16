Return-Path: <linux-kernel+bounces-67873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 176B1857237
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BAA1C23370
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5A0EC2;
	Fri, 16 Feb 2024 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EC4M+qPn"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D138F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042122; cv=none; b=fiyprE3AONl8zuTcrAjG/vAIbhSfda7aaxDn4Ym9WX5PcOD8aa7rbz7GWHx9U4tjaXJAppguKdOTZYHohgjtcvIYdWPHUyFtZtghZrXttRv7LP3HzI7ygrqzZwJET0S1729Hu4OW+hA0yK1sznFbncUD0tRr2SezBSUBnpemn8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042122; c=relaxed/simple;
	bh=wilcIZvJ/x2WKbnzX+mmzsMLHlca/WywYpRCsQDmwww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PU4VEywR8MyqImTQiIAIVzXmHskAb/rxWMYlZIxCRF8evLfIFeShlNBuLQur2a4Peq2i48GPbrkAVj84bQGzeeVWL6y1w2qzVyZdTlrMzinUuR0NUt+l81anVspkRRITcCe8eHvL5JI5PEnsErLwwiAT8gAWpO00QRzJBJnxD6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EC4M+qPn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d932f6ccfaso12998075ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708042120; x=1708646920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B80341bISXEJg7kkhbXc2oX5/huCFSNjahGhVu6ondM=;
        b=EC4M+qPnjeOd0i1tU2ZbepLIJMf3Sj8cPQJh1UORZZBqM/DFFi+80azk+JAOSOAyHl
         0kVFPuRylocuX8/lv55c6o5wSw6a2lfU+jHNs5ngSfzCOUHQvyU5ca+SrP4/gcV4hXxj
         PymOOlgEnQMmN3WCQdMZGwLMeQa12acACv4BX9SYtpFhA88ePdLGOICexIHFmEyDGcPT
         748hf8jJqYavCisBe83X03kARuey5SVHHnjL+0+SGu8yGoY9HPU32piXAi5t4ik6n6/Z
         ccZdKhRHs38ZxubYrr19AyvDmWXpu9j7indWSChusfMCvB0tBVj8u3UuQDUAhwmp+a30
         PCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042120; x=1708646920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B80341bISXEJg7kkhbXc2oX5/huCFSNjahGhVu6ondM=;
        b=brCDOenxSXXqfJCsJsJ6VNholdYAI2QWNYHXs55kwNY4radstxYl28F9uhWxd7bd9K
         Gm8lFsRoA2VfvSjVA3HfJ91vowwxeL6svb8407EtV9lfOAWcperV6BA9hunbiH1A0HeD
         o3dkrkxEf1Z1USh2HH9ZxUo/UOp/1QXaHEiACFIhym6L5LbudJhqKvNim/Kf+bdHLYYe
         aISH2qJYwJ1zkaKgno+B6b6G9t13D/PNAtLi/IE7OWPEmssb7uukcC9qhV/xG9QhZDjo
         Mu1C24TJ1X/balnDLfboHRs/xtykLAdp3mptBiDR8Vo10mruhTUBEXYNkCoYqJ5XmqMf
         AV7w==
X-Forwarded-Encrypted: i=1; AJvYcCVdf9iXqEieKn/6tV2zTDtP/0YdNUjQhDwFAYMgTCqxzFHcRbMo8ar5rlvxzHE7FELxyqy2eaMzGD+UmUvSRsORCely+lhC5wXbRby/
X-Gm-Message-State: AOJu0YxREHRfgtDXiFKR4FrgGe4rfZ+IcSPuVZwKXjd1zN8AfKIlml/g
	6T316Mr4uAiMcCrUmaXWMNYvNsFvTzp8YFwHOyLZJQHbX4hqh2xFCvWLDrVPa3o=
X-Google-Smtp-Source: AGHT+IEEuF0c7LmW9lUaWum18fP3MSd8qAJyzAs9OeCN6ADixKHSo/WOUDyw9k8YmlyzkxoW0t/waQ==
X-Received: by 2002:a17:902:e843:b0:1db:299f:5b0e with SMTP id t3-20020a170902e84300b001db299f5b0emr4475230plg.1.1708042120079;
        Thu, 15 Feb 2024 16:08:40 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001db3d365082sm1789486plb.265.2024.02.15.16.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:08:39 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Eric Lin <eric.lin@sifive.com>,
	Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v1 0/6] SiFive cache controller PMU drivers
Date: Thu, 15 Feb 2024 16:08:12 -0800
Message-ID: <20240216000837.1868917-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds bindings and drivers for the Performance
Monitoring Units (PMUs) found in three SiFive cache controllers.

Composable Cache and Extensible Cache support system-wide profiling
with a single hardware instance. Private L2 Cache supports per-task
profiling with a separate hardware instance per core.

All three PMUs have a similar register interface and event encoding,
though the set of supported events is different. The Extensible Cache
additionally contains a pmCounterInhibit register which allows
atomically monitoring multiple counters.

All three of these cache controllers (with PMUs) have been integrated in
SoCs by our customers. However, as none of those SoCs have been publicly
announced yet, I cannot include SoC-specific compatible strings in this
version of the devicetree bindings.

This series is a follow-up to Eric Lin's series "[PATCH v2 0/3] Add
SiFive Private L2 cache and PMU driver":
https://lore.kernel.org/linux-riscv/20230720135125.21240-1-eric.lin@sifive.com/

Changes in v1:
 - Add back select: clause to binding
 - Make sifive,pl2cache1 the fallback for sifive,pl2cache0
 - Fix the order of the reg property declaration
 - Document the sifive,perfmon-counters property
 - Drop the non-PMU part of the PL2 cache driver, as the config register
   save/restore logic will be moved to M-mode
 - Add missing events to PL2 sets 2, 4, and 5
 - Use event_base and config_base to precompute register addresses
 - Check event validity earlier, in the .event_init hook
 - Implement .filter for systems where only some CPUs have a PL2
 - Only allocate percpu data when probing each PL2 instance
 - Reference count the `struct pmu` to fix unbind/bind crashes
 - Probe via DT since the PMU driver is now the only PL2 driver
 - Allow the driver to be built as a module

Eric Lin (4):
  drivers/perf: Add SiFive Composable Cache PMU driver
  dt-bindings: cache: Add SiFive Extensible Cache controller
  drivers/perf: Add SiFive Extensible Cache PMU driver
  dt-bindings: cache: Add SiFive Private L2 Cache controller

Greentime Hu (1):
  drivers/perf: Add SiFive Private L2 Cache PMU driver

Samuel Holland (1):
  dt-bindings: cache: Document the sifive,perfmon-counters property

 .../bindings/cache/sifive,ccache0.yaml        |   5 +
 .../cache/sifive,extensiblecache0.yaml        | 136 ++++
 .../bindings/cache/sifive,pl2cache0.yaml      |  81 ++
 drivers/perf/Kconfig                          |  29 +
 drivers/perf/Makefile                         |   3 +
 drivers/perf/sifive_ccache_pmu.c              | 577 ++++++++++++++
 drivers/perf/sifive_ecache_pmu.c              | 675 ++++++++++++++++
 drivers/perf/sifive_pl2_pmu.c                 | 748 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   2 +
 9 files changed, 2256 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/sifive,extensiblecache0.yaml
 create mode 100644 Documentation/devicetree/bindings/cache/sifive,pl2cache0.yaml
 create mode 100644 drivers/perf/sifive_ccache_pmu.c
 create mode 100644 drivers/perf/sifive_ecache_pmu.c
 create mode 100644 drivers/perf/sifive_pl2_pmu.c

-- 
2.43.0


