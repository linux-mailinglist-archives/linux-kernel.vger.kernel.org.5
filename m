Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742E07D4EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjJXLN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJXLN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1DB109
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698145961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C2lXPU4q4S6eFWPmbdstO3s/7qoi/uNTcNbWNU4XbWU=;
        b=S3VeLki8ODV3x9/0RxnRX7oJjqnr1BygcEiV+zDzTczACXc1nSCV2o9u6wW48wuZYvx9bL
        lkubtP3CNRf7iILE9MC6csOhDUQVqmgOqEXWsO7t4JZUVo2msGcCEMkC0QqhUi3XWsK4Zb
        OfjsjkILAUJBXvNo6XWHKjzh+32lnck=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-r5dzqk23NsiC6nobMAZT7A-1; Tue, 24 Oct 2023 07:12:40 -0400
X-MC-Unique: r5dzqk23NsiC6nobMAZT7A-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41bef8f8d94so43646651cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698145960; x=1698750760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2lXPU4q4S6eFWPmbdstO3s/7qoi/uNTcNbWNU4XbWU=;
        b=RSXP7m90aeQNHGRMrQcaRrcXieROxRNRTugEvq67EytEawFOBoaTTPEbilQnNUwTx9
         fx0Q8CUWZ34aFdUnUeokIZkYApaWihsbaKx6tQSMgCU6zEnkc10rqeZz1WaLUO63BIab
         FXOVLgN1/2gHwvFyBUynnjmVNHPXwzI3qhU1jQmmNHNaaza8CY/fvHRv0muPYZM5WjTQ
         xSL/G4gw+oGfNzdl0XAukmuo96OGBC/KCYfluUWpuRV2h/7BNpFzB0sl64D8wXhlOA0z
         GsAjuwGndbYvpBoi4a+o61RYFtyfxggdFKeBlxx8mAk1Xju+iaQCEEKU6eXQen0Rfs32
         6xEQ==
X-Gm-Message-State: AOJu0Yw33QYwEkyt1x/Qr31jigFaj45LsG2fTckTa7ikuw0X2V7dBEjU
        PeSvzs/Hu3rcoxZTgLAxmjsp1FZClW+xK7VWtdaOSPpwxCqzKg6z8AD3mWRXTM8xbsFRUuwCdp3
        N5JHr2UbHkWXAV/IZtjRdQqne
X-Received: by 2002:a05:622a:348:b0:41e:1d17:4ca1 with SMTP id r8-20020a05622a034800b0041e1d174ca1mr5741155qtw.67.1698145959886;
        Tue, 24 Oct 2023 04:12:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgH9JWinTw/3VyBxR3NnKUHUrfU7r6j4m3KUt/L2niRCaXzILlLO+k91SaFhh6Nmg6pOHNdg==
X-Received: by 2002:a05:622a:348:b0:41e:1d17:4ca1 with SMTP id r8-20020a05622a034800b0041e1d174ca1mr5741142qtw.67.1698145959653;
        Tue, 24 Oct 2023 04:12:39 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id z5-20020ac87ca5000000b00410ac0068d0sm3380879qtv.91.2023.10.24.04.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:12:39 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:12:35 +0200
From:   Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     anton.yakovlev@opensynergy.com, mst@redhat.com, perex@perex.cz,
        tiwai@suse.com, virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
Subject: Re: [PATCH v3] ALSA: virtio: use ack callback
Message-ID: <ZTemo0P/kEcceK/O@fedora>
References: <ZTaMEUZUTrRRUD6y@fedora>
 <87edhlwd7b.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edhlwd7b.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 05:50:00PM +0200, Takashi Iwai wrote:
> On Mon, 23 Oct 2023 17:06:57 +0200,
> Matias Ezequiel Vara Larsen wrote:
> > 
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
> 
> The variable declaration should be moved to the beginning of the
> function.
> 
> Also, there can be a overlap beyond runtime->boundary (which easily
> happens for 32bit apps), so the calculation can be a bit more complex
> with conditional.
> 

Should I use as an example `cs46xx_playback/capture_transfer()` which relies on
the `snd_pcm_indirect_playback/capture_transfer()`? It looks like it
does already that calculation.

Thanks, Matias.

