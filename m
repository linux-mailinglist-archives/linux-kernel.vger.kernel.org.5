Return-Path: <linux-kernel+bounces-29186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64011830A71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA6E1C24284
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2C224F5;
	Wed, 17 Jan 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TpDV2iT9"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFD2231C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507711; cv=none; b=CkMJGdvtvROyyxLDKDC4tqEWNecONM1MHmvUs7s7UUXjWyE1uZC7T+kjV4cqbzSZnAZhhnmYnd6QwqlGmcbaSXPs6rNlNia+jkWR9VG7jIAB+JSjh6jcx7xoUxHlRhUuWpfpdJEK9ru0KdE1PAJqR88GtcnNy819NhXHJNXnhLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507711; c=relaxed/simple;
	bh=wTIEtPEGvHDDF+fKBFt7TJe6k9xnGtd2Jq24lFbXPO8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=cp/+oF94NuZwWICcpr9BVEw03U6tm5DoW2ZEeNmwHPbftQ61KGL0zYOipmbX9mcLgG/GITTVpMNA0V+Fz2MceCsMI8Tzw1KUQcfKksAVrrA3wsSQWIcqUwAS4rl6R0ePPm+JunNHT0zAJZ7JmnZTt58JNPokhumP076rVmMLcwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TpDV2iT9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e8cf57d03so4919175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705507707; x=1706112507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MyUo/UL6AejHs5hrhdv6/x2YU8XtvFhHsaGgxgVP4HA=;
        b=TpDV2iT90lWEt2PDlbBvIqdtaE8ty6Dx3WgPaYBm1o0EmGAUzNVEPbDh18GgDsbMFR
         OZo7NO2iJLmX3MtgdcRUafr0R+LB/bbgH9Sy18xMH3rJ65M2vA103wNjGCk4t3+Ytgxt
         15QJRPfyZYnQFDXtwZQpklWrYQUMlLPJc7IZ56QtYFPWyBqu56RaFIyRKPYJiMGutpPd
         mdVlIaSYqHNY/eU6HVRqzFzm75fL49RD3UMRkmGsJTa6twUy6JWm21lwx+iLjUdT0sW4
         leTdPs4H/AlTeQ6g15vh7AU7xl+cGEajnq//DLPAQ7if/YFLip6uH9rapj9NOhfZys8t
         xf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705507707; x=1706112507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyUo/UL6AejHs5hrhdv6/x2YU8XtvFhHsaGgxgVP4HA=;
        b=vvBTS5QB/V05Ut4+91NSD3U6cx99fNeZjTGhJ5tJJyEfkd+HBRyyhR7ILnKbokaoWl
         +rKhsCrZGRIB9o0/4XnjmgwQJfiKM/LxODmUb7vNrnubeCY2ouhraJRhqbCtcRmnhH9i
         lQfcMuLK22xS/xwAmqYu9TeBuqOysOuY1btP1piHIP90jSwEhCCHge4IU3U3u697CUz4
         OmiYGPl9xFjDNDuO/+mDTJjYfRGr7BS3oYXiUQdSDCUsZwb/92KgQHB3Z/0LzeriVC21
         0jK+TKxcvZyKzKcD2cZ1wUoJUoBgcc9DHQSooonVuyCs9jOrgiPpWPeW0aJzJ2Yo8tec
         EKXg==
X-Gm-Message-State: AOJu0YyADO26JcKvUneGgU6+hh2AuOVfOlI/wY5pSwlzFtSkuNwftyte
	17HXomg1HnIp3psCz3t+cgiFqAmmhaYKMA==
X-Google-Smtp-Source: AGHT+IHlxHbmKVJpdUR6FTOE1NTTevtRRWD6ZNjn5U6+9dnAYa4RC2TRfYigQaqhNQbHmnO2nJkODQ==
X-Received: by 2002:a05:600c:3506:b0:40c:3e6e:5466 with SMTP id h6-20020a05600c350600b0040c3e6e5466mr4763135wmq.182.1705507706783;
        Wed, 17 Jan 2024 08:08:26 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d0b5:43ec:48:baad])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d6a4a000000b00337b0374a3dsm1972092wrw.57.2024.01.17.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 08:08:26 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/9] PCI: introduce the concept of power sequencing of PCIe devices
Date: Wed, 17 Jan 2024 17:07:39 +0100
Message-Id: <20240117160748.37682-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The responses to the RFC were rather positive so here's a proper series.

During last year's Linux Plumbers we had several discussions centered
around the need to power-on PCI devices before they can be detected on
the bus.

The consensus during the conference was that we need to introduce a
class of "PCI slot drivers" that would handle the power-sequencing.

After some additional brain-storming with Manivannan and the realization
that DT maintainers won't like adding any "fake" nodes not representing
actual devices, we decided to reuse existing PCI infrastructure.

The general idea is to instantiate platform devices for child nodes of
the PCIe port DT node. For those nodes for which a power-sequencing
driver exists, we bind it and let it probe. The driver then triggers a
rescan of the PCI bus with the aim of detecting the now powered-on
device. The device will consume the same DT node as the platform,
power-sequencing device. We use device links to make the latter become
the parent of the former.

The main advantage of this approach is not modifying the existing DT in
any way and especially not adding any "fake" platform devices.

Changes since RFC:
- move the pwrseq functionality out of the port driver and into PCI core
- add support for WCN7850 to the first pwrseq driver (and update bindings)
- describe the WLAN modules in sm8550-qrd and sm8650-qrd
- rework Kconfig options, drop the defconfig changes from the series as
  they are no longer needed
- drop the dt-binding changes for PCI vendor codes
- extend the DT bindings for ath11k_pci with strict property checking
- various minor tweaks and fixes

Bartosz Golaszewski (7):
  arm64: dts: qcom: qrb5165-rb5: describe the WLAN module of QCA6390
  PCI: create platform devices for child OF nodes of the port node
  PCI: hold the rescan mutex when scanning for the first time
  PCI/pwrseq: add pwrseq core code
  dt-bindings: wireless: ath11k: describe QCA6390
  dt-bindings: wireless: ath11k: describe WCN7850
  PCI/pwrseq: add a pwrseq driver for QCA6390

Neil Armstrong (2):
  arm64: dts: qcom: sm8550-qrd: add Wifi nodes
  arm64: dts: qcom: sm8650-qrd: add Wifi nodes

 .../net/wireless/qcom,ath11k-pci.yaml         |  89 ++++++
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  29 ++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  10 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |  37 +++
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  10 +
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts       |  29 ++
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |  10 +
 drivers/pci/Kconfig                           |   1 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/bus.c                             |   9 +-
 drivers/pci/probe.c                           |   2 +
 drivers/pci/pwrseq/Kconfig                    |  16 ++
 drivers/pci/pwrseq/Makefile                   |   4 +
 drivers/pci/pwrseq/pci-pwrseq-qca6390.c       | 267 ++++++++++++++++++
 drivers/pci/pwrseq/pwrseq.c                   |  82 ++++++
 drivers/pci/remove.c                          |   3 +-
 include/linux/pci-pwrseq.h                    |  24 ++
 17 files changed, 621 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/pwrseq/Kconfig
 create mode 100644 drivers/pci/pwrseq/Makefile
 create mode 100644 drivers/pci/pwrseq/pci-pwrseq-qca6390.c
 create mode 100644 drivers/pci/pwrseq/pwrseq.c
 create mode 100644 include/linux/pci-pwrseq.h

-- 
2.40.1


