Return-Path: <linux-kernel+bounces-69601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA2858C3A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7761F21BA6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75AE210E1;
	Sat, 17 Feb 2024 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bCl3uOfV"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA420B03
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131523; cv=none; b=bqPZZ6R7Vex5QwCh9zD5T13SmoAakXxuq5rDXH320vF0OyWpps1JHokMHBFwYW4c/q3+mMfC5x66l5+zF0Xf5VXR7XQJ5rd/isxIrvxiCKBTroSGV244Cf4+dVJs5sMd+bodnimy6eyi1FBrNjKK9plS/ocR4bz6sVtaKX5Hs5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131523; c=relaxed/simple;
	bh=bv/FYmkztJnwsY2iW6Bp2G7/4vfUAi73vHt5Pq3FWHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KmJ4fkg3umFv3F3oS4E2E4p6OOSQsmWNxeuL3oGOMuFCieV/cKPWsx6Or87x/kexATUWuZ/lM9C/PDWzX0aYT3/cITpG+/2F5KA9j+nEX9ASs8Dm7muT7rOOnl4VYoJEOjWNOs3sebmii0TJJnEnOL4lnzpsvNHmWDoYD5P06RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bCl3uOfV; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c40863de70so65077739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708131520; x=1708736320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jA2bwMTLdR68IYWhAHQk0vem/FIvLYvJUSgd6oUDROA=;
        b=bCl3uOfVV496vzz46fQ0TikB5r01tMiO7gRsNhHvbY4pQ9W6hGfXwMlcbfPIKuqOut
         Ui+SYKp0nopFJ277DEbYuqOyXEiNq0r92OFfc0wVNmUtlcjxpBPwOe7WTIhvbmb1p9We
         EaQQSmbc/uNb4EY+3HUa2Rv6zdfYXkzgv+UpQIZHGDxrR1nz4Fj+FRV6MsB4mVfSGd8L
         gbfL5O/cAoJ0fnGh8x01qUJK49Of6AG1anwve9tAodeUGGaNNoAXmiglB4I+Up/3aqx3
         KRQMygnqvcEUAG/hwLNH0NCiFPZ2jBD1E7ziP83lc/OjHz2j8GqN5EDYh3t52V6KOLMo
         xdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708131520; x=1708736320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jA2bwMTLdR68IYWhAHQk0vem/FIvLYvJUSgd6oUDROA=;
        b=bEIv6ece/6YioUTmFM+JnUR1uHRXIM/3RO67JuL21bbXvmdzyZMHP4nPvtKDgjtC5D
         n4zgt4ljgdatFJ/yngEdC46xb4flmAouPufS8WhxU3SCh9FIOiLPbNnan4dALIsBPQnq
         PED7T6zshUeA0+TosBGAC1Rhzu7RuwJykAklRUTiDMLU3sDvYgnOpaRrtR8y6gZOwG4O
         RVvedgRzskfNmW/C+GH5XV7TV578OFbysKykBhNZqBOFog2NEn5tOFwI/J4W4PWNbpXN
         AecEXgRrleT3f3UEMmTZJL6RWdITPa15CdqrDKWf6wRlY1Q8kHZ+TwkrVF8x58zSGpnI
         1hcQ==
X-Gm-Message-State: AOJu0YwMfciCVYJqU7CRaCi+YPV+KsOEvMPaGsG5vXUdkxlBXlFfRiJG
	IgzYCCf7HkIRA8mXWk+ChyBenute9Xs3dkZEaYCSyFWJBODMLvy3Pu5kxHOe4au2zHBEk43fPkC
	+
X-Google-Smtp-Source: AGHT+IEdeqVqcC/VKKKrXOEHY/VeTvf9ltSju1U8A00Dr62R9FD2Xfm3+udDPMEcDgQNQ3u+AM/jrg==
X-Received: by 2002:a5e:c10c:0:b0:7c7:2e71:bb74 with SMTP id v12-20020a5ec10c000000b007c72e71bb74mr626708iol.4.1708131520123;
        Fri, 16 Feb 2024 16:58:40 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d188-20020a6336c5000000b005dc89957e06sm487655pga.71.2024.02.16.16.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:58:39 -0800 (PST)
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
Subject: [PATCH RFC 10/20] dt-bindings: riscv: add Smcntrpmf ISA extension description
Date: Fri, 16 Feb 2024 16:57:28 -0800
Message-Id: <20240217005738.3744121-11-atishp@rivosinc.com>
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

Add the description for Smcntrpmf ISA extension

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 15adeb60441b..149ecf2a8af3 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -135,6 +135,13 @@ properties:
 	    directlyi accessible in the supervisor mode. This extension depend
 	    on Sscsrind, Zihpm, Zicntr extensions.
 
+	- const: smcntrpmf
+	  description: |
+	    The standard Smcntrpmf supervisor-level extension for the machine mode
+	    to enable privilege mode filtering for cycle and instret counters.
+	    The Ssccfg extension depends on this as *cfg CSRs are available only
+	    if smcntrpmf is present.
+
         - const: smstateen
           description: |
             The standard Smstateen extension for controlling access to CSRs
-- 
2.34.1


