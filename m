Return-Path: <linux-kernel+bounces-19427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C9826CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D81C21F19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD90328DA;
	Mon,  8 Jan 2024 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AaJcB30l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF73609D;
	Mon,  8 Jan 2024 11:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FE6C433C7;
	Mon,  8 Jan 2024 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704713202;
	bh=Kf8190eDH63uiI/1Kty/FrLiU0wYYXxAZnLx+hoFun0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaJcB30leAxpAHOxSK+Dety0apz9EWCuwwbVJJsKPWplSGZNsTjyMcfWjJUNYWv5t
	 bjfxBrHI/rk9lTvnyVJd9OAgXBpEV79wuGCpWne5NE93m+DKAfh5gfu871mM7lJCSE
	 PrjijL2y0aKwAbjm5mX2L7BRbc9kEFs6UuyxWpzQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.266
Date: Mon,  8 Jan 2024 12:26:30 +0100
Message-ID: <2024010830-devious-undertake-d0c0@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024010830-helping-boasting-1c28@gregkh>
References: <2024010830-helping-boasting-1c28@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index b89f99423351..500edb9d9f15 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 265
+SUBLEVEL = 266
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 188ea5258c99..8c9160779689 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -797,10 +797,15 @@ void __init omap_soc_device_init(void)
 
 	soc_dev_attr->machine  = soc_name;
 	soc_dev_attr->family   = omap_get_family();
+	if (!soc_dev_attr->family) {
+		kfree(soc_dev_attr);
+		return;
+	}
 	soc_dev_attr->revision = soc_rev;
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
 		kfree(soc_dev_attr);
 		return;
 	}
diff --git a/arch/s390/include/asm/fpu/api.h b/arch/s390/include/asm/fpu/api.h
index 34a7ae68485c..be16a6c0f127 100644
--- a/arch/s390/include/asm/fpu/api.h
+++ b/arch/s390/include/asm/fpu/api.h
@@ -76,7 +76,7 @@ static inline int test_fp_ctl(u32 fpc)
 #define KERNEL_VXR_HIGH		(KERNEL_VXR_V16V23|KERNEL_VXR_V24V31)
 
 #define KERNEL_VXR		(KERNEL_VXR_LOW|KERNEL_VXR_HIGH)
-#define KERNEL_FPR		(KERNEL_FPC|KERNEL_VXR_V0V7)
+#define KERNEL_FPR		(KERNEL_FPC|KERNEL_VXR_LOW)
 
 struct kernel_fpu;
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9d3a971ea364..15bad8d59894 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -772,8 +772,8 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 	} else {
 		local_irq_save(flags);
 		memcpy(addr, opcode, len);
-		local_irq_restore(flags);
 		sync_core();
+		local_irq_restore(flags);
 
 		/*
 		 * Could also do a CLFLUSH here to speed up CPU recovery; but
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index ff08bcb09a68..3f0b072a4cc8 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -250,18 +250,46 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	if (!slave)
 		return 0;
 
-	command = readl(bus->base + ASPEED_I2C_CMD_REG);
+	/*
+	 * Handle stop conditions early, prior to SLAVE_MATCH. Some masters may drive
+	 * transfers with low enough latency between the nak/stop phase of the current
+	 * command and the start/address phase of the following command that the
+	 * interrupts are coalesced by the time we process them.
+	 */
+	if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
+		irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
+		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
+	}
+
+	if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
+	    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
+		irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
+		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
+	}
+
+	/* Propagate any stop conditions to the slave implementation. */
+	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP) {
+		i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
+		bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
+	}
 
-	/* Slave was requested, restart state machine. */
+	/*
+	 * Now that we've dealt with any potentially coalesced stop conditions,
+	 * address any start conditions.
+	 */
 	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
 		irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
 		bus->slave_state = ASPEED_I2C_SLAVE_START;
 	}
 
-	/* Slave is not currently active, irq was for someone else. */
+	/*
+	 * If the slave has been stopped and not started then slave interrupt
+	 * handling is complete.
+	 */
 	if (bus->slave_state == ASPEED_I2C_SLAVE_INACTIVE)
 		return irq_handled;
 
+	command = readl(bus->base + ASPEED_I2C_CMD_REG);
 	dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
 		irq_status, command);
 
@@ -280,17 +308,6 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		irq_handled |= ASPEED_I2CD_INTR_RX_DONE;
 	}
 
-	/* Slave was asked to stop. */
-	if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
-		irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
-		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
-	}
-	if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
-	    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
-		irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
-		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
-	}
-
 	switch (bus->slave_state) {
 	case ASPEED_I2C_SLAVE_READ_REQUESTED:
 		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_ACK))
@@ -319,8 +336,7 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		i2c_slave_event(slave, I2C_SLAVE_WRITE_RECEIVED, &value);
 		break;
 	case ASPEED_I2C_SLAVE_STOP:
-		i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
-		bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
+		/* Stop event handling is done early. Unreachable. */
 		break;
 	case ASPEED_I2C_SLAVE_START:
 		/* Slave was just started. Waiting for the next event. */;
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 9d984f2a8ba7..38d8a01d9f95 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -656,8 +656,10 @@ static int tiadc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, indio_dev);
 
 	err = tiadc_request_dma(pdev, adc_dev);
-	if (err && err == -EPROBE_DEFER)
+	if (err && err != -ENODEV) {
+		dev_err_probe(&pdev->dev, err, "DMA request failed\n");
 		goto err_dma;
+	}
 
 	return 0;
 
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index b52cba1b3c83..3f01ebeda242 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -15,8 +15,8 @@
 /* Conversion times in us */
 static const u16 ms_sensors_ht_t_conversion_time[] = { 50000, 25000,
 						       13000, 7000 };
-static const u16 ms_sensors_ht_h_conversion_time[] = { 16000, 3000,
-						       5000, 8000 };
+static const u16 ms_sensors_ht_h_conversion_time[] = { 16000, 5000,
+						       3000, 8000 };
 static const u16 ms_sensors_tp_conversion_time[] = { 500, 1100, 2100,
 						     4100, 8220, 16440 };
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 2261c6c4ac65..87de2a05c711 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -501,13 +501,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
+			return ret;
 		case IIO_ACCEL:
 			mutex_lock(&st->lock);
 			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
+			return ret;
 
 		default:
 			return -EINVAL;
diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
index e3f9e445e880..fe5a9c54ad58 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -105,6 +105,9 @@ static int micro_key_probe(struct platform_device *pdev)
 	keys->codes = devm_kmemdup(&pdev->dev, micro_keycodes,
 			   keys->input->keycodesize * keys->input->keycodemax,
 			   GFP_KERNEL);
+	if (!keys->codes)
+		return -ENOMEM;
+
 	keys->input->keycode = keys->codes;
 
 	__set_bit(EV_KEY, keys->input->evbit);
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index be3fa1ac4261..8f6dfa6b6e4d 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -280,6 +280,9 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 	}
 	mutex_unlock(&icc_lock);
 
+	if (!node)
+		return ERR_PTR(-EINVAL);
+
 	return node;
 }
 
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 6bdd79a05719..171f4ffcd869 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -868,10 +868,13 @@ static int atl1e_setup_ring_resources(struct atl1e_adapter *adapter)
 		netdev_err(adapter->netdev, "offset(%d) > ring size(%d) !!\n",
 			   offset, adapter->ring_size);
 		err = -1;
-		goto failed;
+		goto free_buffer;
 	}
 
 	return 0;
+free_buffer:
+	kfree(tx_ring->tx_buffer);
+	tx_ring->tx_buffer = NULL;
 failed:
 	if (adapter->ring_vir_addr != NULL) {
 		pci_free_consistent(pdev, adapter->ring_size,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 58d48d76c1b8..53775f3cdaf4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -687,8 +687,8 @@ static void mlx5_fw_tracer_handle_traces(struct work_struct *work)
 		get_block_timestamp(tracer, &tmp_trace_block[TRACES_PER_BLOCK - 1]);
 
 	while (block_timestamp > tracer->last_timestamp) {
-		/* Check block override if its not the first block */
-		if (!tracer->last_timestamp) {
+		/* Check block override if it's not the first block */
+		if (tracer->last_timestamp) {
 			u64 *ts_event;
 			/* To avoid block override be the HW in case of buffer
 			 * wraparound, the time stamp of the previous block
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 5a4bee5253ec..362f01bc8372 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -290,6 +290,9 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
+	e->encap_size = ipv4_encap_size;
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -306,8 +309,6 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
-	e->encap_size = ipv4_encap_size;
-	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(out_dev));
 	neigh_release(n);
@@ -407,6 +408,9 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
+	e->encap_size = ipv6_encap_size;
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -424,8 +428,6 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
-	e->encap_size = ipv6_encap_size;
-	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(out_dev));
 	neigh_release(n);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index ed37cc7c9ae0..a40fecfdb10c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -78,7 +78,7 @@ static void mlx5e_rep_get_drvinfo(struct net_device *dev,
 	count = snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
-	if (count == sizeof(drvinfo->fw_version))
+	if (count >= sizeof(drvinfo->fw_version))
 		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev));
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 9c225256e3f4..409506c1de14 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -928,6 +928,13 @@ static const struct of_device_id atmel_pctrl_of_match[] = {
 	}
 };
 
+/*
+ * This lock class allows to tell lockdep that parent IRQ and children IRQ do
+ * not share the same class so it does not raise false positive
+ */
+static struct lock_class_key atmel_lock_key;
+static struct lock_class_key atmel_request_key;
+
 static int atmel_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1078,6 +1085,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		irq_set_chip_and_handler(irq, &atmel_gpio_irq_chip,
 					 handle_simple_irq);
 		irq_set_chip_data(irq, atmel_pioctrl);
+		irq_set_lockdep_class(irq, &atmel_lock_key, &atmel_request_key);
 		dev_dbg(dev,
 			"atmel gpio irq domain: hwirq: %d, linux irq: %d\n",
 			i, irq);
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 688b4f6227fc..57219aa22ee8 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -597,6 +597,9 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 {
 	lockdep_assert_held(&reset_list_mutex);
 
+	if (IS_ERR_OR_NULL(rstc))
+		return;
+
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 9ed109fb6b67..3bef2ed50a07 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -430,7 +430,6 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct fcoe_ctlr *ctlr;
 	struct fcoe_rcv_info *fr;
 	struct fcoe_percpu_s *bg;
-	struct sk_buff *tmp_skb;
 
 	interface = container_of(ptype, struct bnx2fc_interface,
 				 fcoe_packet_type);
@@ -442,11 +441,9 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto err;
 	}
 
-	tmp_skb = skb_share_check(skb, GFP_ATOMIC);
-	if (!tmp_skb)
-		goto err;
-
-	skb = tmp_skb;
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return -1;
 
 	if (unlikely(eth_hdr(skb)->h_proto != htons(ETH_P_FCOE))) {
 		printk(KERN_ERR PFX "bnx2fc_rcv: Wrong FC type frame\n");
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index f457e083a6f8..c0f727e79307 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -428,8 +428,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 			temp = size;
 		size -= temp;
 		next += temp;
-		if (temp == size)
-			goto done;
 	}
 
 	temp = snprintf(next, size, "\n");
@@ -439,7 +437,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 	size -= temp;
 	next += temp;
 
-done:
 	*sizep = size;
 	*nextp = next;
 }
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 904105100074..c97923858fce 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1011,9 +1011,9 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, ACTISENSE_USG_PID) },
 	{ USB_DEVICE(FTDI_VID, ACTISENSE_NGT_PID) },
 	{ USB_DEVICE(FTDI_VID, ACTISENSE_NGW_PID) },
-	{ USB_DEVICE(FTDI_VID, ACTISENSE_D9AC_PID) },
-	{ USB_DEVICE(FTDI_VID, ACTISENSE_D9AD_PID) },
-	{ USB_DEVICE(FTDI_VID, ACTISENSE_D9AE_PID) },
+	{ USB_DEVICE(FTDI_VID, ACTISENSE_UID_PID) },
+	{ USB_DEVICE(FTDI_VID, ACTISENSE_USA_PID) },
+	{ USB_DEVICE(FTDI_VID, ACTISENSE_NGX_PID) },
 	{ USB_DEVICE(FTDI_VID, ACTISENSE_D9AF_PID) },
 	{ USB_DEVICE(FTDI_VID, CHETCO_SEAGAUGE_PID) },
 	{ USB_DEVICE(FTDI_VID, CHETCO_SEASWITCH_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 31c8ccabbbb7..9a0f9fc99124 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1561,9 +1561,9 @@
 #define ACTISENSE_USG_PID		0xD9A9 /* USG USB Serial Adapter */
 #define ACTISENSE_NGT_PID		0xD9AA /* NGT NMEA2000 Interface */
 #define ACTISENSE_NGW_PID		0xD9AB /* NGW NMEA2000 Gateway */
-#define ACTISENSE_D9AC_PID		0xD9AC /* Actisense Reserved */
-#define ACTISENSE_D9AD_PID		0xD9AD /* Actisense Reserved */
-#define ACTISENSE_D9AE_PID		0xD9AE /* Actisense Reserved */
+#define ACTISENSE_UID_PID		0xD9AC /* USB Isolating Device */
+#define ACTISENSE_USA_PID		0xD9AD /* USB to Serial Adapter */
+#define ACTISENSE_NGX_PID		0xD9AE /* NGX NMEA2000 Gateway */
 #define ACTISENSE_D9AF_PID		0xD9AF /* Actisense Reserved */
 #define CHETCO_SEAGAUGE_PID		0xA548 /* SeaGauge USB Adapter */
 #define CHETCO_SEASWITCH_PID		0xA549 /* SeaSwitch USB Adapter */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index c2ce9a62dd99..c632e143a813 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -272,6 +272,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_RM520N			0x0801
 #define QUECTEL_PRODUCT_EC200U			0x0901
+#define QUECTEL_PRODUCT_EG912Y			0x6001
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
 #define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
@@ -1232,6 +1233,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, 0x0700, 0xff), /* BG95 */
 	  .driver_info = RSVD(3) | ZLP },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x10),
 	  .driver_info = ZLP },
@@ -1244,6 +1246,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG912Y, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
@@ -2242,6 +2245,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
 	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0da, 0xff),                     /* Foxconn T99W265 MBIM variant */
+	  .driver_info = RSVD(3) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0db, 0xff),			/* Foxconn T99W265 MBIM */
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0ee, 0xff),			/* Foxconn T99W368 MBIM */
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 296b489861a9..1522fadd8d2d 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -404,10 +404,12 @@ static int afs_update_cell(struct afs_cell *cell)
 		if (ret == -ENOMEM)
 			goto out_wake;
 
-		ret = -ENOMEM;
 		vllist = afs_alloc_vlserver_list(0);
-		if (!vllist)
+		if (!vllist) {
+			if (ret >= 0)
+				ret = -ENOMEM;
 			goto out_wake;
+		}
 
 		switch (ret) {
 		case -ENODATA:
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 45007d96a402..d06994990fc3 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -20,6 +20,7 @@ static int afs_probe_cell_name(struct dentry *dentry)
 	struct afs_net *net = afs_d2net(dentry);
 	const char *name = dentry->d_name.name;
 	size_t len = dentry->d_name.len;
+	char *result = NULL;
 	int ret;
 
 	/* Names prefixed with a dot are R/W mounts. */
@@ -37,9 +38,22 @@ static int afs_probe_cell_name(struct dentry *dentry)
 	}
 
 	ret = dns_query(net->net, "afsdb", name, len, "srv=1",
-			NULL, NULL, false);
-	if (ret == -ENODATA || ret == -ENOKEY)
+			&result, NULL, false);
+	if (ret == -ENODATA || ret == -ENOKEY || ret == 0)
 		ret = -ENOENT;
+	if (ret > 0 && ret >= sizeof(struct dns_server_list_v1_header)) {
+		struct dns_server_list_v1_header *v1 = (void *)result;
+
+		if (v1->hdr.zero == 0 &&
+		    v1->hdr.content == DNS_PAYLOAD_IS_SERVER_LIST &&
+		    v1->hdr.version == 1 &&
+		    (v1->status != DNS_LOOKUP_GOOD &&
+		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD))
+			return -ENOENT;
+
+	}
+
+	kfree(result);
 	return ret;
 }
 
@@ -163,20 +177,9 @@ static int afs_dynroot_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return 1;
 }
 
-/*
- * Allow the VFS to enquire as to whether a dentry should be unhashed (mustn't
- * sleep)
- * - called from dput() when d_count is going to 0.
- * - return 1 to request dentry be unhashed, 0 otherwise
- */
-static int afs_dynroot_d_delete(const struct dentry *dentry)
-{
-	return d_really_is_positive(dentry);
-}
-
 const struct dentry_operations afs_dynroot_dentry_operations = {
 	.d_revalidate	= afs_dynroot_d_revalidate,
-	.d_delete	= afs_dynroot_d_delete,
+	.d_delete	= always_delete_dentry,
 	.d_release	= afs_d_release,
 	.d_automount	= afs_d_automount,
 };
diff --git a/fs/block_dev.c b/fs/block_dev.c
index fa329c7eddf0..e528ad860143 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2114,21 +2114,26 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	/* Invalidate the page cache, including dirty pages. */
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
 	mapping = bdev->bd_inode->i_mapping;
-	truncate_inode_pages_range(mapping, start, end);
 
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
+		truncate_inode_pages_range(mapping, start, end);
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		truncate_inode_pages_range(mapping, start, end);
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		truncate_inode_pages_range(mapping, start, end);
 		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, 0);
 		break;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1575992d1f14..9f1efd5c24f1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1847,6 +1847,15 @@ static noinline int btrfs_ioctl_snap_create_transid(struct file *file,
 			 * are limited to own subvolumes only
 			 */
 			ret = -EPERM;
+		} else if (btrfs_ino(BTRFS_I(src_inode)) != BTRFS_FIRST_FREE_OBJECTID) {
+			/*
+			 * Snapshots must be made with the src_inode referring
+			 * to the subvolume inode, otherwise the permission
+			 * checking above is useless because we may have
+			 * permission on a lower directory but not the subvol
+			 * itself.
+			 */
+			ret = -EINVAL;
 		} else {
 			ret = btrfs_mksubvol(&file->f_path, name, namelen,
 					     BTRFS_I(src_inode)->root,
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index f41891379de9..db1fcdedf289 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -349,6 +349,10 @@ checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server)
 			cifs_dbg(VFS, "Length less than smb header size\n");
 		}
 		return -EIO;
+	} else if (total_read < sizeof(*smb) + 2 * smb->WordCount) {
+		cifs_dbg(VFS, "%s: can't read BCC due to invalid WordCount(%u)\n",
+			 __func__, smb->WordCount);
+		return -EIO;
 	}
 
 	/* otherwise, there is enough to get to the BCC */
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 7177720e822e..d3d5d2c6c401 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -302,6 +302,9 @@ static const bool has_smb2_data_area[NUMBER_OF_SMB2_COMMANDS] = {
 char *
 smb2_get_data_area_len(int *off, int *len, struct smb2_sync_hdr *shdr)
 {
+	const int max_off = 4096;
+	const int max_len = 128 * 1024;
+
 	*off = 0;
 	*len = 0;
 
@@ -369,29 +372,20 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_sync_hdr *shdr)
 	 * Invalid length or offset probably means data area is invalid, but
 	 * we have little choice but to ignore the data area in this case.
 	 */
-	if (*off > 4096) {
-		cifs_dbg(VFS, "offset %d too large, data area ignored\n", *off);
-		*len = 0;
-		*off = 0;
-	} else if (*off < 0) {
-		cifs_dbg(VFS, "negative offset %d to data invalid ignore data area\n",
-			 *off);
+	if (unlikely(*off < 0 || *off > max_off ||
+		     *len < 0 || *len > max_len)) {
+		cifs_dbg(VFS, "%s: invalid data area (off=%d len=%d)\n",
+			 __func__, *off, *len);
 		*off = 0;
 		*len = 0;
-	} else if (*len < 0) {
-		cifs_dbg(VFS, "negative data length %d invalid, data area ignored\n",
-			 *len);
-		*len = 0;
-	} else if (*len > 128 * 1024) {
-		cifs_dbg(VFS, "data area larger than 128K: %d\n", *len);
+	} else if (*off == 0) {
 		*len = 0;
 	}
 
 	/* return pointer to beginning of data area, ie offset from SMB start */
-	if ((*off != 0) && (*len != 0))
+	if (*off > 0 && *len > 0)
 		return (char *)shdr + *off;
-	else
-		return NULL;
+	return NULL;
 }
 
 /*
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 739556e385be..297f5e455a34 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -651,7 +651,7 @@ struct smb2_tree_disconnect_rsp {
 #define SMB2_CREATE_SD_BUFFER			"SecD" /* security descriptor */
 #define SMB2_CREATE_DURABLE_HANDLE_REQUEST	"DHnQ"
 #define SMB2_CREATE_DURABLE_HANDLE_RECONNECT	"DHnC"
-#define SMB2_CREATE_ALLOCATION_SIZE		"AISi"
+#define SMB2_CREATE_ALLOCATION_SIZE		"AlSi"
 #define SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST "MxAc"
 #define SMB2_CREATE_TIMEWARP_REQUEST		"TWrp"
 #define SMB2_CREATE_QUERY_ON_DISK_ID		"QFid"
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f42a7c777d26..4a03eac43aaf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -579,9 +579,14 @@ static __always_inline bool full_hit(struct ring_buffer *buffer, int cpu, int fu
 	if (!nr_pages || !full)
 		return true;
 
-	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
+	/*
+	 * Add one as dirty will never equal nr_pages, as the sub-buffer
+	 * that the writer is on is not counted as dirty.
+	 * This is needed if "buffer_percent" is set to 100.
+	 */
+	dirty = ring_buffer_nr_dirty_pages(buffer, cpu) + 1;
 
-	return (dirty * 100) > (full * nr_pages);
+	return (dirty * 100) >= (full * nr_pages);
 }
 
 /*
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index a313165e7a67..4d2d501991b1 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -407,6 +407,8 @@ int vlan_vids_add_by_dev(struct net_device *dev,
 		return 0;
 
 	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
+		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
+			continue;
 		err = vlan_vid_add(dev, vid_info->proto, vid_info->vid);
 		if (err)
 			goto unwind;
@@ -417,6 +419,8 @@ int vlan_vids_add_by_dev(struct net_device *dev,
 	list_for_each_entry_continue_reverse(vid_info,
 					     &vlan_info->vid_list,
 					     list) {
+		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
+			continue;
 		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
 	}
 
@@ -436,8 +440,11 @@ void vlan_vids_del_by_dev(struct net_device *dev,
 	if (!vlan_info)
 		return;
 
-	list_for_each_entry(vid_info, &vlan_info->vid_list, list)
+	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
+		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
+			continue;
 		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
+	}
 }
 EXPORT_SYMBOL(vlan_vids_del_by_dev);
 
diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 03593eb240d8..ef0a82dbbe04 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -228,6 +228,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 				uint16_t *nwname = va_arg(ap, uint16_t *);
 				char ***wnames = va_arg(ap, char ***);
 
+				*wnames = NULL;
+
 				errcode = p9pdu_readf(pdu, proto_version,
 								"w", nwname);
 				if (!errcode) {
@@ -237,6 +239,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 							  GFP_NOFS);
 					if (!*wnames)
 						errcode = -ENOMEM;
+					else
+						(*wnames)[0] = NULL;
 				}
 
 				if (!errcode) {
@@ -248,8 +252,10 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 								proto_version,
 								"s",
 								&(*wnames)[i]);
-						if (errcode)
+						if (errcode) {
+							(*wnames)[i] = NULL;
 							break;
+						}
 					}
 				}
 
@@ -257,11 +263,14 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 					if (*wnames) {
 						int i;
 
-						for (i = 0; i < *nwname; i++)
+						for (i = 0; i < *nwname; i++) {
+							if (!(*wnames)[i])
+								break;
 							kfree((*wnames)[i]);
+						}
+						kfree(*wnames);
+						*wnames = NULL;
 					}
-					kfree(*wnames);
-					*wnames = NULL;
 				}
 			}
 			break;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f182a7d3e44c..74695df78122 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1785,7 +1785,8 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		return;
 	}
 
-	set_bit(HCI_INQUIRY, &hdev->flags);
+	if (hci_sent_cmd_data(hdev, HCI_OP_INQUIRY))
+		set_bit(HCI_INQUIRY, &hdev->flags);
 }
 
 static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
diff --git a/net/core/dev.c b/net/core/dev.c
index a381e87fb380..5e043e6f0947 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3140,6 +3140,14 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	if (gso_segs > dev->gso_max_segs)
 		return features & ~NETIF_F_GSO_MASK;
 
+	if (unlikely(skb->len >= READ_ONCE(dev->gso_max_size)))
+		return features & ~NETIF_F_GSO_MASK;
+
+	if (!skb_shinfo(skb)->gso_type) {
+		skb_warn_bad_offload(skb);
+		return features & ~NETIF_F_GSO_MASK;
+	}
+
 	/* Support for GSO partial features requires software
 	 * intervention before we can actually process the packets
 	 * so we need to strip support for any partial features now
diff --git a/net/ife/ife.c b/net/ife/ife.c
index 13bbf8cb6a39..be05b690b9ef 100644
--- a/net/ife/ife.c
+++ b/net/ife/ife.c
@@ -82,6 +82,7 @@ void *ife_decode(struct sk_buff *skb, u16 *metalen)
 	if (unlikely(!pskb_may_pull(skb, total_pull)))
 		return NULL;
 
+	ifehdr = (struct ifeheadr *)(skb->data + skb->dev->hard_header_len);
 	skb_set_mac_header(skb, total_pull);
 	__skb_pull(skb, total_pull);
 	*metalen = ifehdrln - IFE_METAHDRLEN;
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 737c5f4dbf52..def34c843f29 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1044,8 +1044,8 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
 	case WLAN_SP_MESH_PEERING_OPEN:
 		if (!matches_local)
 			event = OPN_RJCT;
-		if (!mesh_plink_free_count(sdata) ||
-		    (sta->mesh->plid && sta->mesh->plid != plid))
+		else if (!mesh_plink_free_count(sdata) ||
+			 (sta->mesh->plid && sta->mesh->plid != plid))
 			event = OPN_IGNR;
 		else
 			event = OPN_ACPT;
@@ -1053,9 +1053,9 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
 	case WLAN_SP_MESH_PEERING_CONFIRM:
 		if (!matches_local)
 			event = CNF_RJCT;
-		if (!mesh_plink_free_count(sdata) ||
-		    sta->mesh->llid != llid ||
-		    (sta->mesh->plid && sta->mesh->plid != plid))
+		else if (!mesh_plink_free_count(sdata) ||
+			 sta->mesh->llid != llid ||
+			 (sta->mesh->plid && sta->mesh->plid != plid))
 			event = CNF_IGNR;
 		else
 			event = CNF_ACPT;
diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 2cc95c8dc4c7..f74baefd855d 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -116,6 +116,14 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = gpiod_direction_output(rfkill->reset_gpio, true);
+	if (ret)
+		return ret;
+
+	ret = gpiod_direction_output(rfkill->shutdown_gpio, true);
+	if (ret)
+		return ret;
+
 	rfkill->rfkill_dev = rfkill_alloc(rfkill->name, &pdev->dev,
 					  rfkill->type, &rfkill_gpio_ops,
 					  rfkill);
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index fc9ef08788f7..9b36fb6aa3e1 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -159,21 +159,47 @@ void rose_kill_by_neigh(struct rose_neigh *neigh)
  */
 static void rose_kill_by_device(struct net_device *dev)
 {
-	struct sock *s;
+	struct sock *sk, *array[16];
+	struct rose_sock *rose;
+	bool rescan;
+	int i, cnt;
 
+start:
+	rescan = false;
+	cnt = 0;
 	spin_lock_bh(&rose_list_lock);
-	sk_for_each(s, &rose_list) {
-		struct rose_sock *rose = rose_sk(s);
+	sk_for_each(sk, &rose_list) {
+		rose = rose_sk(sk);
+		if (rose->device == dev) {
+			if (cnt == ARRAY_SIZE(array)) {
+				rescan = true;
+				break;
+			}
+			sock_hold(sk);
+			array[cnt++] = sk;
+		}
+	}
+	spin_unlock_bh(&rose_list_lock);
 
+	for (i = 0; i < cnt; i++) {
+		sk = array[cnt];
+		rose = rose_sk(sk);
+		lock_sock(sk);
+		spin_lock_bh(&rose_list_lock);
 		if (rose->device == dev) {
-			rose_disconnect(s, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
+			rose_disconnect(sk, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
 			if (rose->neighbour)
 				rose->neighbour->use--;
 			dev_put(rose->device);
 			rose->device = NULL;
 		}
+		spin_unlock_bh(&rose_list_lock);
+		release_sock(sk);
+		sock_put(sk);
+		cond_resched();
 	}
-	spin_unlock_bh(&rose_list_lock);
+	if (rescan)
+		goto start;
 }
 
 /*
@@ -633,7 +659,10 @@ static int rose_release(struct socket *sock)
 		break;
 	}
 
+	spin_lock_bh(&rose_list_lock);
 	dev_put(rose->device);
+	rose->device = NULL;
+	spin_unlock_bh(&rose_list_lock);
 	sock->sk = NULL;
 	release_sock(sk);
 	sock_put(sk);
diff --git a/net/wireless/certs/wens.hex b/net/wireless/certs/wens.hex
new file mode 100644
index 000000000000..0d50369bede9
--- /dev/null
+++ b/net/wireless/certs/wens.hex
@@ -0,0 +1,87 @@
+/* Chen-Yu Tsai's regdb certificate */
+0x30, 0x82, 0x02, 0xa7, 0x30, 0x82, 0x01, 0x8f,
+0x02, 0x14, 0x61, 0xc0, 0x38, 0x65, 0x1a, 0xab,
+0xdc, 0xf9, 0x4b, 0xd0, 0xac, 0x7f, 0xf0, 0x6c,
+0x72, 0x48, 0xdb, 0x18, 0xc6, 0x00, 0x30, 0x0d,
+0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d,
+0x01, 0x01, 0x0b, 0x05, 0x00, 0x30, 0x0f, 0x31,
+0x0d, 0x30, 0x0b, 0x06, 0x03, 0x55, 0x04, 0x03,
+0x0c, 0x04, 0x77, 0x65, 0x6e, 0x73, 0x30, 0x20,
+0x17, 0x0d, 0x32, 0x33, 0x31, 0x32, 0x30, 0x31,
+0x30, 0x37, 0x34, 0x31, 0x31, 0x34, 0x5a, 0x18,
+0x0f, 0x32, 0x31, 0x32, 0x33, 0x31, 0x31, 0x30,
+0x37, 0x30, 0x37, 0x34, 0x31, 0x31, 0x34, 0x5a,
+0x30, 0x0f, 0x31, 0x0d, 0x30, 0x0b, 0x06, 0x03,
+0x55, 0x04, 0x03, 0x0c, 0x04, 0x77, 0x65, 0x6e,
+0x73, 0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06,
+0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01,
+0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f,
+0x00, 0x30, 0x82, 0x01, 0x0a, 0x02, 0x82, 0x01,
+0x01, 0x00, 0xa9, 0x7a, 0x2c, 0x78, 0x4d, 0xa7,
+0x19, 0x2d, 0x32, 0x52, 0xa0, 0x2e, 0x6c, 0xef,
+0x88, 0x7f, 0x15, 0xc5, 0xb6, 0x69, 0x54, 0x16,
+0x43, 0x14, 0x79, 0x53, 0xb7, 0xae, 0x88, 0xfe,
+0xc0, 0xb7, 0x5d, 0x47, 0x8e, 0x1a, 0xe1, 0xef,
+0xb3, 0x90, 0x86, 0xda, 0xd3, 0x64, 0x81, 0x1f,
+0xce, 0x5d, 0x9e, 0x4b, 0x6e, 0x58, 0x02, 0x3e,
+0xb2, 0x6f, 0x5e, 0x42, 0x47, 0x41, 0xf4, 0x2c,
+0xb8, 0xa8, 0xd4, 0xaa, 0xc0, 0x0e, 0xe6, 0x48,
+0xf0, 0xa8, 0xce, 0xcb, 0x08, 0xae, 0x37, 0xaf,
+0xf6, 0x40, 0x39, 0xcb, 0x55, 0x6f, 0x5b, 0x4f,
+0x85, 0x34, 0xe6, 0x69, 0x10, 0x50, 0x72, 0x5e,
+0x4e, 0x9d, 0x4c, 0xba, 0x38, 0x36, 0x0d, 0xce,
+0x73, 0x38, 0xd7, 0x27, 0x02, 0x2a, 0x79, 0x03,
+0xe1, 0xac, 0xcf, 0xb0, 0x27, 0x85, 0x86, 0x93,
+0x17, 0xab, 0xec, 0x42, 0x77, 0x37, 0x65, 0x8a,
+0x44, 0xcb, 0xd6, 0x42, 0x93, 0x92, 0x13, 0xe3,
+0x39, 0x45, 0xc5, 0x6e, 0x00, 0x4a, 0x7f, 0xcb,
+0x42, 0x17, 0x2b, 0x25, 0x8c, 0xb8, 0x17, 0x3b,
+0x15, 0x36, 0x59, 0xde, 0x42, 0xce, 0x21, 0xe6,
+0xb6, 0xc7, 0x6e, 0x5e, 0x26, 0x1f, 0xf7, 0x8a,
+0x57, 0x9e, 0xa5, 0x96, 0x72, 0xb7, 0x02, 0x32,
+0xeb, 0x07, 0x2b, 0x73, 0xe2, 0x4f, 0x66, 0x58,
+0x9a, 0xeb, 0x0f, 0x07, 0xb6, 0xab, 0x50, 0x8b,
+0xc3, 0x8f, 0x17, 0xfa, 0x0a, 0x99, 0xc2, 0x16,
+0x25, 0xbf, 0x2d, 0x6b, 0x1a, 0xaa, 0xe6, 0x3e,
+0x5f, 0xeb, 0x6d, 0x9b, 0x5d, 0x4d, 0x42, 0x83,
+0x2d, 0x39, 0xb8, 0xc9, 0xac, 0xdb, 0x3a, 0x91,
+0x50, 0xdf, 0xbb, 0xb1, 0x76, 0x6d, 0x15, 0x73,
+0xfd, 0xc6, 0xe6, 0x6b, 0x71, 0x9e, 0x67, 0x36,
+0x22, 0x83, 0x79, 0xb1, 0xd6, 0xb8, 0x84, 0x52,
+0xaf, 0x96, 0x5b, 0xc3, 0x63, 0x02, 0x4e, 0x78,
+0x70, 0x57, 0x02, 0x03, 0x01, 0x00, 0x01, 0x30,
+0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7,
+0x0d, 0x01, 0x01, 0x0b, 0x05, 0x00, 0x03, 0x82,
+0x01, 0x01, 0x00, 0x24, 0x28, 0xee, 0x22, 0x74,
+0x7f, 0x7c, 0xfa, 0x6c, 0x1f, 0xb3, 0x18, 0xd1,
+0xc2, 0x3d, 0x7d, 0x29, 0x42, 0x88, 0xad, 0x82,
+0xa5, 0xb1, 0x8a, 0x05, 0xd0, 0xec, 0x5c, 0x91,
+0x20, 0xf6, 0x82, 0xfd, 0xd5, 0x67, 0x60, 0x5f,
+0x31, 0xf5, 0xbd, 0x88, 0x91, 0x70, 0xbd, 0xb8,
+0xb9, 0x8c, 0x88, 0xfe, 0x53, 0xc9, 0x54, 0x9b,
+0x43, 0xc4, 0x7a, 0x43, 0x74, 0x6b, 0xdd, 0xb0,
+0xb1, 0x3b, 0x33, 0x45, 0x46, 0x78, 0xa3, 0x1c,
+0xef, 0x54, 0x68, 0xf7, 0x85, 0x9c, 0xe4, 0x51,
+0x6f, 0x06, 0xaf, 0x81, 0xdb, 0x2a, 0x7b, 0x7b,
+0x6f, 0xa8, 0x9c, 0x67, 0xd8, 0xcb, 0xc9, 0x91,
+0x40, 0x00, 0xae, 0xd9, 0xa1, 0x9f, 0xdd, 0xa6,
+0x43, 0x0e, 0x28, 0x7b, 0xaa, 0x1b, 0xe9, 0x84,
+0xdb, 0x76, 0x64, 0x42, 0x70, 0xc9, 0xc0, 0xeb,
+0xae, 0x84, 0x11, 0x16, 0x68, 0x4e, 0x84, 0x9e,
+0x7e, 0x92, 0x36, 0xee, 0x1c, 0x3b, 0x08, 0x63,
+0xeb, 0x79, 0x84, 0x15, 0x08, 0x9d, 0xaf, 0xc8,
+0x9a, 0xc7, 0x34, 0xd3, 0x94, 0x4b, 0xd1, 0x28,
+0x97, 0xbe, 0xd1, 0x45, 0x75, 0xdc, 0x35, 0x62,
+0xac, 0x1d, 0x1f, 0xb7, 0xb7, 0x15, 0x87, 0xc8,
+0x98, 0xc0, 0x24, 0x31, 0x56, 0x8d, 0xed, 0xdb,
+0x06, 0xc6, 0x46, 0xbf, 0x4b, 0x6d, 0xa6, 0xd5,
+0xab, 0xcc, 0x60, 0xfc, 0xe5, 0x37, 0xb6, 0x53,
+0x7d, 0x58, 0x95, 0xa9, 0x56, 0xc7, 0xf7, 0xee,
+0xc3, 0xa0, 0x76, 0xf7, 0x65, 0x4d, 0x53, 0xfa,
+0xff, 0x5f, 0x76, 0x33, 0x5a, 0x08, 0xfa, 0x86,
+0x92, 0x5a, 0x13, 0xfa, 0x1a, 0xfc, 0xf2, 0x1b,
+0x8c, 0x7f, 0x42, 0x6d, 0xb7, 0x7e, 0xb7, 0xb4,
+0xf0, 0xc7, 0x83, 0xbb, 0xa2, 0x81, 0x03, 0x2d,
+0xd4, 0x2a, 0x63, 0x3f, 0xf7, 0x31, 0x2e, 0x40,
+0x33, 0x5c, 0x46, 0xbc, 0x9b, 0xc1, 0x05, 0xa5,
+0x45, 0x4e, 0xc3,
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 56943daccfc7..ff81e6051773 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1825,6 +1825,8 @@ static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x1043, 0x86ae, "ASUS", 1),  /* Z170 PRO */
 	SND_PCI_QUIRK(0x1043, 0x86c7, "ASUS", 1),  /* Z170M PLUS */
 	SND_PCI_QUIRK(0x1462, 0xec94, "MS-7C94", 1),
+	SND_PCI_QUIRK(0x8086, 0x2060, "Intel NUC5CPYB", 1),
+	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", 1),
 	{}
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5ca5fe75f73f..bfa66b8e3040 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10395,6 +10395,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x32f7, "Lenovo ThinkCentre M90", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3321, "Lenovo ThinkCentre M70 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x331b, "Lenovo ThinkCentre M90 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3364, "Lenovo ThinkCentre M90 Gen5", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3742, "Lenovo TianYi510Pro-14IOB", ALC897_FIXUP_HEADSET_MIC_PIN2),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),

