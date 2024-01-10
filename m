Return-Path: <linux-kernel+bounces-22501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CD4829EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E021C21EED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08474CB41;
	Wed, 10 Jan 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="cb8bAGIY"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B2433C0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d427518d52so31893715ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1704904557; x=1705509357; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NUfXOVWjFppBmkTP9/JtvhS+iSH/scaSCcV++osCkg4=;
        b=cb8bAGIYbccgMwt3dBJmBkKJOLE9WrQfAwAI2g437s6M9DJtPr+LReZWz0Ao4kit2J
         RSlJrJ/FXkTyCtTYCffNbYaUcVzd4LhlYC52/4UbX8nSrN3mZV11mzEtPlW+8r7/FWGV
         +1F3PhgiOrAroZ+LfC/RxEb90dRv0ZUQ5NKN1jvVipj1aQRQ+MI5zpeExPwAZME1jaxW
         8RcBaPqbiGJCmKJCVislUOwbDW3/nVN7rK1xLk5mRzJEuH10HqY3wsisrnfLKUXYpwx8
         dDMYadITCdMURKOFXew1qU103z1dCK8bPD4EX5wOpKnQu3YyYoHqIc9SjtUw+864pYnx
         aE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704904557; x=1705509357;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUfXOVWjFppBmkTP9/JtvhS+iSH/scaSCcV++osCkg4=;
        b=URe7U5FIiofSRcn5iIH6Ih0PPpjKbeVTNKK0bdoDHILHHrQCN+iOn86NZy496IvcOv
         6vt5imP7M5seD9u++mkKdDNOgJH+71OqQsKOnqXWy7rZU3B94lQDE2XKJXaSf2Sayd3K
         +6ir6gUgKA3TE5Re5VE2SmUH2OVJxa1ohdMPXpYSEis41oMQIqh1qxm0KcNHO/asgqm+
         2YD6PSPHo0wEqmRjPi1giPz1ETkb3ZduAwkzUEg2SyO3o6lpKsTJ4XXqZuNV+YEq5mmV
         IvRi1ywZXdrk5ZrmQAO/Lro/Fzzi5Ab7eMC0Z5nZHL9kchDkTDfiYCuZ+j9ksLE9LjP/
         IcOg==
X-Gm-Message-State: AOJu0Yzd/mjyp9Lq54/peLusVMegFZirfOCzzvhhZlQC1XnY3F/xl05c
	oTEXNOwoNZGSvhjuzJSMTC0KnHgYdIpB1g==
X-Google-Smtp-Source: AGHT+IELbgnMH0ltz/uBIUx7pCZ9sWm8n1TjbxqSStE2MTG0+o4QTGL1FeKISXzpn48z88cNXmnpkw==
X-Received: by 2002:a17:903:124a:b0:1d5:65c7:dea5 with SMTP id u10-20020a170903124a00b001d565c7dea5mr368928plh.35.1704904557138;
        Wed, 10 Jan 2024 08:35:57 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:858a:4f95:cb29:907c])
        by smtp.gmail.com with ESMTPSA id p20-20020a170903249400b001d4b5e444d2sm3872265plw.48.2024.01.10.08.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 08:35:56 -0800 (PST)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH RFC 0/3] clk: thead: add support for T-HEAD TH1520 AP clock
 controller
Date: Wed, 10 Jan 2024 08:35:14 -0800
Message-Id: <20240110-clk-th1520-v1-0-8b0682567984@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAELHnmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQwNL3eScbN2SDENTIwNdY0tLEyNLI0vLFFNDJaCGgqLUtMwKsGHRSkF
 uzkqxtbUAtAQHxWEAAAA=
To: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yangtao Li <frank.li@vivo.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Han Gao <gaohan@iscas.ac.cn>, Xi Ruoyao <xry111@xry111.site>, 
 Robert Nelson <robertcnelson@beagleboard.org>, 
 Jason Kridner <jkridner@beagleboard.org>, 
 Drew Fustini <dfustini@tenstorrent.com>, 
 Drew Fustini <dfustini@tenstorrent.org>, 
 Drew Fustini <drew@tenstorrent.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704904555; l=2938;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=uYm/4xZs1+S7XBO0sv9/6rdMfUgmhq4fXQa0VDf/0xI=;
 b=2FFXTCrI1s1CiaVfwXB8XhukXEsvF5hrYCBYiXXPHwq8UfGI0eqE8RV6ocp8CsnYaMDazKEF+
 C5KmMTEj5uzBXS8I0wRPWllTrjOq4lRPQRxyRP7ELnCqw5YB00qCY84
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

This series adds support for the AP sub system clock controller in the
T-HEAD TH1520. This include CPU, DPU, GMAC and TEE PLLs.

Yangtao Li originally submitted this series back in May [1]. Jisheng
made additional improvements and then passed on the work in progress to
me. The driver code is cleaner than the version in the T-Head SDK [2].

I fixed checkpatch and dt_binding_check warnings along with:
- deduplicated CLK_NPU and CLK_NPU_AXI number in header
- corrected the npu_clk enable bit
- fixed c910_i0_clk reg typo

I am marking this as an RFC because I have not been able to get the eMMC
controller to work with the clock driver yet. The T-Head SDK does have
full clock driver support but it still uses a fixed clock for the mmc
controller. I've not yet determined why that is.

According to the documentation [4], the "emmc sdio ref clk" is listed as
792 MHz in table "4.3.4 Clock Frequency of Key Module". PERI_CLK_CFG
contains the clock gate. 792 MHz divided by 4 is 198 MHz which is the
fixed clock frequency used for the mmc controller. However, I can't seem
to figured how the divider is controlled for the "emmc sdio ref clk".

Anyways, Emil is working on the pinctrl driver and Conor asked about the
state of the clock driver [5]. I thought it best to send this RFC now so
that discussion can take place on the list.

Thank you,
Drew

[1] https://lore.kernel.org/linux-riscv/20230515054402.27633-1-frank.li@vivo.com/
[2] https://openbeagle.org/beaglev-ahead/beaglev-ahead-linux/-/blob/beaglev-v5.10.113-1.1.2/drivers/clk/thead/clk-light-fm.c
[3] https://openbeagle.org/beaglev-ahead/beaglev-ahead-linux/-/blob/beaglev-v5.10.113-1.1.2/arch/riscv/boot/dts/thead/light.dtsi
[4] https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
[5] https://lore.kernel.org/linux-riscv/20240109-boggle-frugality-03a77cab8308@spud/

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
Jisheng Zhang (1):
      clk: thead: add support for T-HEAD TH1520 AP clocks

Yangtao Li (2):
      dt-bindings: clock: Add T-Head TH1520 AP clock definitions
      dt-bindings: clock: Document T-Head TH1520 AP clock controller

 .../bindings/clock/thead,th1520-clk-ap.yaml        |   65 ++
 MAINTAINERS                                        |    3 +
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/thead/Kconfig                          |   12 +
 drivers/clk/thead/Makefile                         |    2 +
 drivers/clk/thead/clk-th1520-ap.c                  | 1018 ++++++++++++++++++++
 include/dt-bindings/clock/thead,th1520-clk.h       |   96 ++
 8 files changed, 1198 insertions(+)
---
base-commit: 8cb47d7cd090a690c1785385b2f3d407d4a53ad0
change-id: 20240109-clk-th1520-399429299d51

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>


