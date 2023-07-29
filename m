Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1F767FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjG2Npj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjG2NpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:45:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DD63C0E;
        Sat, 29 Jul 2023 06:44:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686f25d045cso2018548b3a.0;
        Sat, 29 Jul 2023 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638269; x=1691243069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J53ceYAkm+TGfLzkSvTu2FeBVqaGLEyxxjErdRVZjqA=;
        b=dPz+2N9HdiSs62M1j7ZncSiJf8zdGn+QcDRWau0hTFoVgZXjbmHh/krdZ0ilu+Cusc
         TpPqzEUJHURygubWzhjUuPZncoP9FoKd7louhmlqw9XMTjOiyLLV9S9HgPghzM5hqJEL
         tEyHR3PYJv5uf2suue6T/363ovjP8QE0jAPCy9k8Xm/wtZ3Nq7XaTFedbPiT7ZNtjkP8
         Z/8dRgZS7rFdjUYQiSxPignqgpLqh576FFzVtYzaXxvNHY7yOF2u6WPvjeQ/RTU5WpnB
         6Retc296xlrZYnjMyIxg3Lt8cRnEGsKFtIw0Ikpy0U8W5XWEtVwI13omGbY1I4jlEwmP
         upGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638269; x=1691243069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J53ceYAkm+TGfLzkSvTu2FeBVqaGLEyxxjErdRVZjqA=;
        b=IqH5l5qe8WIWmGR7CKSkiN/jLCxJKsbVP0+OhCjI8Ydw9n1uFAad1WEhzKwIiHsg5w
         o6A+EBuyHKyBy1n9XtiJlVfCssRNc3WOXata363HpYOXstr5maOdbb1i9q9hoPFXmSHY
         am69OCsTREUSy7GVi+Qp1jPwpXMrbT4p4XAkefpHkL5JVaJyPrtPuB8P+tA/9PUVdjMr
         nk+YfRyU7TNDx3mhW/9juDJw2BAsCyNZH1I5zF8WzWpByVvKhVQa9f3wHqC5fUujq231
         bLPYNGdbdvDmu7TGNhHNebYU6Eu395kCi3zithOoQI6ZPR6B8ie7wqk2UzYAG6mF1uor
         IKvQ==
X-Gm-Message-State: ABy/qLaRv2AKK0Vqxcbt3w3ljvY+/HNsEDD3qWY/w9bjc2no3R4wAw0j
        DezcVwAEhgFeVGWvjNg0R2a+qMEHt6SbDg==
X-Google-Smtp-Source: APBJJlHv+MXlj1HOPvRZYQoRjyc6m50UQSy7E+ugIjKGBBaXQDDsytx8LG+18SfsfCykPiDNR9Z/JA==
X-Received: by 2002:a05:6a00:1ad3:b0:687:1184:5420 with SMTP id f19-20020a056a001ad300b0068711845420mr5611400pfv.0.1690638269043;
        Sat, 29 Jul 2023 06:44:29 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:44:28 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 17/17] MIPS: configs: Update and rename loongson1c_defconfig
Date:   Sat, 29 Jul 2023 21:43:18 +0800
Message-Id: <20230729134318.1694467-18-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the loongson1c_defconfig to the board name.
Update the following options:
 - Enable CONFIG_SERIAL_OF_PLATFORM
 - Enable CONFIG_RTC_DRV_LOONGSON
 - Disable unnecessary options

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 ...on1c_defconfig => smartloong_1c_defconfig} | 71 ++++++++++++++-----
 1 file changed, 55 insertions(+), 16 deletions(-)
 rename arch/mips/configs/{loongson1c_defconfig => smartloong_1c_defconfig} (59%)

diff --git a/arch/mips/configs/loongson1c_defconfig b/arch/mips/configs/smartloong_1c_defconfig
similarity index 59%
rename from arch/mips/configs/loongson1c_defconfig
rename to arch/mips/configs/smartloong_1c_defconfig
index c3910a9dee9e..48296595425d 100644
--- a/arch/mips/configs/loongson1c_defconfig
+++ b/arch/mips/configs/smartloong_1c_defconfig
@@ -1,7 +1,6 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_KERNEL_XZ=y
 CONFIG_SYSVIPC=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
@@ -12,16 +11,17 @@ CONFIG_NAMESPACES=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
-# CONFIG_COMPAT_BRK is not set
 CONFIG_MACH_LOONGSON32=y
-CONFIG_LOONGSON1_LS1C=y
-# CONFIG_SECCOMP is not set
+CONFIG_MACH_SMARTLOONG_1C=y
 # CONFIG_SUSPEND is not set
+# CONFIG_SECCOMP is not set
+# CONFIG_GCC_PLUGINS is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
-# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -44,17 +44,50 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_SCSI=m
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=m
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ALACRITECH is not set
+# CONFIG_NET_VENDOR_AMAZON is not set
+# CONFIG_NET_VENDOR_AQUANTIA is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_ASIX is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CADENCE is not set
+# CONFIG_NET_VENDOR_CAVIUM is not set
+# CONFIG_NET_VENDOR_CORTINA is not set
+# CONFIG_NET_VENDOR_DAVICOM is not set
+# CONFIG_NET_VENDOR_ENGLEDER is not set
+# CONFIG_NET_VENDOR_EZCHIP is not set
+# CONFIG_NET_VENDOR_FUNGIBLE is not set
+# CONFIG_NET_VENDOR_GOOGLE is not set
+# CONFIG_NET_VENDOR_HUAWEI is not set
 # CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_LITEX is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_MICROSEMI is not set
+# CONFIG_NET_VENDOR_MICROSOFT is not set
+# CONFIG_NET_VENDOR_NI is not set
 # CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NETRONOME is not set
+# CONFIG_NET_VENDOR_PENSANDO is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_RENESAS is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SOLARFLARE is not set
 # CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_SOCIONEXT is not set
 CONFIG_STMMAC_ETH=y
+# CONFIG_NET_VENDOR_SYNOPSYS is not set
+# CONFIG_NET_VENDOR_VERTEXCOM is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WANGXUN is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
@@ -64,7 +97,9 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_LEGACY_PTY_COUNT=8
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
+# CONFIG_PTP_1588_CLOCK is not set
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_LOONGSON1=y
 # CONFIG_HWMON is not set
@@ -89,15 +124,14 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_LOONGSON1=y
+CONFIG_RTC_DRV_LOONGSON=y
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_VHOST_MENU is not set
+# CONFIG_MIPS_PLATFORM_DEVICES is not set
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
@@ -110,12 +144,17 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
-# CONFIG_CRYPTO_ECHAINIV is not set
 # CONFIG_CRYPTO_HW is not set
+# CONFIG_XZ_DEC_X86 is not set
+# CONFIG_XZ_DEC_POWERPC is not set
+# CONFIG_XZ_DEC_IA64 is not set
+# CONFIG_XZ_DEC_ARM is not set
+# CONFIG_XZ_DEC_ARMTHUMB is not set
+# CONFIG_XZ_DEC_SPARC is not set
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_FS=y
+# CONFIG_DEBUG_MISC is not set
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 # CONFIG_EARLY_PRINTK is not set
-- 
2.39.2

