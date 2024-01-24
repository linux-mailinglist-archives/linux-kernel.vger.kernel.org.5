Return-Path: <linux-kernel+bounces-37335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB4C83AE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB16A1F25A09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276DB7CF3B;
	Wed, 24 Jan 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QzJv1qil"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB4C7C0AE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113771; cv=none; b=dhkSzdE2cPMTUKREJpPkpZCPAODgx+F22BO4eTfyK+s3mP7JXtUCOFMVA2p4ele0kN0urR5AGL3mqHFjddfwCM/mfsXB36IF1QRqeS2umXKa+QhdCunjEdE68lVs1xCNoGhA+AgFxvtRhty7u5dfqJIKpTusquWuOEDB/nqA5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113771; c=relaxed/simple;
	bh=F04w5idlr2nJX9VFMu4LZTEdm+qkGs8unEbp6I68iHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH6iJvVNEQu3Lb5uG4JH7kcmAThfUnknbUM4R/oTJd1TxcRF+2hIUHVBw5wOgdOMD5IDiHhptcPwayv3tu2S8vZ2CFfDXLUb6WxggoppnS9a2uEh3xSXMpLeKnYHtIkwpAJ9xrQVu+Tp3i+clonbw+hdQyofF9XbOdgm3QcgdpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QzJv1qil; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OGSw3T084773;
	Wed, 24 Jan 2024 10:28:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706113738;
	bh=sEykJDdFg9X2OQ0VDec3CjV5RuAMnrRw175VNA+WC+k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QzJv1qilgmer72z1wrJ/LZMJ/fAs1pJShJJmOG+TyFtfeKP2n/qQC6y1BWrKy/sjJ
	 aV/PmAumka+FadcnxX/thA2Y2Ia1pMKlkOKNUPGnHsWtKqyBlUDYQ+DhCc8TM4bE+A
	 4qdiVVp3qQNyNB3IycJtCfL1WxWo/JG7NE+9X8UI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OGSwlK004725
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 10:28:58 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 10:28:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 10:28:58 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OGSvLv108543;
	Wed, 24 Jan 2024 10:28:58 -0600
From: Andrew Davis <afd@ti.com>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] ARM: configs: keystone: Remove this defconfig
Date: Wed, 24 Jan 2024 10:28:57 -0600
Message-ID: <20240124162857.111915-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124162857.111915-1-afd@ti.com>
References: <20240124162857.111915-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI Keystone devices can and should use the common multi-v7 defconfig.
Currently it is not clear which defconfig should be used and so config
options for Keystone boards are added to either both defconfigs, or only
one or the other. As nice as it is to have a config just for this platform
it is a maintenance burden. As it is not used by generic distros it is not
very useful to continue to maintain. Remove this defconfig.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/configs/keystone_defconfig | 238 ----------------------------
 1 file changed, 238 deletions(-)
 delete mode 100644 arch/arm/configs/keystone_defconfig

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
deleted file mode 100644
index 59c4835ffc977..0000000000000
--- a/arch/arm/configs/keystone_defconfig
+++ /dev/null
@@ -1,238 +0,0 @@
-CONFIG_POSIX_MQUEUE=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CGROUPS=y
-CONFIG_BLK_CGROUP=y
-CONFIG_CGROUP_SCHED=y
-CONFIG_CGROUP_FREEZER=y
-CONFIG_CGROUP_DEVICE=y
-CONFIG_CGROUP_CPUACCT=y
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
-CONFIG_KALLSYMS_ALL=y
-CONFIG_EXPERT=y
-CONFIG_PROFILING=y
-CONFIG_ARCH_KEYSTONE=y
-CONFIG_ARM_LPAE=y
-CONFIG_PCI_KEYSTONE=y
-CONFIG_SMP=y
-CONFIG_HOTPLUG_CPU=y
-CONFIG_ARM_PSCI=y
-CONFIG_AEABI=y
-CONFIG_HIGHMEM=y
-CONFIG_VFP=y
-CONFIG_NEON=y
-# CONFIG_SUSPEND is not set
-CONFIG_PM=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_FORCE_LOAD=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-# CONFIG_SWAP is not set
-CONFIG_CMA=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_UNIX_DIAG=y
-CONFIG_XFRM_USER=y
-CONFIG_XFRM_SUB_POLICY=y
-CONFIG_XFRM_STATISTICS=y
-CONFIG_NET_KEY=y
-CONFIG_NET_KEY_MIGRATE=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_NET_IPIP=y
-CONFIG_NET_IPGRE_DEMUX=y
-CONFIG_NET_IPGRE=y
-CONFIG_IP_MROUTE=y
-CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
-CONFIG_IP_PIMSM_V2=y
-CONFIG_INET_AH=y
-CONFIG_INET_IPCOMP=y
-CONFIG_INET6_XFRM_MODE_TRANSPORT=m
-CONFIG_INET6_XFRM_MODE_TUNNEL=m
-CONFIG_INET6_XFRM_MODE_BEET=m
-CONFIG_IPV6_SIT=m
-CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_IPV6_SUBTREES=y
-CONFIG_IPV6_MROUTE=y
-CONFIG_IPV6_PIMSM_V2=y
-CONFIG_NETFILTER=y
-CONFIG_NF_CONNTRACK=y
-CONFIG_NF_CT_NETLINK=y
-CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
-CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
-CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
-CONFIG_NETFILTER_XT_TARGET_MARK=y
-CONFIG_NETFILTER_XT_MATCH_COMMENT=y
-CONFIG_NETFILTER_XT_MATCH_CONNBYTES=y
-CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
-CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
-CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
-CONFIG_NETFILTER_XT_MATCH_CPU=y
-CONFIG_NETFILTER_XT_MATCH_IPRANGE=y
-CONFIG_NETFILTER_XT_MATCH_LENGTH=y
-CONFIG_NETFILTER_XT_MATCH_MAC=y
-CONFIG_NETFILTER_XT_MATCH_MARK=y
-CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
-CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
-CONFIG_NETFILTER_XT_MATCH_STATE=y
-CONFIG_NF_CONNTRACK_IPV4=y
-CONFIG_IP_NF_IPTABLES=y
-CONFIG_IP_NF_MATCH_AH=y
-CONFIG_IP_NF_MATCH_ECN=y
-CONFIG_IP_NF_MATCH_TTL=y
-CONFIG_IP_NF_FILTER=y
-CONFIG_IP_NF_TARGET_REJECT=y
-CONFIG_IP_NF_MANGLE=y
-CONFIG_IP_NF_TARGET_ECN=y
-CONFIG_IP_NF_TARGET_TTL=y
-CONFIG_IP_NF_RAW=y
-CONFIG_IP_NF_ARPTABLES=y
-CONFIG_IP_NF_ARPFILTER=y
-CONFIG_IP_NF_ARP_MANGLE=y
-CONFIG_IP6_NF_IPTABLES=m
-CONFIG_IP_SCTP=y
-CONFIG_VLAN_8021Q=y
-CONFIG_CAN=m
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_TI_SCI_PROTOCOL=y
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_PLATRAM=y
-CONFIG_MTD_M25P80=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_MTD_NAND_DAVINCI=y
-CONFIG_MTD_SPI_NOR=y
-CONFIG_MTD_UBI=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_SRAM=y
-CONFIG_EEPROM_AT24=y
-CONFIG_SCSI=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_NETDEVICES=y
-CONFIG_TI_CPTS=y
-CONFIG_TI_KEYSTONE_NETCP=y
-CONFIG_TI_KEYSTONE_NETCP_ETHSS=y
-CONFIG_MARVELL_PHY=y
-CONFIG_MICREL_PHY=y
-CONFIG_DP83867_PHY=y
-CONFIG_CAN_C_CAN=m
-CONFIG_CAN_C_CAN_PLATFORM=m
-CONFIG_INPUT_EVDEV=m
-CONFIG_INPUT_MISC=y
-CONFIG_INPUT_GPIO_DECODER=m
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-# CONFIG_I2C_COMPAT is not set
-CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_DAVINCI=y
-CONFIG_SPI=y
-CONFIG_SPI_CADENCE_QUADSPI=y
-CONFIG_SPI_DAVINCI=y
-CONFIG_SPI_SPIDEV=y
-CONFIG_PINCTRL_SINGLE=y
-CONFIG_GPIOLIB=y
-CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_DAVINCI=y
-CONFIG_GPIO_SYSCON=y
-CONFIG_GPIO_PCA953X=m
-CONFIG_POWER_RESET=y
-CONFIG_POWER_RESET_KEYSTONE=y
-CONFIG_POWER_SUPPLY=y
-# CONFIG_HWMON is not set
-CONFIG_WATCHDOG=y
-CONFIG_DAVINCI_WATCHDOG=y
-CONFIG_REGULATOR=y
-CONFIG_REGULATOR_FIXED_VOLTAGE=y
-CONFIG_USB=y
-CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_MON=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_DWC3=y
-CONFIG_KEYSTONE_USB_PHY=y
-CONFIG_NOP_USB_XCEIV=y
-CONFIG_MMC=y
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_PLTFM=y
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MMC_SDHCI_OMAP=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_ONESHOT=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_LEDS_TRIGGER_BACKLIGHT=y
-CONFIG_LEDS_TRIGGER_CPU=y
-CONFIG_LEDS_TRIGGER_ACTIVITY=y
-CONFIG_LEDS_TRIGGER_GPIO=y
-CONFIG_DMADEVICES=y
-CONFIG_TI_EDMA=y
-CONFIG_MAILBOX=y
-CONFIG_TI_MESSAGE_MANAGER=y
-CONFIG_SOC_TI=y
-CONFIG_KEYSTONE_NAVIGATOR_QMSS=y
-CONFIG_KEYSTONE_NAVIGATOR_DMA=y
-CONFIG_TI_SCI_PM_DOMAINS=y
-CONFIG_MEMORY=y
-CONFIG_TI_AEMIF=y
-CONFIG_PWM=y
-CONFIG_PWM_TIECAP=m
-CONFIG_KEYSTONE_IRQ=y
-CONFIG_RESET_TI_SCI=m
-CONFIG_RESET_TI_SYSCON=m
-CONFIG_EXT4_FS=y
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_FANOTIFY=y
-CONFIG_AUTOFS_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_NTFS_FS=y
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_FS_WBUF_VERIFY=y
-CONFIG_UBIFS_FS=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3_ACL=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFSD=y
-CONFIG_NFSD_V3_ACL=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_CRYPTO_USER=y
-CONFIG_CRYPTO_AUTHENC=y
-CONFIG_CRYPTO_DES=y
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_CTR=y
-CONFIG_CRYPTO_XCBC=y
-CONFIG_CRYPTO_ANSI_CPRNG=y
-CONFIG_CRYPTO_USER_API_HASH=y
-CONFIG_CRYPTO_USER_API_SKCIPHER=y
-CONFIG_DMA_CMA=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
-CONFIG_DEBUG_SHIRQ=y
-CONFIG_DEBUG_USER=y
-- 
2.39.2


