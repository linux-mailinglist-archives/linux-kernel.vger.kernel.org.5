Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF3778274
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjHJU4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHJUz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA7B2D40
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691700914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lfaB6tBMAvL9/pqvVaWnN1LZOF40W/2XE6DW1I2BEG4=;
        b=YVjNFEOmzPT77IDGbMCWaVsj6EUXIDkbQQ3GCrX03/qi4ObeH2TJIh/oyOfunzn2E5gdau
        +zcESvn82wz+emiXmkvMMnd+jO+aN/W+4JtwgevkV8zyB3iBSZRC5BKyxwHqM6JF3Y49qW
        6gcKi8jK+5ZhJcqvNfIuC0RAyhcI9Dg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-5-k_8jKzPrOzXuw9mtG1aQ-1; Thu, 10 Aug 2023 16:55:13 -0400
X-MC-Unique: 5-k_8jKzPrOzXuw9mtG1aQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3176ace3f58so844433f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691700911; x=1692305711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfaB6tBMAvL9/pqvVaWnN1LZOF40W/2XE6DW1I2BEG4=;
        b=jtQMVBpwNfsSP8CoCy/JpZNf7EsboangP/hmismVotXf9Wjp6U13QvUG7VK4qqn/av
         9tyAfTSoicP/h63VihTh00usEPUoV5jnj6DBD/Em+lXpHkSs5EXi7z5xKBSjinzTX/ow
         ndTR3j2JdsAJR6d5dqBhxZXQMjlL0bzNrzVfUxRkHgcalhfUBcS+y9EnBR2uMDCoH2Su
         DQBhOSnKIHTdt2+k6j1VEBPT6SiGOtiFGU6togAWF6bUTppbxC3XWetO2k6pBS2ziQdc
         uLQze59HNcl4xtEtN+NOxA8ThJkmqGHKi2jBzan7FbtVfrIerGTiMA9gmgkx2C/yWe/V
         f0vw==
X-Gm-Message-State: AOJu0Yws2X9wah8v1/WfuhoSEOmtVblAQSGDladFV2OYM0UPekkovXAa
        +eINuOQVxUdPNVC0IA0Nl0fgvVFn68DnqRmR142QPG8FPiPM5+1E85X/8wjyqw9hbW47UIEc9mz
        i7m72Cb0rK7ZVTPXlyU4NeUbIunepxsR3
X-Received: by 2002:a05:6000:90:b0:314:3954:7ff6 with SMTP id m16-20020a056000009000b0031439547ff6mr3227134wrx.56.1691700911598;
        Thu, 10 Aug 2023 13:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNUpf0ajOkTTXi4qlPy6gs875R1+q6YliZ1AXVNxj1/ZIGEmZCK4uQqXByKlrrTsc3hRFOAQ==
X-Received: by 2002:a05:6000:90:b0:314:3954:7ff6 with SMTP id m16-20020a056000009000b0031439547ff6mr3227122wrx.56.1691700911065;
        Thu, 10 Aug 2023 13:55:11 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id s7-20020adfecc7000000b0031912c0ffebsm2457444wro.23.2023.08.10.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:55:10 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:55:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhanghao1 <zhanghao1@kylinos.cn>
Cc:     virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: a new vcpu watchdog driver
Message-ID: <20230810164707-mutt-send-email-mst@kernel.org>
References: <20230731012512.235085-1-zhanghao1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731012512.235085-1-zhanghao1@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 09:25:12AM +0800, zhanghao1 wrote:
> A new virtio pci driver is added for listening to vcpus
> inside guest. Each vcpu creates a corresponding thread to
> periodically send data to qemu's back-end watchdog device.
> If a vCPU is in the stall state, data cannot be sent to
> back-end virtio device. As a result, the back-end device
> can detect that the guest is in the stall state.
> 
> The driver is mainly used with the back-end watchdog device of qemu.
> 
> The qemu backend watchdog device is implemented as follow:
> https://lore.kernel.org/qemu-devel/20230705081813.411526-1-zhanghao1@kylinos.cn/
> 
> Signed-off-by: zhanghao1 <zhanghao1@kylinos.cn>
> ---
>  drivers/virtio/Kconfig                      |   9 +
>  drivers/virtio/Makefile                     |   1 +
>  drivers/virtio/virtio_vcpu_stall_detector.c | 299 ++++++++++++++++++++
>  3 files changed, 309 insertions(+)
>  create mode 100644 drivers/virtio/virtio_vcpu_stall_detector.c
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 0a53a61231c2..869323e345a1 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -173,4 +173,13 @@ config VIRTIO_DMA_SHARED_BUFFER
>  	 This option adds a flavor of dma buffers that are backed by
>  	 virtio resources.
>  
> +config VIRTIO_VCPU_WATCHDOG
> +	tristate "Virtio vcpu watchdog driver"
> +	depends on VIRTIO_PCI
> +	help
> +	 When this driver is bound inside a KVM guest, it will
> +	 periodically "pet" an PCI virtio watchdog device from each vCPU
> +	 and allow the host to detect vCPU stalls.
> +
> +	 If you do not intend to run this kernel as a guest, say N.
>  endif # VIRTIO_MENU
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 8e98d24917cc..c7341f078a34 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
>  obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
>  obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
>  obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
> +obj-$(CONFIG_VIRTIO_VCPU_WATCHDOG) += virtio_vcpu_stall_detector.o
> diff --git a/drivers/virtio/virtio_vcpu_stall_detector.c b/drivers/virtio/virtio_vcpu_stall_detector.c
> new file mode 100644
> index 000000000000..58344ca528be
> --- /dev/null
> +++ b/drivers/virtio/virtio_vcpu_stall_detector.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// VCPU stall detector.
> +// Copyright (C) Kylin Software, 2023
> +
> +#include <linux/cpu.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/nmi.h>
> +#include <uapi/linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +#include <linux/param.h>
> +#include <linux/percpu.h>
> +#include <linux/slab.h>
> +
> +#define VCPU_STALL_REG_STATUS		(0x00)
> +#define VCPU_STALL_REG_LOAD_CNT		(0x04)
> +#define VCPU_STALL_REG_CURRENT_CNT	(0x08)
> +#define VCPU_STALL_REG_CLOCK_FREQ_HZ	(0x0C)
> +#define VCPU_STALL_REG_LEN		(0x10)
> +#define VCPU_STALL_REG_TIMEOUT_SEC	(0x14)
> +
> +#define VCPU_STALL_DEFAULT_CLOCK_HZ	(10)
> +#define VCPU_STALL_MAX_CLOCK_HZ		(100)
> +#define VCPU_STALL_DEFAULT_TIMEOUT_SEC	(8)
> +#define VCPU_STALL_MAX_TIMEOUT_SEC	(600)
> +
> +struct vcpu_stall_detect_config {
> +	u32 clock_freq_hz;
> +	u32 stall_timeout_sec;
> +
> +	enum cpuhp_state hp_online;
> +};
> +
> +struct vcpu_stall_priv {
> +	struct hrtimer vcpu_hrtimer;
> +	struct virtio_device *vdev;
> +	u32 cpu_id;
> +};
> +
> +struct vcpu_stall {
> +	struct vcpu_stall_priv *priv;
> +	struct virtqueue *vq;
> +	spinlock_t lock;
> +	struct pet_event {
> +		u32 cpu_id;
> +		bool is_initialized;
> +		u32 ticks;
> +	} pet_event;


should all be LE. and formatting here is very compiler dependent.
also put this in a header under uapi/

> +};
> +
> +static const struct virtio_device_id vcpu_stall_id_table[] = {
> +	{ VIRTIO_ID_WATCHDOG, VIRTIO_DEV_ANY_ID },
> +	{ 0, },
> +};
> +
> +/* The vcpu stall configuration structure which applies to all the CPUs */
> +static struct vcpu_stall_detect_config vcpu_stall_config;
> +static struct vcpu_stall *vcpu_stall;
> +
> +static struct vcpu_stall_priv __percpu *vcpu_stall_detectors;
> +
> +static enum hrtimer_restart
> +vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
> +{
> +	u32 ticks, ping_timeout_ms;
> +	struct scatterlist sg;
> +	int unused, err = 0;
> +
> +	struct vcpu_stall_priv *vcpu_stall_detector =
> +		this_cpu_ptr(vcpu_stall->priv);
> +
> +	/* Reload the stall detector counter register every
> +	 * `ping_timeout_ms` to prevent the virtual device
> +	 * from decrementing it to 0. The virtual device decrements this
> +	 * register at 'clock_freq_hz' frequency.
> +	 */
> +	ticks = vcpu_stall_config.clock_freq_hz *
> +				vcpu_stall_config.stall_timeout_sec;
> +
> +	spin_lock(&vcpu_stall->lock);
> +	while (virtqueue_get_buf(vcpu_stall->vq, &unused))
> +		;
> +	vcpu_stall->pet_event.ticks = cpu_to_virtio32(vcpu_stall_detector->vdev, ticks);
> +	vcpu_stall->pet_event.is_initialized = true;
> +	vcpu_stall->pet_event.cpu_id = vcpu_stall_detector->cpu_id;
> +
> +	sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
> +	err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
> +	if (!err)
> +		virtqueue_kick(vcpu_stall->vq);
> +	else
> +		pr_err("cpu:%d failed to add outbuf, err:%d\n", vcpu_stall_detector->cpu_id, err);

this can happen if device is slow to use the buffers. and then what?
will missing the pet even mean host will reset the guest?
pr_err also might make guest crash, depending on config.

> +
> +	spin_unlock(&vcpu_stall->lock);
> +
> +	ping_timeout_ms = vcpu_stall_config.stall_timeout_sec *
> +			  MSEC_PER_SEC / 2;
> +	hrtimer_forward_now(hrtimer,
> +			    ms_to_ktime(ping_timeout_ms));
> +	return HRTIMER_RESTART;
> +}
> +
> +static int start_stall_detector_cpu(unsigned int cpu)
> +{
> +	u32 ticks, ping_timeout_ms;
> +	struct scatterlist sg;
> +	struct hrtimer *vcpu_hrtimer;
> +	int err = 0;
> +
> +	struct vcpu_stall_priv *vcpu_stall_detector =
> +		this_cpu_ptr(vcpu_stall->priv);
> +
> +	vcpu_stall_detector->cpu_id = cpu;
> +
> +	vcpu_hrtimer = &vcpu_stall_detector->vcpu_hrtimer;
> +
> +	/* Compute the number of ticks required for the stall detector
> +	 * counter register based on the internal clock frequency and the
> +	 * timeout value given from the device tree.
> +	 */
> +	ticks = vcpu_stall_config.clock_freq_hz *
> +		vcpu_stall_config.stall_timeout_sec;
> +	vcpu_stall->pet_event.ticks = cpu_to_virtio32(vcpu_stall_detector->vdev, ticks);
> +
> +	/* Pet the stall detector at half of its expiration timeout
> +	 * to prevent spurious resets.
> +	 */
> +	ping_timeout_ms = vcpu_stall_config.stall_timeout_sec *
> +			  MSEC_PER_SEC / 2;
> +
> +	hrtimer_init(vcpu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	vcpu_hrtimer->function = vcpu_stall_detect_timer_fn;
> +
> +	vcpu_stall->pet_event.is_initialized = true;
> +
> +	spin_lock(&vcpu_stall->lock);
> +	vcpu_stall->pet_event.cpu_id = cpu;
> +	sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
> +	err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
> +	if (!err)
> +		virtqueue_kick(vcpu_stall->vq);
> +
> +	spin_unlock(&vcpu_stall->lock);
> +
> +	hrtimer_start(vcpu_hrtimer, ms_to_ktime(ping_timeout_ms),
> +		      HRTIMER_MODE_REL_PINNED);
> +	return err;
> +}
> +
> +static int stop_stall_detector_cpu(unsigned int cpu)
> +{
> +	int err = 0;
> +	struct scatterlist sg;
> +
> +	struct vcpu_stall_priv *vcpu_stall_detector =
> +		per_cpu_ptr(vcpu_stall_detectors, cpu);
> +
> +	/* Disable the stall detector for the current CPU */
> +	hrtimer_cancel(&vcpu_stall_detector->vcpu_hrtimer);
> +	vcpu_stall->pet_event.is_initialized = false;
> +	vcpu_stall->pet_event.cpu_id = cpu;
> +
> +	spin_lock(&vcpu_stall->lock);
> +	sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
> +	err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
> +	if (!err)
> +		virtqueue_kick(vcpu_stall->vq);
> +
> +	spin_unlock(&vcpu_stall->lock);
> +
> +	return err;
> +}
> +
> +static int vcpu_stall_detect_probe(struct virtio_device *vdev)
> +{
> +	int ret, cpu;
> +	u32 clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
> +	u32 stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;
> +
> +	vcpu_stall = kzalloc(sizeof(struct vcpu_stall), GFP_KERNEL);
> +	if (!vcpu_stall) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	vdev->priv = vcpu_stall;
> +
> +	vcpu_stall->priv = devm_alloc_percpu(&vdev->dev,
> +					typeof(struct vcpu_stall_priv));
> +	if (!vcpu_stall->priv) {
> +		ret = -ENOMEM;
> +		goto failed_priv;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		struct vcpu_stall_priv *priv;
> +
> +		priv = per_cpu_ptr(vcpu_stall->priv, cpu);
> +		priv->vdev = vdev;
> +	}
> +
> +	ret = virtio_cread_feature(vdev, VCPU_STALL_REG_CLOCK_FREQ_HZ,
> +						struct vcpu_stall_detect_config, clock_freq_hz,
> +						&clock_freq_hz);
> +	if (ret || !clock_freq_hz) {
> +		if (!(clock_freq_hz > 0 &&
> +		      clock_freq_hz < VCPU_STALL_MAX_CLOCK_HZ)) {
> +			dev_warn(&vdev->dev, "clk out of range\n");
> +			clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
> +		}
> +	}
> +	ret = virtio_cread_feature(vdev, VCPU_STALL_REG_TIMEOUT_SEC,
> +						struct vcpu_stall_detect_config, stall_timeout_sec,
> +						&stall_timeout_sec);
> +	if (ret || !stall_timeout_sec) {
> +		if (!(stall_timeout_sec > 0 &&
> +		      stall_timeout_sec < VCPU_STALL_MAX_TIMEOUT_SEC)) {
> +			dev_warn(&vdev->dev, "stall timeout out of range\n");
> +			stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;

how does host know what is the range?

> +		}
> +	}
> +
> +	vcpu_stall_config = (struct vcpu_stall_detect_config) {
> +		.clock_freq_hz		= clock_freq_hz,
> +		.stall_timeout_sec	= stall_timeout_sec
> +	};
> +
> +	/* find virtqueue for guest to send pet event to host */
> +	vcpu_stall->vq = virtio_find_single_vq(vdev, NULL, "pet-event");
> +	if (IS_ERR(vcpu_stall->vq)) {
> +		dev_err(&vdev->dev, "failed to find vq\n");
> +		goto failed_priv;
> +	}
> +
> +	spin_lock_init(&vcpu_stall->lock);
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +				"virt/vcpu_stall_detector:online",
> +				start_stall_detector_cpu,
> +				stop_stall_detector_cpu);
> +	if (ret < 0) {
> +		dev_err(&vdev->dev, "failed to install cpu hotplug\n");
> +		goto failed_priv;
> +	}
> +
> +	vcpu_stall_config.hp_online = ret;
> +	return 0;
> +
> +
> +failed_priv:
> +	kfree(vcpu_stall);
> +err:
> +	return ret;
> +}
> +
> +static void vcpu_stall_detect_remove(struct virtio_device *vdev)
> +{
> +	int cpu;
> +
> +	cpuhp_remove_state(vcpu_stall_config.hp_online);
> +
> +	for_each_possible_cpu(cpu)
> +		stop_stall_detector_cpu(cpu);


you are sending a bunch of messages ok but never even
wait for them to be processed. normally there's
need to reset device, destroy vqs ... not necessary here? why?

> +}
> +
> +static unsigned int features_legacy[] = {
> +	VCPU_STALL_REG_STATUS, VCPU_STALL_REG_LOAD_CNT, VCPU_STALL_REG_CURRENT_CNT,
> +	VCPU_STALL_REG_CLOCK_FREQ_HZ, VCPU_STALL_REG_LEN, VCPU_STALL_REG_TIMEOUT_SEC
> +};
> +


this should be a modern only device, no way this needs legacy support.


> +
> +static unsigned int features[] = {
> +	VCPU_STALL_REG_STATUS, VCPU_STALL_REG_LOAD_CNT, VCPU_STALL_REG_CURRENT_CNT,
> +	VCPU_STALL_REG_CLOCK_FREQ_HZ, VCPU_STALL_REG_LEN, VCPU_STALL_REG_TIMEOUT_SEC
> +};
> +
> +static struct virtio_driver vcpu_stall_detect_driver = {
> +	.feature_table	= features,
> +	.feature_table_size = ARRAY_SIZE(features),
> +	.feature_table_legacy	= features_legacy,
> +	.feature_table_size_legacy	= ARRAY_SIZE(features_legacy),
> +	.driver.name	= KBUILD_MODNAME,
> +	.driver.owner	= THIS_MODULE,
> +	.id_table =	vcpu_stall_id_table,
> +	.probe  = vcpu_stall_detect_probe,
> +	.remove = vcpu_stall_detect_remove,
> +};
> +
> +module_virtio_driver(vcpu_stall_detect_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(virtio, vcpu_stall_id_table);
> +MODULE_AUTHOR("zhanghao1 <zhanghao1@kylinos.cn>");
> +MODULE_DESCRIPTION("VCPU stall detector");
> -- 
> 2.25.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus

