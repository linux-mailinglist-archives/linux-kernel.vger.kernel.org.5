Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D07E7B5BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjJBUIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJBUIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:08:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06125B3;
        Mon,  2 Oct 2023 13:08:10 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392JLIHE025970;
        Mon, 2 Oct 2023 20:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z3xXx0H/L0mcvqYI2I+swhGIxxYamMPE9q4cn6HWt9Y=;
 b=S2NKsnDRdgZafzS8OD5/Rk2+xuUjGO04lp0FEYEBdUanmdAK6+WkhA8+N0Untg7Yx8A2
 ttt55h7DI1UmqWkyy/8ESrcP5IayU4BB6YLti2AcA4bEWp6cDTVAKWO9W0HBks0hMRN4
 4Ma5PazGDPBHzl0umQB0o1TmOWlof96hG5OATZdWw14mCv6KGabAyVzS4kE1DKWwgVZq
 u6QewDv0UgCEmTW4HIeG9DKtoe7SbXRnw7mA6jTtaY+NCF3iwwVBXrJw33yJYevosh9G
 hP82dzn9cwAHyp1pBCcsO4qcE6xrKWbfPNHqcvjze72dSKbIWYyQb9LmwKKPo3E/HhxX Hg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg1v38dpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 20:07:33 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 392K7Wig022867
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Oct 2023 20:07:33 GMT
Received: from [10.110.49.236] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 2 Oct
 2023 13:07:31 -0700
Message-ID: <e3f3c8cd-6338-da08-d988-4d2ed68280e6@quicinc.com>
Date:   Mon, 2 Oct 2023 13:07:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [PATCH v7 01/33] xhci: add support to allocate several
 interrupters
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <20230921214843.18450-2-quic_wcheng@quicinc.com>
 <10ad0613-7e88-dbe8-c5a2-d535f8e9db03@linux.intel.com>
Content-Language: en-US
In-Reply-To: <10ad0613-7e88-dbe8-c5a2-d535f8e9db03@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xX1n7h8flvizu3XZUSm3EWnjGgn-2B-1
X-Proofpoint-ORIG-GUID: xX1n7h8flvizu3XZUSm3EWnjGgn-2B-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=622 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020154
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 9/28/2023 3:31 AM, Mathias Nyman wrote:
> On 22.9.2023 0.48, Wesley Cheng wrote:
>> From: Mathias Nyman <mathias.nyman@linux.intel.com>
>>
>> Modify the XHCI drivers to accommodate for handling multiple event 
>> rings in
>> case there are multiple interrupters.  Add the required APIs so 
>> clients are
>> able to allocate/request for an interrupter ring, and pass this 
>> information
>> back to the client driver.  This allows for users to handle the resource
>> accordingly, such as passing the event ring base address to an audio DSP.
>> There is no actual support for multiple MSI/MSI-X vectors.
>>
>> Factoring out XHCI interrupter APIs and structures done by Wesley 
>> Cheng, in
>> order to allow for USB class drivers to utilze them.
>>
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/host/xhci-debugfs.c |  2 +-
>>   drivers/usb/host/xhci-mem.c     | 93 ++++++++++++++++++++++++++++++---
>>   drivers/usb/host/xhci-ring.c    |  2 +-
>>   drivers/usb/host/xhci.c         | 49 ++++++++++-------
>>   drivers/usb/host/xhci.h         | 77 +--------------------------
>>   include/linux/usb/xhci-intr.h   | 86 ++++++++++++++++++++++++++++++
>>   6 files changed, 207 insertions(+), 102 deletions(-)
>>   create mode 100644 include/linux/usb/xhci-intr.h
>>
>> diff --git a/drivers/usb/host/xhci-debugfs.c 
>> b/drivers/usb/host/xhci-debugfs.c
>> index 99baa60ef50f..15a8402ee8a1 100644
>> --- a/drivers/usb/host/xhci-debugfs.c
>> +++ b/drivers/usb/host/xhci-debugfs.c
>> @@ -693,7 +693,7 @@ void xhci_debugfs_init(struct xhci_hcd *xhci)
>>                        "command-ring",
>>                        xhci->debugfs_root);
>> -    xhci_debugfs_create_ring_dir(xhci, &xhci->interrupter->event_ring,
>> +    xhci_debugfs_create_ring_dir(xhci, 
>> &xhci->interrupters[0]->event_ring,
>>                        "event-ring",
>>                        xhci->debugfs_root);
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>> index 8714ab5bf04d..2f9228d7d22d 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>> @@ -1837,6 +1837,26 @@ xhci_free_interrupter(struct xhci_hcd *xhci, 
>> struct xhci_interrupter *ir)
>>       kfree(ir);
>>   }
>> +void xhci_remove_secondary_interrupter(struct usb_hcd *hcd, struct 
>> xhci_interrupter *ir)
>> +{
>> +    struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>> +    unsigned int intr_num;
>> +
>> +    /* interrupter 0 is primary interrupter, don't touchit */
>> +    if (!ir || !ir->intr_num || ir->intr_num >= 
>> xhci->max_interrupters) {
>> +        xhci_dbg(xhci, "Invalid secondary interrupter, can't remove\n");
>> +        return;
>> +    }
>> +
>> +    /* fixme, should we check xhci->interrupter[intr_num] == ir */
>> +    spin_lock(&xhci->lock);
> 
> Needs to be spin_lock_irq() ir spin_lock_irqsave() as xhci->lock is used 
> in interrupt handler.
> 
> 
>> +    intr_num = ir->intr_num;
>> +    xhci_free_interrupter(xhci, ir);
>> +    xhci->interrupters[intr_num] = NULL;
>> +    spin_unlock(&xhci->lock);
> 
> likewise
> 

Let me check these again.  In general, I think I will use both the 
xhci->mutex and xhci->lock where needed, because I believe we'd run into 
sleep while atomic issues while freeing the DMA memory.  Will rework 
this and submit in the next rev.

>> +}
>> +EXPORT_SYMBOL_GPL(xhci_remove_secondary_interrupter);
>> +
>>   void xhci_mem_cleanup(struct xhci_hcd *xhci)
>>   {
>>       struct device    *dev = xhci_to_hcd(xhci)->self.sysdev;
>> @@ -1844,9 +1864,13 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
>>       cancel_delayed_work_sync(&xhci->cmd_timer);
>> -    xhci_free_interrupter(xhci, xhci->interrupter);
>> -    xhci->interrupter = NULL;
>> -    xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Freed primary event 
>> ring");
>> +    for (i = 0; i < xhci->max_interrupters; i++) {
>> +        if (xhci->interrupters[i]) {
>> +            xhci_free_interrupter(xhci, xhci->interrupters[i]);
>> +            xhci->interrupters[i] = NULL;
>> +        }
>> +    }
>> +    xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Freed interrupters");
>>       if (xhci->cmd_ring)
>>           xhci_ring_free(xhci, xhci->cmd_ring);
>> @@ -1916,6 +1940,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
>>       for (i = 0; i < xhci->num_port_caps; i++)
>>           kfree(xhci->port_caps[i].psi);
>>       kfree(xhci->port_caps);
>> +    kfree(xhci->interrupters);
>>       xhci->num_port_caps = 0;
>>       xhci->usb2_rhub.ports = NULL;
>> @@ -1924,6 +1949,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
>>       xhci->rh_bw = NULL;
>>       xhci->ext_caps = NULL;
>>       xhci->port_caps = NULL;
>> +    xhci->interrupters = NULL;
>>       xhci->page_size = 0;
>>       xhci->page_shift = 0;
>> @@ -2276,6 +2302,13 @@ xhci_add_interrupter(struct xhci_hcd *xhci, 
>> struct xhci_interrupter *ir,
>>           return -EINVAL;
>>       }
>> +    if (xhci->interrupters[intr_num]) {
>> +        xhci_warn(xhci, "Interrupter%d\n already set up", intr_num);
>> +        return -EINVAL;
>> +    }
>> +
>> +    xhci->interrupters[intr_num] = ir;
>> +    ir->intr_num = intr_num;
>>       ir->ir_set = &xhci->run_regs->ir_set[intr_num];
>>       /* set ERST count with the number of entries in the segment 
>> table */
>> @@ -2295,10 +2328,53 @@ xhci_add_interrupter(struct xhci_hcd *xhci, 
>> struct xhci_interrupter *ir,
>>       return 0;
>>   }
>> +struct xhci_interrupter *
>> +xhci_create_secondary_interrupter(struct usb_hcd *hcd)
>> +{
>> +    struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>> +    struct xhci_interrupter *ir;
>> +    unsigned int i;
>> +    int err = -ENOSPC;
>> +
>> +    if (!xhci->interrupters)
>> +        return NULL;
>> +
>> +    ir = xhci_alloc_interrupter(xhci, GFP_KERNEL);
>> +    if (!ir)
>> +        return NULL;
>> +
>> +    spin_lock_irq(&xhci->lock);
>> +
>> +    /* Find available secondary interrupter, interrupter0 is 
>> reserverd for primary */
> 
> reserved
> 
>> +    for (i = 1; i < xhci->max_interrupters; i++) {
>> +        if (xhci->interrupters[i] == NULL) {
>> +            err = xhci_add_interrupter(xhci, ir, i);
>> +            break;
>> +        }
>> +    }
>> +
>> +    spin_unlock_irq(&xhci->lock);
>> +    if (err) {
>> +        xhci_warn(xhci, "Failed to add secondary interrupter, max 
>> interrupters %d\n",
>> +            xhci->max_interrupters);
>> +        xhci_free_interrupter(xhci, ir);
>> +        ir = NULL;
>> +        goto out;
>> +    }
>> +
>> +    xhci_dbg(xhci, "Add secondary interrupter %d, max interrupters 
>> %d\n",
>> +         i, xhci->max_interrupters);
>> +
>> +out:
>> +    return ir;
>> +}
>> +EXPORT_SYMBOL_GPL(xhci_create_secondary_interrupter);
>> +
>>   int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>>   {
>> -    dma_addr_t    dma;
>> +    struct xhci_interrupter *ir;
>>       struct device    *dev = xhci_to_hcd(xhci)->self.sysdev;
>> +    dma_addr_t    dma;
>>       unsigned int    val, val2;
>>       u64        val_64;
>>       u32        page_size, temp;
>> @@ -2422,11 +2498,14 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t 
>> flags)
>>       /* Allocate and set up primary interrupter 0 with an event ring. */
>>       xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>>                  "Allocating primary event ring");
>> -    xhci->interrupter = xhci_alloc_interrupter(xhci, flags);
>> -    if (!xhci->interrupter)
>> +    xhci->interrupters = kcalloc_node(xhci->max_interrupters, 
>> sizeof(*xhci->interrupters),
>> +                      flags, dev_to_node(dev));
>> +
>> +    ir = xhci_alloc_interrupter(xhci, flags);
>> +    if (!ir)
>>           goto fail;
>> -    if (xhci_add_interrupter(xhci, xhci->interrupter, 0))
>> +    if (xhci_add_interrupter(xhci, ir, 0))
>>           goto fail;
>>       xhci->isoc_bei_interval = AVOID_BEI_INTERVAL_MAX;
>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>> index 1dde53f6eb31..93233cf5ff21 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -3074,7 +3074,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
>>       writel(status, &xhci->op_regs->status);
>>       /* This is the handler of the primary interrupter */
>> -    ir = xhci->interrupter;
>> +    ir = xhci->interrupters[0];
>>       if (!hcd->msi_enabled) {
>>           u32 irq_pending;
>>           irq_pending = readl(&ir->ir_set->irq_pending);
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index e1b1b64a0723..3fd2b58ee1d3 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -456,7 +456,7 @@ static int xhci_init(struct usb_hcd *hcd)
>>   static int xhci_run_finished(struct xhci_hcd *xhci)
>>   {
>> -    struct xhci_interrupter *ir = xhci->interrupter;
>> +    struct xhci_interrupter *ir = xhci->interrupters[0];
>>       unsigned long    flags;
>>       u32        temp;
>> @@ -508,7 +508,7 @@ int xhci_run(struct usb_hcd *hcd)
>>       u64 temp_64;
>>       int ret;
>>       struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>> -    struct xhci_interrupter *ir = xhci->interrupter;
>> +    struct xhci_interrupter *ir = xhci->interrupters[0];
>>       /* Start the xHCI host controller runningonly after the USB 2.0 
>> roothub
>>        * is setup.
>>        */
>> @@ -572,7 +572,7 @@ void xhci_stop(struct usb_hcd *hcd)
>>   {
>>       u32 temp;
>>       struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>> -    struct xhci_interrupter *ir = xhci->interrupter;
>> +    struct xhci_interrupter *ir = xhci->interrupters[0];
>>       mutex_lock(&xhci->mutex);
>> @@ -668,36 +668,49 @@ EXPORT_SYMBOL_GPL(xhci_shutdown);
>>   #ifdef CONFIG_PM
>>   static void xhci_save_registers(struct xhci_hcd *xhci)
>>   {
>> -    struct xhci_interrupter *ir = xhci->interrupter;
>> +    struct xhci_interrupter *ir;
>> +    unsigned int i;
>>       xhci->s3.command = readl(&xhci->op_regs->command);
>>       xhci->s3.dev_nt = readl(&xhci->op_regs->dev_notification);
>>       xhci->s3.dcbaa_ptr = xhci_read_64(xhci,&xhci->op_regs->dcbaa_ptr);
>>       xhci->s3.config_reg = readl(&xhci->op_regs->config_reg);
>> -    if (!ir)
>> -        return;
>> +    /* save both primary and all secondary interrupters */
>> +    for (i = 0; i < xhci->max_interrupters; i++) {
>> +        ir = xhci->interrupters[i];
>> +        if (!ir)
>> +            continue;
>> -    ir->s3_erst_size = readl(&ir->ir_set->erst_size);
>> -    ir->s3_erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
>> -    ir->s3_erst_dequeue = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
>> -    ir->s3_irq_pending = readl(&ir->ir_set->irq_pending);
>> -    ir->s3_irq_control = readl(&ir->ir_set->irq_control);
>> +        ir->s3_erst_size = readl(&ir->ir_set->erst_size);
>> +        ir->s3_erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
>> +        ir->s3_erst_dequeue = xhci_read_64(xhci, 
>> &ir->ir_set->erst_dequeue);
>> +        ir->s3_irq_pending = readl(&ir->ir_set->irq_pending);
>> +        ir->s3_irq_control = readl(&ir->ir_set->irq_control);
>> +    }
>>   }
>>   static void xhci_restore_registers(struct xhci_hcd *xhci)
>>   {
>> -    struct xhci_interrupter *ir = xhci->interrupter;
>> +    struct xhci_interrupter *ir;
>> +    unsigned int i;
>>       writel(xhci->s3.command, &xhci->op_regs->command);
>>       writel(xhci->s3.dev_nt, &xhci->op_regs->dev_notification);
>>       xhci_write_64(xhci, xhci->s3.dcbaa_ptr, &xhci->op_regs->dcbaa_ptr);
>>       writel(xhci->s3.config_reg, &xhci->op_regs->config_reg);
>> -    writel(ir->s3_erst_size, &ir->ir_set->erst_size);
>> -    xhci_write_64(xhci, ir->s3_erst_base, &ir->ir_set->erst_base);
>> -    xhci_write_64(xhci, ir->s3_erst_dequeue, &ir->ir_set->erst_dequeue);
>> -    writel(ir->s3_irq_pending, &ir->ir_set->irq_pending);
>> -    writel(ir->s3_irq_control, &ir->ir_set->irq_control);
>> +
>> +    for (i = 0; i < xhci->max_interrupters; i++) {
>> +        ir = xhci->interrupters[i];
>> +        if (!ir)
>> +            continue;
>> +
>> +        writel(ir->s3_erst_size, &ir->ir_set->erst_size);
>> +        xhci_write_64(xhci, ir->s3_erst_base, &ir->ir_set->erst_base);
>> +        xhci_write_64(xhci, ir->s3_erst_dequeue, 
>> &ir->ir_set->erst_dequeue);
>> +        writel(ir->s3_irq_pending, &ir->ir_set->irq_pending);
>> +        writel(ir->s3_irq_control, &ir->ir_set->irq_control);
>> +    }
>>   }
>>   static void xhci_set_cmd_ring_deq(struct xhci_hcd *xhci)
>> @@ -1059,7 +1072,7 @@ int xhci_resume(struct xhci_hcd *xhci, 
>> pm_message_t msg)
>>           xhci_dbg(xhci, "// Disabling event ring interrupts\n");
>>           temp = readl(&xhci->op_regs->status);
>>           writel((temp & ~0x1fff) | STS_EINT, &xhci->op_regs->status);
>> -        xhci_disable_interrupter(xhci->interrupter);
>> +        xhci_disable_interrupter(xhci->interrupters[0]);
>>           xhci_dbg(xhci, "cleaning up memory\n");
>>           xhci_mem_cleanup(xhci);
> 
> All code above looks like it should be its own patch.
> 
> The header shuffling below part of somethine else.
>  >> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>> index 7e282b4522c0..d706a27ec0a3 100644
>> --- a/drivers/usb/host/xhci.h
>> +++ b/drivers/usb/host/xhci.h
>> @@ -17,6 +17,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/usb/hcd.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>> +#include <linux/usb/xhci-intr.h>
>>   /* Code sharing between pci-quirks and xhci hcd */
>>   #include    "xhci-ext-caps.h"
>> @@ -1541,18 +1542,6 @@ static inline const char 
>> *xhci_trb_type_string(u8 type)
>>   #define AVOID_BEI_INTERVAL_MIN    8
>>   #define AVOID_BEI_INTERVAL_MAX    32
>> -struct xhci_segment {
>> -    union xhci_trb        *trbs;
>> -    /* private to HCD */
>> -    struct xhci_segment    *next;
>> -    dma_addr_t       dma;
>> -    /* Max packet sized bounce buffer for td-fragmant alignment */
>> -    dma_addr_t       bounce_dma;
>> -    void            *bounce_buf;
>> -    unsigned int        bounce_offs;
>> -    unsigned int        bounce_len;
>> -};
>> -
>>   enum xhci_cancelled_td_status {
>>       TD_DIRTY = 0,
>>       TD_HALTED,
>> @@ -1585,16 +1574,6 @@ struct xhci_cd {
>>       union xhci_trb        *cmd_trb;
>>   };
>> -enum xhci_ring_type {
>> -    TYPE_CTRL = 0,
>> -    TYPE_ISOC,
>> -    TYPE_BULK,
>> -    TYPE_INTR,
>> -    TYPE_STREAM,
>> -    TYPE_COMMAND,
>> -    TYPE_EVENT,
>> -};
>> -
>>   static inline const char *xhci_ring_type_string(enum xhci_ring_type 
>> type)
>>   {
>>       switch (type) {
>> @@ -1615,46 +1594,6 @@ static inline const char 
>> *xhci_ring_type_string(enum xhci_ring_type type)
>>       }
>>       return "UNKNOWN";
>> -}
>> -
>> -struct xhci_ring {
>> -    struct xhci_segment    *first_seg;
>> -    struct xhci_segment    *last_seg;
>> -    union  xhci_trb        *enqueue;
>> -    struct xhci_segment    *enq_seg;
>> -    union  xhci_trb        *dequeue;
>> -    struct xhci_segment    *deq_seg;
>> -    struct list_head    td_list;
>> -    /*
>> -     * Write the cycle state into the TRB cycle field to give 
>> ownership of
>> -     * the TRB to the host controller (if we are the producer), or to 
>> check
>> -     * if we own the TRB (if we are the consumer).  See section 4.9.1.
>> -     */
>> -    u32            cycle_state;
>> -    unsigned int        stream_id;
>> -    unsigned int        num_segs;
>> -    unsigned int        num_trbs_free; /* used only by xhci DbC */
>> -    unsigned int        bounce_buf_len;
>> -    enum xhci_ring_type    type;
>> -    bool            last_td_was_short;
>> -    struct radix_tree_root    *trb_address_map;
>> -};
>> -
>> -struct xhci_erst_entry {
>> -    /* 64-bit event ring segment address */
>> -    __le64    seg_addr;
>> -    __le32    seg_size;
>> -    /* Set to zero */
>> -    __le32    rsvd;
>> -};
>> -
>> -struct xhci_erst {
>> -    struct xhci_erst_entry    *entries;
>> -    unsigned int        num_entries;
>> -    /* xhci->event_ring keeps track of segment dma addresses */
>> -    dma_addr_t       erst_dma_addr;
>> -    /* Num entries the ERST can contain */
>> -    unsigned int        erst_size;
>>   };
>>   struct xhci_scratchpad {
>> @@ -1707,18 +1646,6 @@ struct xhci_bus_state {
>>       unsigned long        resuming_ports;
>>   };
>> -struct xhci_interrupter {
>> -    struct xhci_ring    *event_ring;
>> -    struct xhci_erst    erst;
>> -    struct xhci_intr_reg __iomem *ir_set;
>> -    unsigned int        intr_num;
>> -    /* For interrupter registers save and restore over suspend/resume */
>> -    u32    s3_irq_pending;
>> -    u32    s3_irq_control;
>> -    u32    s3_erst_size;
>> -    u64    s3_erst_base;
>> -    u64    s3_erst_dequeue;
>> -};
>>   /*
>>    * It can take up to 20 ms to transition from RExit to U0 onthe
>>    * Intel Lynx Point LP xHCI host.
>> @@ -1799,7 +1726,7 @@ struct xhci_hcd {
>>       struct reset_control *reset;
>>       /* data structures */
>>       struct xhci_device_context_array *dcbaa;
>> -    struct xhci_interrupter *interrupter;
>> +    struct xhci_interrupter **interrupters;
>>       struct xhci_ring    *cmd_ring;
>>       unsigned int            cmd_ring_state;
>>   #define CMD_RING_STATE_RUNNING         (1 << 0)
>> diff --git a/include/linux/usb/xhci-intr.h 
>> b/include/linux/usb/xhci-intr.h
>> new file mode 100644
>> index 000000000000..e0091ee2c73a
>> --- /dev/null
>> +++ b/include/linux/usb/xhci-intr.h
>> @@ -0,0 +1,86 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __LINUX_XHCI_INTR_H
>> +#define __LINUX_XHCI_INTR_H
>> +
>> +#include <linux/kernel.h>
>> +
>> +struct xhci_erst_entry {
>> +    /* 64-bit event ring segment address */
>> +    __le64    seg_addr;
>> +    __le32    seg_size;
>> +    /* Set to zero */
>> +    __le32    rsvd;
>> +};
>> +
>> +enum xhci_ring_type {
>> +    TYPE_CTRL = 0,
>> +    TYPE_ISOC,
>> +    TYPE_BULK,
>> +    TYPE_INTR,
>> +    TYPE_STREAM,
>> +    TYPE_COMMAND,
>> +    TYPE_EVENT,
>> +};
>> +
>> +struct xhci_erst {
>> +    struct xhci_erst_entry    *entries;
>> +    unsigned int        num_entries;
>> +    /* xhci->event_ring keeps track of segment dma addresses */
>> +    dma_addr_t       erst_dma_addr;
>> +    /* Num entries the ERST can contain */
>> +    unsigned int        erst_size;
>> +};
>> +
>> +struct xhci_segment {
>> +    union xhci_trb        *trbs;
>> +    /* private to HCD */
>> +    struct xhci_segment    *next;
>> +    dma_addr_t       dma;
>> +    /* Max packet sized bounce buffer for td-fragmant alignment */
>> +    dma_addr_t       bounce_dma;
>> +    void            *bounce_buf;
>> +    unsigned int        bounce_offs;
>> +    unsigned int        bounce_len;
>> +};
>> +
>> +struct xhci_ring {
>> +    struct xhci_segment    *first_seg;
>> +    struct xhci_segment    *last_seg;
>> +    union  xhci_trb        *enqueue;
>> +    struct xhci_segment    *enq_seg;
>> +    union  xhci_trb        *dequeue;
>> +    struct xhci_segment    *deq_seg;
>> +    struct list_head    td_list;
>> +    /*
>> +     * Write the cycle state into the TRB cycle field to give 
>> ownership of
>> +     * the TRB to the host controller (if we are the producer), or to 
>> check
>> +     * if we own the TRB (if we are the consumer).  See section 4.9.1.
>> +     */
>> +    u32            cycle_state;
>> +    unsigned int        stream_id;
>> +    unsigned int        num_segs;
>> +    unsigned int        num_trbs_free;
>> +    unsigned int        num_trbs_free_temp;
>> +    unsigned int        bounce_buf_len;
>> +    enum xhci_ring_type    type;
>> +    bool            last_td_was_short;
>> +    struct radix_tree_root    *trb_address_map;
>> +};
>> +
>> +struct xhci_interrupter {
>> +    struct xhci_ring    *event_ring;
>> +    struct xhci_erst    erst;
>> +    struct xhci_intr_reg __iomem *ir_set;
>> +    unsigned int        intr_num;
>> +    /* For interrupter registers save and restore over suspend/resume */
>> +    u32    s3_irq_pending;
>> +    u32    s3_irq_control;
>> +    u32    s3_erst_size;
>> +    u64    s3_erst_base;
>> +    u64    s3_erst_dequeue;
>> +};
>> +
>> +struct xhci_interrupter *
>> +xhci_create_secondary_interrupter(struct usb_hcd *hcd);
>> +void xhci_remove_secondary_interrupter(struct usb_hcd *hcd, struct 
>> xhci_interrupter *ir);
>> +#endif
>>
> 
> Not convinced we want to share all these xhci private structures in a 
> separate
> header outside of the xhci code.
> 
> As much as possible should be abstracted and added to the xhci sideband
> API in patch 3/33 instead of sharing these.

It gets a bit difficult because xhci_create_secondary_interrupter() will 
return struct xhci_interrupter, so that the class (offload) driver can 
fetch information about the event ring.  So part of that is that the 
class driver has to reference struct xhci_ring as well.

Instead of exposing all these into a header file, what do you think 
about adding the drivers/xhci path as an include directory in the class 
driver make arguments in the makefile?

Thanks
Wesley Cheng
