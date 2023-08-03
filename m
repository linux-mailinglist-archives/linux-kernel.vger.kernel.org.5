Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EECC76E5C7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjHCKdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjHCKct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:32:49 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1366B11B;
        Thu,  3 Aug 2023 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691058768; x=1722594768;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=6hc1/qNVWMhq9Hi9YrzSfxvx3XvZSP+GUU/ssEMrrlA=;
  b=mVG0ieGn/imq9YXnxaNYqEM5l0vxrXRZSTBKDl5doZ1FTmdymfExZVMg
   BvNeUqaNVO8omGZeQtMiRZePPpyzLWV2qafLDtfnsGEjAQWfFOxl4WcIZ
   2OrYTfyb4JZzNsr/RMIh/cccEw/p+o6zoncJHHrXj6TxmeVqk2uW28u29
   OsBIA3UtDTIuVlsjYQoAXzZF2QlbV8VcFNRnXV6wdtO4w37a/P6OjxrXt
   bRoDH8JGd/Bg2YdQ+SoOmmAUeN2vC/2J3ELk1I+6f6VbM5CPcPSF6SxdB
   joHgPOLB7m6J6pAe+74jIDYZAtLfH1HVm7v4gdRM33jbKxPVmbsIeybgc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="400775316"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="400775316"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 03:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="843544345"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="843544345"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga002.fm.intel.com with ESMTP; 03 Aug 2023 03:32:41 -0700
Message-ID: <7b31b220-6fd5-0f5d-7e1a-df3f38bd792f@linux.intel.com>
Date:   Thu, 3 Aug 2023 13:33:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        Thinh.Nguyen@synopsys.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_jackp@quicinc.com, pierre-louis.bossart@linux.intel.com,
        oneukum@suse.com, albertccwang@google.com, o-takashi@sakamocchi.jp
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-5-quic_wcheng@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v4 04/32] usb: host: xhci-mem: Cleanup pending secondary
 event ring events
In-Reply-To: <20230725023416.11205-5-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.7.2023 5.33, Wesley Cheng wrote:
> As part of xHCI bus suspend, the XHCI is halted.  However, if there are
> pending events in the secondary event ring, it is observed that the xHCI
> controller stops responding to further commands upon host or device
> initiated bus resume.  Iterate through all pending events and updating the
> dequeue pointer to the last pending event trb.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>   drivers/usb/host/xhci-mem.c | 74 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 69 insertions(+), 5 deletions(-)

This sounds more like ring handling code.
Maybe xhci-ring.c would be a better place

> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index c51150af22f2..6b01d56c176f 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -1799,17 +1799,85 @@ int xhci_alloc_erst(struct xhci_hcd *xhci,
>   	return 0;
>   }
>   
> +static void xhci_handle_sec_intr_events(struct xhci_hcd *xhci,
> +	struct xhci_ring *ring,	struct xhci_intr_reg __iomem *ir_set,
> +	struct xhci_erst *erst)
> +{

The function name is a bit misleading as it doesn't handle
any of the pending events, it just marks them all handled.

> +	union xhci_trb *erdp_trb, *current_trb;
> +	struct xhci_segment	*seg;
> +	u64 erdp_reg;
> +	u32 iman_reg;
> +	dma_addr_t deq;
> +	unsigned long segment_offset;
> +
> +	/* disable irq, ack pending interrupt and ack all pending events */
> +	iman_reg = readl_relaxed(&ir_set->irq_pending);
> +	iman_reg &= ~IMAN_IE;
> +	writel_relaxed(iman_reg, &ir_set->irq_pending);
> +	iman_reg = readl_relaxed(&ir_set->irq_pending);
> +	if (iman_reg & IMAN_IP)
> +		writel_relaxed(iman_reg, &ir_set->irq_pending);

maybe use xhci_disable_interrupter() helper, it does most of this already.

> +
> +	/* last acked event trb is in erdp reg  */
> +	erdp_reg = xhci_read_64(xhci, &ir_set->erst_dequeue);
> +	deq = (dma_addr_t)(erdp_reg & ~ERST_PTR_MASK);
> +	if (!deq) {
> +		xhci_dbg(xhci, "event ring handling not required\n");
> +		return;
> +	}
> +
> +	seg = ring->first_seg;
> +	segment_offset = deq - seg->dma;
> +
> +	/* find out virtual address of the last acked event trb */
> +	erdp_trb = current_trb = &seg->trbs[0] +
> +				(segment_offset/sizeof(*current_trb));
> +
> +	/* read cycle state of the last acked trb to find out CCS */
> +	ring->cycle_state = le32_to_cpu(current_trb->event_cmd.flags) & TRB_CYCLE;
> +
> +	while (1) {
> +		/* last trb of the event ring: toggle cycle state */
> +		if (current_trb == &seg->trbs[TRBS_PER_SEGMENT - 1]) {
> +			ring->cycle_state ^= 1;
> +			current_trb = &seg->trbs[0];
> +		} else {
> +			current_trb++;
> +		}
> +
> +		/* cycle state transition */
> +		if ((le32_to_cpu(current_trb->event_cmd.flags) & TRB_CYCLE) !=
> +		    ring->cycle_state)
> +			break;
> +	}
> +
> +	if (erdp_trb != current_trb) {
> +		deq = xhci_trb_virt_to_dma(ring->deq_seg, current_trb);
> +		if (deq == 0)
> +			xhci_warn(xhci,
> +				"WARN invalid SW event ring dequeue ptr.\n");
> +		/* Update HC event ring dequeue pointer */
> +		erdp_reg &= ERST_PTR_MASK;
> +		erdp_reg |= ((u64) deq & (u64) ~ERST_PTR_MASK);
> +	}
> +
> +	/* Clear the event handler busy flag (RW1C); event ring is empty. */
> +	erdp_reg |= ERST_EHB;
> +	xhci_write_64(xhci, erdp_reg, &ir_set->erst_dequeue);

There are some helpers like inc_deq() and  xhci_update_erst_dequeue()
that could be used here.

> +}
> +
>   static void
>   xhci_free_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
>   {
>   	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
>   	size_t erst_size;
> -	u64 tmp64;
>   	u32 tmp;
>   
>   	if (!ir)
>   		return;
>   
> +	xhci_handle_sec_intr_events(xhci, ir->event_ring, ir->ir_set, &ir->erst);

Cleaning up the interrupter event ring should be called earlier.
  
Probably from xhci_remove_secondary_interrupter(), before it calls xhci_free_interrupter()

Thanks
-Mathias


