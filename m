Return-Path: <linux-kernel+bounces-85330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D513086B456
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9581F294AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0198F15D5BF;
	Wed, 28 Feb 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SMcRtFUE"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2B15D5CF;
	Wed, 28 Feb 2024 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136704; cv=none; b=EbDokWhHzg2mlbyn3O90exy143wQCxlZeK2sSlZdZcE90D1q9pPPOumr6Kv4ybmLDM6hswUJg1mnpk0+PyxVJ8Am0Jgnbyv0NSM5SQwqw4luRaHJmMkcTSC1Sd7JhkHgj4vqYtnt0CRyaLpKM+nKClXxtJKsRNNBjbOrnPY5rRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136704; c=relaxed/simple;
	bh=uZtchHODXCQN3Si10QreO1w89x0vL5gxc+wdMUgE0FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sH19Qjq/eZj5i5C5DzrDy+sBPrqoL3FqfjmniG8pCD1UwdmWSnYgVNVOcmxHjO+2XxOjz9IqRj7/vP+tG183NajIcOgF8BpxCWOzlLOWpu6CFL5vWZRPe+flzb5MJ0bFYWxdlgNJEfrX7YHJkJUP2RHT7HQGHEzrf/8b/BOd+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SMcRtFUE; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SGBTMr002650;
	Wed, 28 Feb 2024 10:11:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709136689;
	bh=Yrh2hy390eiITmCpnvZoqdlvMfi+N3RptrtIySAEIcA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SMcRtFUE/TcPq28m4uKHESobtoSJuEW9Jz1m7ItOkpMqlTlLNpRqC4VSWqUhwZT+O
	 Il7uLimvA3eTJ0IUHZq60OOQshJw9DWh0j8IqRD4vPuRt3CqDi6mtphTz+iOu+uLBM
	 9iQuZiKRpVTJ4uNpxPv9K3WHMvclsMSXzAI4K+Hw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SGBTxp018625
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Feb 2024 10:11:29 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 10:11:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 10:11:28 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SGBNTO100309;
	Wed, 28 Feb 2024 10:11:24 -0600
Message-ID: <367daea8-9412-757a-0ea1-e304249528a0@ti.com>
Date: Wed, 28 Feb 2024 21:41:23 +0530
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
To: Andrew Davis <afd@ti.com>,
        Sebastian Fricke
	<sebastian.fricke@collabora.com>
CC: <nas.chung@chipsnmedia.com>, <jackson.lee@chipsnmedia.com>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>
References: <20240125130833.1953617-1-devarsht@ti.com>
 <20240216094514.lm4naivfrbiexotl@basti-XPS-13-9310>
 <0d30d2ad-e0af-44ca-a6e7-5dafafe1b82d@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <0d30d2ad-e0af-44ca-a6e7-5dafafe1b82d@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

Thanks for the review.

On 22/02/24 21:41, Andrew Davis wrote:
> On 2/16/24 3:45 AM, Sebastian Fricke wrote:
>> Hey Devarsh,
>>
>> @nas.chung@chipsnmedia.com or @jackson.lee@chipsnmedia.com
>> Could you please run tests on the hardware with this patch and review
>> this patch to make sure that this doesn't break the other hardware with
>> Wave5 chips. Thanks!
>>
>> On 25.01.2024 18:38, Devarsh Thakkar wrote:
>>> Add support for starting a polling timer in case interrupt is not
>>
>> s/interrupt/an interrupt/
>>
>>> available. This helps keep the VPU functional in SoC's such as AM62A, where
>>
>> s/helps keep/helps to keep/
>> s/SoC's/SoCs/
>>
>>> the hardware interrupt hookup may not be present due to an SoC errata [1].
>>
>> I would prefer if we do not hack the driver to adjust to SoC errata,
>> instead of adding polling functionality you could also implement a fake
>> IRQ chip, then the driver can still assume that an interrupt is present
>> and you create a virtual interrupt source that does polling in the
>> background.
>> You could start by adding the fake irq-chip within the wave5 folder and
>> later on that could be moved to the `drivers/irqchip/` directory (by you
>> or someone else), which would be a nice addition to the Linux kernel to
>> provide machines without IRQ support a way to register an interrupt.
> 
> +1
> 
> I'm really surprised that isn't already a thing. A lot of drivers do
> hacky irq+polling to work around missing status update interrupts.
> It seems to lead to race conditions and generally messy to follow code
> in most cases. A simple generic "fire an inteterrupt every X time units"
> virtual interrupt source would cleanup a lot of these.
> 
> Andrew
> 

Well at least for the video codec type of scenarios where multiple instances
of encode & decode can run together and we require to achieve balance between
optimum CPU utilization, real-time performance and latencies we require an
intelligent polling based scheme as implemented in this patchset and I don't
think the fakeirq approach would help to replicate an optimum solution given
all the meta-data related to instance handling and polling interval is present
in video codec driver.

I already shared a good amount of reasoning here [0], but to summarize in
general the scheme we want to follow (and also the scheme which this patchset
implements) is to have a single polling thread for all instances of encoder
and decoder so as to keep the CPU utilization in check while achieving
real-time latencies and performance as seen in the results [1].

For e.g. we only need to start polling when first instance gets launched from
user-space and this information is known only to VPU driver so it would still
need to signal to irq chip (possibly using irq_enable hook) to start polling
on first instance launch.

And again we need to stop polling when last instance gets closed, now here
again driver only knows when the last VPU instance gets closed so the VPU
driver would need to signal to irqchip again to stop polling.

And all these handling requires locking related handling too as multiple
instances can be launched anytime and of any type (either for encoder and
decoder) and this logic would again fall in VPU driver.

Secondly it makes more sense to keep VPU polling interval param inside the VPU
driver rather than fakeirq driver (which would ideally be agnostic to VPU and
handling other peripherals too) as user may want to change it to a different
value than defaults if they have a preference to a subset of fixed use-cases
or want to give more preference to CPU utilizations over Performance/latency
or vice-versa.

Also if we look at it from another angle in some scenario the polling scheme
may offer some advantage over the irq too if system is already under high
interrupt load. For e.g let's say we want to run a 32 instance use-case for a
non real-time processing of video. Now with the polling scheme implemented
here, there would be a single polling thread which would trigger a softirq
every X ms as compare to 32 interrupts being fired per frame for each instance
when irq is being used, and if the system is already running under heavy
interrupt load than it may make more sense to switch to polling if the
use-case doesn't demand aggressive latencies (as with polling VPU latencies
would be slightly higher but that's okay for non real-time video processing
scenarios ). So I think polling feature implemented may not be completely
use-less in general too for SoC's where VPU irq is present.

[0] :
https://lore.kernel.org/all/47fe5d24-4331-a88c-5481-d60a3ae96efa@ti.com/

[1] :
1x 640x480@25 Encoding :
https://gist.github.com/devarsht/ee9664d3403d1212ef477a027b71896c

4x 1080p30 Transcode (File→decode→encode→file).csv irq vs polling comparison :
https://gist.github.com/devarsht/3a58b4f201430dfc61697c7e224e74c2

1x 1080p transcode (File→decode→encode→file) polling_vs_irq_transcode
comparison :
https://gist.github.com/devarsht/a6480f1f2cbdf8dd694d698309d81fb0

1080p60 streaming use-case for irq vs polling comparison
https://gist.github.com/devarsht/44aaa4322454e85e01a8d65ac47c5edb

Regards
Devarsh

>> Please have a look at that potential solution, you potentially need to
>> share the registers between the codec and the fake irq-chip in the DTS.
>>
>>>
>>> The timer is shared across all instances of encoder and decoder and is
>>
>> s/encoder and decoder/encoders and decoders/
>>
>>> started when first instance of encoder or decoder is opened and stopped
>>
>> s/first/the first/
>> s/encoder or decoder/an encoder or a decoder/
>>
>>> when last instance is closed, thus avoiding per instance polling and saving
>>
>> s/last/the last/
>>
>>> CPU bandwidth.
>>>
>>> hrtimer callback is called with 5ms polling interval while any of the
>>
>> s/hrtimer/The hrtimer/
>>
>>> encoder/decoder instances are running to check the interrupt status as
>>> being done in irq handler.
>>
>> s/irq/the irq/
>>
>> Could you ellaborate why you choose the HRtimer for this job and why
>> does it need to be a 5ms polling interval, is that a requirement of this
>> specific hardware or the best constant you figured out during testing?
>>
>>>
>>> Based on above interrupt status, use a worker thread to iterate over the
>>
>> s/on above interrupt status/on the interrupt status above/
>>
>>> interrupt status for each instance and send completion event as being done
>>
>> s/completion/a completion/
>>
>>> in irq thread function.
>>
>> s/irq/the irq/
>>
>>>
>>> Parse for irq number before v4l2 device registration and if not available
>>> only then, initialize hrtimer and worker thread.
>>
>> Thanks for the effort on the description but you do not have to write
>> out word for word what the code is doing, the code should be descriptive
>> enough on its own.
>> More important is that you clearly describe, for example:
>> - why did you choose a certain design?
>> - why did you choose for the HRtimer?
>> - why is the 5ms interval is important (are other intervals also valid?)
>> - why did you choose to add a polling mechanism instead of possible
>> alternatives (like for example an fake irq-chip),
>> -
>>>
>>> Move the core functionality of irq thread function to a separate function
>>
>> s/irq/the irq/
>>
>>> wave5_vpu_handle_irq so that it can be used by both the worker thread when
>>> using polling mode and irq thread when using interrupt mode.
>>
>> s/irq/the irq/
>>
>>>
>>> Protect hrtimer access and instance list with device specific mutex locks
>>
>> s/hrtimer/the hrtimer/
>>
>>> to avoid race conditions while different instances of encoder and decoder
>>
>> s/encoder and decoder/encoders and decoders/
>>
>>> are started together.
>>>
>>> Add module param to change polling interval for debug purpose.
>>
>> s/module/a module/
>> s/polling/the polling/
>> s/debug purpose/debugging purposes/
>>
>> Here again is the question, what can the user expect with different
>> polling intervals? Is there a valid range of intervals?
>>
>> The actual implementation seems good, but I would like to first make
>> sure that we take the best possible approach to this issue.
>>
>> Greetings,
>> Sebastian
>>
>>>
>>> [1] https://www.ti.com/lit/pdf/spruj16
>>> (Ref: Section 4.2.3.3 Resets, Interrupts, and Clocks)
>>>
>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>> ---
>>> Test logs:
>>> https://gist.github.com/devarsht/613bc8aa66e65814c8374ffb6a4f50fb
>>> ---
>>> .../platform/chips-media/wave5/wave5-helper.c |  16 ++-
>>> .../chips-media/wave5/wave5-vpu-dec.c         |  13 +-
>>> .../chips-media/wave5/wave5-vpu-enc.c         |  13 +-
>>> .../platform/chips-media/wave5/wave5-vpu.c    | 117 ++++++++++++------
>>> .../platform/chips-media/wave5/wave5-vpuapi.h |   4 +
>>> 5 files changed, 122 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>>> b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>>> index 8433ecab230c..475b7628964f 100644
>>> --- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>>> +++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>>> @@ -52,6 +52,8 @@ int wave5_vpu_release_device(struct file *filp,
>>>                  char *name)
>>> {
>>>     struct vpu_instance *inst = wave5_to_vpu_inst(filp->private_data);
>>> +    struct vpu_device *dev = inst->dev;
>>> +    int ret = 0;
>>>
>>>     v4l2_m2m_ctx_release(inst->v4l2_fh.m2m_ctx);
>>>     if (inst->state != VPU_INST_STATE_NONE) {
>>> @@ -71,8 +73,20 @@ int wave5_vpu_release_device(struct file *filp,
>>>     }
>>>
>>>     wave5_cleanup_instance(inst);
>>> +    if (dev->irq < 0) {
>>> +        ret = mutex_lock_interruptible(&dev->dev_lock);
>>> +        if (ret)
>>> +            return ret;
>>>
>>> -    return 0;
>>> +        if (list_empty(&dev->instances)) {
>>> +            dev_dbg(dev->dev, "Disabling the hrtimer\n");
>>> +            hrtimer_cancel(&dev->hrtimer);
>>> +        }
>>> +
>>> +        mutex_unlock(&dev->dev_lock);
>>> +    }
>>> +
>>> +    return ret;
>>> }
>>>
>>> int wave5_vpu_queue_init(void *priv, struct vb2_queue *src_vq, struct
>>> vb2_queue *dst_vq,
>>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>>> b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>>> index ef227af72348..c8624c681fa6 100644
>>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>>> @@ -1810,7 +1810,6 @@ static int wave5_vpu_open_dec(struct file *filp)
>>>     v4l2_fh_add(&inst->v4l2_fh);
>>>
>>>     INIT_LIST_HEAD(&inst->list);
>>> -    list_add_tail(&inst->list, &dev->instances);
>>>
>>>     inst->v4l2_m2m_dev = inst->dev->v4l2_m2m_dec_dev;
>>>     inst->v4l2_fh.m2m_ctx =
>>> @@ -1867,6 +1866,18 @@ static int wave5_vpu_open_dec(struct file *filp)
>>>
>>>     wave5_vdi_allocate_sram(inst->dev);
>>>
>>> +    ret = mutex_lock_interruptible(&dev->dev_lock);
>>> +    if (ret)
>>> +        goto cleanup_inst;
>>> +
>>> +    if (dev->irq < 0 && !hrtimer_active(&dev->hrtimer) &&
>>> list_empty(&dev->instances))
>>> +        hrtimer_start(&dev->hrtimer, ns_to_ktime(dev->vpu_poll_interval *
>>> NSEC_PER_MSEC),
>>> +                  HRTIMER_MODE_REL_PINNED);
>>> +
>>> +    list_add_tail(&inst->list, &dev->instances);
>>> +
>>> +    mutex_unlock(&dev->dev_lock);
>>> +
>>>     return 0;
>>>
>>> cleanup_inst:
>>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>>> b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>>> index f29cfa3af94a..9e88424761b6 100644
>>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>>> @@ -1554,7 +1554,6 @@ static int wave5_vpu_open_enc(struct file *filp)
>>>     v4l2_fh_add(&inst->v4l2_fh);
>>>
>>>     INIT_LIST_HEAD(&inst->list);
>>> -    list_add_tail(&inst->list, &dev->instances);
>>>
>>>     inst->v4l2_m2m_dev = inst->dev->v4l2_m2m_enc_dev;
>>>     inst->v4l2_fh.m2m_ctx =
>>> @@ -1729,6 +1728,18 @@ static int wave5_vpu_open_enc(struct file *filp)
>>>
>>>     wave5_vdi_allocate_sram(inst->dev);
>>>
>>> +    ret = mutex_lock_interruptible(&dev->dev_lock);
>>> +    if (ret)
>>> +        goto cleanup_inst;
>>> +
>>> +    if (dev->irq < 0 && !hrtimer_active(&dev->hrtimer) &&
>>> list_empty(&dev->instances))
>>> +        hrtimer_start(&dev->hrtimer, ns_to_ktime(dev->vpu_poll_interval *
>>> NSEC_PER_MSEC),
>>> +                  HRTIMER_MODE_REL_PINNED);
>>> +
>>> +    list_add_tail(&inst->list, &dev->instances);
>>> +
>>> +    mutex_unlock(&dev->dev_lock);
>>> +
>>>     return 0;
>>>
>>> cleanup_inst:
>>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>>> b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>>> index bfe4caa79cc9..968ec9baf1ef 100644
>>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>>> @@ -26,6 +26,9 @@ struct wave5_match_data {
>>>     const char *fw_name;
>>> };
>>>
>>> +static int vpu_poll_interval = 5;
>>> +module_param(vpu_poll_interval, int, 0644);
>>> +
>>> int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout)
>>> {
>>>     int ret;
>>> @@ -40,7 +43,7 @@ int wave5_vpu_wait_interrupt(struct vpu_instance *inst,
>>> unsigned int timeout)
>>>     return 0;
>>> }
>>>
>>> -static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
>>> +static void wave5_vpu_handle_irq(void *dev_id)
>>> {
>>>     u32 seq_done;
>>>     u32 cmd_done;
>>> @@ -48,42 +51,67 @@ static irqreturn_t wave5_vpu_irq_thread(int irq, void
>>> *dev_id)
>>>     struct vpu_instance *inst;
>>>     struct vpu_device *dev = dev_id;
>>>
>>> -    if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS)) {
>>> -        irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
>>> -        wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
>>> -        wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
>>> -
>>> -        list_for_each_entry(inst, &dev->instances, list) {
>>> -            seq_done = wave5_vdi_read_register(dev,
>>> W5_RET_SEQ_DONE_INSTANCE_INFO);
>>> -            cmd_done = wave5_vdi_read_register(dev,
>>> W5_RET_QUEUE_CMD_DONE_INST);
>>> -
>>> -            if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
>>> -                irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
>>> -                if (seq_done & BIT(inst->id)) {
>>> -                    seq_done &= ~BIT(inst->id);
>>> -                    wave5_vdi_write_register(dev,
>>> W5_RET_SEQ_DONE_INSTANCE_INFO,
>>> -                                 seq_done);
>>> -                    complete(&inst->irq_done);
>>> -                }
>>> +    irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
>>> +    wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
>>> +    wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
>>> +
>>> +    list_for_each_entry(inst, &dev->instances, list) {
>>> +        seq_done = wave5_vdi_read_register(dev,
>>> W5_RET_SEQ_DONE_INSTANCE_INFO);
>>> +        cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
>>> +
>>> +        if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
>>> +            irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
>>> +            if (seq_done & BIT(inst->id)) {
>>> +                seq_done &= ~BIT(inst->id);
>>> +                wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO,
>>> +                             seq_done);
>>> +                complete(&inst->irq_done);
>>>             }
>>> +        }
>>>
>>> -            if (irq_reason & BIT(INT_WAVE5_DEC_PIC) ||
>>> -                irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
>>> -                if (cmd_done & BIT(inst->id)) {
>>> -                    cmd_done &= ~BIT(inst->id);
>>> -                    wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
>>> -                                 cmd_done);
>>> -                    inst->ops->finish_process(inst);
>>> -                }
>>> +        if (irq_reason & BIT(INT_WAVE5_DEC_PIC) ||
>>> +            irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
>>> +            if (cmd_done & BIT(inst->id)) {
>>> +                cmd_done &= ~BIT(inst->id);
>>> +                wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
>>> +                             cmd_done);
>>> +                inst->ops->finish_process(inst);
>>>             }
>>> -
>>> -            wave5_vpu_clear_interrupt(inst, irq_reason);
>>>         }
>>> +
>>> +        wave5_vpu_clear_interrupt(inst, irq_reason);
>>>     }
>>> +}
>>> +
>>> +static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
>>> +{
>>> +    struct vpu_device *dev = dev_id;
>>> +
>>> +    if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS))
>>> +        wave5_vpu_handle_irq(dev);
>>>
>>>     return IRQ_HANDLED;
>>> }
>>>
>>> +static void wave5_vpu_irq_work_fn(struct kthread_work *work)
>>> +{
>>> +    struct vpu_device *dev = container_of(work, struct vpu_device, work);
>>> +
>>> +    if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS))
>>> +        wave5_vpu_handle_irq(dev);
>>> +}
>>> +
>>> +static enum hrtimer_restart wave5_vpu_timer_callback(struct hrtimer *timer)
>>> +{
>>> +    struct vpu_device *dev =
>>> +            container_of(timer, struct vpu_device, hrtimer);
>>> +
>>> +    kthread_queue_work(dev->worker, &dev->work);
>>> +    hrtimer_forward_now(timer, ns_to_ktime(vpu_poll_interval *
>>> NSEC_PER_MSEC));
>>> +
>>> +    return HRTIMER_RESTART;
>>> +}
>>> +
>>> static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name,
>>>                    u32 *revision)
>>> {
>>> @@ -209,16 +237,24 @@ static int wave5_vpu_probe(struct platform_device *pdev)
>>>
>>>     dev->irq = platform_get_irq(pdev, 0);
>>>     if (dev->irq < 0) {
>>> -        dev_err(&pdev->dev, "failed to get irq resource\n");
>>> -        ret = -ENXIO;
>>> -        goto err_enc_unreg;
>>> -    }
>>> -
>>> -    ret = devm_request_threaded_irq(&pdev->dev, dev->irq, NULL,
>>> -                    wave5_vpu_irq_thread, IRQF_ONESHOT, "vpu_irq", dev);
>>> -    if (ret) {
>>> -        dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n", ret);
>>> -        goto err_enc_unreg;
>>> +        dev_err(&pdev->dev, "failed to get irq resource, falling back to
>>> polling\n");
>>> +        hrtimer_init(&dev->hrtimer, CLOCK_MONOTONIC,
>>> HRTIMER_MODE_REL_PINNED);
>>> +        dev->hrtimer.function = &wave5_vpu_timer_callback;
>>> +        dev->worker = kthread_create_worker(0, "vpu_irq_thread");
>>> +        if (IS_ERR(dev->worker)) {
>>> +            dev_err(&pdev->dev, "failed to create vpu irq worker\n");
>>> +            ret = PTR_ERR(dev->worker);
>>> +            goto err_vdi_release;
>>> +        }
>>> +        dev->vpu_poll_interval = vpu_poll_interval;
>>> +        kthread_init_work(&dev->work, wave5_vpu_irq_work_fn);
>>> +    } else {
>>> +        ret = devm_request_threaded_irq(&pdev->dev, dev->irq, NULL,
>>> +                        wave5_vpu_irq_thread, IRQF_ONESHOT, "vpu_irq", dev);
>>> +        if (ret) {
>>> +            dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n",
>>> ret);
>>> +            goto err_enc_unreg;
>>> +        }
>>>     }
>>>
>>>     ret = wave5_vpu_load_firmware(&pdev->dev, match_data->fw_name,
>>> &fw_revision);
>>> @@ -254,6 +290,11 @@ static int wave5_vpu_remove(struct platform_device *pdev)
>>> {
>>>     struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
>>>
>>> +    if (dev->irq < 0) {
>>> +        kthread_destroy_worker(dev->worker);
>>> +        hrtimer_cancel(&dev->hrtimer);
>>> +    }
>>> +
>>>     mutex_destroy(&dev->dev_lock);
>>>     mutex_destroy(&dev->hw_lock);
>>>     clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
>>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>>> b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>>> index 352f6e904e50..edc50450ddb8 100644
>>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>>> @@ -756,6 +756,10 @@ struct vpu_device {
>>>     u32 product_code;
>>>     struct ida inst_ida;
>>>     struct clk_bulk_data *clks;
>>> +    struct hrtimer hrtimer;
>>> +    struct kthread_work work;
>>> +    struct kthread_worker *worker;
>>> +    int vpu_poll_interval;
>>>     int num_clks;
>>> };
>>>
>>> -- 
>>> 2.34.1
>>>
>>>
>>

