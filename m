Return-Path: <linux-kernel+bounces-167577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A408BAB85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68AF1F2279F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC154152199;
	Fri,  3 May 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="bFAEX0Ov"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2217139D12
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714735409; cv=none; b=NAeeFphJYY/uPfkm62duCN8RE95UKveSrWTjQE6SsHMnZcfm1OfJRvS6NaNkFwzjf6sIJck0QQ0ey9cUoKvCBkNVCgklc3TLg/78dTbKpIcORYQYoiMxyt1Aj2pMcTDfKpCHWsEc7EBibNVJg/PZE0WZ4U6NI+1xUxiTZiBYk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714735409; c=relaxed/simple;
	bh=hfh1WeCNv7h2tGrmKApVhSXTKBpX68998FW3xDeVNNs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TfK15Sdhdoykp44tSa843OQoNLqnuoqqkrnoNcoKi07YfzMOudSQ4rjramQ+fngqUk6J0EiRkRPrmsje+YnMQ3C+/+rBviySxNsv1kWEP2nFVMD2SRWZ/ICQLwnUKRFCkADnWCd2pP+zk/Zsgnp9xZFxF2Fh3Vg6qMA1KLgqIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b=bFAEX0Ov; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a595c61553cso432787966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 04:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1714735404; x=1715340204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R+1IKXv/OZSXxG3m940o49kC0CNjH3iNdy76Z/a3dsM=;
        b=bFAEX0Ovb2TXSe6ZLvJLARc92+ehGrl6Eupvgd6hIpparaFAqLojCArQPvWXLjmH7G
         zgDC4I8KM5pnRGPvoGjuDXR+rVBmnR8m9oGR5S1imLc03zqTUOLIqFDRzGK5HGcNbhMb
         SJi3PA76H9TnMJ/vI/ZT0mKmD4p1s4KXH33gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714735404; x=1715340204;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+1IKXv/OZSXxG3m940o49kC0CNjH3iNdy76Z/a3dsM=;
        b=Xwe4j+ygQ2Ut91fu2fiOiVz/zt0I2CQELZ6CQ06Hk+MVibzGILWQYyyMusjpOPancv
         xmJZDW2viEjX3Fedn7UC3GGIvLX/DaxDCbGzd0erygZDtesKtOSkzuQrcYS359hUiGoj
         8erYfA59nhYwuXLfTaSer3DZclLxaSL7lxYu2oI7GYcbQnkPNdKFmLcVwma8OfKDB8sq
         HrbyaylzBllX7Im2glJXsPtwgD/haJKo9TZvH/KCJdvHz+cYoEbjfl+013qS5NOq34cK
         6tYX0upmWoxPjveg5Mh3Zd1L/WTpGeA3BjdiSGla+iyTmlCfw5Fva4Y4jU+wnUfTKOua
         hkNg==
X-Forwarded-Encrypted: i=1; AJvYcCX0KJGjRRaPiZtWoNMiDXFMkTnyjqP0UEvvP24pVZqX9vTorRTF00bj+K9hNPMx0/J4nNXt1UJIjRuIiVl7BfEEHtKAQls1kioxMZr2
X-Gm-Message-State: AOJu0YzWEkuMGFbxvkvSorCG9Y/zJ4Xyy5gEYyry0T1l5z/lZldEhIZT
	lUVhmGV/35iAeqZR2RY5fx/8L6ZWTGAzUEf+4lqu3LBPUAtWQD3b2eSJ7l7vAUAyOj97jiy5nG7
	FhHqxOWqXlqBC4ekv8ONVlGsbKzYRHZB3
X-Google-Smtp-Source: AGHT+IF2HiAsSB7nvhSgmkq3UxH39sAbU3Gg3QDWl9FZyADcdhsRlEGNq8GtPY3FVHPtpRfyPmydswOZnsRyZW7iZ3M=
X-Received: by 2002:a17:906:ae8b:b0:a52:30d3:41dd with SMTP id
 md11-20020a170906ae8b00b00a5230d341ddmr1617971ejb.41.1714735403495; Fri, 03
 May 2024 04:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 3 May 2024 20:53:11 +0930
Message-ID: <CACPK8Xd2Qc9MQUJ-8GuRjmyU50oMHpmmHPHLqAh9W_1Gyqi2ug@mail.gmail.com>
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 6.10
To: SoC Team <soc@kernel.org>
Cc: linux-aspeed <linux-aspeed@lists.ozlabs.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"

Hello Soc maintainers,

Here are the ASPEED device tree changes for 6.10. I've missed a few
releases as I was
on leave. Andrew Jeffery has stepped up and helped this cycle, some of the
patches were committed by him this time around.

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.10-devicetree

for you to fetch changes up to c44211af1aa9c6b93178a3993e18a7ebffab7488:

  ARM: dts: aspeed: Add ASRock E3C256D4I BMC (2024-05-02 17:57:16 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 6.10

 - New and removed machines:

  * IBM System1 AST2600 BMC, a x86 server
  * ASUS X4TF AST2600 BMC, a x86 server
  * ASRock SPC621D8HM3 AST2500 BMC, a Intel Xeon system
  * ASRock E3C256D4I AST2500 BMC, a Intel Xeon system
  * Add ASRock X570D4U's AST2500 BMC, an AMD Ryzen 5000 system
  * Facebook Harma's AST2600 BMC
  * Facebook Cloudripper is removed

 - Updates to machines merged this cycle, as well as bonnell,
   yosemite4, minerva and others

----------------------------------------------------------------
Andrew Geissler (1):
      ARM: dts: aspeed: system1: IBM System1 BMC board

Delphine CC Chiu (2):
      ARM: dts: aspeed: yosemite4: Enable ipmb device for OCP debug card
      ARM: dts: aspeed: yosemite4: set bus13 frequency to 100k

Eddie James (2):
      ARM: dts: aspeed: FSI interrupt support
      ARM: dts: Aspeed: Bonnell: Fix NVMe LED labels

Kelly Hung (2):
      dt-bindings: arm: aspeed: add ASUS X4TF board
      ARM: dts: aspeed: x4tf: Add dts for asus x4tf project

Krzysztof Kozlowski (5):
      ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
      ARM: dts: aspeed: yosemite4: correct Mellanox multi-host property
      ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host property
      ARM: dts: aspeed: harma: correct Mellanox multi-host property
      ARM: dts: aspeed: drop unused ref_voltage ADC property

Ninad Palsule (1):
      dt-bindings: arm: aspeed: add IBM system1-bmc

Peter Yin (14):
      dt-bindings: arm: aspeed: add Meta Harma board
      ARM: dts: aspeed: Harma: Add Meta Harma (AST2600) BMC
      ARM: dts: aspeed: Harma: Revise SGPIO line name.
      ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
      ARM: dts: aspeed: Harma: Remove Vuart
      ARM: dts: aspeed: Harma: Add cpu power good line name
      ARM: dts: aspeed: Harma: Add spi-gpio
      ARM: dts: aspeed: Harma: Add PDB temperature
      ARM: dts: aspeed: Harma: Revise max31790 address
      ARM: dts: aspeed: Harma: Add NIC Fru device
      ARM: dts: aspeed: Harma: Add ltc4286 device
      ARM: dts: aspeed: Harma: Revise node name
      ARM: dts: aspeed: Harma: Add retimer device
      ARM: dts: aspeed: Harma: Modify GPIO line name

Renze Nicolai (5):
      dt-bindings: arm: aspeed: add Asrock X570D4U board
      ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
      ARM: dts: aspeed: Modify GPIO table for Asrock X570D4U BMC
      ARM: dts: aspeed: Disable unused ADC channels for Asrock X570D4U BMC
      ARM: dts: aspeed: Modify I2C bus configuration

Tao Ren (1):
      ARM: dts: aspeed: Remove Facebook Cloudripper dts

Yang Chen (11):
      ARM: dts: aspeed: minerva: Revise the name of DTS
      ARM: dts: aspeed: minerva: Modify mac3 setting
      ARM: dts: aspeed: minerva: Change sgpio use
      ARM: dts: aspeed: minerva: Enable power monitor device
      ARM: dts: aspeed: minerva: Add temperature sensor
      ARM: dts: aspeed: minerva: correct the address of eeprom
      ARM: dts: aspeed: minerva: add bus labels and aliases
      ARM: dts: aspeed: minerva: add fan rpm controller
      ARM: dts: aspeed: minerva: Add led-fan-fault gpio
      ARM: dts: aspeed: minerva: add gpio line name
      ARM: dts: aspeed: minerva: add sgpio line name

Zev Weiss (8):
      dt-bindings: arm: aspeed: document ASRock SPC621D8HM3
      ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC
      ARM: dts: aspeed: asrock: Use MAC address from FRU EEPROM
      ARM: dts: aspeed: Add vendor prefixes to lm25066 compat strings
      ARM: dts: aspeed: ahe50dc: Update lm25066 regulator name
      dt-bindings: trivial-devices: add isil,isl69269
      dt-bindings: arm: aspeed: document ASRock E3C256D4I
      ARM: dts: aspeed: Add ASRock E3C256D4I BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    6 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 +
 arch/arm/boot/dts/aspeed/Makefile                  |    9 +-
 .../dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts    |    1 -
 .../dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts     |    9 +
 .../dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts     |  322 ++++
 .../dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts     |   13 +-
 .../dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts   |  324 ++++
 .../boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  |  360 +++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  |  581 +++++++
 .../boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts   |    4 +-
 .../dts/aspeed/aspeed-bmc-facebook-cloudripper.dts |  544 -------
 .../dts/aspeed/aspeed-bmc-facebook-greatlakes.dts  |    4 +-
 .../boot/dts/aspeed/aspeed-bmc-facebook-harma.dts  |  648 ++++++++
 .../dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts |  265 ----
 .../dts/aspeed/aspeed-bmc-facebook-minerva.dts     |  543 +++++++
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts   |   15 +-
 .../dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts  |    2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |    8 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 1623 ++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |    4 +
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi     |    2 +
 22 files changed, 4460 insertions(+), 829 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cloudripper.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts

