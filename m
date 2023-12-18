Return-Path: <linux-kernel+bounces-3406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3CC816BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B269B22C95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C93A19470;
	Mon, 18 Dec 2023 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1eg7c1z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D11B286;
	Mon, 18 Dec 2023 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a22f59c6aeaso333111766b.2;
        Mon, 18 Dec 2023 03:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702897563; x=1703502363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kU1LiiNj9KIu6+7tYv+GKaquR+hqOzQ4EnqPiWM+jqI=;
        b=E1eg7c1zwfkzLQGdt+4Ib6sJBdJa02aBgpbLCA6FbH7DZE/vKYd7u+NSetSHR7Nz3v
         pBE1WKk3efjRKjbKeFlMOCShuGZMpFv9FBshJ16E6xWBGxkDxsuQHtckCDSTa1hKDgLX
         u2OxPhGn5NbNKk8sDj6syK60zl/MU+D4XDuA1ppWPfuaRLTxkw/epLtX/XpaPA6XSQZ8
         O/rNqapLKSt21o5Q3DxCExNlmyEagepIWMAE2PHzYUeCq4+mo20BjUR8GzZ9/CBLSLh6
         sZYiNqJkSjrboSnVku4W0Mazyz9ZyHHkeNXvtln2mwxXmslZ3nVhapRjvl3y+9eoqhhh
         PNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897563; x=1703502363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kU1LiiNj9KIu6+7tYv+GKaquR+hqOzQ4EnqPiWM+jqI=;
        b=FnN93y74FqTuy2SyRWlUyn67pg0nJLTAX2IbrwHZhSYrDMYN3mETPEOTkaNzE/jsUK
         lSaU1FiTM6Ld1Uut8Jk3TJlxfegyTisIyImB25QF3Ie06sW+qCbwXKoAHVvBqUiN9+im
         1yrIHKixUlwsLcxPdfES4f1Tty8R1r4v06uNbrFYyCQYSzRvmKIsKF6otsU3NMl6iXQp
         7KRWIID+UxMKqzxs8CbxKbpLIPga5jQcG8MVUHtgTJbN/kOLHt7moj8wJ7qbCwC2En7z
         sqMESvRhPlfpFT29FI6Mwjh03KLh8xsMiwp5QbouWPxg/ev3by1dHygn0y41yKeFYSeM
         KCqA==
X-Gm-Message-State: AOJu0YziiEW7fs7FoCyABxpIZ4PI1KWCQPCKqsm8ZaXndTnvTcg4HeaI
	XfkA5d2cP9/+J6/tgucqmv8=
X-Google-Smtp-Source: AGHT+IEu4B8/4kbVzadsts53Sxa4qj2ceKCfsDvnjL+HyYXZThTQF8KnpEH1qhhPjPoeNforQTv/XA==
X-Received: by 2002:a17:906:74cd:b0:a23:1000:56a2 with SMTP id z13-20020a17090674cd00b00a23100056a2mr3086326ejl.12.1702897563254;
        Mon, 18 Dec 2023 03:06:03 -0800 (PST)
Received: from localhost.localdomain ([154.72.163.164])
        by smtp.gmail.com with ESMTPSA id pj4-20020a170906d78400b00a2353af1f7bsm1406769ejb.92.2023.12.18.03.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:06:02 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [PATCH v2 0/5] cpufreq support for the D1
Date: Mon, 18 Dec 2023 12:05:38 +0100
Message-Id: <20231218110543.64044-1-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for cpufreq on the D1 SoC, and has been
tested on a Lichee RV module.

Changes in v2:
- Revert opp-microvolt-speed0 property to <target min max>
- Add dt-bindings for "allwinner,sun50i-h6-operating-points"
- Enable sun50i h6 cpufreq multiarch support by moving Kconfig option
  to drivers/cpufreq/Kconfig instead of creating
  drivers/cpufreq/Kconfig.riscv

Brandon Cheo Fusi (5):
  riscv: dts: allwinner: Update opp table to allow CPU frequency scaling
  dt-bindings: opp: sun50i: Add binding for D1 CPUs
  cpufreq: sun50i: Add D1 support
  cpufreq: dt-platdev: Blocklist allwinner,sun20i-d1 SoC
  cpufreq: Make sun50i h6 cpufreq Kconfig option arch generic

 .../allwinner,sun50i-h6-operating-points.yaml  |  4 +++-
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi  | 18 +++++++++++++++---
 drivers/cpufreq/Kconfig                        | 12 ++++++++++++
 drivers/cpufreq/Kconfig.arm                    | 12 ------------
 drivers/cpufreq/Makefile                       |  2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c           |  1 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c         |  1 +
 7 files changed, 33 insertions(+), 17 deletions(-)

-- 
2.30.2


