Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02B47B2821
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjI1WLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjI1WLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:11:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F90199;
        Thu, 28 Sep 2023 15:11:18 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SLMrYD005712;
        Thu, 28 Sep 2023 22:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uk+G1kp/tg9sdS+9uFAYBPz89f84jH42slLz163CM0A=;
 b=aNWY771bOrjm5LLfcK+bUkOwd2QJAYdn6UORXLtisHn8J0yGhx3AwhFwkN5a2vQL9F+m
 vExDIAjZSXaBJKCu/0xkb/zt2+uk+9W0IJX8XWoEID+N58NAwHhekr6qeGS97W0aZ1Lc
 hBPX21lNFDFNG+ATyKCfAxpQTenFu6P8d81FI0I6MXrTls0iCnmEM2J21X8OoJ95IQHy
 d71y9zZQFovSIgw4U3HJpxX89IFa4ytYVmMLy3PxfptcvriisQz7oOuVCbtzmnze2s5e
 vtYIl62J/0QdeUqnjMyA3x/c0jv0tK4i6PAmesVKbCSNHndVXOqQe2TMeBVsbFxBaFee hw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tct5gu7bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 22:10:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SMAa9R031137
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 22:10:36 GMT
Received: from [10.71.112.36] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 28 Sep
 2023 15:10:35 -0700
Message-ID: <0cbc80f2-4238-c9c6-7954-2d6d7e750446@quicinc.com>
Date:   Thu, 28 Sep 2023 15:10:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 02/33] xhci: add helper to stop endpoint and wait for
 completion
Content-Language: en-US
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
 <20230921214843.18450-3-quic_wcheng@quicinc.com>
 <6e9d2094-0bf9-b2ac-29f3-99115b456fdb@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <6e9d2094-0bf9-b2ac-29f3-99115b456fdb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N-MC0TjGQafJ131XUacYB100yuWmPZQF
X-Proofpoint-GUID: N-MC0TjGQafJ131XUacYB100yuWmPZQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_21,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280190
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 9/28/2023 6:31 AM, Mathias Nyman wrote:
> On 22.9.2023 0.48, Wesley Cheng wrote:
>> From: Mathias Nyman <mathias.nyman@linux.intel.com>
>>
>> Expose xhci_stop_endpoint_sync() which is a synchronous variant of
>> xhci_queue_stop_endpoint().  This is useful for client drivers that are
>> using the secondary interrupters, and need to stop/clean up the current
>> session.  The stop endpoint command handler will also take care of 
>> cleaning
>> up the ring.
>>
>> Modifications to repurpose the new API into existing stop endpoint
>> sequences was implemented by Wesley Cheng.
>>
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/host/xhci-hub.c | 29 +++---------------
>>   drivers/usb/host/xhci.c     | 60 +++++++++++++++++++++++++++----------
>>   drivers/usb/host/xhci.h     |  2 ++
>>   3 files changed, 50 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>> index 0054d02239e2..2f7309bdc922 100644
>> --- a/drivers/usb/host/xhci-hub.c
>> +++ b/drivers/usb/host/xhci-hub.c
>> @@ -489,7 +489,6 @@ EXPORT_SYMBOL_GPL(xhci_find_slot_id_by_port);
>>   static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int 
>> suspend)
>>   {
>>       struct xhci_virt_device *virt_dev;
>> -    struct xhci_command *cmd;
>>       unsigned long flags;
>>       int ret;
>>       int i;
>> @@ -501,10 +500,6 @@ static int xhci_stop_device(struct xhci_hcd 
>> *xhci, int slot_id, int suspend)
>>       trace_xhci_stop_device(virt_dev);
>> -    cmd = xhci_alloc_command(xhci, true, GFP_NOIO);
>> -    if (!cmd)
>> -        return -ENOMEM;
>> -
>>       spin_lock_irqsave(&xhci->lock, flags);
>>       for (i = LAST_EP_INDEX; i > 0; i--) {
>>           if (virt_dev->eps[i].ring && virt_dev->eps[i].ring->dequeue) {
>> @@ -521,7 +516,7 @@ static int xhci_stop_device(struct xhci_hcd *xhci, 
>> int slot_id, int suspend)
>>               if (!command) {
>>                   spin_unlock_irqrestore(&xhci->lock, flags);
>>                   ret = -ENOMEM;
>> -                goto cmd_cleanup;
>> +                goto out;
>>               }
>>               ret = xhci_queue_stop_endpoint(xhci, command, slot_id,
>> @@ -529,30 +524,14 @@ static int xhci_stop_device(struct xhci_hcd 
>> *xhci, int slot_id, int suspend)
>>               if (ret) {
>>                   spin_unlock_irqrestore(&xhci->lock, flags);
>>                   xhci_free_command(xhci, command);
>> -                goto cmd_cleanup;
>> +                goto out;
>>               }
>>           }
>>       }
>> -    ret = xhci_queue_stop_endpoint(xhci, cmd, slot_id, 0, suspend);
>> -    if (ret) {
>> -        spin_unlock_irqrestore(&xhci->lock, flags);
>> -        goto cmd_cleanup;
>> -    }
>> -
>> -    xhci_ring_cmd_db(xhci);
>>       spin_unlock_irqrestore(&xhci->lock, flags);
>> +    ret = xhci_stop_endpoint_sync(xhci, &virt_dev->eps[0], suspend);
> 
> I didn't take this new xhci_stop_endpoint_sync() helper into use as it 
> causes an extra
> xhci spinlock release and reacquire here.
> 
> Also the memory allocation flags differ, GFP_NOIO is turned into 
> GFP_KERNEL after this change.
> 

Thanks for the review.  I agree with the points made.  I wasn't sure if 
the extra unlock/lock would cause issues if we've already queued the 
stop ep for the other eps used by the device.

I think addressing the flags might be straightforward, we can just pass 
it in as an argument.  At least for this change in particular, is the 
concern that there could be another XHCI command queued before the stop 
endpoint command is?

>> -    /* Wait for last stop endpoint command to finish */
>> -    wait_for_completion(cmd->completion);
>> -
>> -    if (cmd->status == COMP_COMMAND_ABORTED ||
>> -        cmd->status == COMP_COMMAND_RING_STOPPED) {
>> -        xhci_warn(xhci, "Timeout while waiting for stop endpoint 
>> command\n");
>> -        ret = -ETIME;
>> -    }
>> -
>> -cmd_cleanup:
>> -    xhci_free_command(xhci, cmd);
>> +out:
>>       return ret;
>>   }
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index 3fd2b58ee1d3..163d533d6200 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -2758,6 +2758,46 @@ static int xhci_reserve_bandwidth(struct 
>> xhci_hcd *xhci,
>>       return -ENOMEM;
>>   }
>> +/*
>> + * Synchronous XHCI stop endpoint helper.  Issues the stop endpoint 
>> command and
>> + * waits for the command completion before returning.
>> + */
>> +int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct 
>> xhci_virt_ep *ep, int suspend)
>> +{
>> +    struct xhci_command *command;
>> +    unsigned long flags;
>> +    int ret;
>> +
>> +    command = xhci_alloc_command(xhci, true, GFP_KERNEL);
>> +    if (!command)
>> +        return -ENOMEM;
>> +
>> +    spin_lock_irqsave(&xhci->lock, flags);
>> +    ret = xhci_queue_stop_endpoint(xhci, command, ep->vdev->slot_id,
>> +                       ep->ep_index, suspend);
>> +    if (ret < 0) {
>> +        spin_unlock_irqrestore(&xhci->lock, flags);
>> +        goto out;
>> +    }
>> +
>> +    xhci_ring_cmd_db(xhci);
>> +    spin_unlock_irqrestore(&xhci->lock, flags);
>> +
>> +    ret = wait_for_completion_timeout(command->completion, 
>> msecs_to_jiffies(3000));
>> +    if (!ret)
>> +        xhci_warn(xhci, "%s: Unable to stop endpoint.\n",
>> +                __func__);
>> +
>> +    if (command->status == COMP_COMMAND_ABORTED ||
>> +        command->status == COMP_COMMAND_RING_STOPPED) {
>> +        xhci_warn(xhci, "Timeout while waiting for stop endpoint 
>> command\n");
>> +        ret = -ETIME;
>> +    }
>> +out:
>> +    xhci_free_command(xhci, command);
>> +
>> +    return ret;
>> +}
>>   /* Issue a configure endpoint command or evaluate context command
>>    * and wait for it to finish.
>> @@ -3078,7 +3118,7 @@ static void xhci_endpoint_reset(struct usb_hcd 
>> *hcd,
>>       struct xhci_virt_device *vdev;
>>       struct xhci_virt_ep *ep;
>>       struct xhci_input_control_ctx *ctrl_ctx;
>> -    struct xhci_command *stop_cmd, *cfg_cmd;
>> +    struct xhci_command *cfg_cmd;
>>       unsigned int ep_index;
>>       unsigned long flags;
>>       u32 ep_flag;
>> @@ -3118,10 +3158,6 @@ static void xhci_endpoint_reset(struct usb_hcd 
>> *hcd,
>>       if (ep_flag == SLOT_FLAG || ep_flag == EP0_FLAG)
>>           return;
>> -    stop_cmd = xhci_alloc_command(xhci, true, GFP_NOWAIT);
>> -    if (!stop_cmd)
>> -        return;
>> -
>>       cfg_cmd = xhci_alloc_command_with_ctx(xhci, true, GFP_NOWAIT);
>>       if (!cfg_cmd)
>>           goto cleanup;
>> @@ -3144,23 +3180,16 @@ static void xhci_endpoint_reset(struct usb_hcd 
>> *hcd,
>>           goto cleanup;
>>       }
>> -    err = xhci_queue_stop_endpoint(xhci, stop_cmd, udev->slot_id,
>> -                    ep_index, 0);
>> +    spin_unlock_irqrestore(&xhci->lock, flags);
>> +
> 
> Same here, extra unlock -> lock, and GFP flags differ.
> 
> 

My intention here (minus the GFP flags) was that the locking was mainly 
for setting the EP state flag -- EP_SOFT_CLEAR_TOGGLE.  If that was set, 
then new TD queues are blocked.  Seems like that was why there is a 
check like this afterwards:

if (!list_empty(&ep->ring->td_list)) {

So I believed that releasing the lock here was going to be ok, because 
by that point since the flag is set, nothing would be able to be added 
to the td_list.

Thanks
Wesley Cheng

