Return-Path: <linux-kernel+bounces-8008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7967A81B088
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35799286535
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7A1805E;
	Thu, 21 Dec 2023 08:44:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1AD18026;
	Thu, 21 Dec 2023 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 04923807B;
	Thu, 21 Dec 2023 16:44:24 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:44:23 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:44:17 +0800
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>, Samin Guo
	<samin.guo@starfivetech.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>
CC: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Ley Foon Tan
	<leyfoon.tan@starfivetech.com>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
Subject: [PATCH v5 0/2] Add StarFive JH8100 watchdog
Date: Thu, 21 Dec 2023 16:43:56 +0800
Message-ID: <20231221084358.3458713-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Changes since v4:
- Patch(1/2) expresses JH8100 compatibility to JH7110 in dt-binding,
  and adds minItems to constrain reset property.
- Patch(2/2) adds watchdog node in jh8100.dtsi. This patch depends on
  patch series [1] and [2].
[1]: Initial device tree support for StarFive JH8100 SoC
https://lore.kernel.org/all/20231201121410.95298-7-jeeheng.sia@starfivete=
ch.com/
[2]: Basic clock and reset support for StarFive JH8100 RISC-V SoC
https://lore.kernel.org/all/20231206115000.295825-17-jeeheng.sia@starfive=
tech.com/

Changes since v3:
- Drop items in compatible field.
- Replace items with maxItems in reset field.
- Replace maxItems with items: -description in if else reset field

Changes since v2:
- Express JH8100 compatibility to JH7110 in dt-bindings.
- Rework min/maxItems constraint for JH8100 resets property.

Changes since v1:
- Drop "starfive,jh8100-wdt" compatible field in starfive-wdt.c,
  and express them in dt-bindings.
- Use minItems in resets field to cater for single reset signal
  in JH8100.
- Reword Watchdog reset to Core reset for JH8100.

StarFive's JH8100 watchdog reuses JH7100 register mapping.
DT-binding of JH7100 watchdog is extended to support JH8100.
Since JH8100 only uses 1 reset signal, update the binding to
support one reset for "starfive,jh8100-wdt" compatible.

Ji Sheng Teoh (2):
  dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100
  riscv: dts: starfive: jh8100: Add watchdog node

 .../watchdog/starfive,jh7100-wdt.yaml         | 40 ++++++++++++++-----
 arch/riscv/boot/dts/starfive/jh8100.dtsi      |  9 +++++
 2 files changed, 40 insertions(+), 9 deletions(-)

--=20
2.25.1


