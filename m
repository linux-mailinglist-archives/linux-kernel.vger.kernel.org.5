Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D610C7CC381
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjJQMqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjJQMp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E8DB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697546712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBNpc8RAW/PE5aU8phLj91cR6wABDA4tTEpwyo7nQ9M=;
        b=WflV7bxZVwzJYDMLI5pUMxR28suWlWvvDuDl/hLwV2nJH+HwHun6KF+uQYsRtc/KAJdan1
        I4wfhSwln0i8S4yZStjU9bk/Iv+SLZ12b5mXxkD50fu5T69Z8xLTJSkZtVUKMoWDYYCBav
        lST0aU8v3bzcZnNHZPaDkCToa2Zu3zE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-t13TUJM4OCyQ4-fj-M9S5w-1; Tue, 17 Oct 2023 08:45:11 -0400
X-MC-Unique: t13TUJM4OCyQ4-fj-M9S5w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d03b02d16so102430966d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546710; x=1698151510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBNpc8RAW/PE5aU8phLj91cR6wABDA4tTEpwyo7nQ9M=;
        b=nVb7oP4gQZCNbnpZIOoQ37tlp1NYr84SBIXATFHmJazsJZ9nf6yB3YsObEBmIpsf1K
         VM9PFZuzbgT72h1fME0GficLQKMU/mivkqKSRTv/9ftoDkPiCxkEcU5O6UZLPbQDWtQm
         P+TdswB0sUETSetlQ/tM8iFoNofDHrr3oDxDPnwl2n/q6KNFg7NYPL6DJs24a00MCpZ6
         DZJm6aKjRnFHjTUfm/8TiMDb6EKupHgjF2g/Fx+9fX6DJeE+CC5VgHlQtAXiLrvehCv7
         nIGPOUEgrXmn6byfJRNe7Cmbe7W1zZpfMaVvRzavAbLJ6VQm967LB43iQepvPfcKyXa8
         NagQ==
X-Gm-Message-State: AOJu0YxGC7XMKUnZwBJ5LUIKrRtXXqHyfwNp2jJwRV+N9I6qhQ4t6p2w
        Ofbg0ahiHtjpftifrNXnsZKGwbNMcwqI+RY4zmOsCtJWObTaQveRcBcgZwe0oJu9wp8XeMcm6W0
        pYF/VH0V2ulaqSElco/nhehZi
X-Received: by 2002:a0c:8e85:0:b0:656:3045:5638 with SMTP id x5-20020a0c8e85000000b0065630455638mr1738082qvb.16.1697546710209;
        Tue, 17 Oct 2023 05:45:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiyLhB2c1PSuhfY8KvsNDSjPL19UYsGniCAPLdRDZBdJF7LR+v/M7QaHy5b9dzDsM4U8PngQ==
X-Received: by 2002:a0c:8e85:0:b0:656:3045:5638 with SMTP id x5-20020a0c8e85000000b0065630455638mr1738054qvb.16.1697546709852;
        Tue, 17 Oct 2023 05:45:09 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id f4-20020ad442c4000000b006648514e276sm511692qvr.78.2023.10.17.05.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:45:09 -0700 (PDT)
Date:   Tue, 17 Oct 2023 14:45:05 +0200
From:   Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, anton.yakovlev@opensynergy.com,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, sgarzare@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
Subject: Re: [RFC PATCH] ALSA: virtio: use copy and fill_silence callbacks
Message-ID: <ZS6B0XVRF4KOxbJi@fedora>
References: <ZSgMeoMx6NX2zCx/@fedora>
 <20231016151000.GE119987@fedora>
 <87h6mpn16j.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6mpn16j.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:44:04AM +0200, Takashi Iwai wrote:
> On Mon, 16 Oct 2023 17:10:00 +0200,
> Stefan Hajnoczi wrote:
> > 
> > On Thu, Oct 12, 2023 at 05:10:50PM +0200, Matias Ezequiel Vara Larsen wrote:
> > > This commit replaces the mmap mechanism with the copy() and
> > > fill_silence() callbacks for both capturing and playback for the
> > > virtio-sound driver. This change is required to prevent the updating of
> > > the content of a buffer that is already in the available ring.
> > > 
> > > The current mechanism splits a dma buffer into descriptors that are
> > > exposed to the device. This dma buffer is shared with the user
> > > application. When the device consumes a buffer, the driver moves the
> > > request from the used ring to available ring.
> > > 
> > > The driver exposes the buffer to the device without knowing if the
> > > content has been updated from the user. The section 2.8.21.1 of the
> > > virtio spec states that: "The device MAY access the descriptor chains
> > > the driver created and the memory they refer to immediately". If the
> > > device picks up buffers from the available ring just after it is
> > > notified, it happens that the content may be old.
> > > 
> > > By providing the copy() callback, the driver first updates the content
> > > of the buffer, and then, exposes the buffer to the device by enqueuing
> > > it in the available ring. Thus, device always picks up a buffer that is
> > > updated.
> > > 
> > > For capturing, the driver starts by exposing all the available buffers
> > > to device. After device updates the content of a buffer, it enqueues it
> > > in the used ring. It is only after the copy() for capturing is issued
> > > that the driver re-enqueues the buffer in the available ring.
> > > 
> > > Note that the copy() function assumes that user is always writing a
> > > period. Testing shows that this is true but I may be wrong. This RFC
> > > aims at clarifying this.
> > 
> > This sounds like an ALSA driver API question.
> > 
> > Jaroslav and Takashi: Any thoughts?
> 
> The size of the transfer is determined solely by PCM appl_ptr and
> hw_ptr values.  The former is what applications update via the mmap
> commit or the normal read/write operations, while the latter is
> updated via PCM position() op.  So basically the granularity depends
> on the values returned from PCM position op.
> 
> 

Thanks for your comment, I'll send a second version without the
assumption that applications always update a single period.

Matias

> Takashi
> 
> > 
> > Stefan
> > 
> > > 
> > > Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> > > ---
> > >  sound/virtio/virtio_pcm.c     | 11 ++--
> > >  sound/virtio/virtio_pcm.h     |  9 +++-
> > >  sound/virtio/virtio_pcm_msg.c | 50 ++++++++++++++++---
> > >  sound/virtio/virtio_pcm_ops.c | 94 +++++++++++++++++++++++++++++++----
> > >  4 files changed, 137 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> > > index c10d91fff2fb..bfe982952303 100644
> > > --- a/sound/virtio/virtio_pcm.c
> > > +++ b/sound/virtio/virtio_pcm.c
> > > @@ -104,8 +104,6 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
> > >  	 * only message-based transport.
> > >  	 */
> > >  	vss->hw.info =
> > > -		SNDRV_PCM_INFO_MMAP |
> > > -		SNDRV_PCM_INFO_MMAP_VALID |
> > >  		SNDRV_PCM_INFO_BATCH |
> > >  		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > >  		SNDRV_PCM_INFO_INTERLEAVED |
> > > @@ -471,12 +469,11 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
> > >  			for (kss = ks->substream; kss; kss = kss->next)
> > >  				vs->substreams[kss->number]->substream = kss;
> > >  
> > > -			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops);
> > > +			if (i == SNDRV_PCM_STREAM_CAPTURE)
> > > +				snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_capture_ops);
> > > +			else
> > > +				snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_playback_ops);
> > >  		}
> > > -
> > > -		snd_pcm_set_managed_buffer_all(vpcm->pcm,
> > > -					       SNDRV_DMA_TYPE_VMALLOC, NULL,
> > > -					       0, 0);
> > >  	}
> > >  
> > >  	return 0;
> > > diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
> > > index 062eb8e8f2cf..1c1106ec971f 100644
> > > --- a/sound/virtio/virtio_pcm.h
> > > +++ b/sound/virtio/virtio_pcm.h
> > > @@ -50,6 +50,8 @@ struct virtio_pcm_substream {
> > >  	struct work_struct elapsed_period;
> > >  	spinlock_t lock;
> > >  	size_t buffer_bytes;
> > > +	u8 *buffer;
> > > +	size_t buffer_sz;
> > >  	size_t hw_ptr;
> > >  	bool xfer_enabled;
> > >  	bool xfer_xrun;
> > > @@ -90,7 +92,8 @@ struct virtio_pcm {
> > >  	struct virtio_pcm_stream streams[SNDRV_PCM_STREAM_LAST + 1];
> > >  };
> > >  
> > > -extern const struct snd_pcm_ops virtsnd_pcm_ops;
> > > +extern const struct snd_pcm_ops virtsnd_pcm_playback_ops;
> > > +extern const struct snd_pcm_ops virtsnd_pcm_capture_ops;
> > >  
> > >  int virtsnd_pcm_validate(struct virtio_device *vdev);
> > >  
> > > @@ -117,7 +120,9 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
> > >  
> > >  void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
> > >  
> > > -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss);
> > > +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, bool single);
> > > +
> > > +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss, bool single);
> > >  
> > >  unsigned int virtsnd_pcm_msg_pending_num(struct virtio_pcm_substream *vss);
> > >  
> > > diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> > > index aca2dc1989ba..9a5f9814cb62 100644
> > > --- a/sound/virtio/virtio_pcm_msg.c
> > > +++ b/sound/virtio/virtio_pcm_msg.c
> > > @@ -132,7 +132,6 @@ static void virtsnd_pcm_sg_from(struct scatterlist *sgs, int nsgs, u8 *data,
> > >  int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
> > >  			  unsigned int periods, unsigned int period_bytes)
> > >  {
> > > -	struct snd_pcm_runtime *runtime = vss->substream->runtime;
> > >  	unsigned int i;
> > >  
> > >  	vss->msgs = kcalloc(periods, sizeof(*vss->msgs), GFP_KERNEL);
> > > @@ -142,7 +141,7 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
> > >  	vss->nmsgs = periods;
> > >  
> > >  	for (i = 0; i < periods; ++i) {
> > > -		u8 *data = runtime->dma_area + period_bytes * i;
> > > +		u8 *data = vss->buffer + period_bytes * i;
> > >  		int sg_num = virtsnd_pcm_sg_num(data, period_bytes);
> > >  		struct virtio_pcm_msg *msg;
> > >  
> > > @@ -186,10 +185,12 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
> > >  /**
> > >   * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
> > >   * @vss: VirtIO PCM substream.
> > > + * @single: true to enqueue a single message, false to enqueue all of them.
> > >   *
> > >   * All messages are organized in an ordered circular list. Each time the
> > > - * function is called, all currently non-enqueued messages are added to the
> > > - * virtqueue. For this, the function keeps track of two values:
> > > + * function is called, first non-enqueued message is added to the virtqueue.
> > > + * When single is True, only the first message is enqueued. When False, all the
> > > + * available messages are enqueued.  The function keeps track of two values:
> > >   *
> > >   *   msg_last_enqueued = index of the last enqueued message,
> > >   *   msg_count = # of pending messages in the virtqueue.
> > > @@ -198,7 +199,7 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
> > >   *          spinlocks to be held by caller.
> > >   * Return: 0 on success, -errno on failure.
> > >   */
> > > -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> > > +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, bool single)
> > >  {
> > >  	struct snd_pcm_runtime *runtime = vss->substream->runtime;
> > >  	struct virtio_snd *snd = vss->snd;
> > > @@ -211,6 +212,13 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> > >  	i = (vss->msg_last_enqueued + 1) % runtime->periods;
> > >  	n = runtime->periods - vss->msg_count;
> > >  
> > > +	if (single) {
> > > +		if (n < 1)
> > > +			return -EFAULT;
> > > +
> > > +		n = 1;
> > > +	}
> > > +
> > >  	for (; n; --n, i = (i + 1) % runtime->periods) {
> > >  		struct virtio_pcm_msg *msg = vss->msgs[i];
> > >  		struct scatterlist *psgs[] = {
> > > @@ -250,6 +258,36 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> > >  	return 0;
> > >  }
> > >  
> > > +/**
> > > + * virtsnd_pcm_msg_send_locked() - Send asynchronous I/O messages.
> > > + * @vss: VirtIO PCM substream.
> > > + * @single: true to enqueue a single message, false to enqueue all of them.
> > > + *
> > > + * This function holds the tx/rx queue and the VirtIO substream spinlocks
> > > + * before calling virtsnd_pcm_msg_send(). This is a wrapper function to ease
> > > + * the invocation of virtsnd_pcm_msg_send().
> > > + *
> > > + * Context: Any context.
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +
> > > +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss, bool single)
> > > +{
> > > +	struct virtio_snd_queue *queue;
> > > +	int rc;
> > > +	unsigned long flags;
> > > +
> > > +	queue = virtsnd_pcm_queue(vss);
> > > +
> > > +	spin_lock_irqsave(&queue->lock, flags);
> > > +	spin_lock(&vss->lock);
> > > +	rc = virtsnd_pcm_msg_send(vss, single);
> > > +	spin_unlock(&vss->lock);
> > > +	spin_unlock_irqrestore(&queue->lock, flags);
> > > +
> > > +	return rc;
> > > +}
> > > +
> > >  /**
> > >   * virtsnd_pcm_msg_pending_num() - Returns the number of pending I/O messages.
> > >   * @vss: VirtIO substream.
> > > @@ -320,8 +358,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
> > >  					le32_to_cpu(msg->status.latency_bytes));
> > >  
> > >  		schedule_work(&vss->elapsed_period);
> > > -
> > > -		virtsnd_pcm_msg_send(vss);
> > >  	} else if (!vss->msg_count) {
> > >  		wake_up_all(&vss->msg_empty);
> > >  	}
> > > diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> > > index f8bfb87624be..a208439dbff8 100644
> > > --- a/sound/virtio/virtio_pcm_ops.c
> > > +++ b/sound/virtio/virtio_pcm_ops.c
> > > @@ -238,6 +238,11 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
> > >  	 */
> > >  	virtsnd_pcm_msg_free(vss);
> > >  
> > > +	vss->buffer_sz = params_buffer_bytes(hw_params);
> > > +	vss->buffer = alloc_pages_exact(vss->buffer_sz, GFP_KERNEL);
> > > +	if (!vss->buffer)
> > > +		return -ENOMEM;
> > > +
> > >  	return virtsnd_pcm_msg_alloc(vss, params_periods(hw_params),
> > >  				     params_period_bytes(hw_params));
> > >  }
> > > @@ -257,6 +262,11 @@ static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
> > >  	if (!virtsnd_pcm_msg_pending_num(vss))
> > >  		virtsnd_pcm_msg_free(vss);
> > >  
> > > +	if (vss->buffer) {
> > > +		free_pages_exact(vss->buffer, vss->buffer_sz);
> > > +		vss->buffer = NULL;
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >  
> > > @@ -331,15 +341,18 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
> > >  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > >  		queue = virtsnd_pcm_queue(vss);
> > >  
> > > -		spin_lock_irqsave(&queue->lock, flags);
> > > -		spin_lock(&vss->lock);
> > > -		rc = virtsnd_pcm_msg_send(vss);
> > > -		if (!rc)
> > > -			vss->xfer_enabled = true;
> > > -		spin_unlock(&vss->lock);
> > > -		spin_unlock_irqrestore(&queue->lock, flags);
> > > -		if (rc)
> > > -			return rc;
> > > +		// The buffers should be exposed first during capturing so that
> > > +		// the device can consume them. Capturing cannot begin
> > > +		// otherwise.
> > > +		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
> > > +			rc = virtsnd_pcm_msg_send_locked(vss, false);
> > > +			if (rc)
> > > +				return rc;
> > > +		}
> > > +
> > > +		spin_lock_irqsave(&vss->lock, flags);
> > > +		vss->xfer_enabled = true;
> > > +		spin_unlock_irqrestore(&vss->lock, flags);
> > >  
> > >  		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
> > >  						GFP_KERNEL);
> > > @@ -450,8 +463,66 @@ virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
> > >  	return hw_ptr;
> > >  }
> > >  
> > > -/* PCM substream operators map. */
> > > -const struct snd_pcm_ops virtsnd_pcm_ops = {
> > > +static int virtsnd_pcm_pb_copy(struct snd_pcm_substream *substream,
> > > +			       int channel, unsigned long pos, struct iov_iter
> > > +			       *src, unsigned long count)
> > > +{
> > > +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> > > +
> > > +	if (unlikely(pos + count > vss->buffer_sz))
> > > +		return -EINVAL;
> > > +
> > > +	if (copy_from_iter(vss->buffer + pos, count, src) != count)
> > > +		return -EFAULT;
> > > +
> > > +	return virtsnd_pcm_msg_send_locked(vss, true);
> > > +}
> > > +
> > > +static int virtsnd_pcm_cap_copy(struct snd_pcm_substream *substream,
> > > +				int channel, unsigned long pos, struct iov_iter
> > > +				*dst, unsigned long count)
> > > +{
> > > +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> > > +
> > > +	if (unlikely(pos + count > vss->buffer_sz))
> > > +		return -EINVAL;
> > > +
> > > +	if (copy_to_iter(vss->buffer + pos, count, dst) != count)
> > > +		return -EFAULT;
> > > +
> > > +	return virtsnd_pcm_msg_send_locked(vss, true);
> > > +}
> > > +
> > > +static int virtsnd_pcm_pb_silence(struct snd_pcm_substream *substream, int channel,
> > > +				  unsigned long pos, unsigned long count)
> > > +{
> > > +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> > > +
> > > +	if (unlikely(pos + count > vss->buffer_sz))
> > > +		return -EINVAL;
> > > +
> > > +	memset(vss->buffer + pos, 0, count);
> > > +
> > > +	return virtsnd_pcm_msg_send_locked(vss, true);
> > > +}
> > > +
> > > +/* PCM substream operators map for playback. */
> > > +const struct snd_pcm_ops virtsnd_pcm_playback_ops = {
> > > +	.open = virtsnd_pcm_open,
> > > +	.close = virtsnd_pcm_close,
> > > +	.ioctl = snd_pcm_lib_ioctl,
> > > +	.hw_params = virtsnd_pcm_hw_params,
> > > +	.hw_free = virtsnd_pcm_hw_free,
> > > +	.prepare = virtsnd_pcm_prepare,
> > > +	.trigger = virtsnd_pcm_trigger,
> > > +	.sync_stop = virtsnd_pcm_sync_stop,
> > > +	.pointer = virtsnd_pcm_pointer,
> > > +	.copy = virtsnd_pcm_pb_copy,
> > > +	.fill_silence = virtsnd_pcm_pb_silence,
> > > +};
> > > +
> > > +/* PCM substream operators map for capturing. */
> > > +const struct snd_pcm_ops virtsnd_pcm_capture_ops = {
> > >  	.open = virtsnd_pcm_open,
> > >  	.close = virtsnd_pcm_close,
> > >  	.ioctl = snd_pcm_lib_ioctl,
> > > @@ -461,4 +532,5 @@ const struct snd_pcm_ops virtsnd_pcm_ops = {
> > >  	.trigger = virtsnd_pcm_trigger,
> > >  	.sync_stop = virtsnd_pcm_sync_stop,
> > >  	.pointer = virtsnd_pcm_pointer,
> > > +	.copy = virtsnd_pcm_cap_copy,
> > >  };
> > > 
> > > base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
> > > -- 
> > > 2.41.0
> > > 
> > Verifying...
> 

