Return-Path: <linux-kernel+bounces-76780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6547885FC79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A821C23B60
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0E41482F7;
	Thu, 22 Feb 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TqaFtIBz"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3A14D42B;
	Thu, 22 Feb 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616027; cv=none; b=PtP5dqWL3HHW96ywuVrn4o3x2HrvdtyHKF2/bugYzLrkcq0EIq/RufA9FNGlAneE8BBqpFloYGoisQ1FCTpW2iE08UyFzUS7J6mE9Bq9YA6vTlvEB6FzUUd6KSJVyQi5aBVjDyvqNMDgpEDi0mVX4B25tF9Hrun454lY7vKDvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616027; c=relaxed/simple;
	bh=d9BioIvmY4/WcJeQIM806KlJiZfLRaQN/+7P3VF/KAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pps3tW/8nWQFp7ZTRcKK9Dv4whouSxDLbk7GpLgiRlDjKQ19HR3cZV78SPTZHDe4tAdfannnzEdSHBHFCnsPBWI8d64p4CGhqv9Gw/6ZyYRftFRZ/CeZ7w9eJ3o5WwC+0EIeFCbSdGjvLE1eo04UJQk/JawP6DQXgGiR1h+9Wgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TqaFtIBz; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MFXBTm092430;
	Thu, 22 Feb 2024 09:33:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708615991;
	bh=IVORbzBRnk3vC1u6yEyJTmEonLOHw51BELoXhyQiSYw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TqaFtIBzhBUKkWqDhS7sL2mxFvtxMDk9wME9aMWWnb82rC3Nkpgoe/2gfk5cw8Fd3
	 wn+ugjvOFUSoVqFcytC6SM0hRXbhGUGkanGQuU/9I2i9NnqzyPxpalA5U0Gy5vDHXl
	 dH4OCKZ2b4Gno8mf0BeaAM3O8T0JkKgADDz3TvDE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MFXBRs012821
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 09:33:11 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 09:33:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 09:33:11 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MFX6v7076173;
	Thu, 22 Feb 2024 09:33:07 -0600
Message-ID: <47fe5d24-4331-a88c-5481-d60a3ae96efa@ti.com>
Date: Thu, 22 Feb 2024 21:03:06 +0530
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
To: Sebastian Fricke <sebastian.fricke@collabora.com>
CC: <nas.chung@chipsnmedia.com>, <jackson.lee@chipsnmedia.com>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>
References: <20240125130833.1953617-1-devarsht@ti.com>
 <20240216094514.lm4naivfrbiexotl@basti-XPS-13-9310>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240216094514.lm4naivfrbiexotl@basti-XPS-13-9310>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Sebastian,

Thanks for the review.

On 16/02/24 15:15, Sebastian Fricke wrote:
> Hey Devarsh,
> 
> @nas.chung@chipsnmedia.com or @jackson.lee@chipsnmedia.com
> Could you please run tests on the hardware with this patch and review
> this patch to make sure that this doesn't break the other hardware with
> Wave5 chips. Thanks!
> 

Yes, I think Jackson verified it and provided a Tested-By, at my end too I had
tested different scenarios on different platforms, I can attach some test logs
too in cover-letter in V2. Also we have been using a version of this patch in
our local SDK for over a year, running different kind of tests (multistream,
file based e.t.c) so it pretty much looks stable to me.

> On 25.01.2024 18:38, Devarsh Thakkar wrote:
>> Add support for starting a polling timer in case interrupt is not
> 
> s/interrupt/an interrupt/
> 
>> available. This helps keep the VPU functional in SoC's such as AM62A, where
> 
> s/helps keep/helps to keep/
> s/SoC's/SoCs/
> 
>> the hardware interrupt hookup may not be present due to an SoC errata [1].
> 
> I would prefer if we do not hack the driver to adjust to SoC errata,
> instead of adding polling functionality you could also implement a fake
> IRQ chip, then the driver can still assume that an interrupt is present
> and you create a virtual interrupt source that does polling in the
> background.
> You could start by adding the fake irq-chip within the wave5 folder and
> later on that could be moved to the `drivers/irqchip/` directory (by you
> or someone else), which would be a nice addition to the Linux kernel to
> provide machines without IRQ support a way to register an interrupt.
> Please have a look at that potential solution, you potentially need to
> share the registers between the codec and the fake irq-chip in the DTS.
> 

[0] Thanks for the inputs, I tried to have a look at fakeirq approach after
you suggested.

Just a quick recap, as we want to avoid per instance hrtimer threads to save
on CPU, we are running a single hrtimer polling thread across all VPU
instances by starting it once first instance is opened and disabling it when
last instance is closed

Now as I understand with fakeirq irqchip driver we can emulate and trigger an
interrupt every Xms (by running an hrtimer underneath) but we would probably
still need some hooks in CnM driver similar to and in place of what we have in
current hrtimer based implementation as fakeirq driver is unaware of VPU
context, For e.g. we need to signal the fakeirq to start the hrtimer when
first instance is opened (probably by calling irq_enable) and disable the
hrtimer when last instance is closed.

Also I am not sure it would be good (and legal) to keep polling interval
module param in irqchip driver.

Secondly, the current hrtimer based implementation looks compact to me in the
sense that code-paths are non-intrusive w.r.t irq flow and we have the ISR
specific code refactored into a common function to be used by both flows to
avoid duplication. Also with CnM VPU already capable of running without irq
support as reflected in dt-bindings I don't see it totally illegal to keep
hrtimer polling support in driver as such.

Furthermore, I do see some driver(s) switching to hrtimer when irq is not
present [1] as shown in below link :

https://elixir.bootlin.com/linux/v6.7.5/source/drivers/usb/typec/tipd/core.c#L1299

>>
>> The timer is shared across all instances of encoder and decoder and is
> 
> s/encoder and decoder/encoders and decoders/
> 
>> started when first instance of encoder or decoder is opened and stopped
> 
> s/first/the first/
> s/encoder or decoder/an encoder or a decoder/
> 
>> when last instance is closed, thus avoiding per instance polling and saving
> 
> s/last/the last/
> 
>> CPU bandwidth.
>>
>> hrtimer callback is called with 5ms polling interval while any of the
> 
> s/hrtimer/The hrtimer/
> 
>> encoder/decoder instances are running to check the interrupt status as
>> being done in irq handler.
> 
> s/irq/the irq/
> 
> Could you ellaborate why you choose the HRtimer for this job and why
> does it need to be a 5ms polling interval, is that a requirement of this
> specific hardware or the best constant you figured out during testing?
> >>
>> Based on above interrupt status, use a worker thread to iterate over the
> 
> s/on above interrupt status/on the interrupt status above/
> 
>> interrupt status for each instance and send completion event as being done
> 
> s/completion/a completion/
> 
>> in irq thread function.
> 
> s/irq/the irq/
> 
>>
>> Parse for irq number before v4l2 device registration and if not available
>> only then, initialize hrtimer and worker thread.
> 
> Thanks for the effort on the description but you do not have to write
> out word for word what the code is doing, the code should be descriptive
> enough on its own.

Yeah, will update it in v2.

> More important is that you clearly describe, for example:
> - why did you choose a certain design?> - why did you choose for the HRtimer?> - why is the 5ms interval is
important (are other intervals also valid?)

hrtimer was mainly chosen as it provides precise timing and scheduling and the
API seems better suited for periodic polling task such as this.
Yes other intervals are also valid. The trade-off is mainly between CPU usage
and the latency.

As a general rule of thumb,

Worst case latency with hrtimer =  Actual latency (which was possible with
irq)  + Polling interval

NOTE:
Latency: Time taken to process one frame by VPU)
Actual Latency : Time taken by hardware to process frame and the time when it
would have triggerd irq if it was present

With aggressive polling intervals (i.e. going with even lesser values) the CPU
usage increases although worst case latencies get better.

The 5ms offered a good balance between the two as we were able to reach close
to actual latencies without incurring too much of CPU as shown in below analysis:

1) 1x 640x480@25 Encoding:

[2] https://gist.github.com/devarsht/ee9664d3403d1212ef477a027b71896c

In above, it can be seen 5ms polling gives better latency

2) 4x 1080p30 Transcode (File→decode→encode→file).csv irq vs polling comparison:

[3] https://gist.github.com/devarsht/3a58b4f201430dfc61697c7e224e74c2

3) 1x 1080p transcode (File→decode→encode→file) polling_vs_irq_transcode
comparison :

[4] https://gist.github.com/devarsht/a6480f1f2cbdf8dd694d698309d81fb0

In both above, it can be seen there is comparable performance achieved with
5ms polling without incurring too much of CPU.

4) We also ran 1080p60 streaming use-case for irq vs polling comparison for
CPU usage and Latencies :

[5] https://gist.github.com/devarsht/44aaa4322454e85e01a8d65ac47c5edb

And here too we found 5ms as apt value to reach closer to actual (irq)
latencies without too much of CPU usage.

> - why did you choose to add a polling mechanism instead of possible
> alternatives (like for example an fake irq-chip),
> -

I think I covered it above in first paragraph [0].
>>>> Move the core functionality of irq thread function to a separate function
> 
> s/irq/the irq/
> 
>> wave5_vpu_handle_irq so that it can be used by both the worker thread when
>> using polling mode and irq thread when using interrupt mode.
> 
> s/irq/the irq/
> 
>>
>> Protect hrtimer access and instance list with device specific mutex locks
> 
> s/hrtimer/the hrtimer/
> 
>> to avoid race conditions while different instances of encoder and decoder
> 
> s/encoder and decoder/encoders and decoders/
> 
>> are started together.
>>
>> Add module param to change polling interval for debug purpose.
> 
> s/module/a module/
> s/polling/the polling/
> s/debug purpose/debugging purposes/
> 
> Here again is the question, what can the user expect with different
> polling intervals? Is there a valid range of intervals?
> 

As mentioned above, decreasing the polling interval will make us reach better
latencies but CPU usage will increase too. It depends on what user wants from
this trade-off perspective but 5ms as a default for this hardware seemed
appropriate per experiments shared above to reach closer to actual latencies
(for e.g. CnM VPU gives ~3ms latency for 640x480).

> The actual implementation seems good, but I would like to first make
> sure that we take the best possible approach to this issue.
> 

I personally feel this hrtimer based approach as an apt one for the reasons
(and analysis) explained above.

Kindly let me know your opinions and if any queries or I missed to answer
something here.

[1] :
https://elixir.bootlin.com/linux/v6.7.5/source/drivers/usb/typec/tipd/core.c#L1299
[2] https://gist.github.com/devarsht/ee9664d3403d1212ef477a027b71896c
[3] https://gist.github.com/devarsht/3a58b4f201430dfc61697c7e224e74c2
[4] https://gist.github.com/devarsht/a6480f1f2cbdf8dd694d698309d81fb0
[5] https://gist.github.com/devarsht/44aaa4322454e85e01a8d65ac47c5edb

Regards
Devarsh

> Greetings,
> Sebastian
> 
>>
>> [1] https://www.ti.com/lit/pdf/spruj16
>> (Ref: Section 4.2.3.3 Resets, Interrupts, and Clocks)
>>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>> Test logs:
>> https://gist.github.com/devarsht/613bc8aa66e65814c8374ffb6a4f50fb
>> ---
>> .../platform/chips-media/wave5/wave5-helper.c |  16 ++-
>> .../chips-media/wave5/wave5-vpu-dec.c         |  13 +-
>> .../chips-media/wave5/wave5-vpu-enc.c         |  13 +-
>> .../platform/chips-media/wave5/wave5-vpu.c    | 117 ++++++++++++------
>> .../platform/chips-media/wave5/wave5-vpuapi.h |   4 +
>> 5 files changed, 122 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>> b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>> index 8433ecab230c..475b7628964f 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>> @@ -52,6 +52,8 @@ int wave5_vpu_release_device(struct file *filp,
>>                  char *name)
>> {
>>     struct vpu_instance *inst = wave5_to_vpu_inst(filp->private_data);
>> +    struct vpu_device *dev = inst->dev;
>> +    int ret = 0;
>>
>>     v4l2_m2m_ctx_release(inst->v4l2_fh.m2m_ctx);
>>     if (inst->state != VPU_INST_STATE_NONE) {
>> @@ -71,8 +73,20 @@ int wave5_vpu_release_device(struct file *filp,
>>     }
>>
>>     wave5_cleanup_instance(inst);
>> +    if (dev->irq < 0) {
>> +        ret = mutex_lock_interruptible(&dev->dev_lock);
>> +        if (ret)
>> +            return ret;
>>
>> -    return 0;
>> +        if (list_empty(&dev->instances)) {
>> +            dev_dbg(dev->dev, "Disabling the hrtimer\n");
>> +            hrtimer_cancel(&dev->hrtimer);
>> +        }
>> +
>> +        mutex_unlock(&dev->dev_lock);
>> +    }
>> +
>> +    return ret;
>> }
>>
>> int wave5_vpu_queue_init(void *priv, struct vb2_queue *src_vq, struct
>> vb2_queue *dst_vq,
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> index ef227af72348..c8624c681fa6 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> @@ -1810,7 +1810,6 @@ static int wave5_vpu_open_dec(struct file *filp)
>>     v4l2_fh_add(&inst->v4l2_fh);
>>
>>     INIT_LIST_HEAD(&inst->list);
>> -    list_add_tail(&inst->list, &dev->instances);
>>
>>     inst->v4l2_m2m_dev = inst->dev->v4l2_m2m_dec_dev;
>>     inst->v4l2_fh.m2m_ctx =
>> @@ -1867,6 +1866,18 @@ static int wave5_vpu_open_dec(struct file *filp)
>>
>>     wave5_vdi_allocate_sram(inst->dev);
>>
>> +    ret = mutex_lock_interruptible(&dev->dev_lock);
>> +    if (ret)
>> +        goto cleanup_inst;
>> +
>> +    if (dev->irq < 0 && !hrtimer_active(&dev->hrtimer) &&
>> list_empty(&dev->instances))
>> +        hrtimer_start(&dev->hrtimer, ns_to_ktime(dev->vpu_poll_interval *
>> NSEC_PER_MSEC),
>> +                  HRTIMER_MODE_REL_PINNED);
>> +
>> +    list_add_tail(&inst->list, &dev->instances);
>> +
>> +    mutex_unlock(&dev->dev_lock);
>> +
>>     return 0;
>>
>> cleanup_inst:
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> index f29cfa3af94a..9e88424761b6 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> @@ -1554,7 +1554,6 @@ static int wave5_vpu_open_enc(struct file *filp)
>>     v4l2_fh_add(&inst->v4l2_fh);
>>
>>     INIT_LIST_HEAD(&inst->list);
>> -    list_add_tail(&inst->list, &dev->instances);
>>
>>     inst->v4l2_m2m_dev = inst->dev->v4l2_m2m_enc_dev;
>>     inst->v4l2_fh.m2m_ctx =
>> @@ -1729,6 +1728,18 @@ static int wave5_vpu_open_enc(struct file *filp)
>>
>>     wave5_vdi_allocate_sram(inst->dev);
>>
>> +    ret = mutex_lock_interruptible(&dev->dev_lock);
>> +    if (ret)
>> +        goto cleanup_inst;
>> +
>> +    if (dev->irq < 0 && !hrtimer_active(&dev->hrtimer) &&
>> list_empty(&dev->instances))
>> +        hrtimer_start(&dev->hrtimer, ns_to_ktime(dev->vpu_poll_interval *
>> NSEC_PER_MSEC),
>> +                  HRTIMER_MODE_REL_PINNED);
>> +
>> +    list_add_tail(&inst->list, &dev->instances);
>> +
>> +    mutex_unlock(&dev->dev_lock);
>> +
>>     return 0;
>>
>> cleanup_inst:
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> index bfe4caa79cc9..968ec9baf1ef 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> @@ -26,6 +26,9 @@ struct wave5_match_data {
>>     const char *fw_name;
>> };
>>
>> +static int vpu_poll_interval = 5;
>> +module_param(vpu_poll_interval, int, 0644);
>> +
>> int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout)
>> {
>>     int ret;
>> @@ -40,7 +43,7 @@ int wave5_vpu_wait_interrupt(struct vpu_instance *inst,
>> unsigned int timeout)
>>     return 0;
>> }
>>
>> -static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
>> +static void wave5_vpu_handle_irq(void *dev_id)
>> {
>>     u32 seq_done;
>>     u32 cmd_done;
>> @@ -48,42 +51,67 @@ static irqreturn_t wave5_vpu_irq_thread(int irq, void
>> *dev_id)
>>     struct vpu_instance *inst;
>>     struct vpu_device *dev = dev_id;
>>
>> -    if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS)) {
>> -        irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
>> -        wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
>> -        wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
>> -
>> -        list_for_each_entry(inst, &dev->instances, list) {
>> -            seq_done = wave5_vdi_read_register(dev,
>> W5_RET_SEQ_DONE_INSTANCE_INFO);
>> -            cmd_done = wave5_vdi_read_register(dev,
>> W5_RET_QUEUE_CMD_DONE_INST);
>> -
>> -            if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
>> -                irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
>> -                if (seq_done & BIT(inst->id)) {
>> -                    seq_done &= ~BIT(inst->id);
>> -                    wave5_vdi_write_register(dev,
>> W5_RET_SEQ_DONE_INSTANCE_INFO,
>> -                                 seq_done);
>> -                    complete(&inst->irq_done);
>> -                }
>> +    irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
>> +    wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
>> +    wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
>> +
>> +    list_for_each_entry(inst, &dev->instances, list) {
>> +        seq_done = wave5_vdi_read_register(dev,
>> W5_RET_SEQ_DONE_INSTANCE_INFO);
>> +        cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
>> +
>> +        if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
>> +            irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
>> +            if (seq_done & BIT(inst->id)) {
>> +                seq_done &= ~BIT(inst->id);
>> +                wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO,
>> +                             seq_done);
>> +                complete(&inst->irq_done);
>>             }
>> +        }
>>
>> -            if (irq_reason & BIT(INT_WAVE5_DEC_PIC) ||
>> -                irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
>> -                if (cmd_done & BIT(inst->id)) {
>> -                    cmd_done &= ~BIT(inst->id);
>> -                    wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
>> -                                 cmd_done);
>> -                    inst->ops->finish_process(inst);
>> -                }
>> +        if (irq_reason & BIT(INT_WAVE5_DEC_PIC) ||
>> +            irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
>> +            if (cmd_done & BIT(inst->id)) {
>> +                cmd_done &= ~BIT(inst->id);
>> +                wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
>> +                             cmd_done);
>> +                inst->ops->finish_process(inst);
>>             }
>> -
>> -            wave5_vpu_clear_interrupt(inst, irq_reason);
>>         }
>> +
>> +        wave5_vpu_clear_interrupt(inst, irq_reason);
>>     }
>> +}
>> +
>> +static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
>> +{
>> +    struct vpu_device *dev = dev_id;
>> +
>> +    if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS))
>> +        wave5_vpu_handle_irq(dev);
>>
>>     return IRQ_HANDLED;
>> }
>>
>> +static void wave5_vpu_irq_work_fn(struct kthread_work *work)
>> +{
>> +    struct vpu_device *dev = container_of(work, struct vpu_device, work);
>> +
>> +    if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS))
>> +        wave5_vpu_handle_irq(dev);
>> +}
>> +
>> +static enum hrtimer_restart wave5_vpu_timer_callback(struct hrtimer *timer)
>> +{
>> +    struct vpu_device *dev =
>> +            container_of(timer, struct vpu_device, hrtimer);
>> +
>> +    kthread_queue_work(dev->worker, &dev->work);
>> +    hrtimer_forward_now(timer, ns_to_ktime(vpu_poll_interval *
>> NSEC_PER_MSEC));
>> +
>> +    return HRTIMER_RESTART;
>> +}
>> +
>> static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name,
>>                    u32 *revision)
>> {
>> @@ -209,16 +237,24 @@ static int wave5_vpu_probe(struct platform_device *pdev)
>>
>>     dev->irq = platform_get_irq(pdev, 0);
>>     if (dev->irq < 0) {
>> -        dev_err(&pdev->dev, "failed to get irq resource\n");
>> -        ret = -ENXIO;
>> -        goto err_enc_unreg;
>> -    }
>> -
>> -    ret = devm_request_threaded_irq(&pdev->dev, dev->irq, NULL,
>> -                    wave5_vpu_irq_thread, IRQF_ONESHOT, "vpu_irq", dev);
>> -    if (ret) {
>> -        dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n", ret);
>> -        goto err_enc_unreg;
>> +        dev_err(&pdev->dev, "failed to get irq resource, falling back to
>> polling\n");
>> +        hrtimer_init(&dev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
>> +        dev->hrtimer.function = &wave5_vpu_timer_callback;
>> +        dev->worker = kthread_create_worker(0, "vpu_irq_thread");
>> +        if (IS_ERR(dev->worker)) {
>> +            dev_err(&pdev->dev, "failed to create vpu irq worker\n");
>> +            ret = PTR_ERR(dev->worker);
>> +            goto err_vdi_release;
>> +        }
>> +        dev->vpu_poll_interval = vpu_poll_interval;
>> +        kthread_init_work(&dev->work, wave5_vpu_irq_work_fn);
>> +    } else {
>> +        ret = devm_request_threaded_irq(&pdev->dev, dev->irq, NULL,
>> +                        wave5_vpu_irq_thread, IRQF_ONESHOT, "vpu_irq", dev);
>> +        if (ret) {
>> +            dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n",
>> ret);
>> +            goto err_enc_unreg;
>> +        }
>>     }
>>
>>     ret = wave5_vpu_load_firmware(&pdev->dev, match_data->fw_name,
>> &fw_revision);
>> @@ -254,6 +290,11 @@ static int wave5_vpu_remove(struct platform_device *pdev)
>> {
>>     struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
>>
>> +    if (dev->irq < 0) {
>> +        kthread_destroy_worker(dev->worker);
>> +        hrtimer_cancel(&dev->hrtimer);
>> +    }
>> +
>>     mutex_destroy(&dev->dev_lock);
>>     mutex_destroy(&dev->hw_lock);
>>     clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> index 352f6e904e50..edc50450ddb8 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> @@ -756,6 +756,10 @@ struct vpu_device {
>>     u32 product_code;
>>     struct ida inst_ida;
>>     struct clk_bulk_data *clks;
>> +    struct hrtimer hrtimer;
>> +    struct kthread_work work;
>> +    struct kthread_worker *worker;
>> +    int vpu_poll_interval;
>>     int num_clks;
>> };
>>
>> -- 
>> 2.34.1
>>
>>

