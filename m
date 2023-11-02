Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACFE7DF3CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376485AbjKBNaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjKBNaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:30:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB9134;
        Thu,  2 Nov 2023 06:30:00 -0700 (PDT)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C2889276;
        Thu,  2 Nov 2023 14:29:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698931779;
        bh=/sh9prC++Fc6zpNGsPMkNaDs3jMJdd1ngbFquFJ+6wQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X2MiJtqP7DxyBPPPJX6eEuqL4tkGUJpvWm3wa3OOtNPmq70BiZ1wF0jqtfMi2dlxY
         959DEz7og2Xyg79lV8gCBbnc+7Gt8JIci1c6py2Oy2cZ+7s1IGifPC4eI98fHglmUF
         9IPvaFUtDlbpEd2XXLJ0i8957WuNWtpt5X6gYFT0=
Message-ID: <3219a0bd-97a8-4e84-9873-ddd508149b98@ideasonboard.com>
Date:   Thu, 2 Nov 2023 13:29:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] usb: gadget: uvc: Fix use-after-free for inflight
 usb_requests
Content-Language: en-US
To:     Avichal Rakesh <arakesh@google.com>
Cc:     etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.grzeschik@pengutronix.de
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
 <20231027201959.1869181-1-arakesh@google.com>
 <20231027201959.1869181-4-arakesh@google.com>
 <6d7b5ba5-9037-4a3e-a6b0-6b4ad6c8700a@ideasonboard.com>
 <7f5f38fb-3c32-437f-8a3b-e94fa923fec4@google.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
Autocrypt: addr=dan.scally@ideasonboard.com; keydata=
 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
In-Reply-To: <7f5f38fb-3c32-437f-8a3b-e94fa923fec4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avichal

On 30/10/2023 20:56, Avichal Rakesh wrote:
> Thank you for taking a look Dan!
>
> On 10/28/23 13:56, Dan Scally wrote:
>> Hi Avichal
>>
>> On 27/10/2023 21:19, Avichal Rakesh wrote:
>>> Currently, the uvc gadget driver allocates all uvc_requests as one array
>>> and deallocates them all when the video stream stops. This includes
>>> de-allocating all the usb_requests associated with those uvc_requests.
>>> This can lead to use-after-free issues if any of those de-allocated
>>> usb_requests were still owned by the usb controller.
>>>
>>> This is patch 2 of 2 in fixing the use-after-free issue. It adds a new
>>> flag to uvc_video to track when frames and requests should be flowing.
>>> When disabling the video stream, the flag is tripped and, instead
>>> of de-allocating all uvc_requests and usb_requests, the gadget
>>> driver only de-allocates those usb_requests that are currently
>>> owned by it (as present in req_free). Other usb_requests are left
>>> untouched until their completion handler is called which takes care
>>> of freeing the usb_request and its corresponding uvc_request.
>>>
>>> Now that uvc_video does not depends on uvc->state, this patch removes
>>> unnecessary upates to uvc->state that were made to accommodate uvc_video
>>> logic. This should ensure that uvc gadget driver never accidentally
>>> de-allocates a usb_request that it doesn't own.
>>>
>>> Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.com
>>> Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>> Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>> Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>> Signed-off-by: Avichal Rakesh <arakesh@google.com>
>>> ---
>>> v1 -> v2: Rebased to ToT, and fixed deadlock reported in
>>>             https://lore.kernel.org/all/ZRv2UnKztgyqk2pt@pengutronix.de/
>>> v2 -> v3: Fix email threading goof-up
>>> v3 -> v4: re-rebase to ToT & moved to a uvc_video level lock
>>>             as discussed in
>>>             https://lore.kernel.org/b14b296f-2e08-4edf-aeea-1c5b621e2d0c@google.com/
>>> v4 -> v5: Address review comments. Add Reviewed-by & Tested-by.
>>> v5 -> v6: Added another patch before this one to make uvcg_video_disable
>>>             easier to review.
>>> v6 -> v7: Fix warning reported in
>>>             https://lore.kernel.org/202310200457.GwPPFuHX-lkp@intel.com/
>>> v7 -> v8: No change. Getting back in review queue
>>> v8 -> v9: No change.
>>>
>>>    drivers/usb/gadget/function/uvc.h       |   1 +
>>>    drivers/usb/gadget/function/uvc_v4l2.c  |  12 +--
>>>    drivers/usb/gadget/function/uvc_video.c | 128 ++++++++++++++++++++----
>>>    3 files changed, 111 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
>>> index 993694da0bbc..be0d012aa244 100644
>>> --- a/drivers/usb/gadget/function/uvc.h
>>> +++ b/drivers/usb/gadget/function/uvc.h
>>> @@ -102,6 +102,7 @@ struct uvc_video {
>>>        unsigned int uvc_num_requests;
>>>
>>>        /* Requests */
>>> +    bool is_enabled; /* tracks whether video stream is enabled */
>>>        unsigned int req_size;
>>>        struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
>>>        struct list_head req_free;
>>> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
>>> index 904dd283cbf7..2f8634e05612 100644
>>> --- a/drivers/usb/gadget/function/uvc_v4l2.c
>>> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
>>> @@ -451,8 +451,8 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
>>>         * Complete the alternate setting selection setup phase now that
>>>         * userspace is ready to provide video frames.
>>>         */
>>> -    uvc_function_setup_continue(uvc, 0);
>>>        uvc->state = UVC_STATE_STREAMING;
>>> +    uvc_function_setup_continue(uvc, 0);
>>>
>>>        return 0;
>>>    }
>>> @@ -468,11 +468,11 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
>>>        if (type != video->queue.queue.type)
>>>            return -EINVAL;
>>>
>>> -    uvc->state = UVC_STATE_CONNECTED;
>>>        ret = uvcg_video_disable(video);
>>>        if (ret < 0)
>>>            return ret;
>>>
>>> +    uvc->state = UVC_STATE_CONNECTED;
>>>        uvc_function_setup_continue(uvc, 1);
>>>        return 0;
>>>    }
>>
>> I'm not sure I understand what these re-orderings are for...can you explain please?
> This specific one was a leftover from testing, removed this hunk.
> But the ones below are undoing the change in patch 1, which is
> flawed in its use of uvc->state without any memory guarantees.
>
> So from patch 1 to patch 4, we shuffle the code around a bit,
> but this makes patch 1 somewhat complete and functional even if
> patch 4 were to be reverted.


Okedokey - that's fine (and good)

>
>>> @@ -507,14 +507,6 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
>>>    static void uvc_v4l2_disable(struct uvc_device *uvc)
>>>    {
>>>        uvc_function_disconnect(uvc);
>>> -    /*
>>> -     * Drop uvc->state to CONNECTED if it was streaming before.
>>> -     * This ensures that the usb_requests are no longer queued
>>> -     * to the controller.
>>> -     */
>>> -    if (uvc->state == UVC_STATE_STREAMING)
>>> -        uvc->state = UVC_STATE_CONNECTED;
>>> -
>>>        uvcg_video_disable(&uvc->video);
>>>        uvcg_free_buffers(&uvc->video.queue);
>>>        uvc->func_connected = false;
>>> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
>>> index 1081dd790fd6..8f330ce696ec 100644
>>> --- a/drivers/usb/gadget/function/uvc_video.c
>>> +++ b/drivers/usb/gadget/function/uvc_video.c
>>> @@ -227,6 +227,9 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
>>>     * Request handling
>>>     */
>>>
>>> +/*
>>> + * Must be called with req_lock held as it modifies the list ureq is held in
>>> + */
>>
>>
>> This comment probably belongs in patch #2. And in that case, shouldn't uvc_video_free_requests() hold the lock in that patch?
> Patch 2 doesn't change any existing locking semantics. The current
> code does not enforce any locking on freeing the requests, and neither
> does patch 2.
>
> Patch 4 introduces another call site for uvc_video_free_request, so
> some synchronization guarantees are needed (and hence the addition
> of this comment).
>
> As for uvc_video_free_requests not holding the lock, it is safe because
> uvc_video_free_requests is only called if request initialization fails.
> So uvc_video_free_requests should be the thread safe, as no other thread
> is processing requests when it is called.
>
> I did add a comment in uvcg_video_enable mentioning why it is safe to
> not hold req_free even though it accesses request related fields.


I understand, but in that case I think the comment is a little confusing - it's not the fact that 
the function modifies the list ureq is held in that requires it to be locked but that there're 
potentially multiple threads doing so. Can we go for something like "Callers must take care to hold 
req_lock when using this function outside of a single thread"? Feel free to re-word that however you 
like, as long as it's clear that it's only necessary when multiple threads could be active.

>
> Happy to add another comment to uvc_video_free_requests if that makes it
> clearer!
>
>>>    static void
>>>    uvc_video_free_request(struct uvc_request *ureq, struct usb_ep *ep)
>>>    {
>>> @@ -271,9 +274,25 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>>>        struct uvc_request *ureq = req->context;
>>>        struct uvc_video *video = ureq->video;
>>>        struct uvc_video_queue *queue = &video->queue;
>>> -    struct uvc_device *uvc = video->uvc;
>>> +    struct uvc_buffer *last_buf = NULL;


This initialisation's unnecessary since it's unconditionally set below.

>>>        unsigned long flags;
>>>
>>> +    spin_lock_irqsave(&video->req_lock, flags);
>>> +    if (!video->is_enabled) {
>>> +        /*
>>> +         * When is_enabled is false, uvc_video_disable ensures that
>> s/uvc_video_disable/uvc_video_disable()
> Done!
>
>>> +         * in-flight uvc_buffers are returned, so we can safely
>>> +         * call free_request without worrying about last_buf.
>>> +         */
>>> +        uvc_video_free_request(ureq, ep);
>> Now I understand the conditional in this function in patch 2 :)
>>> +        spin_unlock_irqrestore(&video->req_lock, flags);
>>> +        return;
>>> +    }
>>> +
>>> +    last_buf = ureq->last_buf;
>>> +    ureq->last_buf = NULL;
>>> +    spin_unlock_irqrestore(&video->req_lock, flags);
>>
>> I'm not a huge fan of this locking, unlocking and relocking the same spinlock within the same function. Can we just hold the lock for the duration? if not, can there be an explanatory comment as to why?
> I agree that this is a little unfortunate, and it'd be nice if we
> only had a single driver level lock. However, as it stands, if
> we hold req_lock for the entirety of completion handler, we risk
> two things:
>
> 1. Adding dependencies between queue->irqlock and video->reqlock
> 2. Starving the video_pump thread.
>
> As of this patch, uvc_video_complete follows the same pattern as
> video_pump function:
> 1. Acquire req_lock
> 2. Fetch/Query usb_request
> 3. Drop req_lock
>
> 4. Acquire queue->irqlock
> 5. Buffer ops (encode/free/stop)
> 6. Drop queue->irqlock
>
> 7. Acquire req_lock
> 8. usb_request cleanup/handling
> 9. Drop req_lock
>
> (7), (8), and (9) are optional for video_pump, while
> (4), (5), and (6) are optional for uvc_video_complete.
>
> We can short-circuit uvc_video_complete with only one lock
> on the happy path, but this would have to be the flow for
> non-happy paths unless we want to hold the two locks at
> the same time (which isn't the worst idea, but comes with
> its own set of concerns).
>

Yeah. Sorry - I had missed that uvcg_video_pump() follows the same pattern too. Alright, I think 
leave this as-is.

>>> +
>>>        switch (req->status) {
>>>        case 0:
>>>            break;
>>> @@ -295,17 +314,26 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>>>            uvcg_queue_cancel(queue, 0);
>>>        }
>>>
>>> -    if (ureq->last_buf) {
>>> -        uvcg_complete_buffer(&video->queue, ureq->last_buf);
>>> -        ureq->last_buf = NULL;
>>> +    if (last_buf) {
>>> +        spin_lock_irqsave(&queue->irqlock, flags);
>>> +        uvcg_complete_buffer(&video->queue, last_buf);
>>> +        spin_unlock_irqrestore(&queue->irqlock, flags);
>>
>>
>> I think it's right to take the irqlock here but it probably should have always been held, so this probably ought to go in its own commit with a Fixes:
> The lock here wasn't required before, because uvcg_complete_buffer was
> only ever called by the completion handler, which is synchronized by
> the usb controller. This is the reason we never saw an issue despite
> not holding the lock.


Ah - I was misled by the "called with &queue_irqlock held..." comment on uvc_complete_buffer()...I 
assumed that meant "you must call this function with &queue->irqlock held", but that turns out to be 
something of a hangover - originally it was placed there by 95faf82bd3ea6 because the callers of (at 
the time uvc_queue_next_buffer(), later renamed to) uvcg_complete_buffer() already held the irqlock. 
Clearly it needed locking then, but the function at the time manipulated queue->irqqueue and now it 
no longer does - that part has been stripped out to encode_bulk/encode_isoc/encode_isoc_sg(). So, 
probably that comment ought to have been removed at some point.

> This patch introduces another call site in uvcg_video_disable, so to
> protect memory consistency, we need to make sure calls to
> uvcg_complete_buffer are synchronized on something other than
> the usb controller.

If it's simply to prevent double calling uvcg_complete_buffer() for a buffer, is holding the irqlock 
necessary? Both uvc_video_complete() and uvc_video_disable() conditionally call 
uvcg_complete_buffer() based on whether ureq->last_buf is set or not, and both functions assess that 
whilst holding req_lock, so unless I'm missing something that situation is already guarded against.


>
>>>        }
>>>
>>>        spin_lock_irqsave(&video->req_lock, flags);
>>> -    list_add_tail(&req->list, &video->req_free);
>>> -    spin_unlock_irqrestore(&video->req_lock, flags);
>>> -
>>> -    if (uvc->state == UVC_STATE_STREAMING)
>>> +    /*
>>> +     * Video stream might have been disabled while we were
>>> +     * processing the current usb_request. So make sure
>>> +     * we're still streaming before queueing the usb_request
>>> +     * back to req_free
>>> +     */
>>> +    if (video->is_enabled) {
>>> +        list_add_tail(&req->list, &video->req_free);
>>>            queue_work(video->async_wq, &video->pump);
>>> +    } else {
>>> +        uvc_video_free_request(ureq, ep);
>>> +    }
>>> +    spin_unlock_irqrestore(&video->req_lock, flags);
>>>    }
>>>
>>>    static int
>>> @@ -393,20 +421,22 @@ static void uvcg_video_pump(struct work_struct *work)
>>>        struct uvc_video_queue *queue = &video->queue;
>>>        /* video->max_payload_size is only set when using bulk transfer */
>>>        bool is_bulk = video->max_payload_size;
>>> -    struct uvc_device *uvc = video->uvc;
>>>        struct usb_request *req = NULL;
>>>        struct uvc_buffer *buf;
>>>        unsigned long flags;
>>>        bool buf_done;
>>>        int ret;
>>>
>>> -    while (uvc->state == UVC_STATE_STREAMING && video->ep->enabled) {
>>> +    while (true) {
>>> +        if (!video->ep->enabled)
>>> +            return;
>>> +
>>>            /*
>>> -         * Retrieve the first available USB request, protected by the
>>> -         * request lock.
>>> +         * Check is_enabled and retrieve the first available USB
>>> +         * request, protected by the request lock.
>>>             */
>>>            spin_lock_irqsave(&video->req_lock, flags);
>>> -        if (list_empty(&video->req_free)) {
>>> +        if (!video->is_enabled || list_empty(&video->req_free)) {
>>>                spin_unlock_irqrestore(&video->req_lock, flags);
>>>                return;
>>>            }
>>> @@ -488,9 +518,11 @@ static void uvcg_video_pump(struct work_struct *work)
>>>            return;
>>>
>>>        spin_lock_irqsave(&video->req_lock, flags);
>>> -    list_add_tail(&req->list, &video->req_free);
>>> +    if (video->is_enabled)
>>> +        list_add_tail(&req->list, &video->req_free);
>>> +    else
>>> +        uvc_video_free_request(req->context, video->ep);
>>>        spin_unlock_irqrestore(&video->req_lock, flags);
>>> -    return;
>>>    }
>>>
>>>    /*
>>> @@ -499,7 +531,11 @@ static void uvcg_video_pump(struct work_struct *work)
>>>    int
>>>    uvcg_video_disable(struct uvc_video *video)
>>>    {
>>> -    struct uvc_request *ureq;
>>> +    unsigned long flags;
>>> +    struct list_head inflight_bufs;
>>> +    struct usb_request *req, *temp;
>>> +    struct uvc_buffer *buf, *btemp;
>>> +    struct uvc_request *ureq, *utemp;
>>>
>>>        if (video->ep == NULL) {
>>>            uvcg_info(&video->uvc->func,
>>> @@ -507,15 +543,58 @@ uvcg_video_disable(struct uvc_video *video)
>>>            return -ENODEV;
>>>        }
>>>
>>> +    INIT_LIST_HEAD(&inflight_bufs);
>>> +    spin_lock_irqsave(&video->req_lock, flags);
>>> +    video->is_enabled = false;
>>> +
>>> +    /*
>>> +     * Remove any in-flight buffers from the uvc_requests
>>> +     * because we want to return them before cancelling the
>>> +     * queue. This ensures that we aren't stuck waiting for
>>> +     * all complete callbacks to come through before disabling
>>> +     * vb2 queue.
>>> +     */
>>> +    list_for_each_entry(ureq, &video->ureqs, list) {
>>> +        if (ureq->last_buf) {
>>> +            list_add_tail(&ureq->last_buf->queue, &inflight_bufs);
>>> +            ureq->last_buf = NULL;
>>> +        }
>>> +    }
>>> +    spin_unlock_irqrestore(&video->req_lock, flags);
>>> +
>>>        cancel_work_sync(&video->pump);
>>>        uvcg_queue_cancel(&video->queue, 0);
>>>
>>> -    list_for_each_entry(ureq, &video->ureqs, list) {
>>> -        if (ureq->req)
>>> -            usb_ep_dequeue(video->ep, ureq->req);
>>> +    spin_lock_irqsave(&video->req_lock, flags);
>>> +    /*
>>> +     * Remove all uvc_reqeusts from ureqs with list_del_init
s/uvc_reqeusts/uvc_requests
>>> +     * This lets uvc_video_free_request correctly identify
>>> +     * if the uvc_request is attached to a list or not when freeing
>>> +     * memory.
>>> +     */
>>> +    list_for_each_entry_safe(ureq, utemp, &video->ureqs, list)
>>> +        list_del_init(&ureq->list);
>>> +
>>> +    list_for_each_entry_safe(req, temp, &video->req_free, list) {
>>> +        list_del(&req->list);
>>> +        uvc_video_free_request(req->context, video->ep);
>>>        }
>>>
>>> -    uvc_video_free_requests(video);
>>> +    INIT_LIST_HEAD(&video->ureqs);
>>> +    INIT_LIST_HEAD(&video->req_free);
>>> +    video->req_size = 0;
>>> +    spin_unlock_irqrestore(&video->req_lock, flags);
>>> +
>>> +    /*
>>> +     * Return all the video buffers before disabling the queue.
>>> +     */
>>> +    spin_lock_irqsave(&video->queue.irqlock, flags);
>>> +    list_for_each_entry_safe(buf, btemp, &inflight_bufs, queue) {
>>> +        list_del(&buf->queue);
>>> +        uvcg_complete_buffer(&video->queue, buf);
>>> +    }
>>> +    spin_unlock_irqrestore(&video->queue.irqlock, flags);
>>> +
>>>        uvcg_queue_enable(&video->queue, 0);
>>>        return 0;
>>>    }
>>> @@ -533,6 +612,14 @@ int uvcg_video_enable(struct uvc_video *video)
>>>            return -ENODEV;
>>>        }
>>>
>>> +    /*
>>> +     * Safe to access request related fields without req_lock because
>>> +     * this is the only thread currently active, and no other
>>> +     * request handling thread will become active until this function
>>> +     * returns.
>>> +     */
>>> +    video->is_enabled = true;
>>> +
>>>        if ((ret = uvcg_queue_enable(&video->queue, 1)) < 0)
>>>            return ret;
>>>
>>> @@ -558,6 +645,7 @@ int uvcg_video_enable(struct uvc_video *video)
>>>     */
>>>    int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
>>>    {
>>> +    video->is_enabled = false;
>>>        INIT_LIST_HEAD(&video->ureqs);
>>>        INIT_LIST_HEAD(&video->req_free);
>>>        spin_lock_init(&video->req_lock);
>>> -- 
>>> 2.42.0.820.g83a721a137-goog
