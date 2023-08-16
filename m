Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5308D77E683
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344763AbjHPQfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344746AbjHPQf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:35:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C005519A7;
        Wed, 16 Aug 2023 09:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AEA76229B;
        Wed, 16 Aug 2023 16:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1F4C433C7;
        Wed, 16 Aug 2023 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692203721;
        bh=arAe38SKphvoA+hsSogkeAo1imyzn9vzwVto7Rv14L4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y7qKoDpXxSMkrBtp1myFzwVzBS/w65OSYbT6rTtDr1aZdjO4UZlnYlKSVXwCC552g
         iFTKO/iexSzLzX1J02sV9SVrrPZP/xb7E2Cido5MWP7u6F9btVe/iRgVyFPh4fxBPx
         KFoQMxHVLFGFdXhKAMwyv4BsI7bTZecMW6cSbSs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.14.323
Date:   Wed, 16 Aug 2023 18:35:10 +0200
Message-ID: <2023081610-spoon-shirt-85a0@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081610-lukewarm-defy-2e9d@gregkh>
References: <2023081610-lukewarm-defy-2e9d@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 3e6450cba24b..529740dc2976 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 322
+SUBLEVEL = 323
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 5576f7646fb6..60f7e45d3aa8 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -469,8 +469,7 @@ setup_memory(void *kernel_end)
 extern void setup_memory(void *);
 #endif /* !CONFIG_DISCONTIGMEM */
 
-int __init
-page_is_ram(unsigned long pfn)
+int page_is_ram(unsigned long pfn)
 {
 	struct memclust_struct * cluster;
 	struct memdesc_struct * memdesc;
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a0c38a70ceeb..ecbc90b7ed4d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -12,7 +12,6 @@ config 64BIT
 config SPARC
 	bool
 	default y
-	select ARCH_HAS_CPU_FINALIZE_INIT if !SMP
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select OF
@@ -48,6 +47,7 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select ARCH_HAS_CPU_FINALIZE_INIT if !SMP
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
 	select HAVE_UID16
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 63ed146abef0..5f7d47322221 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -227,8 +227,8 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 
 	/* Round the lowest possible end address up to a PMD boundary. */
 	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
-	if (end >= TASK_SIZE_MAX)
-		end = TASK_SIZE_MAX;
+	if (end >= DEFAULT_MAP_WINDOW)
+		end = DEFAULT_MAP_WINDOW;
 	end -= len;
 
 	if (end > start) {
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index be441d520d63..80af2ca9816e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -992,4 +992,6 @@ enum taa_mitigations {
 	TAA_MITIGATION_TSX_DISABLED,
 };
 
+extern bool gds_ucode_mitigated(void);
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0661f1950a48..33102596923c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -201,8 +201,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 
 u64 __read_mostly host_xcr0;
 
-extern bool gds_ucode_mitigated(void);
-
 static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
 
 static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 982b69d017cd..fe07f7316c75 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -403,6 +403,12 @@ enum desc_status {
 	 * of a channel can be BUSY at any time.
 	 */
 	BUSY,
+	/*
+	 * Pause was called while descriptor was BUSY. Due to hardware
+	 * limitations, only termination is possible for descriptors
+	 * that have been paused.
+	 */
+	PAUSED,
 	/*
 	 * Sitting on the channel work_list but xfer done
 	 * by PL330 core
@@ -1926,7 +1932,7 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
 	list_for_each_entry(desc, &pch->work_list, node) {
 
 		/* If already submitted */
-		if (desc->status == BUSY)
+		if (desc->status == BUSY || desc->status == PAUSED)
 			continue;
 
 		ret = pl330_submit_req(pch->thread, desc);
@@ -2191,6 +2197,7 @@ static int pl330_pause(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
 	struct pl330_dmac *pl330 = pch->dmac;
+	struct dma_pl330_desc *desc;
 	unsigned long flags;
 
 	pm_runtime_get_sync(pl330->ddma.dev);
@@ -2200,6 +2207,10 @@ static int pl330_pause(struct dma_chan *chan)
 	_stop(pch->thread);
 	spin_unlock(&pl330->lock);
 
+	list_for_each_entry(desc, &pch->work_list, node) {
+		if (desc->status == BUSY)
+			desc->status = PAUSED;
+	}
 	spin_unlock_irqrestore(&pch->lock, flags);
 	pm_runtime_mark_last_busy(pl330->ddma.dev);
 	pm_runtime_put_autosuspend(pl330->ddma.dev);
@@ -2290,7 +2301,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 		else if (running && desc == running)
 			transferred =
 				pl330_get_current_xferred_count(pch, desc);
-		else if (desc->status == BUSY)
+		else if (desc->status == BUSY || desc->status == PAUSED)
 			/*
 			 * Busy but not running means either just enqueued,
 			 * or finished and not yet marked done
@@ -2307,6 +2318,9 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 			case DONE:
 				ret = DMA_COMPLETE;
 				break;
+			case PAUSED:
+				ret = DMA_PAUSED;
+				break;
 			case PREP:
 			case BUSY:
 				ret = DMA_IN_PROGRESS;
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 4f604d71a46e..ae57a47fbf22 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -945,7 +945,7 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	/* Determine display colour depth for everything except LVDS now,
 	 * DP requires this before mode_valid() is called.
 	 */
-	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS && nv_connector->native_mode)
+	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
 		nouveau_connector_detect_depth(connector);
 
 	/* Find the native mode if this is a digital panel, if we didn't
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 416cae5ebbd0..61f20278ec2a 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -47,7 +47,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	platform_set_drvdata(pdev, indio_dev);
 
 	state->ec = ec->ec_dev;
-	state->msg = devm_kzalloc(&pdev->dev,
+	state->msg = devm_kzalloc(&pdev->dev, sizeof(*state->msg) +
 				max((u16)sizeof(struct ec_params_motion_sense),
 				state->ec->max_response), GFP_KERNEL);
 	if (!state->msg)
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index cb5785dda524..ac804c3abd95 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -12141,6 +12141,7 @@ static void free_cntrs(struct hfi1_devdata *dd)
 
 	if (dd->synth_stats_timer.data)
 		del_timer_sync(&dd->synth_stats_timer);
+	cancel_work_sync(&dd->update_cntr_work);
 	dd->synth_stats_timer.data = 0;
 	ppd = (struct hfi1_pportdata *)(dd + 1);
 	for (i = 0; i < dd->num_pports; i++, ppd++) {
diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 52307dce08ba..0c392b41a858 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -339,13 +339,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 				return;
 			}
 			for (len = 0; len < remain && len < host->fifo_width;) {
-				/* SCR data must be read in big endian. */
-				if (data->mrq->cmd->opcode == SD_APP_SEND_SCR)
-					*sgp = ioread32be(host->base +
-							  REG_DATA_WINDOW);
-				else
-					*sgp = ioread32(host->base +
-							REG_DATA_WINDOW);
+				*sgp = ioread32(host->base + REG_DATA_WINDOW);
 				sgp++;
 				len += 4;
 			}
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e86b21f097b6..3b5518276ef0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4345,7 +4345,9 @@ void bond_setup(struct net_device *bond_dev)
 
 	bond_dev->hw_features = BOND_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
-				NETIF_F_HW_VLAN_CTAG_FILTER;
+				NETIF_F_HW_VLAN_CTAG_FILTER |
+				NETIF_F_HW_VLAN_STAG_RX |
+				NETIF_F_HW_VLAN_STAG_FILTER;
 
 	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
 	bond_dev->features |= bond_dev->hw_features;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b616961267d0..b62417a0c72d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1275,7 +1275,7 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 	if (zerocopy)
 		return false;
 
-	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
+	if (SKB_DATA_ALIGN(len + TUN_RX_PAD + XDP_PACKET_HEADROOM) +
 	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
 		return false;
 
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index ac79f2088b31..480fc9bb4c90 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1594,7 +1594,7 @@ NCR_700_intr(int irq, void *dev_id)
 				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
 #endif
 				resume_offset = hostdata->pScript + Ent_SendMessagePhaseMismatch;
-			} else if(dsp >= to32bit(&slot->pSG[0].ins) &&
+			} else if (slot && dsp >= to32bit(&slot->pSG[0].ins) &&
 				  dsp <= to32bit(&slot->pSG[NCR_700_SG_SEGMENTS].ins)) {
 				int data_transfer = NCR_700_readl(host, DBC_REG) & 0xffffff;
 				int SGcount = (dsp - to32bit(&slot->pSG[0].ins))/sizeof(struct NCR_700_SG_List);
diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index cddd78893b46..37b93c3c9451 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -248,6 +248,7 @@ int raid_component_add(struct raid_template *r,struct device *raid_dev,
 	return 0;
 
 err_out:
+	put_device(&rc->dev);
 	list_del(&rc->node);
 	rd->component_count--;
 	put_device(component_dev);
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 7f0ceb65c3f3..99f472bb9f7e 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -311,7 +311,7 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 			       size_t length, loff_t *ppos)
 {
 	int host, channel, id, lun;
-	char *buffer, *p;
+	char *buffer, *end, *p;
 	int err;
 
 	if (!buf || length > PAGE_SIZE)
@@ -326,10 +326,14 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 		goto out;
 
 	err = -EINVAL;
-	if (length < PAGE_SIZE)
-		buffer[length] = '\0';
-	else if (buffer[PAGE_SIZE-1])
-		goto out;
+	if (length < PAGE_SIZE) {
+		end = buffer + length;
+		*end = '\0';
+	} else {
+		end = buffer + PAGE_SIZE - 1;
+		if (*end)
+			goto out;
+	}
 
 	/*
 	 * Usage: echo "scsi add-single-device 0 1 2 3" >/proc/scsi/scsi
@@ -338,10 +342,10 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	if (!strncmp("scsi add-single-device", buffer, 22)) {
 		p = buffer + 23;
 
-		host = simple_strtoul(p, &p, 0);
-		channel = simple_strtoul(p + 1, &p, 0);
-		id = simple_strtoul(p + 1, &p, 0);
-		lun = simple_strtoul(p + 1, &p, 0);
+		host    = (p     < end) ? simple_strtoul(p, &p, 0) : 0;
+		channel = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		id      = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		lun     = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
 
 		err = scsi_add_single_device(host, channel, id, lun);
 
@@ -352,10 +356,10 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	} else if (!strncmp("scsi remove-single-device", buffer, 25)) {
 		p = buffer + 26;
 
-		host = simple_strtoul(p, &p, 0);
-		channel = simple_strtoul(p + 1, &p, 0);
-		id = simple_strtoul(p + 1, &p, 0);
-		lun = simple_strtoul(p + 1, &p, 0);
+		host    = (p     < end) ? simple_strtoul(p, &p, 0) : 0;
+		channel = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		id      = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		lun     = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
 
 		err = scsi_remove_single_device(host, channel, id, lun);
 	}
diff --git a/drivers/scsi/snic/snic_disc.c b/drivers/scsi/snic/snic_disc.c
index 69c5e26a9d5b..388ba2ebcce5 100644
--- a/drivers/scsi/snic/snic_disc.c
+++ b/drivers/scsi/snic/snic_disc.c
@@ -316,6 +316,7 @@ snic_tgt_create(struct snic *snic, struct snic_tgt_id *tgtid)
 			      "Snic Tgt: device_add, with err = %d\n",
 			      ret);
 
+		put_device(&tgt->dev);
 		put_device(&snic->shost->shost_gendev);
 		spin_lock_irqsave(snic->shost->host_lock, flags);
 		list_del(&tgt->list);
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 5adeb1e4b186..411807dbaed0 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1505,10 +1505,6 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
  */
 static enum blk_eh_timer_return storvsc_eh_timed_out(struct scsi_cmnd *scmnd)
 {
-#if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
-	if (scmnd->device->host->transportt == fc_transport_template)
-		return fc_eh_timed_out(scmnd);
-#endif
 	return BLK_EH_RESET_TIMER;
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 5d142d7f6272..0b65328adff1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3172,9 +3172,14 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	u32 reg;
 
 	if (pm_runtime_suspended(dwc->dev)) {
+		dwc->pending_events = true;
+		/*
+		 * Trigger runtime resume. The get() function will be balanced
+		 * after processing the pending events in dwc3_process_pending
+		 * events().
+		 */
 		pm_runtime_get(dwc->dev);
 		disable_irq_nosync(dwc->irq_gadget);
-		dwc->pending_events = true;
 		return IRQ_HANDLED;
 	}
 
@@ -3414,6 +3419,8 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
 {
 	if (dwc->pending_events) {
 		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		pm_runtime_put(dwc->dev);
 		dwc->pending_events = false;
 		enable_irq(dwc->irq_gadget);
 	}
diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 3dbd60540372..263847bf1fe5 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -330,7 +330,8 @@ static int alauda_get_media_status(struct us_data *us, unsigned char *data)
 	rc = usb_stor_ctrl_transfer(us, us->recv_ctrl_pipe,
 		command, 0xc0, 0, 1, data, 2);
 
-	usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);
+	if (rc == USB_STOR_XFER_GOOD)
+		usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);
 
 	return rc;
 }
@@ -466,10 +467,14 @@ static int alauda_init_media(struct us_data *us)
 static int alauda_check_media(struct us_data *us)
 {
 	struct alauda_info *info = (struct alauda_info *) us->extra;
-	unsigned char status[2];
+	unsigned char *status = us->iobuf;
 	int rc;
 
 	rc = alauda_get_media_status(us, status);
+	if (rc != USB_STOR_XFER_GOOD) {
+		status[0] = 0xF0;	/* Pretend there's no media */
+		status[1] = 0;
+	}
 
 	/* Check for no media or door open */
 	if ((status[0] & 0x80) || ((status[0] & 0x1F) == 0x10)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fd56c22c12a0..d80ec99dc798 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3884,11 +3884,12 @@ int btree_write_cache_pages(struct address_space *mapping,
 			free_extent_buffer(eb);
 
 			/*
-			 * the filesystem may choose to bump up nr_to_write.
+			 * The filesystem may choose to bump up nr_to_write.
 			 * We have to make sure to honor the new nr_to_write
-			 * at any time
+			 * at any time.
 			 */
-			nr_to_write_done = wbc->nr_to_write <= 0;
+			nr_to_write_done = (wbc->sync_mode == WB_SYNC_NONE &&
+					    wbc->nr_to_write <= 0);
 		}
 		pagevec_release(&pvec);
 		cond_resched();
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 9c7971c196c9..bc5f447d93bd 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1121,9 +1121,17 @@ int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty)
 
 int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
 {
+	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 	struct buffer_head *ibh;
 	int err;
 
+	/*
+	 * Do not dirty inodes after the log writer has been detached
+	 * and its nilfs_root struct has been freed.
+	 */
+	if (unlikely(nilfs_purging(nilfs)))
+		return 0;
+
 	err = nilfs_load_inode_block(inode, &ibh);
 	if (unlikely(err)) {
 		nilfs_msg(inode->i_sb, KERN_WARNING,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 6d297562b48d..f4215dbaca0d 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2859,6 +2859,7 @@ void nilfs_detach_log_writer(struct super_block *sb)
 		nilfs_segctor_destroy(nilfs->ns_writer);
 		nilfs->ns_writer = NULL;
 	}
+	set_nilfs_purging(nilfs);
 
 	/* Force to free the list of dirty files */
 	spin_lock(&nilfs->ns_inode_lock);
@@ -2871,4 +2872,5 @@ void nilfs_detach_log_writer(struct super_block *sb)
 	up_write(&nilfs->ns_segctor_sem);
 
 	nilfs_dispose_list(nilfs, &garbage_list, 1);
+	clear_nilfs_purging(nilfs);
 }
diff --git a/fs/nilfs2/the_nilfs.h b/fs/nilfs2/the_nilfs.h
index b305c6f033e7..6db4943fd05b 100644
--- a/fs/nilfs2/the_nilfs.h
+++ b/fs/nilfs2/the_nilfs.h
@@ -37,6 +37,7 @@ enum {
 	THE_NILFS_DISCONTINUED,	/* 'next' pointer chain has broken */
 	THE_NILFS_GC_RUNNING,	/* gc process is running */
 	THE_NILFS_SB_DIRTY,	/* super block is dirty */
+	THE_NILFS_PURGING,	/* disposing dirty files for cleanup */
 };
 
 /**
@@ -216,6 +217,7 @@ THE_NILFS_FNS(INIT, init)
 THE_NILFS_FNS(DISCONTINUED, discontinued)
 THE_NILFS_FNS(GC_RUNNING, gc_running)
 THE_NILFS_FNS(SB_DIRTY, sb_dirty)
+THE_NILFS_FNS(PURGING, purging)
 
 /*
  * Mount option operations
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index d5e933e6a611..e71e155f3b88 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -968,6 +968,29 @@ int __nft_release_basechain(struct nft_ctx *ctx);
 
 unsigned int nft_do_chain(struct nft_pktinfo *pkt, void *priv);
 
+static inline bool nft_use_inc(u32 *use)
+{
+	if (*use == UINT_MAX)
+		return false;
+
+	(*use)++;
+
+	return true;
+}
+
+static inline void nft_use_dec(u32 *use)
+{
+	WARN_ON_ONCE((*use)-- == 0);
+}
+
+/* For error and abort path: restore use counter to previous state. */
+static inline void nft_use_inc_restore(u32 *use)
+{
+	WARN_ON_ONCE(!nft_use_inc(use));
+}
+
+#define nft_use_dec_restore	nft_use_dec
+
 /**
  *	struct nft_table - nf_tables table
  *
@@ -1051,8 +1074,8 @@ struct nft_object {
 	struct list_head		list;
 	char				*name;
 	struct nft_table		*table;
-	u32				genmask:2,
-					use:30;
+	u32				genmask:2;
+	u32				use;
 	/* runtime data below here */
 	const struct nft_object_ops	*ops ____cacheline_aligned;
 	unsigned char			data[]
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 5318c5e18acf..34210306ea66 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -159,7 +159,7 @@ static int __kstrncpy(char **dst, const char *name, size_t count, gfp_t gfp)
 {
 	*dst = kstrndup(name, count, gfp);
 	if (!*dst)
-		return -ENOSPC;
+		return -ENOMEM;
 	return count;
 }
 
@@ -459,7 +459,7 @@ static ssize_t trigger_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -500,7 +500,7 @@ static ssize_t trigger_async_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -543,7 +543,7 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s' using custom fallback mechanism\n", name);
 
diff --git a/net/dccp/output.c b/net/dccp/output.c
index 91a15b3c4915..d872dd1cfb5e 100644
--- a/net/dccp/output.c
+++ b/net/dccp/output.c
@@ -189,7 +189,7 @@ unsigned int dccp_sync_mss(struct sock *sk, u32 pmtu)
 
 	/* And store cached results */
 	icsk->icsk_pmtu_cookie = pmtu;
-	dp->dccps_mss_cache = cur_mps;
+	WRITE_ONCE(dp->dccps_mss_cache, cur_mps);
 
 	return cur_mps;
 }
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 794be8ab05f4..24aeab90539b 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -645,7 +645,7 @@ static int do_dccp_getsockopt(struct sock *sk, int level, int optname,
 		return dccp_getsockopt_service(sk, len,
 					       (__be32 __user *)optval, optlen);
 	case DCCP_SOCKOPT_GET_CUR_MPS:
-		val = dp->dccps_mss_cache;
+		val = READ_ONCE(dp->dccps_mss_cache);
 		break;
 	case DCCP_SOCKOPT_AVAILABLE_CCIDS:
 		return ccid_getsockopt_builtin_ccids(sk, len, optval, optlen);
@@ -765,7 +765,7 @@ int dccp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int rc, size;
 	long timeo;
 
-	if (len > dp->dccps_mss_cache)
+	if (len > READ_ONCE(dp->dccps_mss_cache))
 		return -EMSGSIZE;
 
 	lock_sock(sk);
@@ -798,6 +798,12 @@ int dccp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		goto out_discard;
 	}
 
+	/* We need to check dccps_mss_cache after socket is locked. */
+	if (len > dp->dccps_mss_cache) {
+		rc = -EMSGSIZE;
+		goto out_discard;
+	}
+
 	skb_reserve(skb, sk->sk_prot->max_header);
 	rc = memcpy_from_msg(skb_put(skb, len), msg, len);
 	if (rc != 0)
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 5f80e57e93ed..b54e964dff3a 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -194,7 +194,8 @@ static struct nd_opt_hdr *ndisc_next_option(struct nd_opt_hdr *cur,
 static inline int ndisc_is_useropt(const struct net_device *dev,
 				   struct nd_opt_hdr *opt)
 {
-	return opt->nd_opt_type == ND_OPT_RDNSS ||
+	return opt->nd_opt_type == ND_OPT_PREFIX_INFO ||
+		opt->nd_opt_type == ND_OPT_RDNSS ||
 		opt->nd_opt_type == ND_OPT_DNSSL ||
 		ndisc_ops_is_useropt(dev, opt->nd_opt_type);
 }
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 68a13ab584ac..27c24c99d23b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -248,7 +248,7 @@ static int nft_delchain(struct nft_ctx *ctx)
 	if (err < 0)
 		return err;
 
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 	nft_deactivate_next(ctx->net, ctx->chain);
 
 	return err;
@@ -289,7 +289,7 @@ nf_tables_delrule_deactivate(struct nft_ctx *ctx, struct nft_rule *rule)
 	/* You cannot delete the same rule twice */
 	if (nft_is_active_next(ctx->net, rule)) {
 		nft_deactivate_next(ctx->net, rule);
-		ctx->chain->use--;
+		nft_use_dec(&ctx->chain->use);
 		return 0;
 	}
 	return -ENOENT;
@@ -378,7 +378,7 @@ static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 		return err;
 
 	nft_deactivate_next(ctx->net, set);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -410,7 +410,7 @@ static int nft_delobj(struct nft_ctx *ctx, struct nft_object *obj)
 		return err;
 
 	nft_deactivate_next(ctx->net, obj);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -1421,9 +1421,6 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	unsigned int i;
 	int err;
 
-	if (table->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (nla[NFTA_CHAIN_HOOK]) {
 		struct nft_chain_hook hook;
 		struct nf_hook_ops *ops;
@@ -1491,16 +1488,22 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	if (err < 0)
 		goto err1;
 
+	if (!nft_use_inc(&table->use)) {
+		err = -EMFILE;
+		goto err_use;
+	}
+
 	ctx->chain = chain;
 	err = nft_trans_chain_add(ctx, NFT_MSG_NEWCHAIN);
 	if (err < 0)
 		goto err2;
 
-	table->use++;
 	list_add_tail_rcu(&chain->list, &table->chains);
 
 	return 0;
 err2:
+	nft_use_dec_restore(&table->use);
+err_use:
 	nf_tables_unregister_hooks(net, table, chain, afi->nops);
 err1:
 	nf_tables_chain_destroy(chain);
@@ -2371,9 +2374,6 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 		if (!create || nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EINVAL;
 		handle = nf_tables_alloc_handle(table);
-
-		if (chain->use == UINT_MAX)
-			return -EOVERFLOW;
 	}
 
 	if (nla[NFTA_RULE_POSITION]) {
@@ -2441,23 +2441,28 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 		expr = nft_expr_next(expr);
 	}
 
+	if (!nft_use_inc(&chain->use)) {
+		err = -EMFILE;
+		goto err2;
+	}
+
 	if (nlh->nlmsg_flags & NLM_F_REPLACE) {
 		trans = nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule);
 		if (trans == NULL) {
 			err = -ENOMEM;
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 		err = nft_delrule(&ctx, old_rule);
 		if (err < 0) {
 			nft_trans_destroy(trans);
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 
 		list_add_tail_rcu(&rule->list, &old_rule->list);
 	} else {
 		if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) == NULL) {
 			err = -ENOMEM;
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 
 		if (nlh->nlmsg_flags & NLM_F_APPEND) {
@@ -2472,9 +2477,11 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 				list_add_rcu(&rule->list, &chain->rules);
 		}
 	}
-	chain->use++;
+
 	return 0;
 
+err_destroy_flow_rule:
+	nft_use_dec_restore(&chain->use);
 err2:
 	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE_ERROR);
 	nf_tables_rule_destroy(&ctx, rule);
@@ -3262,10 +3269,15 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	if (ops->privsize != NULL)
 		size = ops->privsize(nla, &desc);
 
+	if (!nft_use_inc(&table->use)) {
+		err = -EMFILE;
+		goto err1;
+	}
+
 	set = kvzalloc(sizeof(*set) + size + udlen, GFP_KERNEL);
 	if (!set) {
 		err = -ENOMEM;
-		goto err1;
+		goto err_alloc;
 	}
 
 	name = nla_strdup(nla[NFTA_SET_NAME], GFP_KERNEL);
@@ -3310,7 +3322,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 		goto err4;
 
 	list_add_tail_rcu(&set->list, &table->sets);
-	table->use++;
+
 	return 0;
 
 err4:
@@ -3319,6 +3331,8 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	kfree(set->name);
 err2:
 	kvfree(set);
+err_alloc:
+	nft_use_dec_restore(&table->use);
 err1:
 	module_put(ops->type->owner);
 	return err;
@@ -3393,9 +3407,6 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_set_binding *i;
 	struct nft_set_iter iter;
 
-	if (set->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (!list_empty(&set->bindings) && set->flags & NFT_SET_ANONYMOUS)
 		return -EBUSY;
 
@@ -3420,10 +3431,12 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 			return iter.err;
 	}
 bind:
+	if (!nft_use_inc(&set->use))
+		return -EMFILE;
+
 	binding->chain = ctx->chain;
 	list_add_tail_rcu(&binding->list, &set->bindings);
 	nft_set_trans_bind(ctx, set);
-	set->use++;
 
 	return 0;
 }
@@ -3448,7 +3461,7 @@ void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
 	if (set->flags & NFT_SET_ANONYMOUS)
 		nft_clear(ctx->net, set);
 
-	set->use++;
+	nft_use_inc_restore(&set->use);
 }
 EXPORT_SYMBOL_GPL(nf_tables_activate_set);
 
@@ -3464,17 +3477,17 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		else
 			list_del_rcu(&binding->list);
 
-		set->use--;
+		nft_use_dec(&set->use);
 		break;
 	case NFT_TRANS_PREPARE:
 		if (set->flags & NFT_SET_ANONYMOUS)
 			nft_deactivate_next(ctx->net, set);
 
-		set->use--;
+		nft_use_dec(&set->use);
 		return;
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
-		set->use--;
+		nft_use_dec(&set->use);
 		/* fall through */
 	default:
 		nf_tables_unbind_set(ctx, set, binding,
@@ -3947,7 +3960,7 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 	if (destroy_expr && nft_set_ext_exists(ext, NFT_SET_EXT_EXPR))
 		nf_tables_expr_destroy(NULL, nft_set_ext_expr(ext));
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 	kfree(elem);
 }
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
@@ -4090,8 +4103,16 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 					   set->objtype, genmask);
 		if (IS_ERR(obj)) {
 			err = PTR_ERR(obj);
+			obj = NULL;
 			goto err2;
 		}
+
+		if (!nft_use_inc(&obj->use)) {
+			err = -EMFILE;
+			obj = NULL;
+			goto err2;
+		}
+
 		nft_set_ext_add(&tmpl, NFT_SET_EXT_OBJREF);
 	}
 
@@ -4150,10 +4171,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		udata->len = ulen - 1;
 		nla_memcpy(&udata->data, nla[NFTA_SET_ELEM_USERDATA], ulen);
 	}
-	if (obj) {
+	if (obj)
 		*nft_set_ext_obj(ext) = obj;
-		obj->use++;
-	}
 
 	trans = nft_trans_elem_alloc(ctx, NFT_MSG_NEWSETELEM, set);
 	if (trans == NULL)
@@ -4199,13 +4218,14 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 err5:
 	kfree(trans);
 err4:
-	if (obj)
-		obj->use--;
 	kfree(elem.priv);
 err3:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
 		nft_data_release(&elem.data.val, desc.type);
 err2:
+	if (obj)
+		nft_use_dec_restore(&obj->use);
+
 	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
 err1:
 	return err;
@@ -4266,11 +4286,14 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
  */
 void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 {
+	struct nft_chain *chain;
+
 	if (type == NFT_DATA_VERDICT) {
 		switch (data->verdict.code) {
 		case NFT_JUMP:
 		case NFT_GOTO:
-			data->verdict.chain->use++;
+			chain = data->verdict.chain;
+			nft_use_inc_restore(&chain->use);
 			break;
 		}
 	}
@@ -4285,7 +4308,7 @@ static void nft_set_elem_activate(const struct net *net,
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_hold(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use++;
+		nft_use_inc_restore(&(*nft_set_ext_obj(ext))->use);
 }
 
 static void nft_set_elem_deactivate(const struct net *net,
@@ -4297,7 +4320,7 @@ static void nft_set_elem_deactivate(const struct net *net,
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_release(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 }
 
 static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
@@ -4672,9 +4695,14 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 
 	nft_ctx_init(&ctx, net, skb, nlh, afi, table, NULL, nla);
 
+	if (!nft_use_inc(&table->use))
+		return -EMFILE;
+
 	type = nft_obj_type_get(objtype);
-	if (IS_ERR(type))
-		return PTR_ERR(type);
+	if (IS_ERR(type)) {
+		err = PTR_ERR(type);
+		goto err_type;
+	}
 
 	obj = nft_obj_init(&ctx, type, nla[NFTA_OBJ_DATA]);
 	if (IS_ERR(obj)) {
@@ -4693,7 +4721,7 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 		goto err3;
 
 	list_add_tail_rcu(&obj->list, &table->objects);
-	table->use++;
+
 	return 0;
 err3:
 	kfree(obj->name);
@@ -4703,6 +4731,9 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 	kfree(obj);
 err1:
 	module_put(type->owner);
+err_type:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -5304,7 +5335,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			 */
 			if (nft_trans_set(trans)->flags & NFT_SET_ANONYMOUS &&
 			    !list_empty(&nft_trans_set(trans)->bindings))
-				trans->ctx.table->use--;
+				nft_use_dec(&trans->ctx.table->use);
 
 			nf_tables_set_notify(&trans->ctx, nft_trans_set(trans),
 					     NFT_MSG_NEWSET, GFP_KERNEL);
@@ -5418,7 +5449,7 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
 			} else {
-				trans->ctx.table->use--;
+				nft_use_dec_restore(&trans->ctx.table->use);
 				list_del_rcu(&trans->ctx.chain->list);
 				nf_tables_unregister_hooks(trans->ctx.net,
 							   trans->ctx.table,
@@ -5427,25 +5458,25 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 			}
 			break;
 		case NFT_MSG_DELCHAIN:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, trans->ctx.chain);
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWRULE:
-			trans->ctx.chain->use--;
+			nft_use_dec_restore(&trans->ctx.chain->use);
 			list_del_rcu(&nft_trans_rule(trans)->list);
 			nft_rule_expr_deactivate(&trans->ctx,
 						 nft_trans_rule(trans),
 						 NFT_TRANS_ABORT);
 			break;
 		case NFT_MSG_DELRULE:
-			trans->ctx.chain->use++;
+			nft_use_inc_restore(&trans->ctx.chain->use);
 			nft_clear(trans->ctx.net, nft_trans_rule(trans));
 			nft_rule_expr_activate(&trans->ctx, nft_trans_rule(trans));
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSET:
-			trans->ctx.table->use--;
+			nft_use_dec_restore(&trans->ctx.table->use);
 			if (nft_trans_set_bound(trans)) {
 				nft_trans_destroy(trans);
 				break;
@@ -5453,7 +5484,7 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 			list_del_rcu(&nft_trans_set(trans)->list);
 			break;
 		case NFT_MSG_DELSET:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_set(trans));
 			nft_trans_destroy(trans);
 			break;
@@ -5477,11 +5508,11 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWOBJ:
-			trans->ctx.table->use--;
+			nft_use_dec_restore(&trans->ctx.table->use);
 			list_del_rcu(&nft_trans_obj(trans)->list);
 			break;
 		case NFT_MSG_DELOBJ:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_obj(trans));
 			nft_trans_destroy(trans);
 			break;
@@ -5882,8 +5913,9 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 			return PTR_ERR(chain);
 		if (nft_is_base_chain(chain))
 			return -EOPNOTSUPP;
+		if (!nft_use_inc(&chain->use))
+			return -EMFILE;
 
-		chain->use++;
 		data->verdict.chain = chain;
 		break;
 	}
@@ -5895,10 +5927,13 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 static void nft_verdict_uninit(const struct nft_data *data)
 {
+	struct nft_chain *chain;
+
 	switch (data->verdict.code) {
 	case NFT_JUMP:
 	case NFT_GOTO:
-		data->verdict.chain->use--;
+		chain = data->verdict.chain;
+		nft_use_dec(&chain->use);
 		break;
 	}
 }
@@ -6059,11 +6094,11 @@ int __nft_release_basechain(struct nft_ctx *ctx)
 				   ctx->afi->nops);
 	list_for_each_entry_safe(rule, nr, &ctx->chain->rules, list) {
 		list_del(&rule->list);
-		ctx->chain->use--;
+		nft_use_dec(&ctx->chain->use);
 		nf_tables_rule_release(ctx, rule);
 	}
 	list_del(&ctx->chain->list);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 	nf_tables_chain_destroy(ctx->chain);
 
 	return 0;
@@ -6093,23 +6128,23 @@ static void __nft_release_afinfo(struct net *net, struct nft_af_info *afi)
 			ctx.chain = chain;
 			list_for_each_entry_safe(rule, nr, &chain->rules, list) {
 				list_del(&rule->list);
-				chain->use--;
+				nft_use_dec(&chain->use);
 				nf_tables_rule_release(&ctx, rule);
 			}
 		}
 		list_for_each_entry_safe(set, ns, &table->sets, list) {
 			list_del(&set->list);
-			table->use--;
+			nft_use_dec(&table->use);
 			nft_set_destroy(set);
 		}
 		list_for_each_entry_safe(obj, ne, &table->objects, list) {
 			list_del(&obj->list);
-			table->use--;
+			nft_use_dec(&table->use);
 			nft_obj_destroy(obj);
 		}
 		list_for_each_entry_safe(chain, nc, &table->chains, list) {
 			list_del(&chain->list);
-			table->use--;
+			nft_use_dec(&table->use);
 			nf_tables_chain_destroy(chain);
 		}
 		list_del(&table->list);
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 8ad0be6c53fd..f3c5d4b14657 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -43,8 +43,10 @@ static int nft_objref_init(const struct nft_ctx *ctx,
 	if (IS_ERR(obj))
 		return -ENOENT;
 
+	if (!nft_use_inc(&obj->use))
+		return -EMFILE;
+
 	nft_objref_priv(expr) = obj;
-	obj->use++;
 
 	return 0;
 }
@@ -73,7 +75,7 @@ static void nft_objref_deactivate(const struct nft_ctx *ctx,
 	if (phase == NFT_TRANS_COMMIT)
 		return;
 
-	obj->use--;
+	nft_use_dec(&obj->use);
 }
 
 static void nft_objref_activate(const struct nft_ctx *ctx,
@@ -81,7 +83,7 @@ static void nft_objref_activate(const struct nft_ctx *ctx,
 {
 	struct nft_object *obj = nft_objref_priv(expr);
 
-	obj->use++;
+	nft_use_inc_restore(&obj->use);
 }
 
 static struct nft_expr_type nft_objref_type;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 228a409eb92d..b69598071730 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -403,18 +403,20 @@ static void __packet_set_status(struct packet_sock *po, void *frame, int status)
 {
 	union tpacket_uhdr h;
 
+	/* WRITE_ONCE() are paired with READ_ONCE() in __packet_get_status */
+
 	h.raw = frame;
 	switch (po->tp_version) {
 	case TPACKET_V1:
-		h.h1->tp_status = status;
+		WRITE_ONCE(h.h1->tp_status, status);
 		flush_dcache_page(pgv_to_page(&h.h1->tp_status));
 		break;
 	case TPACKET_V2:
-		h.h2->tp_status = status;
+		WRITE_ONCE(h.h2->tp_status, status);
 		flush_dcache_page(pgv_to_page(&h.h2->tp_status));
 		break;
 	case TPACKET_V3:
-		h.h3->tp_status = status;
+		WRITE_ONCE(h.h3->tp_status, status);
 		flush_dcache_page(pgv_to_page(&h.h3->tp_status));
 		break;
 	default:
@@ -431,17 +433,19 @@ static int __packet_get_status(struct packet_sock *po, void *frame)
 
 	smp_rmb();
 
+	/* READ_ONCE() are paired with WRITE_ONCE() in __packet_set_status */
+
 	h.raw = frame;
 	switch (po->tp_version) {
 	case TPACKET_V1:
 		flush_dcache_page(pgv_to_page(&h.h1->tp_status));
-		return h.h1->tp_status;
+		return READ_ONCE(h.h1->tp_status);
 	case TPACKET_V2:
 		flush_dcache_page(pgv_to_page(&h.h2->tp_status));
-		return h.h2->tp_status;
+		return READ_ONCE(h.h2->tp_status);
 	case TPACKET_V3:
 		flush_dcache_page(pgv_to_page(&h.h3->tp_status));
-		return h.h3->tp_status;
+		return READ_ONCE(h.h3->tp_status);
 	default:
 		WARN(1, "TPACKET version not supported.\n");
 		BUG();
diff --git a/tools/testing/radix-tree/regression1.c b/tools/testing/radix-tree/regression1.c
index 0aece092f40e..a247026042d4 100644
--- a/tools/testing/radix-tree/regression1.c
+++ b/tools/testing/radix-tree/regression1.c
@@ -198,7 +198,7 @@ void regression1_test(void)
 	nr_threads = 2;
 	pthread_barrier_init(&worker_barrier, NULL, nr_threads);
 
-	threads = malloc(nr_threads * sizeof(pthread_t *));
+	threads = malloc(nr_threads * sizeof(*threads));
 
 	for (i = 0; i < nr_threads; i++) {
 		arg = i;
