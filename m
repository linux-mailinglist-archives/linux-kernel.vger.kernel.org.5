Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8507D9ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbjJ0OLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345517AbjJ0OLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9CFC0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698415841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRdYkYxdau6CHgpGFJcrqTFnU1sI1stdpBHA/cH/+NM=;
        b=YmTis0aB/SStviEMk7d58pGaI2uuqac2rO1XmPu5kxuR/k3N5j/IuKUyS/jdnTVZ9RVd7N
        GirI0kIMCON3hV2OSZDbbz8leMZkW1Kwn1CtJxNEyILlZmHduS02YfKQmSv8awHlHW1kul
        u5umDkxkjPsyT9GVeiriPu4DcDWZ0KI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-E_3SK5IaPtWhyecp-9vVSQ-1; Fri, 27 Oct 2023 10:10:37 -0400
X-MC-Unique: E_3SK5IaPtWhyecp-9vVSQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9c7558b89ccso141651266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698415837; x=1699020637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRdYkYxdau6CHgpGFJcrqTFnU1sI1stdpBHA/cH/+NM=;
        b=cFHcQql86PRxpb+piUFe9AQQK3ZIk5KYsbmN321Nm7UlLVxoaiEERXKNytafHYvVp5
         p9pkgDfxCWKbVFcSGNtyhDWW4/TBZ8zTasK/Rj9He2mdaEdveFmGEKiSbESHqScj3Wnq
         nhd3NczbtHiuE95kMZr5CTNXILgrBWp2Tv3VWyWcyewvRd6nL52xqRvc66EjfA1bWiah
         b4/pA4LORt/tp9yPZ89qfgBCZ6r/PgdpVXDZP0kyZriefAP2JONp++ad0pgGITKtup39
         P1qy26Z/+TAqOAQuotIq/mrrp+h9U/b5P/0Bif5DFgAmFV0zh9S/Qp8AxlS7ETHkq1mY
         FG8A==
X-Gm-Message-State: AOJu0Yye2l+rWqG8NHp8PU9pglTMbwdvD0UTatAF8J+h8w2otILdu1Hr
        RGQ4Y6dlAOSjX0LAd46/uRi3W9paITVhNsG0ToSOwZzZIFN3O8s/eafZ4ew5hlNdqxzz+7HMT9v
        oOUtq0FZG+KOS4tsjQNUXcUzL
X-Received: by 2002:a17:907:26c4:b0:9b9:f980:8810 with SMTP id bp4-20020a17090726c400b009b9f9808810mr2403288ejc.34.1698415836781;
        Fri, 27 Oct 2023 07:10:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMqeS/ENQMteZysZriJDyAUYQDfdM2t4FWgavS3j/Huq1sdB1zR86mo2jMEQI9/MoAZHy9gg==
X-Received: by 2002:a17:907:26c4:b0:9b9:f980:8810 with SMTP id bp4-20020a17090726c400b009b9f9808810mr2403261ejc.34.1698415836321;
        Fri, 27 Oct 2023 07:10:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:52a8:fc3f:6e84:948f:e841])
        by smtp.gmail.com with ESMTPSA id cf17-20020a170906b2d100b00997d7aa59fasm1275905ejb.14.2023.10.27.07.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:10:35 -0700 (PDT)
Date:   Fri, 27 Oct 2023 10:10:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
        anton.yakovlev@opensynergy.com, perex@perex.cz, tiwai@suse.com,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
Subject: Re: [PATCH v4] ALSA: virtio: use ack callback
Message-ID: <20231027100703-mutt-send-email-mst@kernel.org>
References: <ZTjkn1YAFz67yfqx@fedora>
 <87cyx0xvn7.wl-tiwai@suse.de>
 <jmuevryxo2nlqriqbwz6y2ttwzxwajfsnb5vaez2oqu7etkrd3@lu3pgnfushmr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jmuevryxo2nlqriqbwz6y2ttwzxwajfsnb5vaez2oqu7etkrd3@lu3pgnfushmr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 12:18:00PM +0200, Stefano Garzarella wrote:
> On Fri, Oct 27, 2023 at 11:27:40AM +0200, Takashi Iwai wrote:
> > On Wed, 25 Oct 2023 11:49:19 +0200,
> > Matias Ezequiel Vara Larsen wrote:
> > > 
> > > This commit uses the ack() callback to determine when a buffer has been
> > > updated, then exposes it to guest.
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
> > > When the ack() callback is invoked, the driver exposes only the buffers
> > > that have already been updated, i.e., enqueued in the available ring.
> > > Thus, the device always picks up a buffer that is updated.
> > > 
> > > For capturing, the driver starts by exposing all the available buffers
> > > to device. After device updates the content of a buffer, it enqueues it
> > > in the used ring. It is only after the ack() for capturing is issued
> > > that the driver re-enqueues the buffer in the available ring.
> > > 
> > > Co-developed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > > Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> > 
> > Applied now to for-next branch.
> 
> Cool, thanks for that!
> 
> I just wonder if we should CC stable since we are fixing a virtio
> specification violation.
> 
> @Michael what do you think?
> 
> Thanks,
> Stefano


Acked-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: de3a9980d8c3 ("ALSA: virtio: add virtio sound driver")


The patch is too big for stable - more than 100 lines added. See:
Documentation/process/stable-kernel-rules.rst



-- 
MST

