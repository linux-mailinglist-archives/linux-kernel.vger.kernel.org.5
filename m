Return-Path: <linux-kernel+bounces-21545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB988290F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD961F26A2B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0E33E497;
	Tue,  9 Jan 2024 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hTkAn3qv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2A364C1;
	Tue,  9 Jan 2024 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409NadZJ015473;
	Tue, 9 Jan 2024 23:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5vsgqYN1xMICRac8a9jc/Xitc5cxzbAO0Ciy0hjnofU=; b=hT
	kAn3qvFo7ObgGy5OksxJP1DXLtgxdlzkXk5f2Z5u8o5a3zUNWc2+oim9rutnsg6s
	7Pq3KafEl2D1NoBbdLKf5Gna3fSfxIO6fV9ebb9uOL9ChHCm+uSe7m4auLG4/IxH
	t3LbU087/+J/Fe4gNYmZoO6DAVG/3w7xGPu/suOj8kO2SzUVqHfHLuHfh0tMm6zA
	IgX7v+KxT2g0yaXEaLyM/nCIawiOG2Gj1/4lTPveV7lFjjR6cXlmClczxNJVXBjD
	p6j8P4nQn8NwpUUHiWpdtpVkeimaZhdQ6l+rv+Z6Jbl8bh1CH9N0hJT8vzEJNdcY
	u0Q1GQRDfOpiGk4mu14w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9vfguf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 23:43:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Nh0Dn002252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 23:43:00 GMT
Received: from [10.110.97.125] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 15:42:59 -0800
Message-ID: <b254f73b-a1bc-3dd4-f485-a3acf556835d@quicinc.com>
Date: Tue, 9 Jan 2024 15:42:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v12 04/41] usb: host: xhci-mem: Cleanup pending secondary
 event ring events
Content-Language: en-US
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <gregkh@linuxfoundation.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <broonie@kernel.org>, <bgoswami@quicinc.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <agross@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20240102214549.22498-1-quic_wcheng@quicinc.com>
 <20240102214549.22498-5-quic_wcheng@quicinc.com>
 <734591a1-50b4-6dc7-0b93-077355ec12e4@linux.intel.com>
 <7b2ec96b-b72f-c848-7c35-36e61a4072ac@quicinc.com>
In-Reply-To: <7b2ec96b-b72f-c848-7c35-36e61a4072ac@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DPckguU-3nXYKirH72rirGdGbZdDUF1O
X-Proofpoint-ORIG-GUID: DPckguU-3nXYKirH72rirGdGbZdDUF1O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090191

Hi Mathias,

On 1/8/2024 12:51 PM, Wesley Cheng wrote:
> Hi Mathias,
> 
> On 1/4/2024 6:48 AM, Mathias Nyman wrote:
>> On 2.1.2024 23.45, Wesley Cheng wrote:
>>> As part of xHCI bus suspend, the XHCI is halted.  However, if there are
>>> pending events in the secondary event ring, it is observed that the xHCI
>>> controller stops responding to further commands upon host or device
>>> initiated bus resume.  Iterate through all pending events and update the
>>> dequeue pointer to the beginning of the event ring.
>>>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ...
>>> +/*
>>> + * Move the event ring dequeue pointer to skip events kept in the 
>>> secondary
>>> + * event ring.  This is used to ensure that pending events in the 
>>> ring are
>>> + * acknowledged, so the XHCI HCD can properly enter suspend/resume.  
>>> The
>>> + * secondary ring is typically maintained by an external component.
>>> + */
>>> +void xhci_skip_sec_intr_events(struct xhci_hcd *xhci,
>>> +    struct xhci_ring *ring,    struct xhci_interrupter *ir)
>>> +{
>>> +    union xhci_trb *erdp_trb, *current_trb;
>>> +    u64 erdp_reg;
>>> +    u32 iman_reg;
>>> +    dma_addr_t deq;
>>> +
>>> +    /* disable irq, ack pending interrupt and ack all pending events */
>>> +    xhci_disable_interrupter(ir);
>>> +    iman_reg = readl_relaxed(&ir->ir_set->irq_pending);
>>> +    if (iman_reg & IMAN_IP)
>>> +        writel_relaxed(iman_reg, &ir->ir_set->irq_pending);
>>> +
>>> +    /* last acked event trb is in erdp reg  */
>>> +    erdp_reg = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
>>> +    deq = (dma_addr_t)(erdp_reg & ERST_PTR_MASK);
>>> +    if (!deq) {
>>> +        xhci_err(xhci, "event ring handling not required\n");
>>> +        return;
>>> +    }
>>> +
>>> +    erdp_trb = current_trb = ir->event_ring->dequeue;
>>> +    /* read cycle state of the last acked trb to find out CCS */
>>> +    ring->cycle_state = le32_to_cpu(current_trb->event_cmd.flags) & 
>>> TRB_CYCLE;
>>> +
>>> +    while (1) {
>>> +        inc_deq(xhci, ir->event_ring);
>>> +        erdp_trb = ir->event_ring->dequeue;
>>> +        /* cycle state transition */
>>> +        if ((le32_to_cpu(erdp_trb->event_cmd.flags) & TRB_CYCLE) !=
>>> +            ring->cycle_state)
>>> +            break;
>>> +    }
>>> +
>>> +    xhci_update_erst_dequeue(xhci, ir, current_trb, true);
>>> +}
>>
>> Code above is very similar to the existing event ring processing parts 
>> of xhci_irq()
>> and xhci_handle_event()
>>
>> I'll see if I can refactor the existing event ring processing, 
>> decouple it from
>> event handling so that it could be used by primary and secondary 
>> interrupters with
>> handlers, and this case where we just want to clear the event ring.
>>
> 
> Thanks, that makes sense.  Will take a look as well.
> 

How about something like the below?  Tested this on my set up and 
everything looks to be working fine.  Had to add another param to struct 
xhci_interrupters to tell the XHCI interrupt handler to say if that 
particular interrupter wants to skip_events (handling).  This way, its 
something that the class driver utilizing the interrupter will have to 
tell XHCI sideband.  It would allow the user to determine if they want 
to use the interrupter to actually handle events or not on the proc 
running Linux.

Thanks
Wesley Cheng

---------------------------------------------------------------------


diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 4460fa7e9fab..5bf74c37cbf6 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1827,7 +1827,7 @@ xhci_remove_interrupter(struct xhci_hcd *xhci, 
struct xhci_interrupter *ir)
  		tmp &= ERST_SIZE_MASK;
  		writel(tmp, &ir->ir_set->erst_size);

-		xhci_write_64(xhci, ERST_EHB, &ir->ir_set->erst_dequeue);
+		xhci_update_erst_dequeue(xhci, ir, ir->event_ring->first_seg->trbs, 
true);
  	}
  }

@@ -1865,11 +1865,12 @@ void xhci_remove_secondary_interrupter(struct 
usb_hcd *hcd, struct xhci_interrup
  	if (!ir || !ir->intr_num || ir->intr_num >= xhci->max_interrupters)
  		xhci_dbg(xhci, "Invalid secondary interrupter, can't remove\n");

-	/* fixme, should we check xhci->interrupter[intr_num] == ir */
-	/* fixme locking */
-
  	spin_lock_irq(&xhci->lock);
-
+	/*
+	 * Cleanup secondary interrupter to ensure there are no pending events.
+	 * This also updates event ring dequeue pointer back to the start.
+	 */
+	xhci_skip_sec_intr_events(xhci, ir->event_ring, ir);
  	intr_num = ir->intr_num;

  	xhci_remove_interrupter(xhci, ir);
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 33806ae966f9..1d69da07ffdd 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2905,6 +2905,46 @@ static int handle_tx_event(struct xhci_hcd *xhci,
  	return -ENODEV;
  }

+static void xhci_clear_interrupt_pending(struct xhci_hcd *xhci, struct 
xhci_interrupter *ir)
+{
+	struct usb_hcd *hcd = xhci_to_hcd(xhci);
+
+	if (!hcd->msi_enabled) {
+		u32 irq_pending;
+		irq_pending = readl(&ir->ir_set->irq_pending);
+		irq_pending |= IMAN_IP;
+		writel(irq_pending, &ir->ir_set->irq_pending);
+	}
+}
+
+static void xhci_handle_event_trb(struct xhci_hcd *xhci,
+				   struct xhci_interrupter *ir, union xhci_trb *event)
+{
+	u32 trb_type;
+
+	trb_type = TRB_FIELD_TO_TYPE(le32_to_cpu(event->event_cmd.flags));
+
+	switch (trb_type) {
+	case TRB_COMPLETION:
+		handle_cmd_completion(xhci, &event->event_cmd);
+		break;
+	case TRB_PORT_STATUS:
+		handle_port_status(xhci, ir, event);
+		break;
+	case TRB_TRANSFER:
+		handle_tx_event(xhci, ir, &event->trans_event);
+		break;
+	case TRB_DEV_NOTE:
+		handle_device_notification(xhci, event);
+		break;
+	default:
+		if (trb_type >= TRB_VENDOR_DEFINED_LOW)
+			handle_vendor_event(xhci, event, trb_type);
+		else
+			xhci_warn(xhci, "ERROR unknown event type %d\n", trb_type);
+	}
+}
+
  /*
   * This function handles all OS-owned events on the event ring.  It 
may drop
   * xhci->lock between event processing (e.g. to pass up port status 
changes).
@@ -2914,7 +2954,6 @@ static int handle_tx_event(struct xhci_hcd *xhci,
  static int xhci_handle_event(struct xhci_hcd *xhci, struct 
xhci_interrupter *ir)
  {
  	union xhci_trb *event;
-	u32 trb_type;

  	/* Event ring hasn't been allocated yet. */
  	if (!ir || !ir->event_ring || !ir->event_ring->dequeue) {
@@ -2935,28 +2974,9 @@ static int xhci_handle_event(struct xhci_hcd 
*xhci, struct xhci_interrupter *ir)
  	 * speculative reads of the event's flags/data below.
  	 */
  	rmb();
-	trb_type = TRB_FIELD_TO_TYPE(le32_to_cpu(event->event_cmd.flags));
-	/* FIXME: Handle more event types. */
+	if (!ir->skip_events)
+		xhci_handle_event_trb(xhci, ir, event);

-	switch (trb_type) {
-	case TRB_COMPLETION:
-		handle_cmd_completion(xhci, &event->event_cmd);
-		break;
-	case TRB_PORT_STATUS:
-		handle_port_status(xhci, ir, event);
-		break;
-	case TRB_TRANSFER:
-		handle_tx_event(xhci, ir, &event->trans_event);
-		break;
-	case TRB_DEV_NOTE:
-		handle_device_notification(xhci, event);
-		break;
-	default:
-		if (trb_type >= TRB_VENDOR_DEFINED_LOW)
-			handle_vendor_event(xhci, event, trb_type);
-		else
-			xhci_warn(xhci, "ERROR unknown event type %d\n", trb_type);
-	}
  	/* Any of the above functions may drop and re-acquire the lock, so check
  	 * to make sure a watchdog timer didn't mark the host as non-responsive.
  	 */
@@ -2980,7 +3000,7 @@ static int xhci_handle_event(struct xhci_hcd 
*xhci, struct xhci_interrupter *ir)
   * - When all events have finished
   * - To avoid "Event Ring Full Error" condition
   */
-static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
+void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
  				     struct xhci_interrupter *ir,
  				     union xhci_trb *event_ring_deq,
  				     bool clear_ehb)
@@ -3013,6 +3033,75 @@ static void xhci_update_erst_dequeue(struct 
xhci_hcd *xhci,
  	xhci_write_64(xhci, temp_64, &ir->ir_set->erst_dequeue);
  }

+static irqreturn_t xhci_handle_events(struct xhci_hcd *xhci, struct 
xhci_interrupter *ir)
+{
+	union xhci_trb *event_ring_deq;
+	irqreturn_t ret = IRQ_NONE;
+	int event_loop = 0;
+	u64 temp_64;
+
+	xhci_clear_interrupt_pending(xhci, ir);
+
+	if (xhci->xhc_state & XHCI_STATE_DYING ||
+	    xhci->xhc_state & XHCI_STATE_HALTED) {
+		xhci_dbg(xhci, "xHCI dying, ignoring interrupt. "
+				"Shouldn't IRQs be disabled?\n");
+		/* Clear the event handler busy flag (RW1C);
+		 * the event ring should be empty.
+		 */
+		temp_64 = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
+		xhci_write_64(xhci, temp_64 | ERST_EHB,
+				&ir->ir_set->erst_dequeue);
+		ret = IRQ_HANDLED;
+		goto out;
+	}
+
+	event_ring_deq = ir->event_ring->dequeue;
+	/* FIXME this should be a delayed service routine
+	 * that clears the EHB.
+	 */
+	while (xhci_handle_event(xhci, ir) > 0) {
+		if (event_loop++ < TRBS_PER_SEGMENT / 2)
+			continue;
+		xhci_update_erst_dequeue(xhci, ir, event_ring_deq, false);
+		event_ring_deq = ir->event_ring->dequeue;
+
+		/* ring is half-full, force isoc trbs to interrupt more often */
+		if (xhci->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
+			xhci->isoc_bei_interval = xhci->isoc_bei_interval / 2;
+
+		event_loop = 0;
+	}
+
+	xhci_update_erst_dequeue(xhci, ir, event_ring_deq, true);
+	ret = IRQ_HANDLED;
+
+out:
+	return ret;
+
+}
+
+/*
+ * Move the event ring dequeue pointer to skip events kept in the secondary
+ * event ring.  This is used to ensure that pending events in the ring are
+ * acknowledged, so the XHCI HCD can properly enter suspend/resume.  The
+ * secondary ring is typically maintained by an external component.
+ */
+void xhci_skip_sec_intr_events(struct xhci_hcd *xhci,
+	struct xhci_ring *ring,	struct xhci_interrupter *ir)
+{
+	union xhci_trb *current_trb;
+
+	/* disable irq, ack pending interrupt and ack all pending events */
+	xhci_disable_interrupter(ir);
+
+	current_trb = ir->event_ring->dequeue;
+	/* read cycle state of the last acked trb to find out CCS */
+	ring->cycle_state = le32_to_cpu(current_trb->event_cmd.flags) & TRB_CYCLE;
+
+	xhci_handle_events(xhci, ir);
+}
+
  /*
   * xHCI spec says we can get an interrupt, and if the HC has an error 
condition,
   * we might get bad data out of the event ring.  Section 4.10.2.7 has 
a list of
@@ -3021,12 +3110,8 @@ static void xhci_update_erst_dequeue(struct 
xhci_hcd *xhci,
  irqreturn_t xhci_irq(struct usb_hcd *hcd)
  {
  	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
-	union xhci_trb *event_ring_deq;
-	struct xhci_interrupter *ir;
  	irqreturn_t ret = IRQ_NONE;
-	u64 temp_64;
  	u32 status;
-	int event_loop = 0;

  	spin_lock(&xhci->lock);
  	/* Check if the xHC generated the interrupt, or the irq is shared */
@@ -3060,48 +3145,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
  	status |= STS_EINT;
  	writel(status, &xhci->op_regs->status);

-	/* This is the handler of the primary interrupter */
-	ir = xhci->interrupters[0];
-	if (!hcd->msi_enabled) {
-		u32 irq_pending;
-		irq_pending = readl(&ir->ir_set->irq_pending);
-		irq_pending |= IMAN_IP;
-		writel(irq_pending, &ir->ir_set->irq_pending);
-	}
-
-	if (xhci->xhc_state & XHCI_STATE_DYING ||
-	    xhci->xhc_state & XHCI_STATE_HALTED) {
-		xhci_dbg(xhci, "xHCI dying, ignoring interrupt. "
-				"Shouldn't IRQs be disabled?\n");
-		/* Clear the event handler busy flag (RW1C);
-		 * the event ring should be empty.
-		 */
-		temp_64 = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
-		xhci_write_64(xhci, temp_64 | ERST_EHB,
-				&ir->ir_set->erst_dequeue);
-		ret = IRQ_HANDLED;
-		goto out;
-	}
-
-	event_ring_deq = ir->event_ring->dequeue;
-	/* FIXME this should be a delayed service routine
-	 * that clears the EHB.
-	 */
-	while (xhci_handle_event(xhci, ir) > 0) {
-		if (event_loop++ < TRBS_PER_SEGMENT / 2)
-			continue;
-		xhci_update_erst_dequeue(xhci, ir, event_ring_deq, false);
-		event_ring_deq = ir->event_ring->dequeue;
-
-		/* ring is half-full, force isoc trbs to interrupt more often */
-		if (xhci->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
-			xhci->isoc_bei_interval = xhci->isoc_bei_interval / 2;
-
-		event_loop = 0;
-	}
-
-	xhci_update_erst_dequeue(xhci, ir, event_ring_deq, true);
-	ret = IRQ_HANDLED;
+	ret = xhci_handle_events(xhci, xhci->interrupters[0]);

  out:
  	spin_unlock(&xhci->lock);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 573ca5c4f31a..eb15c63e6775 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -333,7 +333,7 @@ static int xhci_enable_interrupter(struct 
xhci_interrupter *ir)
  	return 0;
  }

-static int xhci_disable_interrupter(struct xhci_interrupter *ir)
+int xhci_disable_interrupter(struct xhci_interrupter *ir)
  {
  	u32 iman;

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index e98099b960e4..a4126dfbd77a 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1691,6 +1691,7 @@ struct xhci_interrupter {
  	struct xhci_erst	erst;
  	struct xhci_intr_reg __iomem *ir_set;
  	unsigned int		intr_num;
+	bool			skip_events;
  	/* For interrupter registers save and restore over suspend/resume */
  	u32	s3_irq_pending;
  	u32	s3_irq_control;
@@ -2093,6 +2094,9 @@ struct xhci_interrupter *
  xhci_create_secondary_interrupter(struct usb_hcd *hcd, int num_seg);
  void xhci_remove_secondary_interrupter(struct usb_hcd
  				       *hcd, struct xhci_interrupter *ir);
+void xhci_skip_sec_intr_events(struct xhci_hcd *xhci,
+	struct xhci_ring *ring,	struct xhci_interrupter *ir);
+int xhci_disable_interrupter(struct xhci_interrupter *ir);

  /* xHCI host controller glue */
  typedef void (*xhci_get_quirks_t)(struct device *, struct xhci_hcd *);
@@ -2180,6 +2184,10 @@ void inc_deq(struct xhci_hcd *xhci, struct 
xhci_ring *ring);
  unsigned int count_trbs(u64 addr, u64 len);
  int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct xhci_virt_ep 
*ep,
  			    int suspend, gfp_t gfp_flags);
+void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
+				     struct xhci_interrupter *ir,
+				     union xhci_trb *event_ring_deq,
+				     bool clear_ehb);

  /* xHCI roothub code */
  void xhci_set_link_state(struct xhci_hcd *xhci, struct xhci_port *port,


