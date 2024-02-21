Return-Path: <linux-kernel+bounces-74715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7587785D82A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B649B22967
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C875469D38;
	Wed, 21 Feb 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnpJNOWU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8F47A7C;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519547; cv=none; b=oEPIKjGrKBPxS91jhE6jss4plwm0JYOU9wFZXMUUm/3g6NKXosL4uD30YA8aDr855eomTOJyLOb8ExYsXYgSakgnxhSYBTTLaOj+d/TFjrHW1VCP/mh38/FAUSMuVNgiKoRHlZiJZlug/thanIoI5kuYia8VEINaF7k87BDGkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519547; c=relaxed/simple;
	bh=TB84W7Tu2siA4tIKu3yesEUxKHpCOYUqZbf+Veml5KM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DhPi9gkgpS7i7x5bkRjS/CvLI72tGRX07CYxG3Ht4mVg+5ok0Vc8/PE7VKUh+5EMZ6kdJEjctD4c3nnbVrmVBAeAqmPh0O3w1axFd0sFjBXkflLdQLkStqz0lNj+XGkqghfdKfS7JOYteNIQCfoU2XeZVa5Dky+uuaVQ4A+Ik60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnpJNOWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 891FEC433C7;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708519546;
	bh=TB84W7Tu2siA4tIKu3yesEUxKHpCOYUqZbf+Veml5KM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JnpJNOWUVTYBFT+i+XagwsGgIK7/A0MhPqyfyu6xjZoR2HUyLZiiheZfOrGf/OtXF
	 LARvs2ThlNDs31G+0/6CCrZPzGm8ux5whyvtVY8thhdLOWRo4bbIvB0B4P+ilWVx6g
	 NYEKpxCxYA4WHfxuwyfzyU1oXvMh5imvtpNpfXRpkVEIsXSXNpW+LeqnZlZM7qjjsX
	 7K79qyTZQGy/5+C+aGB5FuNZKlA6z7eVC5OVvABCU2jBUs1Ou0t5ULCekysLgACvKG
	 VMITxPQuRDNe1beHRwX92Yk04SR6g9h9hB6P1G+ibuNo/rjw8B4MX+VqYxgGVdkeTU
	 O9ZWbpePocR3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7006FC48BF6;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v6 0/5] mmc: add hi3798mv200 specific extensions of DWMMC
Date: Wed, 21 Feb 2024 20:45:02 +0800
Message-Id: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE7w1WUC/4XOTU7DMBAF4KtUXmPkGc/YCSvugbpI/EMsSI2S1
 gJVuTtO2RQlUpdvpPneu4o5TCnM4uVwFVMoaU75VIN5Ogg3dKf3IJOvWaBCUoAge5Lj6OSQtG2
 bsaBSsmOrVfAREJ2oj19TiOn7hr4dax7SfM7Tz62jwHr94xDMHldAKmk9Gd83xF0wr/ly/sz54
 9nlUaxgwccIVkSB8kYH04HnLaLvEbuL6IpEYDIE1rRktwg9RmhdEr1ve08Na9wifIeg2kV4XcL
 KOObYBNL/kWVZfgEVSG0DygEAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 Yang Xiwen <forbidden405@outlook.com>, Paul Menzel <pmenzel@molgen.mpg.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708519512; l=2922;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=TB84W7Tu2siA4tIKu3yesEUxKHpCOYUqZbf+Veml5KM=;
 b=FFPZK/QxMFGsqomSktavHt+7L+NWbqTXJM+fy71PZsxVFDZLZIyPHvLXWS5hJF2X7Q3PP38nV
 rqA/zqDDt8rBYiA4jDMV7TVqFW6E2R7dUq4li2T1s9fN4Xd0gWjq8OO
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

it's modified from hi3798cv200 driver, but quite a lot of code gets
rewritten because of the hardware differences. Actually cv200 DWMMC core
is called HIMCIV200 while mv200 DWMMC core is called HIMCIV300 in
downstream.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v6:
- apply the comments to the first patch, add their trailers
- Link to v5: https://lore.kernel.org/r/20240220-b4-mmc-hi3798mv200-v5-0-f506c55f8e43@outlook.com

Changes in v5:
- pick the dependant patch: https://lore.kernel.org/all/20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com/
  to fix the bot build error.
- edit the semantic meaning of hisilicon,sap-dll-reg property (Rob Herring)
  The suggestion is from the CRG driver side:
  https://lore.kernel.org/all/20240218205741.GA1561527-robh@kernel.org/
- Link to v4: https://lore.kernel.org/r/20240217-b4-mmc-hi3798mv200-v4-0-0fdd9bd48532@outlook.com

Changes in v4:
- rename dw_mmc-hi3798 back to hi3798cv200 - Suggested by Krzysztof Kozlowski.
- add r-bs to patch 1 and 2 - Reviewed by Krzysztof Kozlowski.
- Link to v3: https://lore.kernel.org/r/20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com

Changes in v3:
- dw_mmc-hi3798: fix bot error (Rob Herring)
- Link to v2: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com

Changes in v2:
- dw_mmc-hi3798mv200: use dev_err_probe() helper - Suggested by Krzysztof Kozlowski.
- dw_mmc-hi3798mv200: add missing err=0;
- dw_mmc-hi3798c(m)v200: remove unused MODULE_ALIAS() - Suggested by Krzysztof Kozlowski.
- binding: rename the binding, a lot of tweaks suggested by Krzysztof Kozlowski.
- Link to v1: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com

---
Yang Xiwen (5):
      mmc: host: mmc_of_parse_clk_phase(): Pass struct device * instead of mmc_host *
      mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
      mmc: dw_mmc: add support for hi3798mv200
      dt-bindings: mmc: dw-mshc-hi3798cv200: convert to YAML
      dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc: add Hi3798MV200 binding

 .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ----
 .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml         |  97 +++++++++
 drivers/mmc/core/host.c                            |   4 +-
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   1 -
 drivers/mmc/host/dw_mmc-hi3798mv200.c              | 239 +++++++++++++++++++++
 drivers/mmc/host/sdhci-of-aspeed.c                 |   2 +-
 include/linux/mmc/host.h                           |   2 +-
 9 files changed, 349 insertions(+), 46 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240121-b4-mmc-hi3798mv200-a5730edf122c

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


