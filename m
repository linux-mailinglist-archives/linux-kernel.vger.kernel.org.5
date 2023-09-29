Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B026D7B2963
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjI2AH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjI2AHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:07:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8F61A3;
        Thu, 28 Sep 2023 17:07:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4064014bca5so53355195e9.3;
        Thu, 28 Sep 2023 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695946064; x=1696550864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5OD6QfO8UFj6rBKfs0pqCOiEIzLk/acverJtq6us9U=;
        b=ByeliCh8+azC4Va3VVAnn+o0WTP7l5jEirsZ6A15hZofoOm+5YWXtHD0E4YA7ec9Bj
         PjCCVLxiqvIzaXL/Me25sUMOK2mqddIbsVSDqYbmkYsXP4wsb+ypxOGvCnN7oWDvZhxo
         hUaGd19t5JmR7XS/3GWsRY3V5S5OyASAEQ/lWsuvxWvz3obWPBpvfkhFeWz64FuK5fr5
         fP/LmNj+KqrX4nbQWgwY9P4qbcbLDZ1JN6Fy5v2VzSyXhYpoE9LT4mK96FRUSKVM1BAW
         c8kLk6xA9CuPR0ASjHtyZY8id+xeeM71Wwzr+/ZPbG83lm5t1PSNg7uxOXOdBvEth8GI
         VPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695946064; x=1696550864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5OD6QfO8UFj6rBKfs0pqCOiEIzLk/acverJtq6us9U=;
        b=AJRhT6gU7I1KuGaTzLRAMubj9COY21tk80ErW+efxXEaf7CLRHJMiuoOiXZ71U4AYu
         ZpSRbrkpsG+W/INQjHS3rijksjtvNvwiG578ArMk6Fy8v/FAZnt9Tg2UtKZ0yIWFcDca
         idBQLm/xxoaHM0XqpfD3JVFbwmM+qyn3pFx07o5Kyqg8ivBmjPhs9ZY3td1siqrckVCc
         TFU62VWbPHm5PCwWgB1ozjLjglGt8Rj6oc5chILeXlm3IRGQF4P446aCvDe6TgK7GLmK
         3ZBqD45xOGM9Oqc/bbn3mvwW/vVppYT2pUXK3KkroBgKSUgzvANBMfwTom/2UV39o1EA
         q38A==
X-Gm-Message-State: AOJu0Yy7A3Cf8s+QaYv1FtgTfnBstFSqG4g+JEXIvl2I5Mpq1Ei6pFrv
        yA9Edzt1blssci9K//2TAxY=
X-Google-Smtp-Source: AGHT+IEZsec19x4Dyp5Qyd9/dFnOI7gl2COruqQpH5xdgflyCZasqF1DinDundjYp1jJ68yPiLXLMQ==
X-Received: by 2002:a7b:cb8d:0:b0:406:177e:5df7 with SMTP id m13-20020a7bcb8d000000b00406177e5df7mr2657926wmi.29.1695946063658;
        Thu, 28 Sep 2023 17:07:43 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fe98:5e2c:1821:4cb6])
        by smtp.gmail.com with ESMTPSA id y20-20020a7bcd94000000b004030e8ff964sm245667wmj.34.2023.09.28.17.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:07:43 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5/5] riscv: configs: defconfig: Enable configs required for RZ/Five SoC
Date:   Fri, 29 Sep 2023 01:07:04 +0100
Message-Id: <20230929000704.53217-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable the configs required by the below IP blocks which are
present on RZ/Five SoC:
* ADC
* CANFD
* DMAC
* eMMC/SDHI
* OSTM
* RAVB (+ Micrel PHY)
* RIIC
* RSPI
* SSI (Sound+WM8978 codec)
* Thermal
* USB (PHY/RESET/OTG)

Along with the above some core configs are enabled too,
-> CPU frequency scaling as RZ/Five does support this.
-> MTD is enabled as RSPI can be connected to flash chips
-> Enabled I2C chardev so that it enables userspace to read/write
   i2c devices (similar to arm64)
-> Thermal configs as RZ/Five SoC does have thermal unit
-> GPIO regulator as we might have IP blocks for which voltage
   levels are controlled by GPIOs
-> OTG configs as RZ/Five USB can support host/function
-> Gadget configs so that we can test USB function (as done in arm64
   all the gadget configs are enabled)

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/configs/defconfig | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ab86ec3b9eab..1e81c865a271 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -36,6 +36,13 @@ CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
 CONFIG_CPU_IDLE=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=m
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
+CONFIG_CPUFREQ_DT=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
@@ -94,6 +101,7 @@ CONFIG_NETLINK_DIAG=y
 CONFIG_CGROUP_NET_PRIO=y
 CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
+CONFIG_CAN=m
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_HOST_GENERIC=y
@@ -101,6 +109,11 @@ CONFIG_PCIE_XILINX=y
 CONFIG_PCIE_FU740=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_NVME=m
@@ -123,8 +136,11 @@ CONFIG_VIRTIO_NET=y
 CONFIG_MACB=y
 CONFIG_E1000E=y
 CONFIG_R8169=y
+CONFIG_RAVB=y
 CONFIG_STMMAC_ETH=m
+CONFIG_MICREL_PHY=y
 CONFIG_MICROSEMI_PHY=y
+CONFIG_CAN_RCAR_CANFD=m
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_KEYBOARD_SUN4I_LRADC=m
 CONFIG_SERIAL_8250=y
@@ -135,16 +151,24 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_MV64XXX=m
+CONFIG_I2C_RIIC=y
 CONFIG_SPI=y
+CONFIG_SPI_RSPI=m
 CONFIG_SPI_SIFIVE=y
 CONFIG_SPI_SUN6I=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_GPIO_SIFIVE=y
+CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
+CONFIG_RZG2L_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
+CONFIG_RENESAS_RZG2LWDT=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_GPIO=y
 CONFIG_DRM=m
 CONFIG_DRM_RADEON=m
 CONFIG_DRM_NOUVEAU=m
@@ -152,39 +176,67 @@ CONFIG_DRM_SUN4I=m
 CONFIG_DRM_VIRTIO_GPU=m
 CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_RZ=m
+CONFIG_SND_SOC_WM8978=m
+CONFIG_SND_SIMPLE_CARD=m
 CONFIG_USB=y
+CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PLATFORM=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_RENESAS_USBHS=m
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
 CONFIG_USB_MUSB_HDRC=m
 CONFIG_USB_MUSB_SUNXI=m
 CONFIG_NOP_USB_XCEIV=m
+CONFIG_USB_GADGET=y
+CONFIG_USB_RENESAS_USBHS_UDC=m
+CONFIG_USB_CONFIGFS=m
+CONFIG_USB_CONFIGFS_SERIAL=y
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_OBEX=y
+CONFIG_USB_CONFIGFS_NCM=y
+CONFIG_USB_CONFIGFS_ECM=y
+CONFIG_USB_CONFIGFS_ECM_SUBSET=y
+CONFIG_USB_CONFIGFS_RNDIS=y
+CONFIG_USB_CONFIGFS_EEM=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_USB_CONFIGFS_F_FS=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SPI=y
+CONFIG_MMC_SDHI=y
 CONFIG_MMC_SUNXI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
+CONFIG_RZ_DMAC=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_RENESAS_OSTM=y
 CONFIG_SUN8I_DE2_CCU=m
 CONFIG_SUN50I_IOMMU=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
 CONFIG_ARCH_R9A07G043=y
+CONFIG_IIO=y
+CONFIG_RZG2L_ADC=m
+CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_PHY_SUN4I_USB=m
+CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_LIBNVDIMM=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_EXT4_FS=y
-- 
2.34.1

