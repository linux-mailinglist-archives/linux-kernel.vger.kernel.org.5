Return-Path: <linux-kernel+bounces-69613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EED858C60
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7171F21F60
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BFB33CF9;
	Sat, 17 Feb 2024 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IgB1jEAv"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0742E827
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131539; cv=none; b=p5aXMP1Mq4mCbVXEzZP/GwW3TueJn0Rwv8Lx5BUZ4jh0Cx2jPCV2nb2rWTl8kkhH+S7NgnDvkia6TauspDMiJDcJfgR2VfZpYn6BeJW17vT1vONRIowkJAE+Y3r1NL7k8B+fg7P4VcnVyeiL10U5OfW8zoW3Bo4LA19aOoU9Ia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131539; c=relaxed/simple;
	bh=54qScfthhEAuE+eosMKvOHGN/ixxPgbOd6VfF3jL3Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gg/9aVk4xxqiWWZWP7qe2yo+PZtsGmRhtqPBxFAv0T2QOArxZAKOMUgPbwlp8KzruX3kFS8R+VdyClB5uM4bn4jOi1r2+Qho90gWHxmCLHTSAGkBAXFlYhVCmnSsctBzCsYtRZU2rhLXFsBUCzd5deHQ4xSFshvnKeY33+gwJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IgB1jEAv; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-204235d0913so985170fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708131536; x=1708736336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM8zssVewnxKekt4u8gJqVdaJ7ofC8o/V7nPW8x9v/k=;
        b=IgB1jEAvE7iziKe+kiL4G5rklZhg3WbbRBBwz4ZZG025TosNvCatOhacEuCwYZbbDv
         1/OIZ0YFWVO7/uytWcDkABOvZeIpc47ewmvGP51nsbyn5RcQteoyW3DPeETQr+BmZJ4/
         h1RKcwHZEs2mEyB/rpYav+dk/Qv7CN43JjuOwG+5lRD9PEhuqTwoPZxzXz3oNbu1Whnb
         Ao7T+RPeGC3Z/WDky5jnm8Qz7MdD9y78/JnrqYQgYkXMBZE/oav16ct1GHza/lJyVeJF
         ZmCFbxTAEKMyt111fBvI4dS1xyrutETKjgC/h7vZ492YLeysf0CJ+edkROLAe8e1t3KP
         XMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708131536; x=1708736336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM8zssVewnxKekt4u8gJqVdaJ7ofC8o/V7nPW8x9v/k=;
        b=vAmgpyI1zJ+EYnCtqyVtzxShh6KlqufXQAuoR4PIhVSNZhOA+/vhqCGL1/FYSA4NEU
         cwuujrLVE5EYkUA3/T0UAU9mVHelwAhvxj0O0YBLl1hKpaor2Mr2ktAjq1JTfytHD5mz
         3XFoJyyIZcI+bQz6NG9JhY7rmxr4cN0A/ebEX3EjTKJHNFX6TgYqw2QtsBIAuk/Nfy4W
         M+7XSkE8cBxRoL8KbOvtaNLnrSeIYl/3tjzrq9jzXWWfC15LtcCHu1VxdIvPFVTs/Ed5
         3BPH5UKRq/CFhZ8oYyMe+y1+LpS0D7xcggQEo+JASJEDiukCFjmmEYmj0KOBBvIwiojs
         sorg==
X-Gm-Message-State: AOJu0Yz9FTfu9uChXxF/OZv7CtYAEbQhYj9fuinuqY/U4B84/ae/mt6h
	LOdstd5BPTwIGYNbn7Yu1HGgwdDydUK5RIl0BU5Dqa/VktrB2PM17FlphU/izS7XOi2fywQyg1P
	Y
X-Google-Smtp-Source: AGHT+IHxQ/ohabidKPISMfSUq9m2exq/kzmKZJs/ZvDEyG8lUk4zXZLeanKyyRpfmzqm9XJNLg+WQw==
X-Received: by 2002:a05:6870:d88d:b0:218:df68:87b2 with SMTP id oe13-20020a056870d88d00b00218df6887b2mr6753520oac.44.1708131536206;
        Fri, 16 Feb 2024 16:58:56 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d188-20020a6336c5000000b005dc89957e06sm487655pga.71.2024.02.16.16.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:58:55 -0800 (PST)
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
Subject: [PATCH RFC 16/20] tools/perf: Pass the Counter constraint values in the pmu events
Date: Fri, 16 Feb 2024 16:57:34 -0800
Message-Id: <20240217005738.3744121-17-atishp@rivosinc.com>
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

RISC-V doesn't have any standard event to counter mapping discovery
mechanism in the ISA. The ISA defines 29 programmable counters and
platforms can choose to implement any number of them and map any
events to any counters. Thus, the perf tool need to inform the driver
about the counter mapping of each events.

The current perf infrastructure only parses the 'Counter' constraints
in metrics. This patch extends that to pass in the pmu events so that
any driver can retrieve those values via perf attributes if defined
accordingly.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/pmu-events/jevents.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 30934a490109..f1e320077695 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -278,6 +278,11 @@ class JsonEvent:
         return fixed[name.lower()]
       return event
 
+    def counter_list_to_bitmask(counterlist):
+      counter_ids = list(map(int, counterlist.split(',')))
+      bitmask = sum(1 << pos for pos in counter_ids)
+      return bitmask
+
     def unit_to_pmu(unit: str) -> Optional[str]:
       """Convert a JSON Unit to Linux PMU name."""
       if not unit:
@@ -401,6 +406,10 @@ class JsonEvent:
       else:
         raise argparse.ArgumentTypeError('Cannot find arch std event:', arch_std)
 
+    if self.counter:
+      bitmask = counter_list_to_bitmask(self.counter)
+      event += f',counterid_mask={bitmask:#x}'
+
     self.event = real_event(self.name, event)
 
   def __repr__(self) -> str:
-- 
2.34.1


