Return-Path: <linux-kernel+bounces-165544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABAB8B8DC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D40C1C210C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6F812FF7B;
	Wed,  1 May 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="L7sY7+Jb"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE188827
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579766; cv=none; b=E1t9AORAhsVbHYhilHo+XqRdRBAkpY/nRJmz5AV9LF7zP3S5kvqWcWQ6DMv0s2DwkBxgUzgb2WGVICcT1mxkdb5cpn9ynAvL71m/V3Y77//pgpIhEfR9t8D6k260wMqBAIyIK9CwZZwiphfGShVJMcCHWMvx65nFzEeht+iGM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579766; c=relaxed/simple;
	bh=grZIYDSJSO3REGNNzGyxBR1mttKa0lxqxLASclIKY84=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=h0ie67ptbBgRJJf0npW5zXN6B+XGJ30kVMlV/qeqbgFpsxg5Dm0IklaT8yNWN55Ri4LmIX0cr5fFUxNYuvATbqEI2C68us/6f7TAhx5Ayq1qKwGrPmRNg01sxL8N1PhmQ0FR8YbfyaAUhVFwUd5aToACjW5wcHKj0THqeYYApaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=L7sY7+Jb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ee12766586so758077b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1714579763; x=1715184563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hs8AEy6uwBw23GBhL/y4wzU+oAIIpJLenHoelU6juSY=;
        b=L7sY7+JbqKrTW8oUbDTqU6KDNvsYL7/6NkjJHY7lXI5MQKuQhmFbWrzbnEPNte+KL1
         DIeWh4n7Pcopg9Mfj1a15niITo4coPW53EdwGMo1ImQJVu9JMvhdledfZrSkMkJF8mz2
         fq2kRblGer41dCTlKOCeZL5qF54t+67nYEZ/fR5qiadWLOIvGRteDDLPASHH/c/tjfIb
         FpIVY0oURQy1i9sbsATOubsX++F8Cejgi5RjyelE7TwbFIGBse9toreTUdiPhdADcdRt
         0TK7c18GUV6QBSUYo5ngUZjVZCWLKKcKT58aLfA4vkPhk0rIPd7SX27fmjZdPwEIy4ku
         5WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579763; x=1715184563;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hs8AEy6uwBw23GBhL/y4wzU+oAIIpJLenHoelU6juSY=;
        b=GQppsAu2yNvyzBzhFwXEfD3hu4jLq3iQtsdsckNK978LZqkWyHgv17cUYYtuXBEJqZ
         dhPNxw11MdmTWbxm9H6Lz5/mCAIZRBsrhYQhPtf2ekP6XrOIyJxJF3GizNI8Mb1jiGu6
         i8tivBNn3hRka8HXnGACjnj+ux1dmMXOWJl/0g6LIIIOAKZo22b8YNRwxdlVDOxBwr4+
         9YoeRK2lnBO2+H3XRu3V97FhE/NuUgfPmKy3FV7oxRaKSy3pb/s8fos9iIaLBkPRnKbp
         NFYA7spqXiGh2k767XkZtzOuvkCb3Ank8d3YEcO3ETpQxAORT0j2Gt0ZVzj4nGmCMWmD
         tP7g==
X-Forwarded-Encrypted: i=1; AJvYcCWB1PVw2e5CRfD9GkeSro6ka//loHsVwzTTlN0Qet4348Gnb9G7OBZbdHTSyjWdrw42/XfZczZs1M48R/riK5WJNI3TtcPDNAuvfmeD
X-Gm-Message-State: AOJu0Yz8L/xTSQqlX+gqOdZXKeovJeHtEDa6Z0AkmeW6IaQAdtMRPh84
	+7i/Lg/ARYfbhqtq1GwuDZHMh4EPeK3P8OvHvC7sUIh69o+6WEcoxCFTZ1Fnb/g=
X-Google-Smtp-Source: AGHT+IHuAOyWlgVt2h3uyi8hnKTZI7/x7V3qqE6MOMe6LFlu4tUIxezgPSdRgqkWAJuomjPaTKM+Xg==
X-Received: by 2002:a05:6a21:3392:b0:1a9:509c:eba6 with SMTP id yy18-20020a056a21339200b001a9509ceba6mr160923pzb.25.1714579760977;
        Wed, 01 May 2024 09:09:20 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00170600b006e6b180d87asm22803891pfc.35.2024.05.01.09.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:09:20 -0700 (PDT)
Date: Wed, 01 May 2024 09:09:20 -0700 (PDT)
X-Google-Original-Date: Wed, 01 May 2024 09:09:18 PDT (-0700)
Subject:     Re: [PATCH v1] riscv: defconfig: Enable StarFive JH7110 drivers
In-Reply-To: <20240403060902.42834-1-hal.feng@starfivetech.com>
CC: Conor Dooley <conor.dooley@microchip.com>,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, hal.feng@starfivetech.com,
  emil.renner.berthing@canonical.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: hal.feng@starfivetech.com
Message-ID: <mhng-3c2a418c-ce79-4287-a890-208a5d026e70@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 02 Apr 2024 23:09:02 PDT (-0700), hal.feng@starfivetech.com wrote:
> Add support for StarFive JH7110 SoC and VisionFive 2 board.
> - Clock & reset
> - Cache
> - Temperature sensor
> - PMIC (AXP15060)
> - Restart GPIO
> - RNG
> - I2C
> - SPI
> - Quad SPI
> - USB & USB 2.0 PHY & PCIe 2.0/USB 3.0 PHY
> - Audio (I2S / TDM / PWM-DAC)
> - Camera Subsystem & MIPI-CSI2 RX & D-PHY RX
>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>
> Hi,
>
> As more drivers of StarFive JH7110 VisionFive 2 board are upstream,
> add support for them in riscv defconfig.
>
> Best regards,
> Hal
>
> ---
>  arch/riscv/configs/defconfig | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index fc0ec2ee13bc..a4eb66b30d95 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -111,6 +111,7 @@ CONFIG_PCIE_XILINX=y
>  CONFIG_PCIE_FU740=y
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_SIFIVE_CCACHE=y
>  CONFIG_MTD=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
> @@ -154,24 +155,36 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y
> +CONFIG_HW_RANDOM_JH7110=m
> +CONFIG_I2C=y
>  CONFIG_I2C_CHARDEV=m
> +CONFIG_I2C_DESIGNWARE_PLATFORM=y
>  CONFIG_I2C_MV64XXX=m
>  CONFIG_I2C_RIIC=y
>  CONFIG_SPI=y
> +CONFIG_SPI_CADENCE_QUADSPI=m
> +CONFIG_SPI_PL022=m
>  CONFIG_SPI_RSPI=m
>  CONFIG_SPI_SIFIVE=y
>  CONFIG_SPI_SUN6I=y
>  # CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_GPIO_SIFIVE=y
> +CONFIG_POWER_RESET_GPIO_RESTART=y
> +CONFIG_SENSORS_SFCTEMP=y
>  CONFIG_CPU_THERMAL=y
>  CONFIG_DEVFREQ_THERMAL=y
>  CONFIG_RZG2L_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_SUNXI_WATCHDOG=y
>  CONFIG_RENESAS_RZG2LWDT=y
> +CONFIG_MFD_AXP20X_I2C=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_AXP20X=y
>  CONFIG_REGULATOR_GPIO=y
> +CONFIG_MEDIA_SUPPORT=m
> +CONFIG_V4L_PLATFORM_DRIVERS=y
> +CONFIG_VIDEO_CADENCE_CSI2RX=m
>  CONFIG_DRM=m
>  CONFIG_DRM_RADEON=m
>  CONFIG_DRM_NOUVEAU=m
> @@ -183,6 +196,10 @@ CONFIG_SOUND=y
>  CONFIG_SND=y
>  CONFIG_SND_SOC=y
>  CONFIG_SND_SOC_RZ=m
> +CONFIG_SND_DESIGNWARE_I2S=m
> +CONFIG_SND_SOC_STARFIVE=m
> +CONFIG_SND_SOC_JH7110_PWMDAC=m
> +CONFIG_SND_SOC_JH7110_TDM=m
>  CONFIG_SND_SOC_WM8978=m
>  CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_USB=y
> @@ -196,6 +213,11 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_RENESAS_USBHS=m
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
> +CONFIG_USB_CDNS_SUPPORT=m
> +CONFIG_USB_CDNS3=m
> +CONFIG_USB_CDNS3_GADGET=y
> +CONFIG_USB_CDNS3_HOST=y
> +CONFIG_USB_CDNS3_STARFIVE=m
>  CONFIG_USB_MUSB_HDRC=m
>  CONFIG_USB_MUSB_SUNXI=m
>  CONFIG_NOP_USB_XCEIV=m
> @@ -233,6 +255,13 @@ CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_INPUT=y
>  CONFIG_VIRTIO_MMIO=y
>  CONFIG_RENESAS_OSTM=y
> +CONFIG_STAGING=y
> +CONFIG_STAGING_MEDIA=y
g
I don't think we want staging on in defconfig.

> +CONFIG_VIDEO_STARFIVE_CAMSS=m

Is it just for this?  I think we can just exclude that from defconfig 
until it gets out of staging, we should be able to boot without it.  
According to the TODO userspace isn't there yet, so I think it should be 
pretty safe.

> +CONFIG_CLK_STARFIVE_JH7110_AON=y
> +CONFIG_CLK_STARFIVE_JH7110_STG=y
> +CONFIG_CLK_STARFIVE_JH7110_ISP=y
> +CONFIG_CLK_STARFIVE_JH7110_VOUT=y
>  CONFIG_SUN8I_DE2_CCU=m
>  CONFIG_SUN50I_IOMMU=y
>  CONFIG_RPMSG_CHAR=y
> @@ -244,6 +273,9 @@ CONFIG_RZG2L_ADC=m
>  CONFIG_RESET_RZG2L_USBPHY_CTRL=y
>  CONFIG_PHY_SUN4I_USB=m
>  CONFIG_PHY_RCAR_GEN3_USB2=y
> +CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
> +CONFIG_PHY_STARFIVE_JH7110_PCIE=m
> +CONFIG_PHY_STARFIVE_JH7110_USB=m
>  CONFIG_LIBNVDIMM=y
>  CONFIG_NVMEM_SUNXI_SID=y
>  CONFIG_EXT4_FS=y
>
> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f

