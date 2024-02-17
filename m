Return-Path: <linux-kernel+bounces-69595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B6858C23
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975CE1C21054
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725591D529;
	Sat, 17 Feb 2024 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Xkx/aXIF"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E21CD1C
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131507; cv=none; b=HVbu/mmAx7UhJL8YZZaDYGqXIve/zTezJy+Nr3BN1X8yL40evwsxdHL32Po1kPrap7zOQNM/bSd2TyWtPm6ZyFJ0fmfdUHi+fdUayHDfrQLmLk2dBK8erzTu3LAPQaJDS6/hWWB8uJAM9AKVskTcDel5S822T5eZkRJ58hx1c1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131507; c=relaxed/simple;
	bh=wApsm5WI3b6ryt2xXhsST9JCFAgMEijoZLP8Q80/+38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0I5AM5NoHT07zPYTw4atwaGdhEE1Ho+3s3zTMILERoB1ZZpgeYALir6ctyewMVCdcMFtnsYik47wPhHJN3R8yQuu0WtVYquCANxTnY0T72gKS08INpfI9NZJtBmpjlph1ztUZoAJv/AGhRvikkJdV4BB11N0dPOz9JoJlhF4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Xkx/aXIF; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-204f50f305cso1848292fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708131504; x=1708736304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGOhtuG2UaHnTQxcaDC8cd9FvgXaDTb+kFLo3H4sRjk=;
        b=Xkx/aXIFtLL4NOJc6WW/nbFdMM55wijiJf33fSfxT4oQ/0dI2L51iSNq5BqkJEQEIS
         kSl9FnspmGN/OXdOapUYOu2JtFO07t1BQFtSktvQgZAoxLMV95yE+GfMwCLxM0WLzueY
         DiLl7jQ6b/w2uOkwMwZP5C3zKk9FfL5LNjLlpcf85fVIPtR01XF1kwcKuzjUHbcUOW5a
         M6sHden2tY7WexLYgpwmwOYb90tKfpHgtMBqBrvUhJBrZ/AvqG23XFcDuElyRvFOo5PE
         roELP8VvyLjOlOP+lAvGPVi8m+yUiCEP6Ml2MBO8kEb/OT25ZAMyN3Ld6eGBSsHQbutN
         gpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708131504; x=1708736304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGOhtuG2UaHnTQxcaDC8cd9FvgXaDTb+kFLo3H4sRjk=;
        b=pMuGyLWDfN81JbhPbzTJfGkBldezcMuzonH8SYnW8+5mbjDWyC287lNpDJ28O5T7PQ
         W2okGyNKJv0M10Fpl/CT3LWzWebntlIy4RGVnIq1prQpnR5M9NY+qgyns6Fgc08n8Lor
         S0t2T1iF0znGYBme21UKK6xlYU9j4WytYFJQ4Pg/wGa3vNaLh6Ww3/45eLuf/a9JuzW/
         7OtF53eScLtNq92npLKDKWJ6F6vHpAaddqJd5QID12UypHjosft4vMf5jzsv1my0F4iJ
         frfnnA7w9d3M5a0Imfx96eh11tJZbor0uz7VKkVVRFTAzvH8LAox6qzg5XwuTyTs5KqV
         xYdQ==
X-Gm-Message-State: AOJu0YydLb2iso3krRDaEANgUGolaXvCEhrgswWPiBTKEffOksqadzq6
	m02t1yROMX0/OGCAg2dRma9b5OOhVw0Joyh0du3hmM6xDf4SuBWv7sYHwRKvYn0uVDOy4tVhOvP
	W
X-Google-Smtp-Source: AGHT+IHVmqRBo/P6TbzgA+IGRtey54aZ2Ug+NftR1Tt1j04Iczb8JXsSk87BBrBxRg2sWo4RpRMoyA==
X-Received: by 2002:a05:6870:40d3:b0:21e:7fba:1960 with SMTP id l19-20020a05687040d300b0021e7fba1960mr1993804oal.18.1708131504258;
        Fri, 16 Feb 2024 16:58:24 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d188-20020a6336c5000000b005dc89957e06sm487655pga.71.2024.02.16.16.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:58:23 -0800 (PST)
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
Subject: [PATCH RFC 04/20] dt-bindings: riscv: add Sxcsrind ISA extension description
Date: Fri, 16 Feb 2024 16:57:22 -0800
Message-Id: <20240217005738.3744121-5-atishp@rivosinc.com>
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

Add the S[m|s]csrind ISA extension description.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 63d81dc895e5..77a9f867e36b 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -134,6 +134,20 @@ properties:
             added by other RISC-V extensions in H/S/VS/U/VU modes and as
             ratified at commit a28bfae (Ratified (#7)) of riscv-state-enable.
 
+	- const: smcsrind
+          description: |
+            The standard Smcsrind supervisor-level extension extends the
+	    indirect CSR access mechanism defined by the Smaia extension. This
+	    extension allows other ISA extension to use indirect CSR access
+	    mechanism in M-mode.
+
+	- const: sscsrind
+          description: |
+            The standard Sscsrind supervisor-level extension extends the
+	    indirect CSR access mechanism defined by the Ssaia extension. This
+	    extension allows other ISA extension to use indirect CSR access
+	    mechanism in S-mode.
+
         - const: ssaia
           description: |
             The standard Ssaia supervisor-level extension for the advanced
-- 
2.34.1


