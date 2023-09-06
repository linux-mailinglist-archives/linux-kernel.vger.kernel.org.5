Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0D47944A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbjIFUic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjIFUiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:38:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82681BEA;
        Wed,  6 Sep 2023 13:38:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38B5C433CD;
        Wed,  6 Sep 2023 20:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694032684;
        bh=AbyxZ3XgCPvUMMrwzPvq+hr+GiZJrmJR83Tz1cKASdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBxYegqNwI9CHTQwXI8M65WeDk9T/EpNe85cExkLCBIG3dalh6O6QwqocBFpLd8Tj
         JhaPje/O4FyoT7CdAs6Fhb2CLXGkW8R9YIIeIKXBhkpmID9mebF/x0Z8uwtl0OFBSZ
         DjjO7cV00ih3osTcys4vic8xftCjc+TJwIkd1tbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.131
Date:   Wed,  6 Sep 2023 21:37:52 +0100
Message-ID: <2023090652-suffocate-waltz-bc92@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023090651-gradually-repacking-389b@gregkh>
References: <2023090651-gradually-repacking-389b@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 08cc0832e4d1..1f537b7286b5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 130
+SUBLEVEL = 131
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 83cfbb882a2d..7f6bd7f069e4 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -220,8 +220,6 @@ void sharpsl_battery_kick(void)
 {
 	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(125));
 }
-EXPORT_SYMBOL(sharpsl_battery_kick);
-
 
 static void sharpsl_battery_thread(struct work_struct *private_)
 {
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 371008e9bb02..264de0bc97d6 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>	/* symbol_get ; symbol_put */
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio_keys.h>
@@ -514,17 +513,6 @@ static struct pxa2xx_spi_chip spitz_ads7846_chip = {
 	.gpio_cs		= SPITZ_GPIO_ADS7846_CS,
 };
 
-static void spitz_bl_kick_battery(void)
-{
-	void (*kick_batt)(void);
-
-	kick_batt = symbol_get(sharpsl_battery_kick);
-	if (kick_batt) {
-		kick_batt();
-		symbol_put(sharpsl_battery_kick);
-	}
-}
-
 static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
 	.dev_id = "spi2.1",
 	.table = {
@@ -552,7 +540,7 @@ static struct corgi_lcd_platform_data spitz_lcdcon_info = {
 	.max_intensity		= 0x2f,
 	.default_intensity	= 0x1f,
 	.limit_mask		= 0x0b,
-	.kick_battery		= spitz_bl_kick_battery,
+	.kick_battery		= sharpsl_battery_kick,
 };
 
 static struct pxa2xx_spi_chip spitz_lcdcon_chip = {
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 2c52ee27b4f2..50de86eb8784 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/leds.h>
 #include <linux/mmc/host.h>
-#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/spi/spi.h>
@@ -167,12 +166,7 @@ static struct platform_device db1x00_audio_dev = {
 
 static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	mmc_cd(ptr, msecs_to_jiffies(500));
-	symbol_put(mmc_detect_change);
-
+	mmc_detect_change(ptr, msecs_to_jiffies(500));
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 1864eb935ca5..76080c71a2a7 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -10,7 +10,6 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/leds.h>
@@ -340,14 +339,7 @@ static irqreturn_t db1200_mmc_cd(int irq, void *ptr)
 
 static irqreturn_t db1200_mmc_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	if (mmc_cd) {
-		mmc_cd(ptr, msecs_to_jiffies(200));
-		symbol_put(mmc_detect_change);
-	}
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == DB1200_SD0_INSERT_INT)
@@ -431,14 +423,7 @@ static irqreturn_t pb1200_mmc1_cd(int irq, void *ptr)
 
 static irqreturn_t pb1200_mmc1_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	if (mmc_cd) {
-		mmc_cd(ptr, msecs_to_jiffies(200));
-		symbol_put(mmc_detect_change);
-	}
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == PB1200_SD1_INSERT_INT)
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index cd72eaa1168f..ca71e5ed51ab 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/ata_platform.h>
 #include <linux/mmc/host.h>
-#include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/platnand.h>
 #include <linux/platform_device.h>
@@ -459,14 +458,7 @@ static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
 
 static irqreturn_t db1300_mmc_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m.  We can only be called once MMC core has
-	 * initialized the controller, so symbol_get() should always succeed.
-	 */
-	mmc_cd = symbol_get(mmc_detect_change);
-	mmc_cd(ptr, msecs_to_jiffies(200));
-	symbol_put(mmc_detect_change);
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == DB1300_SD1_INSERT_INT)
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 199e8f7d426d..2e4ac39dd975 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -355,6 +355,7 @@ static void btsdio_remove(struct sdio_func *func)
 	if (!data)
 		return;
 
+	cancel_work_sync(&data->work);
 	hdev = data->hdev;
 
 	sdio_set_drvdata(func, NULL);
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 1bd3979abde6..c61d55ed71a3 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -623,7 +623,7 @@ svc_create_memory_pool(struct platform_device *pdev,
 	paddr = begin;
 	size = end - begin;
 	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
-	if (!va) {
+	if (IS_ERR(va)) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 24292acdbaf8..a9abebb07f35 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1439,3 +1439,4 @@ static struct platform_driver fsi_master_acf = {
 
 module_platform_driver(fsi_master_acf);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FW_FILE_NAME);
diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 3f8b24a57014..c034a1e850e4 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -153,6 +153,7 @@ struct wacom_remote {
 		struct input_dev *input;
 		bool registered;
 		struct wacom_battery battery;
+		ktime_t active_time;
 	} remotes[WACOM_MAX_REMOTES];
 };
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 33e763e746a0..76561f538eda 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2535,6 +2535,18 @@ static void wacom_wireless_work(struct work_struct *work)
 	return;
 }
 
+static void wacom_remote_destroy_battery(struct wacom *wacom, int index)
+{
+	struct wacom_remote *remote = wacom->remote;
+
+	if (remote->remotes[index].battery.battery) {
+		devres_release_group(&wacom->hdev->dev,
+				     &remote->remotes[index].battery.bat_desc);
+		remote->remotes[index].battery.battery = NULL;
+		remote->remotes[index].active_time = 0;
+	}
+}
+
 static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 {
 	struct wacom_remote *remote = wacom->remote;
@@ -2549,9 +2561,7 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 			remote->remotes[i].registered = false;
 			spin_unlock_irqrestore(&remote->remote_lock, flags);
 
-			if (remote->remotes[i].battery.battery)
-				devres_release_group(&wacom->hdev->dev,
-						     &remote->remotes[i].battery.bat_desc);
+			wacom_remote_destroy_battery(wacom, i);
 
 			if (remote->remotes[i].group.name)
 				devres_release_group(&wacom->hdev->dev,
@@ -2559,7 +2569,6 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 
 			remote->remotes[i].serial = 0;
 			remote->remotes[i].group.name = NULL;
-			remote->remotes[i].battery.battery = NULL;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		}
 	}
@@ -2644,6 +2653,9 @@ static int wacom_remote_attach_battery(struct wacom *wacom, int index)
 	if (remote->remotes[index].battery.battery)
 		return 0;
 
+	if (!remote->remotes[index].active_time)
+		return 0;
+
 	if (wacom->led.groups[index].select == WACOM_STATUS_UNKNOWN)
 		return 0;
 
@@ -2659,6 +2671,7 @@ static void wacom_remote_work(struct work_struct *work)
 {
 	struct wacom *wacom = container_of(work, struct wacom, remote_work);
 	struct wacom_remote *remote = wacom->remote;
+	ktime_t kt = ktime_get();
 	struct wacom_remote_data data;
 	unsigned long flags;
 	unsigned int count;
@@ -2685,6 +2698,10 @@ static void wacom_remote_work(struct work_struct *work)
 		serial = data.remote[i].serial;
 		if (data.remote[i].connected) {
 
+			if (kt - remote->remotes[i].active_time > WACOM_REMOTE_BATTERY_TIMEOUT
+			    && remote->remotes[i].active_time != 0)
+				wacom_remote_destroy_battery(wacom, i);
+
 			if (remote->remotes[i].serial == serial) {
 				wacom_remote_attach_battery(wacom, i);
 				continue;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 02ca80f68d17..51a8e8d10519 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1134,6 +1134,7 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	if (index < 0 || !remote->remotes[index].registered)
 		goto out;
 
+	remote->remotes[i].active_time = ktime_get();
 	input = remote->remotes[index].input;
 
 	input_report_key(input, BTN_0, (data[9] & 0x01));
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index db06084c4ed5..4ea1910ec3fa 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -15,6 +15,7 @@
 #define WACOM_NAME_MAX		64
 #define WACOM_MAX_REMOTES	5
 #define WACOM_STATUS_UNKNOWN	255
+#define WACOM_REMOTE_BATTERY_TIMEOUT	21000000000ll
 
 /* packet length for individual models */
 #define WACOM_PKGLEN_BBFUN	 9
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index c167186085c8..a281df78d168 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -523,11 +523,12 @@ config MMC_ALCOR
 	  of Alcor Micro PCI-E card reader
 
 config MMC_AU1X
-	tristate "Alchemy AU1XX0 MMC Card Interface support"
+	bool "Alchemy AU1XX0 MMC Card Interface support"
 	depends on MIPS_ALCHEMY
+	depends on MMC=y
 	help
 	  This selects the AMD Alchemy(R) Multimedia card interface.
-	  If you have a Alchemy platform with a MMC slot, say Y or M here.
+	  If you have a Alchemy platform with a MMC slot, say Y here.
 
 	  If unsure, say N.
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
index bc594892507a..8c3661525694 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
@@ -8,7 +8,7 @@
 #include "enetc.h"
 
 int enetc_phc_index = -1;
-EXPORT_SYMBOL(enetc_phc_index);
+EXPORT_SYMBOL_GPL(enetc_phc_index);
 
 static struct ptp_clock_info enetc_ptp_caps = {
 	.owner		= THIS_MODULE,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 7b48df301079..b34f9e6500cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -994,7 +994,7 @@ mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 		return -EINVAL;
 
 	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
-		tx_ant = BIT(ffs(tx_ant) - 1) - 1;
+		return -EINVAL;
 
 	mt7921_mutex_acquire(dev);
 
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 384d93146e1f..7e41b4842c1f 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -752,7 +752,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	default:
-		dev_err(&gpio_dev->pdev->dev, "Invalid config param %04x\n",
+		dev_dbg(&gpio_dev->pdev->dev, "Invalid config param %04x\n",
 			param);
 		return -ENOTSUPP;
 	}
@@ -805,7 +805,7 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		default:
-			dev_err(&gpio_dev->pdev->dev,
+			dev_dbg(&gpio_dev->pdev->dev,
 				"Invalid config param %04x\n", param);
 			ret = -ENOTSUPP;
 		}
diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 75db7ab654a5..1e09c9a228d6 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1438,7 +1438,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 		unreachable();
 	}
 }
-EXPORT_SYMBOL(ds1685_rtc_poweroff);
+EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
 /* ----------------------------------------------------------------------- */
 
 
diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index bc033849fcea..2a4c6cf14fac 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -323,6 +323,7 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	mp871xinit(padapter);
 	init_default_value(padapter);
 	r8712_InitSwLeds(padapter);
+	mutex_init(&padapter->mutex_start);
 	return ret;
 }
 
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 6db2493e6d3a..ed8e70cce68b 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -567,7 +567,6 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 	if (rtl871x_load_fw(padapter))
 		goto deinit_drv_sw;
 	spin_lock_init(&padapter->lock_rx_ff0_filter);
-	mutex_init(&padapter->mutex_start);
 	return 0;
 
 deinit_drv_sw:
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 197397a98944..45010c77fe3a 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -125,6 +125,7 @@ struct qcom_geni_serial_port {
 	u32 tx_fifo_width;
 	u32 rx_fifo_depth;
 	bool setup;
+	unsigned long clk_rate;
 	int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
 	unsigned int baud;
 	void *rx_fifo;
@@ -1022,6 +1023,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		goto out_restart_rx;
 
 	uport->uartclk = clk_rate;
+	port->clk_rate = clk_rate;
 	dev_pm_opp_set_rate(uport->dev, clk_rate);
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
@@ -1291,10 +1293,13 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 
 	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
 		geni_icc_enable(&port->se);
+		if (port->clk_rate)
+			dev_pm_opp_set_rate(uport->dev, port->clk_rate);
 		geni_se_resources_on(&port->se);
 	} else if (new_state == UART_PM_STATE_OFF &&
 			old_state == UART_PM_STATE_ON) {
 		geni_se_resources_off(&port->se);
+		dev_pm_opp_set_rate(uport->dev, 0);
 		geni_icc_disable(&port->se);
 	}
 }
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index b57cf8ddbf63..e8f8a94ad606 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1170,9 +1170,18 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 		state |= BIT(offset);
 	else
 		state &= ~BIT(offset);
-	sc16is7xx_port_write(port, SC16IS7XX_IOSTATE_REG, state);
+
+	/*
+	 * If we write IOSTATE first, and then IODIR, the output value is not
+	 * transferred to the corresponding I/O pin.
+	 * The datasheet states that each register bit will be transferred to
+	 * the corresponding I/O pin programmed as output when writing to
+	 * IOSTATE. Therefore, configure direction first with IODIR, and then
+	 * set value after with IOSTATE.
+	 */
 	sc16is7xx_port_update(port, SC16IS7XX_IODIR_REG, BIT(offset),
 			      BIT(offset));
+	sc16is7xx_port_write(port, SC16IS7XX_IOSTATE_REG, state);
 
 	return 0;
 }
@@ -1258,6 +1267,12 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
 		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
 		s->p[i].port.iobase	= i;
+		/*
+		 * Use all ones as membase to make sure uart_configure_port() in
+		 * serial_core.c does not abort for SPI/I2C devices where the
+		 * membase address is not applicable.
+		 */
+		s->p[i].port.membase	= (void __iomem *)~0;
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 669e7606651a..d8efa90479e2 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -175,10 +175,12 @@ static struct imx_usbmisc_data *usbmisc_get_init_data(struct device *dev)
 	if (of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI)
 		data->ulpi = 1;
 
-	of_property_read_u32(np, "samsung,picophy-pre-emp-curr-control",
-			&data->emp_curr_control);
-	of_property_read_u32(np, "samsung,picophy-dc-vol-level-adjust",
-			&data->dc_vol_level_adjust);
+	if (of_property_read_u32(np, "samsung,picophy-pre-emp-curr-control",
+			&data->emp_curr_control))
+		data->emp_curr_control = -1;
+	if (of_property_read_u32(np, "samsung,picophy-dc-vol-level-adjust",
+			&data->dc_vol_level_adjust))
+		data->dc_vol_level_adjust = -1;
 
 	return data;
 }
diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 2318c7906acd..a2cb4f48c84c 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -657,13 +657,15 @@ static int usbmisc_imx7d_init(struct imx_usbmisc_data *data)
 			usbmisc->base + MX7D_USBNC_USB_CTRL2);
 		/* PHY tuning for signal quality */
 		reg = readl(usbmisc->base + MX7D_USB_OTG_PHY_CFG1);
-		if (data->emp_curr_control && data->emp_curr_control <=
+		if (data->emp_curr_control >= 0 &&
+			data->emp_curr_control <=
 			(TXPREEMPAMPTUNE0_MASK >> TXPREEMPAMPTUNE0_BIT)) {
 			reg &= ~TXPREEMPAMPTUNE0_MASK;
 			reg |= (data->emp_curr_control << TXPREEMPAMPTUNE0_BIT);
 		}
 
-		if (data->dc_vol_level_adjust && data->dc_vol_level_adjust <=
+		if (data->dc_vol_level_adjust >= 0 &&
+			data->dc_vol_level_adjust <=
 			(TXVREFTUNE0_MASK >> TXVREFTUNE0_BIT)) {
 			reg &= ~TXVREFTUNE0_MASK;
 			reg |= (data->dc_vol_level_adjust << TXVREFTUNE0_BIT);
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 8f94bc4a82cf..d3b4dc00007f 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -938,6 +938,12 @@ static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
 			return ret;
 	}
 
+	if (priv->drvdata->usb_post_init) {
+		ret = priv->drvdata->usb_post_init(priv);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 119641761c3b..f13930b4534c 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -259,6 +259,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM05G			0x030a
 #define QUECTEL_PRODUCT_EM060K			0x030b
 #define QUECTEL_PRODUCT_EM05G_CS		0x030c
+#define QUECTEL_PRODUCT_EM05GV2			0x030e
 #define QUECTEL_PRODUCT_EM05CN_SG		0x0310
 #define QUECTEL_PRODUCT_EM05G_SG		0x0311
 #define QUECTEL_PRODUCT_EM05CN			0x0312
@@ -1190,6 +1191,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(6) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_GR, 0xff),
 	  .driver_info = RSVD(6) | ZLP },
+	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05GV2, 0xff),
+	  .driver_info = RSVD(4) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_CS, 0xff),
 	  .driver_info = RSVD(6) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_RS, 0xff),
@@ -2232,6 +2235,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0db, 0xff),			/* Foxconn T99W265 MBIM */
 	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0ee, 0xff),			/* Foxconn T99W368 MBIM */
+	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0f0, 0xff),			/* Foxconn T99W373 MBIM */
+	  .driver_info = RSVD(3) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 5340a3a3a81b..a7b0134d382b 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -13,11 +13,10 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
 
-#include "tcpci.h"
-
 #define	PD_RETRY_COUNT_DEFAULT			3
 #define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
 #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
@@ -616,6 +615,10 @@ static int tcpci_init(struct tcpc_dev *tcpc)
 	if (time_after(jiffies, timeout))
 		return -ETIMEDOUT;
 
+	ret = tcpci_write16(tcpci, TCPC_FAULT_STATUS, TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT);
+	if (ret < 0)
+		return ret;
+
 	/* Handle vendor init */
 	if (tcpci->data->init) {
 		ret = tcpci->data->init(tcpci, tcpci->data);
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
deleted file mode 100644
index b2edd45f13c6..000000000000
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ /dev/null
@@ -1,209 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2015-2017 Google, Inc
- *
- * USB Type-C Port Controller Interface.
- */
-
-#ifndef __LINUX_USB_TCPCI_H
-#define __LINUX_USB_TCPCI_H
-
-#include <linux/usb/typec.h>
-
-#define TCPC_VENDOR_ID			0x0
-#define TCPC_PRODUCT_ID			0x2
-#define TCPC_BCD_DEV			0x4
-#define TCPC_TC_REV			0x6
-#define TCPC_PD_REV			0x8
-#define TCPC_PD_INT_REV			0xa
-
-#define TCPC_ALERT			0x10
-#define TCPC_ALERT_EXTND		BIT(14)
-#define TCPC_ALERT_EXTENDED_STATUS	BIT(13)
-#define TCPC_ALERT_VBUS_DISCNCT		BIT(11)
-#define TCPC_ALERT_RX_BUF_OVF		BIT(10)
-#define TCPC_ALERT_FAULT		BIT(9)
-#define TCPC_ALERT_V_ALARM_LO		BIT(8)
-#define TCPC_ALERT_V_ALARM_HI		BIT(7)
-#define TCPC_ALERT_TX_SUCCESS		BIT(6)
-#define TCPC_ALERT_TX_DISCARDED		BIT(5)
-#define TCPC_ALERT_TX_FAILED		BIT(4)
-#define TCPC_ALERT_RX_HARD_RST		BIT(3)
-#define TCPC_ALERT_RX_STATUS		BIT(2)
-#define TCPC_ALERT_POWER_STATUS		BIT(1)
-#define TCPC_ALERT_CC_STATUS		BIT(0)
-
-#define TCPC_ALERT_MASK			0x12
-#define TCPC_POWER_STATUS_MASK		0x14
-#define TCPC_FAULT_STATUS_MASK		0x15
-
-#define TCPC_EXTENDED_STATUS_MASK		0x16
-#define TCPC_EXTENDED_STATUS_MASK_VSAFE0V	BIT(0)
-
-#define TCPC_ALERT_EXTENDED_MASK	0x17
-#define TCPC_SINK_FAST_ROLE_SWAP	BIT(0)
-
-#define TCPC_CONFIG_STD_OUTPUT		0x18
-
-#define TCPC_TCPC_CTRL			0x19
-#define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
-#define PLUG_ORNT_CC1			0
-#define PLUG_ORNT_CC2			1
-#define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
-#define TCPC_TCPC_CTRL_EN_LK4CONN_ALRT	BIT(6)
-
-#define TCPC_EXTENDED_STATUS		0x20
-#define TCPC_EXTENDED_STATUS_VSAFE0V	BIT(0)
-
-#define TCPC_ROLE_CTRL			0x1a
-#define TCPC_ROLE_CTRL_DRP		BIT(6)
-#define TCPC_ROLE_CTRL_RP_VAL_SHIFT	4
-#define TCPC_ROLE_CTRL_RP_VAL_MASK	0x3
-#define TCPC_ROLE_CTRL_RP_VAL_DEF	0x0
-#define TCPC_ROLE_CTRL_RP_VAL_1_5	0x1
-#define TCPC_ROLE_CTRL_RP_VAL_3_0	0x2
-#define TCPC_ROLE_CTRL_CC2_SHIFT	2
-#define TCPC_ROLE_CTRL_CC2_MASK		0x3
-#define TCPC_ROLE_CTRL_CC1_SHIFT	0
-#define TCPC_ROLE_CTRL_CC1_MASK		0x3
-#define TCPC_ROLE_CTRL_CC_RA		0x0
-#define TCPC_ROLE_CTRL_CC_RP		0x1
-#define TCPC_ROLE_CTRL_CC_RD		0x2
-#define TCPC_ROLE_CTRL_CC_OPEN		0x3
-
-#define TCPC_FAULT_CTRL			0x1b
-
-#define TCPC_POWER_CTRL			0x1c
-#define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
-#define TCPC_POWER_CTRL_BLEED_DISCHARGE	BIT(3)
-#define TCPC_POWER_CTRL_AUTO_DISCHARGE	BIT(4)
-#define TCPC_DIS_VOLT_ALRM		BIT(5)
-#define TCPC_POWER_CTRL_VBUS_VOLT_MON	BIT(6)
-#define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
-
-#define TCPC_CC_STATUS			0x1d
-#define TCPC_CC_STATUS_TOGGLING		BIT(5)
-#define TCPC_CC_STATUS_TERM		BIT(4)
-#define TCPC_CC_STATUS_TERM_RP		0
-#define TCPC_CC_STATUS_TERM_RD		1
-#define TCPC_CC_STATE_SRC_OPEN		0
-#define TCPC_CC_STATUS_CC2_SHIFT	2
-#define TCPC_CC_STATUS_CC2_MASK		0x3
-#define TCPC_CC_STATUS_CC1_SHIFT	0
-#define TCPC_CC_STATUS_CC1_MASK		0x3
-
-#define TCPC_POWER_STATUS		0x1e
-#define TCPC_POWER_STATUS_DBG_ACC_CON	BIT(7)
-#define TCPC_POWER_STATUS_UNINIT	BIT(6)
-#define TCPC_POWER_STATUS_SOURCING_VBUS	BIT(4)
-#define TCPC_POWER_STATUS_VBUS_DET	BIT(3)
-#define TCPC_POWER_STATUS_VBUS_PRES	BIT(2)
-#define TCPC_POWER_STATUS_VCONN_PRES	BIT(1)
-#define TCPC_POWER_STATUS_SINKING_VBUS	BIT(0)
-
-#define TCPC_FAULT_STATUS		0x1f
-
-#define TCPC_ALERT_EXTENDED		0x21
-
-#define TCPC_COMMAND			0x23
-#define TCPC_CMD_WAKE_I2C		0x11
-#define TCPC_CMD_DISABLE_VBUS_DETECT	0x22
-#define TCPC_CMD_ENABLE_VBUS_DETECT	0x33
-#define TCPC_CMD_DISABLE_SINK_VBUS	0x44
-#define TCPC_CMD_SINK_VBUS		0x55
-#define TCPC_CMD_DISABLE_SRC_VBUS	0x66
-#define TCPC_CMD_SRC_VBUS_DEFAULT	0x77
-#define TCPC_CMD_SRC_VBUS_HIGH		0x88
-#define TCPC_CMD_LOOK4CONNECTION	0x99
-#define TCPC_CMD_RXONEMORE		0xAA
-#define TCPC_CMD_I2C_IDLE		0xFF
-
-#define TCPC_DEV_CAP_1			0x24
-#define TCPC_DEV_CAP_2			0x26
-#define TCPC_STD_INPUT_CAP		0x28
-#define TCPC_STD_OUTPUT_CAP		0x29
-
-#define TCPC_MSG_HDR_INFO		0x2e
-#define TCPC_MSG_HDR_INFO_DATA_ROLE	BIT(3)
-#define TCPC_MSG_HDR_INFO_PWR_ROLE	BIT(0)
-#define TCPC_MSG_HDR_INFO_REV_SHIFT	1
-#define TCPC_MSG_HDR_INFO_REV_MASK	0x3
-
-#define TCPC_RX_DETECT			0x2f
-#define TCPC_RX_DETECT_HARD_RESET	BIT(5)
-#define TCPC_RX_DETECT_SOP		BIT(0)
-#define TCPC_RX_DETECT_SOP1		BIT(1)
-#define TCPC_RX_DETECT_SOP2		BIT(2)
-#define TCPC_RX_DETECT_DBG1		BIT(3)
-#define TCPC_RX_DETECT_DBG2		BIT(4)
-
-#define TCPC_RX_BYTE_CNT		0x30
-#define TCPC_RX_BUF_FRAME_TYPE		0x31
-#define TCPC_RX_BUF_FRAME_TYPE_SOP	0
-#define TCPC_RX_HDR			0x32
-#define TCPC_RX_DATA			0x34 /* through 0x4f */
-
-#define TCPC_TRANSMIT			0x50
-#define TCPC_TRANSMIT_RETRY_SHIFT	4
-#define TCPC_TRANSMIT_RETRY_MASK	0x3
-#define TCPC_TRANSMIT_TYPE_SHIFT	0
-#define TCPC_TRANSMIT_TYPE_MASK		0x7
-
-#define TCPC_TX_BYTE_CNT		0x51
-#define TCPC_TX_HDR			0x52
-#define TCPC_TX_DATA			0x54 /* through 0x6f */
-
-#define TCPC_VBUS_VOLTAGE			0x70
-#define TCPC_VBUS_VOLTAGE_MASK			0x3ff
-#define TCPC_VBUS_VOLTAGE_LSB_MV		25
-#define TCPC_VBUS_SINK_DISCONNECT_THRESH	0x72
-#define TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB_MV	25
-#define TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX	0x3ff
-#define TCPC_VBUS_STOP_DISCHARGE_THRESH		0x74
-#define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
-#define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
-
-/* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
-#define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
-
-struct tcpci;
-
-/*
- * @TX_BUF_BYTE_x_hidden:
- *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
- * @frs_sourcing_vbus:
- *		Optional; Callback to perform chip specific operations when FRS
- *		is sourcing vbus.
- * @auto_discharge_disconnect:
- *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
- * @vbus_vsafe0v:
- *		optional; Set when TCPC can detect whether vbus is at VSAFE0V.
- * @set_partner_usb_comm_capable:
- *		Optional; The USB Communications Capable bit indicates if port
- *		partner is capable of communication over the USB data lines
- *		(e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
- */
-struct tcpci_data {
-	struct regmap *regmap;
-	unsigned char TX_BUF_BYTE_x_hidden:1;
-	unsigned char auto_discharge_disconnect:1;
-	unsigned char vbus_vsafe0v:1;
-
-	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
-	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
-			 bool enable);
-	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
-				  enum typec_cc_status cc);
-	int (*set_vbus)(struct tcpci *tcpci, struct tcpci_data *data, bool source, bool sink);
-	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
-	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
-					     bool capable);
-};
-
-struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-void tcpci_unregister_port(struct tcpci *tcpci);
-irqreturn_t tcpci_irq(struct tcpci *tcpci);
-
-struct tcpm_port;
-struct tcpm_port *tcpci_get_tcpm_port(struct tcpci *tcpci);
-#endif /* __LINUX_USB_TCPCI_H */
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index df2505570f07..4b6705f3d7b7 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -11,11 +11,10 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
 
-#include "tcpci.h"
-
 #define PD_ACTIVITY_TIMEOUT_MS				10000
 
 #define TCPC_VENDOR_ALERT				0x80
diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
index 8a952eaf9016..1b7c31278ebb 100644
--- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
+++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
@@ -11,10 +11,9 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 
-#include "tcpci.h"
-
 #define MT6360_REG_PHYCTRL1	0x80
 #define MT6360_REG_PHYCTRL3	0x82
 #define MT6360_REG_PHYCTRL7	0x86
diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index b56a0880a044..3291ca4948da 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -10,9 +10,9 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/gpio/consumer.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/regmap.h>
-#include "tcpci.h"
 
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index f7e99757a50e..4f38b2d609f1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2689,6 +2689,13 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			port->sink_cap_done = true;
 			tcpm_set_state(port, ready_state(port), 0);
 			break;
+		/*
+		 * Some port partners do not support GET_STATUS, avoid soft reset the link to
+		 * prevent redundant power re-negotiation
+		 */
+		case GET_STATUS_SEND:
+			tcpm_set_state(port, ready_state(port), 0);
+			break;
 		case SRC_READY:
 		case SNK_READY:
 			if (port->vdm_state > VDM_STATE_READY) {
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c247b1bf57cc..f6536b224586 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -716,6 +716,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
+		++spiltted;
+		tight = false;
 		goto next_part;
 	}
 
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 2e2df6ede583..9722e5237799 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1485,7 +1485,7 @@ struct create_context *smb2_find_context_vals(void *open_req, const char *tag, i
 		    name_len < 4 ||
 		    name_off + name_len > cc_len ||
 		    (value_off & 0x7) != 0 ||
-		    (value_off && (value_off < name_off + name_len)) ||
+		    (value_len && value_off < name_off + (name_len < 8 ? 8 : name_len)) ||
 		    ((u64)value_off + value_len > cc_len))
 			return ERR_PTR(-EINVAL);
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 0fde3d12b346..7983e8c9c89d 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4289,7 +4289,7 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
 			name_len -= XATTR_USER_PREFIX_LEN;
 
-		ptr = (char *)(&eainfo->name + name_len + 1);
+		ptr = eainfo->name + name_len + 1;
 		buf_free_len -= (offsetof(struct smb2_ea_info, name) +
 				name_len + 1);
 		/* bailout if xattr can't fit in buf_free_len */
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index ddc3cea9c905..fa1cd556ab7a 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -1567,7 +1567,7 @@ struct smb2_ea_info {
 	__u8   Flags;
 	__u8   EaNameLength;
 	__le16 EaValueLength;
-	char name[1];
+	char name[];
 	/* optionally followed by value */
 } __packed; /* level 15 Query */
 
diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index adf3bb0a8048..279d945d4ebe 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -205,7 +205,8 @@ static int nilfs_palloc_get_block(struct inode *inode, unsigned long blkoff,
 	int ret;
 
 	spin_lock(lock);
-	if (prev->bh && blkoff == prev->blkoff) {
+	if (prev->bh && blkoff == prev->blkoff &&
+	    likely(buffer_uptodate(prev->bh))) {
 		get_bh(prev->bh);
 		*bhp = prev->bh;
 		spin_unlock(lock);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index b908216f306d..324e23236c34 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1029,7 +1029,7 @@ int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
 	int err;
 
 	spin_lock(&nilfs->ns_inode_lock);
-	if (ii->i_bh == NULL) {
+	if (ii->i_bh == NULL || unlikely(!buffer_uptodate(ii->i_bh))) {
 		spin_unlock(&nilfs->ns_inode_lock);
 		err = nilfs_ifile_get_inode_block(ii->i_root->ifile,
 						  inode->i_ino, pbh);
@@ -1038,7 +1038,10 @@ int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
 		spin_lock(&nilfs->ns_inode_lock);
 		if (ii->i_bh == NULL)
 			ii->i_bh = *pbh;
-		else {
+		else if (unlikely(!buffer_uptodate(ii->i_bh))) {
+			__brelse(ii->i_bh);
+			ii->i_bh = *pbh;
+		} else {
 			brelse(*pbh);
 			*pbh = ii->i_bh;
 		}
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 9e865732d352..d61d702215db 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -725,6 +725,11 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		struct page *page = pvec.pages[i];
 
 		lock_page(page);
+		if (unlikely(page->mapping != mapping)) {
+			/* Exclude pages removed from the address space */
+			unlock_page(page);
+			continue;
+		}
 		if (!page_has_buffers(page))
 			create_empty_buffers(page, i_blocksize(inode), 0);
 		unlock_page(page);
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
new file mode 100644
index 000000000000..f7c01ce879a2
--- /dev/null
+++ b/include/linux/usb/tcpci.h
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2015-2017 Google, Inc
+ *
+ * USB Type-C Port Controller Interface.
+ */
+
+#ifndef __LINUX_USB_TCPCI_H
+#define __LINUX_USB_TCPCI_H
+
+#include <linux/usb/typec.h>
+#include <linux/usb/tcpm.h>
+
+#define TCPC_VENDOR_ID			0x0
+#define TCPC_PRODUCT_ID			0x2
+#define TCPC_BCD_DEV			0x4
+#define TCPC_TC_REV			0x6
+#define TCPC_PD_REV			0x8
+#define TCPC_PD_INT_REV			0xa
+
+#define TCPC_ALERT			0x10
+#define TCPC_ALERT_EXTND		BIT(14)
+#define TCPC_ALERT_EXTENDED_STATUS	BIT(13)
+#define TCPC_ALERT_VBUS_DISCNCT		BIT(11)
+#define TCPC_ALERT_RX_BUF_OVF		BIT(10)
+#define TCPC_ALERT_FAULT		BIT(9)
+#define TCPC_ALERT_V_ALARM_LO		BIT(8)
+#define TCPC_ALERT_V_ALARM_HI		BIT(7)
+#define TCPC_ALERT_TX_SUCCESS		BIT(6)
+#define TCPC_ALERT_TX_DISCARDED		BIT(5)
+#define TCPC_ALERT_TX_FAILED		BIT(4)
+#define TCPC_ALERT_RX_HARD_RST		BIT(3)
+#define TCPC_ALERT_RX_STATUS		BIT(2)
+#define TCPC_ALERT_POWER_STATUS		BIT(1)
+#define TCPC_ALERT_CC_STATUS		BIT(0)
+
+#define TCPC_ALERT_MASK			0x12
+#define TCPC_POWER_STATUS_MASK		0x14
+#define TCPC_FAULT_STATUS_MASK		0x15
+
+#define TCPC_EXTENDED_STATUS_MASK		0x16
+#define TCPC_EXTENDED_STATUS_MASK_VSAFE0V	BIT(0)
+
+#define TCPC_ALERT_EXTENDED_MASK	0x17
+#define TCPC_SINK_FAST_ROLE_SWAP	BIT(0)
+
+#define TCPC_CONFIG_STD_OUTPUT		0x18
+
+#define TCPC_TCPC_CTRL			0x19
+#define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
+#define PLUG_ORNT_CC1			0
+#define PLUG_ORNT_CC2			1
+#define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
+#define TCPC_TCPC_CTRL_EN_LK4CONN_ALRT	BIT(6)
+
+#define TCPC_EXTENDED_STATUS		0x20
+#define TCPC_EXTENDED_STATUS_VSAFE0V	BIT(0)
+
+#define TCPC_ROLE_CTRL			0x1a
+#define TCPC_ROLE_CTRL_DRP		BIT(6)
+#define TCPC_ROLE_CTRL_RP_VAL_SHIFT	4
+#define TCPC_ROLE_CTRL_RP_VAL_MASK	0x3
+#define TCPC_ROLE_CTRL_RP_VAL_DEF	0x0
+#define TCPC_ROLE_CTRL_RP_VAL_1_5	0x1
+#define TCPC_ROLE_CTRL_RP_VAL_3_0	0x2
+#define TCPC_ROLE_CTRL_CC2_SHIFT	2
+#define TCPC_ROLE_CTRL_CC2_MASK		0x3
+#define TCPC_ROLE_CTRL_CC1_SHIFT	0
+#define TCPC_ROLE_CTRL_CC1_MASK		0x3
+#define TCPC_ROLE_CTRL_CC_RA		0x0
+#define TCPC_ROLE_CTRL_CC_RP		0x1
+#define TCPC_ROLE_CTRL_CC_RD		0x2
+#define TCPC_ROLE_CTRL_CC_OPEN		0x3
+
+#define TCPC_FAULT_CTRL			0x1b
+
+#define TCPC_POWER_CTRL			0x1c
+#define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
+#define TCPC_POWER_CTRL_BLEED_DISCHARGE	BIT(3)
+#define TCPC_POWER_CTRL_AUTO_DISCHARGE	BIT(4)
+#define TCPC_DIS_VOLT_ALRM		BIT(5)
+#define TCPC_POWER_CTRL_VBUS_VOLT_MON	BIT(6)
+#define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
+
+#define TCPC_CC_STATUS			0x1d
+#define TCPC_CC_STATUS_TOGGLING		BIT(5)
+#define TCPC_CC_STATUS_TERM		BIT(4)
+#define TCPC_CC_STATUS_TERM_RP		0
+#define TCPC_CC_STATUS_TERM_RD		1
+#define TCPC_CC_STATE_SRC_OPEN		0
+#define TCPC_CC_STATUS_CC2_SHIFT	2
+#define TCPC_CC_STATUS_CC2_MASK		0x3
+#define TCPC_CC_STATUS_CC1_SHIFT	0
+#define TCPC_CC_STATUS_CC1_MASK		0x3
+
+#define TCPC_POWER_STATUS		0x1e
+#define TCPC_POWER_STATUS_DBG_ACC_CON	BIT(7)
+#define TCPC_POWER_STATUS_UNINIT	BIT(6)
+#define TCPC_POWER_STATUS_SOURCING_VBUS	BIT(4)
+#define TCPC_POWER_STATUS_VBUS_DET	BIT(3)
+#define TCPC_POWER_STATUS_VBUS_PRES	BIT(2)
+#define TCPC_POWER_STATUS_VCONN_PRES	BIT(1)
+#define TCPC_POWER_STATUS_SINKING_VBUS	BIT(0)
+
+#define TCPC_FAULT_STATUS		0x1f
+#define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
+
+#define TCPC_ALERT_EXTENDED		0x21
+
+#define TCPC_COMMAND			0x23
+#define TCPC_CMD_WAKE_I2C		0x11
+#define TCPC_CMD_DISABLE_VBUS_DETECT	0x22
+#define TCPC_CMD_ENABLE_VBUS_DETECT	0x33
+#define TCPC_CMD_DISABLE_SINK_VBUS	0x44
+#define TCPC_CMD_SINK_VBUS		0x55
+#define TCPC_CMD_DISABLE_SRC_VBUS	0x66
+#define TCPC_CMD_SRC_VBUS_DEFAULT	0x77
+#define TCPC_CMD_SRC_VBUS_HIGH		0x88
+#define TCPC_CMD_LOOK4CONNECTION	0x99
+#define TCPC_CMD_RXONEMORE		0xAA
+#define TCPC_CMD_I2C_IDLE		0xFF
+
+#define TCPC_DEV_CAP_1			0x24
+#define TCPC_DEV_CAP_2			0x26
+#define TCPC_STD_INPUT_CAP		0x28
+#define TCPC_STD_OUTPUT_CAP		0x29
+
+#define TCPC_MSG_HDR_INFO		0x2e
+#define TCPC_MSG_HDR_INFO_DATA_ROLE	BIT(3)
+#define TCPC_MSG_HDR_INFO_PWR_ROLE	BIT(0)
+#define TCPC_MSG_HDR_INFO_REV_SHIFT	1
+#define TCPC_MSG_HDR_INFO_REV_MASK	0x3
+
+#define TCPC_RX_DETECT			0x2f
+#define TCPC_RX_DETECT_HARD_RESET	BIT(5)
+#define TCPC_RX_DETECT_SOP		BIT(0)
+#define TCPC_RX_DETECT_SOP1		BIT(1)
+#define TCPC_RX_DETECT_SOP2		BIT(2)
+#define TCPC_RX_DETECT_DBG1		BIT(3)
+#define TCPC_RX_DETECT_DBG2		BIT(4)
+
+#define TCPC_RX_BYTE_CNT		0x30
+#define TCPC_RX_BUF_FRAME_TYPE		0x31
+#define TCPC_RX_BUF_FRAME_TYPE_SOP	0
+#define TCPC_RX_HDR			0x32
+#define TCPC_RX_DATA			0x34 /* through 0x4f */
+
+#define TCPC_TRANSMIT			0x50
+#define TCPC_TRANSMIT_RETRY_SHIFT	4
+#define TCPC_TRANSMIT_RETRY_MASK	0x3
+#define TCPC_TRANSMIT_TYPE_SHIFT	0
+#define TCPC_TRANSMIT_TYPE_MASK		0x7
+
+#define TCPC_TX_BYTE_CNT		0x51
+#define TCPC_TX_HDR			0x52
+#define TCPC_TX_DATA			0x54 /* through 0x6f */
+
+#define TCPC_VBUS_VOLTAGE			0x70
+#define TCPC_VBUS_VOLTAGE_MASK			0x3ff
+#define TCPC_VBUS_VOLTAGE_LSB_MV		25
+#define TCPC_VBUS_SINK_DISCONNECT_THRESH	0x72
+#define TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB_MV	25
+#define TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX	0x3ff
+#define TCPC_VBUS_STOP_DISCHARGE_THRESH		0x74
+#define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
+#define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
+
+/* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
+#define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
+
+struct tcpci;
+
+/*
+ * @TX_BUF_BYTE_x_hidden:
+ *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
+ * @frs_sourcing_vbus:
+ *		Optional; Callback to perform chip specific operations when FRS
+ *		is sourcing vbus.
+ * @auto_discharge_disconnect:
+ *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
+ * @vbus_vsafe0v:
+ *		optional; Set when TCPC can detect whether vbus is at VSAFE0V.
+ * @set_partner_usb_comm_capable:
+ *		Optional; The USB Communications Capable bit indicates if port
+ *		partner is capable of communication over the USB data lines
+ *		(e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
+ */
+struct tcpci_data {
+	struct regmap *regmap;
+	unsigned char TX_BUF_BYTE_x_hidden:1;
+	unsigned char auto_discharge_disconnect:1;
+	unsigned char vbus_vsafe0v:1;
+
+	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
+	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
+			 bool enable);
+	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
+				  enum typec_cc_status cc);
+	int (*set_vbus)(struct tcpci *tcpci, struct tcpci_data *data, bool source, bool sink);
+	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
+	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
+					     bool capable);
+};
+
+struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
+void tcpci_unregister_port(struct tcpci *tcpci);
+irqreturn_t tcpci_irq(struct tcpci *tcpci);
+
+struct tcpm_port;
+struct tcpm_port *tcpci_get_tcpm_port(struct tcpci *tcpci);
+#endif /* __LINUX_USB_TCPCI_H */
diff --git a/kernel/module.c b/kernel/module.c
index ed96295cc114..3c90840133c0 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2220,12 +2220,20 @@ void *__symbol_get(const char *symbol)
 	};
 
 	preempt_disable();
-	if (!find_symbol(&fsa) || strong_try_module_get(fsa.owner)) {
-		preempt_enable();
-		return NULL;
+	if (!find_symbol(&fsa))
+		goto fail;
+	if (fsa.license != GPL_ONLY) {
+		pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",
+			symbol);
+		goto fail;
 	}
+	if (strong_try_module_get(fsa.owner))
+		goto fail;
 	preempt_enable();
 	return (void *)kernel_symbol_value(fsa.sym);
+fail:
+	preempt_enable();
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index f10f4e6d3fb8..3d4add94e367 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1093,6 +1093,7 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 	int i, altno, err, stream;
 	struct audioformat *fp = NULL;
 	struct snd_usb_power_domain *pd = NULL;
+	bool set_iface_first;
 	int num, protocol;
 
 	dev = chip->dev;
@@ -1223,11 +1224,19 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 				return err;
 		}
 
+		set_iface_first = false;
+		if (protocol == UAC_VERSION_1 ||
+		    (chip->quirk_flags & QUIRK_FLAG_SET_IFACE_FIRST))
+			set_iface_first = true;
+
 		/* try to set the interface... */
 		usb_set_interface(chip->dev, iface_no, 0);
+		if (set_iface_first)
+			usb_set_interface(chip->dev, iface_no, altno);
 		snd_usb_init_pitch(chip, fp);
 		snd_usb_init_sample_rate(chip, fp, fp->rate_max);
-		usb_set_interface(chip->dev, iface_no, altno);
+		if (!set_iface_first)
+			usb_set_interface(chip->dev, iface_no, altno);
 	}
 	return 0;
 }
