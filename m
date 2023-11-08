Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5267E5889
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjKHOT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjKHOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:19:25 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B80C1FC3;
        Wed,  8 Nov 2023 06:19:23 -0800 (PST)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A75209CC;
        Wed,  8 Nov 2023 15:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699453140;
        bh=yStNjADaT5ZcsiE8x3Oa1LhD4fZZvecWjz5Q4pBKu24=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FMiQMMUuMpvrxHhgyWuPKgLDmFdvqblog7C3YVsfvsQvW400Vh74bz8TqMbk+D0+s
         jxnfMUQgcP99iUJKJ83Mm8ZXn3S2YK1p4y/G+nCfeYH9qa49iDj6H0fP8zB+PDu0VI
         MJVvteZ61KUcEuGPWI1xHFp/FiIAZjcScOHuGB4c=
Message-ID: <9ee4f736-e346-4b92-9a6d-8104d87132fc@ideasonboard.com>
Date:   Wed, 8 Nov 2023 14:19:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Content-Language: en-US
To:     Kuen-Han Tsai <khtsai@google.com>
Cc:     gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        michal.simek@amd.com, piyush.mehta@amd.com,
        radhey.shyam.pandey@amd.com, siva.durga.prasad.paladugu@amd.com
References: <80a05f4a-eaae-4db1-9604-c5eed9ff594c@ideasonboard.com>
 <20231108114848.794045-1-khtsai@google.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
Autocrypt: addr=dan.scally@ideasonboard.com; keydata=
 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
In-Reply-To: <20231108114848.794045-1-khtsai@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 08/11/2023 11:48, Kuen-Han Tsai wrote:
> On 02/11/2023 07:11, Piyush Mehta wrote:
>> There could be chances where the usb_ep_queue() could fail and trigger
>> complete() handler with error status. In this case, if usb_ep_queue()
>> is called with lock held and the triggered complete() handler is waiting
>> for the same lock to be cleared could result in a deadlock situation and
>> could result in system hang. To aviod this scenerio, call usb_ep_queue()
>> with lock removed. This patch does the same.
> I would like to provide more background information on this problem.
>
> We met a deadlock issue on Android devices and the followings are stack traces.
>
> [35845.978435][T18021] Core - Debugging Information for Hardlockup core(8) - locked CPUs mask (0x100)
> [35845.978442][T18021] Call trace:
> [*][T18021]  queued_spin_lock_slowpath+0x84/0x388
> [35845.978451][T18021]  uvc_video_complete+0x180/0x24c
> [35845.978458][T18021]  usb_gadget_giveback_request+0x38/0x14c
> [35845.978464][T18021]  dwc3_gadget_giveback+0xe4/0x218
> [35845.978469][T18021]  dwc3_gadget_ep_cleanup_cancelled_requests+0xc8/0x108
> [35845.978474][T18021]  __dwc3_gadget_kick_transfer+0x34c/0x368
> [35845.978479][T18021]  __dwc3_gadget_start_isoc+0x13c/0x3b8
> [35845.978483][T18021]  dwc3_gadget_ep_queue+0x150/0x2f0
> [35845.978488][T18021]  usb_ep_queue+0x58/0x16c
> [35845.978493][T18021]  uvcg_video_pump+0x22c/0x518
>
> As mentioned by Piyush, the uvcg_video_pump function acquires a spinlock before submitting the USB
> request to the endpoint, which will be processed by the dwc3 controller in our case.
>
> However, a deadlock can occur when the dwc3 controller fails to kick the transfer and decides to
> cancel and clean up all requests. At this point, the dwc3 driver calls the giveback function asking
> the corresponding driver to handle the cancellation. The uvcg_queue_cancel function then acquires
> the same spinlock to cancel the request, which results in a double acquirement and a deadlock.


Yep - I understand. I think the locking change looks fine, it's just the addition of the 
usb_ep_set_halt() that doesn't seem necessary.

>
>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>> ---
>>    drivers/usb/gadget/function/uvc_video.c | 5 +++--
>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
>> index 91af3b1ef0d4..0a5d9ac145e7 100644
>> --- a/drivers/usb/gadget/function/uvc_video.c
>> +++ b/drivers/usb/gadget/function/uvc_video.c
>> @@ -460,11 +460,12 @@ static void uvcg_video_pump(struct work_struct *work)
>>    			req->no_interrupt = 1;
>>    		}
>>
>> -		/* Queue the USB request */
>> -		ret = uvcg_video_ep_queue(video, req);
>>    		spin_unlock_irqrestore(&queue->irqlock, flags);
>>
>> +		/* Queue the USB request */
>> +		ret = uvcg_video_ep_queue(video, req);
>>    		if (ret < 0) {
>> +			usb_ep_set_halt(video->ep);
>>    			uvcg_queue_cancel(queue, 0);
>>    			break;
>>    		}
