Return-Path: <linux-kernel+bounces-69614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236AE858C64
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF10B23DE2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA13770E;
	Sat, 17 Feb 2024 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WrLODcPp"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DA33CD9
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131542; cv=none; b=bPaudxd1HddQndJbuhXYQU+4wv+waGbyvuslV8iENjulogz/f+LGhf7CMTO+3WK7TNBxikilGiKI+L9kdolpEv/l0URjLr/ibElfcKrgzWr0NA4fiUxVNBIiXxN0zgumGFizXcdWolJQ/719Y7sNt0uo/2WKDPTVIFPLhnGyIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131542; c=relaxed/simple;
	bh=9DAIMVm8fvPVvSUhtbVjIqqHxtU2fJeSDtTzHSCfXnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hH9locTE2gak4QsGmTaFtIYr/ZUlJ1Rgzi+qK2wJ9U5w5ktMQJvKFCM/k6KcKVsSU5fkWY0ksvRkta+28LtztF5WoD8+KJxU/PiQSX5JNBFlYz4WaA22WvpVfgF8k0pvtAiDLt+NZCxkYVUSJ2AA5S1PpTMN79RTJblLEWXidbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WrLODcPp; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21e10a0fa24so1277544fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708131539; x=1708736339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOdL5Y7wmQdu3cBOk4Oia1bMlPhRJp0p0ru1YQcJjcc=;
        b=WrLODcPpHGx0Lc6FyjAbFiuCgRbdCVaojVz6xr2Mkl1Hx5YJBwDbJtid/KKOAtn9x4
         S4jIzf1VBMiawm1HFgaKuS5xJBpHhah/njFYh6sAiAs6jW3BeEwWqHJsEHWs976adLRC
         AUH/5X3pt7xjoTXGspD6CGUqIixEtcQlHssqd4qmc79mOExPVJMpEfC9pGm8xwr1FVUO
         C7QMBDQk3LaQAo3TZOcuDLXmpNj+YGsf1uLbrQECQUKMNL79DrhZAHCpIOnwnCCcBbB7
         IyvwPBg7NA6//CsnLABc7HsCjrjsv1Di6diKO4tc4DNRk6yHoS0jhgytjsrybhqV7EPx
         QSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708131539; x=1708736339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOdL5Y7wmQdu3cBOk4Oia1bMlPhRJp0p0ru1YQcJjcc=;
        b=Qoym0ir9tfGYuctaoKIai1SPm24hzMp6/F50mb63GPVItYtk5FpZV7QfIkDqXCbAs+
         /sqb6FF5DTvKlaGALoAHBU8lURCLjvpLUJ4kcXdu1RjVZEdmPTzTvCukQFgmvHbfQzNx
         gZoedtninqWm3gEmtPrEqBElP2Dr3ArEjM3WqzcWyv2AU9ro/tVuup1zZ+lA9kyCHS3s
         xol7bn/henZQhsyO4/AVNW0at/Q87V2uYmR+gMpeAUVA7WvTrjTd8vgNa6lQn4F0YGDQ
         Sqda3U6XU4vrIfnxmCjsnDgxVxEemUomN/EZ4zButl4rV/pPWXdHHvgdhyvYjiYMX7Ij
         nodw==
X-Gm-Message-State: AOJu0YzUGW06+87QxwF/Nvzy70zyTobroC1lZVQMcjAm28IRlqhyW97V
	IBFoaF99bLfM8CcQ9hjQOnSdrkys+8y/uWmlVG/rUKuBWuBhtW/fN4r9vpDZKkBma4Jr3O6JZV9
	g
X-Google-Smtp-Source: AGHT+IHFCfL+kwIHjaTpNxoNxqc+zu9FKDlVsVbSX+8xeWrslZki49h1LDIhhrjmSSo0/9Xc9V8bBQ==
X-Received: by 2002:a05:6871:b26:b0:21e:430b:79e2 with SMTP id fq38-20020a0568710b2600b0021e430b79e2mr5862300oab.47.1708131538814;
        Fri, 16 Feb 2024 16:58:58 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d188-20020a6336c5000000b005dc89957e06sm487655pga.71.2024.02.16.16.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:58:58 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor@kernel.org>,
	devicetree@vger.kernel.org,
	Evan Green <evan@rivosinc.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	John Garry <john.g.garry@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kan Liang <kan.liang@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Will Deacon <will@kernel.org>,
	kaiwenxue1@gmail.com,
	Yang Jihong <yangjihong1@huawei.com>
Subject: [PATCH RFC 17/20] perf: Add json file for virt machine supported events
Date: Fri, 16 Feb 2024 16:57:35 -0800
Message-Id: <20240217005738.3744121-18-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217005738.3744121-1-atishp@rivosinc.com>
References: <20240217005738.3744121-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux driver will use the event encodings specified in platform
specific json file only for platforms with counter delegation support.

Use the perf json infrastructure to encode those events and let the
driver uses that if counter delegation is available.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../pmu-events/arch/riscv/qemu/virt/cpu.json  | 30 ++++++++
 .../arch/riscv/qemu/virt/firmware.json        | 68 +++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/qemu/virt/cpu.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/qemu/virt/firmware.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index cfc449b19810..b3e7d544e29c 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -17,3 +17,4 @@
 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
+0x0-0x0-0x0,v1,qemu/virt,core
diff --git a/tools/perf/pmu-events/arch/riscv/qemu/virt/cpu.json b/tools/perf/pmu-events/arch/riscv/qemu/virt/cpu.json
new file mode 100644
index 000000000000..9ab631723c88
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/qemu/virt/cpu.json
@@ -0,0 +1,30 @@
+[
+  {
+    "ArchStdEvent": "instructions",
+    "EventCode": "0x02",
+    "Counter":"2,3,4,5,6,7,8,9,10"
+  },
+  {
+    "ArchStdEvent": "cycles",
+    "EventCode": "0x01",
+    "Counter":"0,3,4,5,6,7,8,9,10"
+  },
+  {
+    "EventName": "dTLB-load-misses",
+    "EventCode": "0x10019",
+    "BriefDescription": "Data TLB load miss",
+    "Counter":"3,4,5,6,7,8,9,10"
+  },
+  {
+    "EventName": "dTLB-store-misses",
+    "EventCode": "0x1001B",
+    "BriefDescription": "Data TLB store miss",
+    "Counter":"3,4,5,6,7,8,9,10"
+  },
+  {
+    "EventName": "iTLB-load-misses",
+    "EventCode": "0x10021",
+    "BriefDescription": "Instruction fetch TLB load miss",
+    "Counter":"3,4,5,6,7,8,9,10"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/qemu/virt/firmware.json b/tools/perf/pmu-events/arch/riscv/qemu/virt/firmware.json
new file mode 100644
index 000000000000..9b4a032186a7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/qemu/virt/firmware.json
@@ -0,0 +1,68 @@
+[
+  {
+    "ArchStdEvent": "FW_MISALIGNED_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_MISALIGNED_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ILLEGAL_INSN"
+  },
+  {
+    "ArchStdEvent": "FW_SET_TIMER"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
+  }
+]
-- 
2.34.1


