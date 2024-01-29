Return-Path: <linux-kernel+bounces-43383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72AB8412F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885AE1F233CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9511C85;
	Mon, 29 Jan 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TsN/RPBU"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F05101CF;
	Mon, 29 Jan 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554976; cv=none; b=trmpR/g36BYnp9FYrKd+uD/74Yzd0JN+nie75hvbDN6n5k+YZBdSDGDyC19d0xSSSI3s2KyaKucrsCokRT/0oZ172ZnJhl4cp2SIaKIx9uoXkjO6Jm9XErnlI3lM3lsPL7T6coPdN5iwwdfrjGaSpVov7Jc4Q0ZX/6qZRrRdOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554976; c=relaxed/simple;
	bh=wE6v+xXnM1dSZ3ZOcrXWGG1bRVHoCQMA/GRPTUmAnAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BV3ReF1lDHq8Ux2Zt0mK9hnAHYShMp9VJFw6n/LL29g9uGbZz8a/3AiMfkAtJ5eZY5QY8sjITPqY5wH2QafMcqryyxhIfR8+7ttF7KyKOH3pzgo2Kis4ezVau76bLy4ur46t/xIrhl663+wxME1v512p+ZCkJ3vEDYTQj++QFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TsN/RPBU; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TJ2mAJ058104;
	Mon, 29 Jan 2024 13:02:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706554968;
	bh=jjB6+J55/QLiyzhtPIqWFuVy+0Y9jkQNx6f94FRbY2w=;
	h=From:To:CC:Subject:Date;
	b=TsN/RPBU1Tc5VyJIpfR06s9YyLdHBkqawabsKfC22nvMcj59vGYRKqT2A3prQ6lHB
	 C/iBxqpcq+GMip/we1GXZmOoC/yb6ANCVxuA+uuDbadAnKaMW/uNPc3hPy0b1vyIOy
	 huO1MjZzb6IkQg42Dww9OoFPRkiLoS++AakFDhUU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TJ2mak053301
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 13:02:48 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 13:02:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 13:02:47 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TJ2ldl003658;
	Mon, 29 Jan 2024 13:02:47 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Support Opensource
	<support.opensource@diasemi.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH v2 0/4] Power supply register with devm
Date: Mon, 29 Jan 2024 13:02:42 -0600
Message-ID: <20240129190246.73067-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

These are the 4 patches that had "unused variable" warnings (thanks kernel
test robot). Fixed the warnings and rebased on -next so all taken patches
from v1 are dropped.

Thanks,
Andrew

Andrew Davis (4):
  power: supply: max14577: Use devm_power_supply_register() helper
  power: supply: max77693: Use devm_power_supply_register() helper
  power: supply: max8925: Use devm_power_supply_register() helper
  power: supply: wm8350: Use devm_power_supply_register() helper

 drivers/power/supply/max14577_charger.c |  8 ++----
 drivers/power/supply/max77693_charger.c | 10 ++-----
 drivers/power/supply/max8925_power.c    | 37 +++++++------------------
 drivers/power/supply/wm8350_power.c     | 30 +++++---------------
 4 files changed, 23 insertions(+), 62 deletions(-)

-- 
2.39.2


