Return-Path: <linux-kernel+bounces-161638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABFB8B4EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BFD281327
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5B8C13B;
	Mon, 29 Apr 2024 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT/Ar35a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F7D515;
	Mon, 29 Apr 2024 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350418; cv=none; b=cVIxPRuHwZRTwIoi2oZe0GjJV6iNE/PPBlwauBk7VYMLMJZ/xJu9IYTYfrF2ZkZjWkj9A5WGk9/974P9TTNX9tHC/ZrBks4i2tSrVsEPz78wRB3XW/c1qGxA4MZpxjdzV/egh4mEo6EhZL+reJ8HB3cxnep/kMOj6a1+/RJORzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350418; c=relaxed/simple;
	bh=nmPdrX+XsSeX70KVtZRtkwwkkaIBq4Gq9LfwCK24YRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSTfJSzn1wd5cNo8Rd2H8ZaRplwuFcShF7OC3idXgdmH0fTCV3MevHzQEobxTR7b+JEzSgDVzV5tVlteyP6MZtF5Vi4d8ksOV+f8uf7tMbNiwYEJCzcA3wnQfx9OxbpjYGC4mQi5BVmbs6W5tRr0EYp33DfXJHHwDqb4+kLE2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT/Ar35a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCC1C4AF18;
	Mon, 29 Apr 2024 00:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714350418;
	bh=nmPdrX+XsSeX70KVtZRtkwwkkaIBq4Gq9LfwCK24YRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oT/Ar35aIU9cm3DjlkVKJdGkPm3jBBhYz3I9S8J/2yDZvKQNDAl4SnkFvdF1/1bMT
	 9CCMH8itbLIY8HlW0cWN14nq5Sh77uJliLgzTFFalORgYa1URbCXMSpCQJs6Su92X0
	 wukRp9CPI3MrK/juh1N6tBePsQNiGBgzuHD+I12KqFKmOl64nxMznxUI8SC9JYRLzV
	 cXJct7T+wUmTH4i9J+gZGGHbVszgg3+ftndiGf9U5xXOkyWe0VU+v0VqX6Cks4bnIc
	 LezJJXjGQ1XtRqe7Dvn+dyI1/aOODAybWtaUb85cd6bAvMYgq/aRymaMczgQw2M78Q
	 IMD706AOTXSFg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v4 4/8] riscv: dts: starfive: visionfive 2: use cpus label for timebase freq
Date: Mon, 29 Apr 2024 08:13:13 +0800
Message-ID: <20240429001317.432-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429001317.432-1-jszhang@kernel.org>
References: <20240429001317.432-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed out by Krzysztof "Board should not bring new CPU nodes.
Override by label instead."

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 50955cc45658..910c07bd4af9 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -26,10 +26,6 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	cpus {
-		timebase-frequency = <4000000>;
-	};
-
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0x1 0x0>;
@@ -69,6 +65,10 @@ codec {
 	};
 };
 
+&cpus {
+	timebase-frequency = <4000000>;
+};
+
 &dvp_clk {
 	clock-frequency = <74250000>;
 };
-- 
2.43.0


