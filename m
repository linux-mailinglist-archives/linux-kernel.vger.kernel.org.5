Return-Path: <linux-kernel+bounces-61561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175638513AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C325428153A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96D39FF2;
	Mon, 12 Feb 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UvRXLNYZ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4541EEB3;
	Mon, 12 Feb 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741557; cv=none; b=uP/FzXUF6rt6vAovyPLWlvkLSlJ2d4VX597UBTs2fAmVQAt8gFodkgvqqeAWf96uLtIR5lUuInYOAZmrbH3vd5xFjr4QJF2GUoarm2A1LyMGdBUjyVanNI4eGeW7BQ054zuifAdgGLsqSeISTRgcTW5lsp8cmOPEusQfnxQ32ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741557; c=relaxed/simple;
	bh=+Zeva8y22+g8pFIy4j2jTFH0ichej60kpPdgG0pTir4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m+cFqVdvv/mqy0PeXilo6AiBTtMpJyf0x1Rruhld34yapm1XTIgV3+uGyzArNYt61LOP1FA7tib37bf4K7v7jitUPjoCMYkwrMFObtCGeLai0yiyMBdwwnKxwbIBTe+Qs/v8/VxhNWqCjE730vfljZOPiVonUDjzu+kXppsyj3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UvRXLNYZ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CCd7eL123860;
	Mon, 12 Feb 2024 06:39:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707741547;
	bh=JJjkiBJ2XGuAYcuybq+tQZzwYetMMFlH6u82w7wGMBg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UvRXLNYZFNTJ8is6KH0u2kvgPt7mhJEBj257Q5b6J+LVgnS4cvBPXEkWMpVIctPxa
	 ZztA2c0z8ivsXAm6wVRPaVsqW3v8NvDI08FSf2qxiYTz0kh3qmfM2xtHIo5w6Qvlxh
	 Fgn3W62dugBkPQ3scwRN7O7bl3pCuVdt/RUaPx8w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CCd7ZG008440
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 06:39:07 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 06:39:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 06:39:06 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CCd2sS004302;
	Mon, 12 Feb 2024 06:39:03 -0600
Message-ID: <a5a03084-af27-ce99-4a99-8045ea0d5e87@ti.com>
Date: Mon, 12 Feb 2024 18:09:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] media: chips-media: wave5: Add hrtimer based polling
 support
Content-Language: en-US
To: <nas.chung@chipsnmedia.com>, <jackson.lee@chipsnmedia.com>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>, <b-brnich@ti.com>, <detheridge@ti.com>,
        <p-mantena@ti.com>, <vijayp@ti.com>
References: <20240125130833.1953617-1-devarsht@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240125130833.1953617-1-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Gentle reminder.

On 25/01/24 18:38, Devarsh Thakkar wrote:
> Add support for starting a polling timer in case interrupt is not
> available. This helps keep the VPU functional in SoC's such as AM62A, where
> the hardware interrupt hookup may not be present due to an SoC errata [1].
> 
> The timer is shared across all instances of encoder and decoder and is
> started when first instance of encoder or decoder is opened and stopped
> when last instance is closed, thus avoiding per instance polling and saving
> CPU bandwidth.
> 
> hrtimer callback is called with 5ms polling interval while any of the
> encoder/decoder instances are running to check the interrupt status as
> being done in irq handler.
> 
> Based on above interrupt status, use a worker thread to iterate over the
> interrupt status for each instance and send completion event as being done
> in irq thread function.
> 
> Parse for irq number before v4l2 device registration and if not available
> only then, initialize hrtimer and worker thread.
> 
> Move the core functionality of irq thread function to a separate function
> wave5_vpu_handle_irq so that it can be used by both the worker thread when
> using polling mode and irq thread when using interrupt mode.
> 
> Protect hrtimer access and instance list with device specific mutex locks
> to avoid race conditions while different instances of encoder and decoder
> are started together.
> 
> Add module param to change polling interval for debug purpose.
> 
> [1] https://www.ti.com/lit/pdf/spruj16
> (Ref: Section 4.2.3.3 Resets, Interrupts, and Clocks)
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> Test logs:
> https://gist.github.com/devarsht/613bc8aa66e65814c8374ffb6a4f50fb
> ---
>  .../platform/chips-media/wave5/wave5-helper.c |  16 ++-
>  .../chips-media/wave5/wave5-vpu-dec.c         |  13 +-
>  .../chips-media/wave5/wave5-vpu-enc.c         |  13 +-
>  .../platform/chips-media/wave5/wave5-vpu.c    | 117 ++++++++++++------
>  .../platform/chips-media/wave5/wave5-vpuapi.h |   4 +
>  5 files changed, 122 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> index 8433ecab230c..475b7628964f 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> @@ -52,6 +52,8 @@ int wave5_vpu_release_device(struct file *filp,
>  			     char *name)
>  {
>  	struct vpu_instance *inst = wave5_to_vpu_inst(filp->private_data);
> +	struct vpu_device *dev = inst->dev;
> +	int ret = 0;
>  
>  	v4l2_m2m_ctx_release(inst->v4l2_fh.m2m_ctx);
>  	if (inst->state != VPU_INST_STATE_NONE) {
> @@ -71,8 +73,20 @@ int wave5_vpu_release_device(struct file *filp,
>  	}
>  
>  	wave5_cleanup_instance(inst);
> +	if (dev->irq < 0) {
> +		ret = mutex_lock_interruptible(&dev->dev_lock);
> +		if (ret)
> +			return ret;
>  
> -	return 0;
> +		if (list_empty(&dev->instances)) {
> +			dev_dbg(dev->dev, "Disabling the hrtimer\n");
> +			hrtimer_cancel(&dev->hrtimer);
> +		}
> +
> +		mutex_unlock(&dev->dev_lock);
> +	}
> +
> +	return ret;
>  }
>  
>  int wave5_vpu_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq,
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index ef227af72348..c8624c681fa6 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -1810,7 +1810,6 @@ static int wave5_vpu_open_dec(struct file *filp)
>  	v4l2_fh_add(&inst->v4l2_fh);
>  
>  	INIT_LIST_HEAD(&inst->list);
> -	list_add_tail(&inst->list, &dev->instances);
>  
>  	inst->v4l2_m2m_dev = inst->dev->v4l2_m2m_dec_dev;
>  	inst->v4l2_fh.m2m_ctx =
> @@ -1867,6 +1866,18 @@ static int wave5_vpu_open_dec(struct file *filp)
>  
>  	wave5_vdi_allocate_sram(inst->dev);
>  
> +	ret = mutex_lock_interruptible(&dev->dev_lock);
> +	if (ret)
> +		goto cleanup_inst;
> +
> +	if (dev->irq < 0 && !hrtimer_active(&dev->hrtimer) && list_empty(&dev->instances))
> +		hrtimer_start(&dev->hrtimer, ns_to_ktime(dev->vpu_poll_interval * NSEC_PER_MSEC),
> +			      HRTIMER_MODE_REL_PINNED);
> +
> +	list_add_tail(&inst->list, &dev->instances);
> +
> +	mutex_unlock(&dev->dev_lock);
> +
>  	return 0;
>  
>  cleanup_inst:
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index f29cfa3af94a..9e88424761b6 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -1554,7 +1554,6 @@ static int wave5_vpu_open_enc(struct file *filp)
>  	v4l2_fh_add(&inst->v4l2_fh);
>  
>  	INIT_LIST_HEAD(&inst->list);
> -	list_add_tail(&inst->list, &dev->instances);
>  
>  	inst->v4l2_m2m_dev = inst->dev->v4l2_m2m_enc_dev;
>  	inst->v4l2_fh.m2m_ctx =
> @@ -1729,6 +1728,18 @@ static int wave5_vpu_open_enc(struct file *filp)
>  
>  	wave5_vdi_allocate_sram(inst->dev);
>  
> +	ret = mutex_lock_interruptible(&dev->dev_lock);
> +	if (ret)
> +		goto cleanup_inst;
> +
> +	if (dev->irq < 0 && !hrtimer_active(&dev->hrtimer) && list_empty(&dev->instances))
> +		hrtimer_start(&dev->hrtimer, ns_to_ktime(dev->vpu_poll_interval * NSEC_PER_MSEC),
> +			      HRTIMER_MODE_REL_PINNED);
> +
> +	list_add_tail(&inst->list, &dev->instances);
> +
> +	mutex_unlock(&dev->dev_lock);
> +
>  	return 0;
>  
>  cleanup_inst:
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> index bfe4caa79cc9..968ec9baf1ef 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> @@ -26,6 +26,9 @@ struct wave5_match_data {
>  	const char *fw_name;
>  };
>  
> +static int vpu_poll_interval = 5;
> +module_param(vpu_poll_interval, int, 0644);
> +
>  int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout)
>  {
>  	int ret;
> @@ -40,7 +43,7 @@ int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout)
>  	return 0;
>  }
>  
> -static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
> +static void wave5_vpu_handle_irq(void *dev_id)
>  {
>  	u32 seq_done;
>  	u32 cmd_done;
> @@ -48,42 +51,67 @@ static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
>  	struct vpu_instance *inst;
>  	struct vpu_device *dev = dev_id;
>  
> -	if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS)) {
> -		irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
> -		wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
> -		wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
> -
> -		list_for_each_entry(inst, &dev->instances, list) {
> -			seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
> -			cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
> -
> -			if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
> -			    irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
> -				if (seq_done & BIT(inst->id)) {
> -					seq_done &= ~BIT(inst->id);
> -					wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO,
> -								 seq_done);
> -					complete(&inst->irq_done);
> -				}
> +	irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
> +	wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
> +	wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
> +
> +	list_for_each_entry(inst, &dev->instances, list) {
> +		seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
> +		cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
> +
> +		if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
> +		    irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
> +			if (seq_done & BIT(inst->id)) {
> +				seq_done &= ~BIT(inst->id);
> +				wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO,
> +							 seq_done);
> +				complete(&inst->irq_done);
>  			}
> +		}
>  
> -			if (irq_reason & BIT(INT_WAVE5_DEC_PIC) ||
> -			    irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
> -				if (cmd_done & BIT(inst->id)) {
> -					cmd_done &= ~BIT(inst->id);
> -					wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
> -								 cmd_done);
> -					inst->ops->finish_process(inst);
> -				}
> +		if (irq_reason & BIT(INT_WAVE5_DEC_PIC) ||
> +		    irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
> +			if (cmd_done & BIT(inst->id)) {
> +				cmd_done &= ~BIT(inst->id);
> +				wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
> +							 cmd_done);
> +				inst->ops->finish_process(inst);
>  			}
> -
> -			wave5_vpu_clear_interrupt(inst, irq_reason);
>  		}
> +
> +		wave5_vpu_clear_interrupt(inst, irq_reason);
>  	}
> +}
> +
> +static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
> +{
> +	struct vpu_device *dev = dev_id;
> +
> +	if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS))
> +		wave5_vpu_handle_irq(dev);
>  
>  	return IRQ_HANDLED;
>  }
>  
> +static void wave5_vpu_irq_work_fn(struct kthread_work *work)
> +{
> +	struct vpu_device *dev = container_of(work, struct vpu_device, work);
> +
> +	if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS))
> +		wave5_vpu_handle_irq(dev);
> +}
> +
> +static enum hrtimer_restart wave5_vpu_timer_callback(struct hrtimer *timer)
> +{
> +	struct vpu_device *dev =
> +			container_of(timer, struct vpu_device, hrtimer);
> +
> +	kthread_queue_work(dev->worker, &dev->work);
> +	hrtimer_forward_now(timer, ns_to_ktime(vpu_poll_interval * NSEC_PER_MSEC));
> +
> +	return HRTIMER_RESTART;
> +}
> +
>  static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name,
>  				   u32 *revision)
>  {
> @@ -209,16 +237,24 @@ static int wave5_vpu_probe(struct platform_device *pdev)
>  
>  	dev->irq = platform_get_irq(pdev, 0);
>  	if (dev->irq < 0) {
> -		dev_err(&pdev->dev, "failed to get irq resource\n");
> -		ret = -ENXIO;
> -		goto err_enc_unreg;
> -	}
> -
> -	ret = devm_request_threaded_irq(&pdev->dev, dev->irq, NULL,
> -					wave5_vpu_irq_thread, IRQF_ONESHOT, "vpu_irq", dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n", ret);
> -		goto err_enc_unreg;
> +		dev_err(&pdev->dev, "failed to get irq resource, falling back to polling\n");
> +		hrtimer_init(&dev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
> +		dev->hrtimer.function = &wave5_vpu_timer_callback;
> +		dev->worker = kthread_create_worker(0, "vpu_irq_thread");
> +		if (IS_ERR(dev->worker)) {
> +			dev_err(&pdev->dev, "failed to create vpu irq worker\n");
> +			ret = PTR_ERR(dev->worker);
> +			goto err_vdi_release;
> +		}
> +		dev->vpu_poll_interval = vpu_poll_interval;
> +		kthread_init_work(&dev->work, wave5_vpu_irq_work_fn);
> +	} else {
> +		ret = devm_request_threaded_irq(&pdev->dev, dev->irq, NULL,
> +						wave5_vpu_irq_thread, IRQF_ONESHOT, "vpu_irq", dev);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n", ret);
> +			goto err_enc_unreg;
> +		}
>  	}
>  
>  	ret = wave5_vpu_load_firmware(&pdev->dev, match_data->fw_name, &fw_revision);
> @@ -254,6 +290,11 @@ static int wave5_vpu_remove(struct platform_device *pdev)
>  {
>  	struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
>  
> +	if (dev->irq < 0) {
> +		kthread_destroy_worker(dev->worker);
> +		hrtimer_cancel(&dev->hrtimer);
> +	}
> +
>  	mutex_destroy(&dev->dev_lock);
>  	mutex_destroy(&dev->hw_lock);
>  	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> index 352f6e904e50..edc50450ddb8 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> @@ -756,6 +756,10 @@ struct vpu_device {
>  	u32 product_code;
>  	struct ida inst_ida;
>  	struct clk_bulk_data *clks;
> +	struct hrtimer hrtimer;
> +	struct kthread_work work;
> +	struct kthread_worker *worker;
> +	int vpu_poll_interval;
>  	int num_clks;
>  };
>  

