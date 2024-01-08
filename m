Return-Path: <linux-kernel+bounces-19511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5A6826E15
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF001F22B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EF54597B;
	Mon,  8 Jan 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPJJ1RNO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB274596A;
	Mon,  8 Jan 2024 12:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF91C433CA;
	Mon,  8 Jan 2024 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716938;
	bh=KIh12wVbDmJiLHjHRse8HnJ7sh45nq/r0+4isSVV99Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPJJ1RNOMq8OA+P+YYHyX5MQVybNVBAXdmytjK7+EB7yxDuOoYxkd+QwLwboxvJ1e
	 s8xi6Nlj4R0yIO18YkhyedWPOPFEa8MIfryhNkIgwct+Se/a+1O1nIGPnFjngLiv2O
	 UtFApi4ZbtA56JYGrR//Ng6s07WM+nyLtaBsaWn6IE/InZrMXfARP8zkbMjQ0onqd4
	 265JR/AgH4RyPmpeenLqXjGCCX4UuCKKWQRlV+HYkk5B2G0Bh4etc9f6zQkH4IuORM
	 3Txt5ngLeejGaPok6lhjlFPEkiSBCvnBUaTN1uT7EUOT6vqnm0hnx9BZGYoE8F/DT3
	 aLBv3k0YgwVuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 3/3] ARM: sun9i: smp: fix return code check of of_property_match_string
Date: Mon,  8 Jan 2024 07:28:46 -0500
Message-ID: <20240108122849.2090674-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108122849.2090674-1-sashal@kernel.org>
References: <20240108122849.2090674-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.146
Content-Transfer-Encoding: 8bit

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit 643fe70e7bcdcc9e2d96952f7fc2bab56385cce5 ]

of_property_match_string returns an int; either an index from 0 or
greater if successful or negative on failure. Even it's very
unlikely that the DT CPU node contains multiple enable-methods
these checks should be fixed.

This patch was inspired by the work of Nick Desaulniers.

Link: https://lore.kernel.org/lkml/20230516-sunxi-v1-1-ac4b9651a8c1@google.com/T/
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Link: https://lore.kernel.org/r/20231228193903.9078-2-wahrenst@gmx.net
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-sunxi/mc_smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 26cbce1353387..5d7ddfd5990e5 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -804,14 +804,14 @@ static int __init sunxi_mc_smp_init(void)
 	for (i = 0; i < ARRAY_SIZE(sunxi_mc_smp_data); i++) {
 		ret = of_property_match_string(node, "enable-method",
 					       sunxi_mc_smp_data[i].enable_method);
-		if (!ret)
+		if (ret >= 0)
 			break;
 	}
 
 	is_a83t = sunxi_mc_smp_data[i].is_a83t;
 
 	of_node_put(node);
-	if (ret)
+	if (ret < 0)
 		return -ENODEV;
 
 	if (!sunxi_mc_smp_cpu_table_init())
-- 
2.43.0


