Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078937D4EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJXLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJXLPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F9B128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698146093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hTdyqatG5DouPXQmvRhvV630uEOjMrQcYsSlUwpigks=;
        b=Z++26uLLSvxd9rP1XSodSYeG9x9cJ2OTJeK+zd4747Vg1prBCj5iBH6SqBAdaL11ah1vpk
        yZG8pjMw8WPfS7NrSR8lPWI5pSKCZ9JKOOXOHJPqxHFFgUuQQ2BHZtVgLAa636gdAKjOA9
        dlEKdJiD0q3Ip4gpPMYWOhjUymaPh+o=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-p-4OzRUdOJqjcDDwuwq9MA-1; Tue, 24 Oct 2023 07:14:42 -0400
X-MC-Unique: p-4OzRUdOJqjcDDwuwq9MA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b2e44c8664so6560084b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698146081; x=1698750881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTdyqatG5DouPXQmvRhvV630uEOjMrQcYsSlUwpigks=;
        b=o4ln14ogZUTzz8i8nRrpG5yJ5xXq070nVM39eNxSuEh90AqNsAGJ+mJp4sBnyTvR5j
         RFnjv+D8FW3qnyhSr9KwQSY59Y0P47NQdZJW0jWE6RZxXM8eRuCHzvqe+BLoX/FR5vvM
         LVrN60JWpss+5VztvNMJpnb1vnSUP+3V2eGuFyTkPTzEGuHolHGyS4PDs8a5xO29Qhrx
         QhrlPJvWsCpZNqUp0nWkZdTZVW+S2FoDTZl/e598HyYwhS3FnrV+dsrbD7HOkT4V4MIA
         Wtt+VjjYts5Lu466druiqkiMl3rR0w3Dx8SJW3jS2jnkmgu+9/YqZVdOjTKWuqR/O11Y
         Aezg==
X-Gm-Message-State: AOJu0YxOpTOta0zSZJ90OLMHhg96Rjn+lKNF/Lq7eCBm7AliUeABMokH
        hmJOM9Sp34hO5qydvwBG7jRVH/p2annxQtYmwv1ZjBRWnHeGJvNPN7N0Hq+xdNkilLfieFpGMYD
        TM7Kox6WWbMdhswwZHn3rQAGg
X-Received: by 2002:a05:6808:f03:b0:3a4:298f:b2e0 with SMTP id m3-20020a0568080f0300b003a4298fb2e0mr15955769oiw.26.1698146081539;
        Tue, 24 Oct 2023 04:14:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKNI5AYRMTsJuglw0ECsi2x1XwuTEkDAmDMREWiGgSD3/8RH2NBaiXLDOgRkL//mKGI7rLwg==
X-Received: by 2002:a05:6808:f03:b0:3a4:298f:b2e0 with SMTP id m3-20020a0568080f0300b003a4298fb2e0mr15955745oiw.26.1698146081170;
        Tue, 24 Oct 2023 04:14:41 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id pm10-20020ad446ca000000b0066d1f118b7esm3576255qvb.1.2023.10.24.04.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:14:40 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:14:37 +0200
From:   Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To:     Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc:     mst@redhat.com, perex@perex.cz, tiwai@suse.com,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
Subject: Re: [PATCH v3] ALSA: virtio: use ack callback
Message-ID: <ZTenHeJ0LUTbMuTF@fedora>
References: <ZTaMEUZUTrRRUD6y@fedora>
 <a7808ac5-3f03-4584-93bc-485d358d57c1@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7808ac5-3f03-4584-93bc-485d358d57c1@opensynergy.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 09:11:10AM +0900, Anton Yakovlev wrote:
> Hi Matias,
> 
> Thanks for the new patch!
> 
> 
> 
> On 24.10.2023 00:06, Matias Ezequiel Vara Larsen wrote:
> > This commit uses the ack() callback to determine when a buffer has been
> > updated, then exposes it to guest.
> > 
> > The current mechanism splits a dma buffer into descriptors that are
> > exposed to the device. This dma buffer is shared with the user
> > application. When the device consumes a buffer, the driver moves the
> > request from the used ring to available ring.
> > 
> > The driver exposes the buffer to the device without knowing if the
> > content has been updated from the user. The section 2.8.21.1 of the
> > virtio spec states that: "The device MAY access the descriptor chains
> > the driver created and the memory they refer to immediately". If the
> > device picks up buffers from the available ring just after it is
> > notified, it happens that the content may be old.
> > 
> > When the ack() callback is invoked, the driver exposes only the buffers
> > that have already been updated, i.e., enqueued in the available ring.
> > Thus, the device always picks up a buffer that is updated.
> > 
> > For capturing, the driver starts by exposing all the available buffers
> > to device. After device updates the content of a buffer, it enqueues it
> > in the used ring. It is only after the ack() for capturing is issued
> > that the driver re-enqueues the buffer in the available ring.
> > 
> > Co-developed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> > ---
> > Changelog:
> > v2 -> v3:
> >   * Use ack() callback instead of copy()/fill_silence()
> >   * Change commit name
> >   * Rewrite commit message
> >   * Remove virtsnd_pcm_msg_send_locked()
> >   * Use single callback for both capture and playback
> >   * Fix kernel test robot warnings regarding documentation
> >   * v2 patch at:
> >     https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flkml%2f87y1fzkq8c.wl%2dtiwai%40suse.de%2fT%2f&umid=6a6586e6-1bcb-48d2-8c0c-75ef6bb15df9&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-090fe82db9a03f0dc8c4f214d4d2e2bf916e7f1f
> > v1 -> v2:
> >   * Use snd_pcm_set_managed_buffer_all()for buffer allocation/freeing.
> >   * Make virtsnd_pcm_msg_send() generic by specifying the offset and size
> >     for the modified part of the buffer; this way no assumptions need to
> >     be made.
> >   * Disable SNDRV_PCM_INFO_NO_REWINDS since now only sequential
> >     reading/writing of frames is supported.
> >   * Correct comment at virtsnd_pcm_msg_send().
> >   * v1 patch at:
> >     https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flkml%2f20231016151000.GE119987%40fedora%2ft%2f&umid=6a6586e6-1bcb-48d2-8c0c-75ef6bb15df9&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-2d4d809544c877beff1a631a29db01290c65d879
> > 
> >   sound/virtio/virtio_pcm.c     |  1 +
> >   sound/virtio/virtio_pcm.h     |  6 ++-
> >   sound/virtio/virtio_pcm_msg.c | 80 ++++++++++++++++++++---------------
> >   sound/virtio/virtio_pcm_ops.c | 30 +++++++++++--
> >   4 files changed, 79 insertions(+), 38 deletions(-)
> > 
> > diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> > index c10d91fff2fb..9cc5a95b4913 100644
> > --- a/sound/virtio/virtio_pcm.c
> > +++ b/sound/virtio/virtio_pcm.c
> > @@ -124,6 +124,7 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
> >   	values = le64_to_cpu(info->formats);
> >   	vss->hw.formats = 0;
> > +	vss->appl_ptr = 0;
> >   	for (i = 0; i < ARRAY_SIZE(g_v2a_format_map); ++i)
> >   		if (values & (1ULL << i)) {
> > diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
> > index 062eb8e8f2cf..ea3c2845ae9b 100644
> > --- a/sound/virtio/virtio_pcm.h
> > +++ b/sound/virtio/virtio_pcm.h
> > @@ -27,6 +27,7 @@ struct virtio_pcm_msg;
> >    *        substream operators.
> >    * @buffer_bytes: Current buffer size in bytes.
> >    * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
> > + * @appl_ptr: Substream application pointer value in bytes [0 ... buffer_bytes).
> >    * @xfer_enabled: Data transfer state (0 - off, 1 - on).
> >    * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
> >    * @stopped: True if the substream is stopped and must be released on the device
> > @@ -51,13 +52,13 @@ struct virtio_pcm_substream {
> >   	spinlock_t lock;
> >   	size_t buffer_bytes;
> >   	size_t hw_ptr;
> > +	size_t appl_ptr;
> >   	bool xfer_enabled;
> >   	bool xfer_xrun;
> >   	bool stopped;
> >   	bool suspended;
> >   	struct virtio_pcm_msg **msgs;
> >   	unsigned int nmsgs;
> > -	int msg_last_enqueued;
> >   	unsigned int msg_count;
> >   	wait_queue_head_t msg_empty;
> >   };
> > @@ -117,7 +118,8 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
> >   void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
> > -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss);
> > +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
> > +			 unsigned long bytes);
> >   unsigned int virtsnd_pcm_msg_pending_num(struct virtio_pcm_substream *vss);
> > diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> > index aca2dc1989ba..106e8e847746 100644
> > --- a/sound/virtio/virtio_pcm_msg.c
> > +++ b/sound/virtio/virtio_pcm_msg.c
> > @@ -155,7 +155,6 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
> >   			    sizeof(msg->xfer));
> >   		sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], &msg->status,
> >   			    sizeof(msg->status));
> > -		msg->length = period_bytes;
> >   		virtsnd_pcm_sg_from(&msg->sgs[PCM_MSG_SG_DATA], sg_num, data,
> >   				    period_bytes);
> > @@ -181,66 +180,81 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
> >   	vss->msgs = NULL;
> >   	vss->nmsgs = 0;
> > +	vss->appl_ptr = 0;
> >   }
> >   /**
> >    * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
> >    * @vss: VirtIO PCM substream.
> > + * @offset: starting position that has been updated
> > + * @bytes: number of bytes that has been updated
> >    *
> >    * All messages are organized in an ordered circular list. Each time the
> >    * function is called, all currently non-enqueued messages are added to the
> > - * virtqueue. For this, the function keeps track of two values:
> > - *
> > - *   msg_last_enqueued = index of the last enqueued message,
> > - *   msg_count = # of pending messages in the virtqueue.
> > + * virtqueue. For this, the function uses offset and bytes to calculate the
> > + * messages that need to be added.
> >    *
> >    * Context: Any context. Expects the tx/rx queue and the VirtIO substream
> >    *          spinlocks to be held by caller.
> >    * Return: 0 on success, -errno on failure.
> >    */
> > -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> > +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
> > +			 unsigned long bytes)
> >   {
> > -	struct snd_pcm_runtime *runtime = vss->substream->runtime;
> >   	struct virtio_snd *snd = vss->snd;
> >   	struct virtio_device *vdev = snd->vdev;
> >   	struct virtqueue *vqueue = virtsnd_pcm_queue(vss)->vqueue;
> > -	int i;
> > -	int n;
> > +	unsigned long period_bytes = snd_pcm_lib_period_bytes(vss->substream);
> > +	unsigned long start, end, i;
> > +	unsigned int msg_count = vss->msg_count;
> >   	bool notify = false;
> > +	int rc;
> > -	i = (vss->msg_last_enqueued + 1) % runtime->periods;
> > -	n = runtime->periods - vss->msg_count;
> > +	start = offset / period_bytes;
> > +	end = (offset + bytes - 1) / period_bytes;
> > -	for (; n; --n, i = (i + 1) % runtime->periods) {
> > +	for (i = start; i <= end; i++) {
> >   		struct virtio_pcm_msg *msg = vss->msgs[i];
> >   		struct scatterlist *psgs[] = {
> >   			&msg->sgs[PCM_MSG_SG_XFER],
> >   			&msg->sgs[PCM_MSG_SG_DATA],
> >   			&msg->sgs[PCM_MSG_SG_STATUS]
> >   		};
> > -		int rc;
> > -
> > -		msg->xfer.stream_id = cpu_to_le32(vss->sid);
> > -		memset(&msg->status, 0, sizeof(msg->status));
> > -
> > -		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
> > -			rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
> > -					       GFP_ATOMIC);
> > -		else
> > -			rc = virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
> > -					       GFP_ATOMIC);
> > -
> > -		if (rc) {
> > -			dev_err(&vdev->dev,
> > -				"SID %u: failed to send I/O message\n",
> > -				vss->sid);
> > -			return rc;
> > +		unsigned long n;
> > +
> > +		n = period_bytes - (offset % period_bytes);
> > +		if (n > bytes)
> > +			n = bytes;
> > +
> > +		msg->length += n;
> > +		if (msg->length == period_bytes) {
> > +			msg->xfer.stream_id = cpu_to_le32(vss->sid);
> > +			memset(&msg->status, 0, sizeof(msg->status));
> > +
> > +			if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
> > +				rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
> > +						       GFP_ATOMIC);
> > +			else
> > +				rc = virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
> > +						       GFP_ATOMIC);
> > +
> > +			if (rc) {
> > +				dev_err(&vdev->dev,
> > +					"SID %u: failed to send I/O message\n",
> > +					vss->sid);
> > +				return rc;
> > +			}
> > +
> > +			vss->msg_count++;
> >   		}
> > -		vss->msg_last_enqueued = i;
> > -		vss->msg_count++;
> > +		offset = 0;
> > +		bytes -= n;
> >   	}
> > +	if (msg_count == vss->msg_count)
> > +		return 0;
> > +
> >   	if (!(vss->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING)))
> >   		notify = virtqueue_kick_prepare(vqueue);
> > @@ -309,6 +323,8 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
> >   	if (vss->hw_ptr >= vss->buffer_bytes)
> >   		vss->hw_ptr -= vss->buffer_bytes;
> > +	msg->length = 0;
> > +
> >   	vss->xfer_xrun = false;
> >   	vss->msg_count--;
> > @@ -320,8 +336,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
> >   					le32_to_cpu(msg->status.latency_bytes));
> >   		schedule_work(&vss->elapsed_period);
> > -
> > -		virtsnd_pcm_msg_send(vss);
> >   	} else if (!vss->msg_count) {
> >   		wake_up_all(&vss->msg_empty);
> >   	}
> > diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> > index f8bfb87624be..21cde37ecfa3 100644
> > --- a/sound/virtio/virtio_pcm_ops.c
> > +++ b/sound/virtio/virtio_pcm_ops.c
> > @@ -282,7 +282,6 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
> >   		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
> >   		vss->hw_ptr = 0;
> > -		vss->msg_last_enqueued = -1;
> >   	} else {
> >   		struct snd_pcm_runtime *runtime = substream->runtime;
> >   		unsigned int buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
> > @@ -324,7 +323,7 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
> >   	struct virtio_snd_queue *queue;
> >   	struct virtio_snd_msg *msg;
> >   	unsigned long flags;
> > -	int rc;
> > +	int rc = 0;
> >   	switch (command) {
> >   	case SNDRV_PCM_TRIGGER_START:
> > @@ -333,7 +332,8 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
> >   		spin_lock_irqsave(&queue->lock, flags);
> >   		spin_lock(&vss->lock);
> > -		rc = virtsnd_pcm_msg_send(vss);
> > +		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
> > +			rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
> >   		if (!rc)
> >   			vss->xfer_enabled = true;
> >   		spin_unlock(&vss->lock);
> > @@ -450,6 +450,29 @@ virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
> >   	return hw_ptr;
> >   }
> > +static int virtsnd_pcm_ack(struct snd_pcm_substream *substream)
> > +{
> > +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> > +	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
> > +	unsigned long flags;
> > +	struct snd_pcm_runtime *runtime = vss->substream->runtime;
> > +	ssize_t appl_pos = frames_to_bytes(runtime, runtime->control->appl_ptr);
> > +	ssize_t buf_size = frames_to_bytes(runtime, runtime->buffer_size);
> > +	int rc;
> > +
> > +	spin_lock_irqsave(&queue->lock, flags);
> > +	spin_lock(&vss->lock);
> > +
> > +	ssize_t bytes = (appl_pos - vss->appl_ptr) % buf_size;
> > +
> > +	rc = virtsnd_pcm_msg_send(vss, vss->appl_ptr % buf_size, bytes);
> > +	vss->appl_ptr += bytes;
> 
> I think it makes sense to store vss->appl_ptr in frames (type
> snd_pcm_uframes_t instead of size_t), and do all calculations in frames.
> You could do convertion before invoking virtsnd_pcm_msg_send().
> 

Will do, Thanks.

> We also need to either disable rewinds (SNDRV_PCM_INFO_NO_REWINDS), or take
> into account the case when the new runtime->control->appl_ptr value is less
> than the old one.
> 

I am planning to disable rewinds for the moment.

Thanks, Matias.

