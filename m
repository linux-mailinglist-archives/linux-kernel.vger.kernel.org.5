Return-Path: <linux-kernel+bounces-122328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F7F88F545
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5131C27ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415AB374EF;
	Thu, 28 Mar 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmR6t64N"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9A32C92;
	Thu, 28 Mar 2024 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592559; cv=none; b=umnggHkugWaQpwihmb0njdzRAMT5RoGr+AHOwTNwDUSyQNk7jE37rhaZbC71FigHqzoaZnOdkNk3IFU+DwJsDS4yqchSMHSGWkBXQ/WrNiID2pDKghEh/UBM0ag9ve5bHSoGshCGtLhA6ZlyovPCLBWrZirWik6xEsUef2Lw2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592559; c=relaxed/simple;
	bh=OVpo1ra63qCtsbXIsud4GWQ+pj1esg4FLbiAQKE0ba8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=G8KSoJZlV1xvB7gEoe/2w1cP3orlqMuwxg6mCbKzt01F+TKoARtfDSR4e5JcgEu3AmxT2o39txrjMlu/Jtczcb2k9L/4vG91My6ua8f7ZxPGzSIugRGlxKua0kYqhEzETASi2znNEsEAO1cvVYYQ40YSltabJ/qYV5lVYtwxR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmR6t64N; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c3d3710018so369306b6e.0;
        Wed, 27 Mar 2024 19:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711592557; x=1712197357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj+WYWAhqjw7xLvVT8giLYQdLcc7zs4jwkGM88zeFSU=;
        b=JmR6t64NjMj1UkFzpuKll411OitV02XpM4UJNbS2+JNwrWv2xmii1a8czOvQXjPflB
         bC97qSYarvynxfzd6l42SMr0F8v03peeWUbSHPXAwKagRHNlrQ840BoKvm8TDmPDtERN
         iNuMGO+rAb0gubNDCYtTOQIzyQ+o0waFGFhHqTj9PTYp6vur7XDcxg6YkBsZ4mMqV45F
         7Csq8D9lkYp4ggRtw0QepTWRnRNOmfjlICTeZBzoJ9/c5cO6oJnlh6qIvxGTtzASlugG
         53WtrDqRLuWTsjwJ4U+F4udPGP9HF0MgkqPhl94Qnf8nIS33Yayb6cTejJWZygFA1bFe
         yfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592557; x=1712197357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj+WYWAhqjw7xLvVT8giLYQdLcc7zs4jwkGM88zeFSU=;
        b=e/Io6AOJ/pdjCIEXJJBtm3/s6oySfCAdyJvbTZOKG5FJW/7lotKF2+lBUDyurRaWCI
         mqoLF85ab+aSEHKgD34b/8hjunRrQNuwUmRSO+Z+D1QB+PLuSFNc1ZtHJnll+V6i+NPX
         Gv8DjB1I6LTHZkiD/k06lyfHlhGsSKNeBm/j0IZkepu1QrrRl/99aCdZ7b0L9o0O1uTD
         3J12qwT4hvgEXwDjOgjAPa0AfCNxvi16Ta1KTIiCxlSlF8uLPzp262oFQOZTeIHCbjPV
         b8/LwG2HXv2KNKQtcvNHLtHHtNs6j7qp9yQRZ9WucZs5RHrZcnABMBxvEIu8ENAt8I9d
         DLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5HqredlpBI2t7+FLCpUutVsL8S1f+evQxBbPmqoVzcxiLa8rANnZNxvaQnmPjN5RxyHEeD5x/ZNKsis9bsNvqPxvqUfi9TFMgUZ9KX0GP6lNgoXw4wBnD3sJa8EK6tWuZBtM8ErTxtxQar5vDGoo2XlXFOhT4Scsx+Oms3oFpXY3vGAQ2WtHw
X-Gm-Message-State: AOJu0YycBI92trxohc7EmKhfV1HeiLLv9TiiA9RqeRrd5vPlbmrIYmo3
	Py1IYy2EV9vRVqL8RBAcA7W8WuoGc7aXwogoQ0tYq4kjJH51brBq
X-Google-Smtp-Source: AGHT+IE8ZzQ2gr87ufaZX9Ve6iQlcEly34B9ZC4/VnAKww459oP0Tv9uUglaABvQbe7WYWRki2abqQ==
X-Received: by 2002:a05:6808:1706:b0:3c3:e78d:f1be with SMTP id bc6-20020a056808170600b003c3e78df1bemr147151oib.57.1711592557102;
        Wed, 27 Mar 2024 19:22:37 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e355-7eb0-17c6-c47d-d4ee-f9e8.emome-ip6.hinet.net. [2001:b400:e355:7eb0:17c6:c47d:d4ee:f9e8])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78699000000b006ea858ea901sm229256pfo.210.2024.03.27.19.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:22:36 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] drivers: watchdog: ast2500 and ast2600 support bootstatus
Date: Thu, 28 Mar 2024 10:22:27 +0800
Message-Id: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2500/ast2600

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set.

Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
ast2500 SCU3C when bit1 is set.

Change Log:

v5 -> v6
  - Fixed missing WDT_TIMEOUT_STATUS_EVENT.

v4 -> v5
  - Revert indentation. 

v3 -> v4
  - Add error handling for syscon_regmap_lookup_by_phandle and
  regmap_read.

v2 -> v3
  - Fixed WDIOF_CARDRESET status bit check and added support
  for WDIOF_EXTERN1 on ast2500 and ast2600.

v1 -> v2
  - Add comment and support WDIOF_CARDRESET in ast2600

v1
  - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
---

Peter Yin (4):
  ARM: dts: aspeed: Add the AST2500 WDT with SCU register
  ARM: dts: aspeed: Add the AST2600 WDT with SCU register
  dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
  drivers: watchdog: ast2500 and ast2600 support bootstatus

 .../bindings/watchdog/aspeed-wdt.txt          |  4 +++
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi       |  3 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  4 +++
 drivers/watchdog/aspeed_wdt.c                 | 35 ++++++++++++++++---
 4 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.25.1


