Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD637D0CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376999AbjJTKJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376873AbjJTKJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD77B6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697796497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8DPd11sc2uBsWrWlYeP8kGG0jI+Vgzqkk7sKu4E6ndQ=;
        b=jAXBI5Hrq00N7FZdwnSHVafzrpvegbpjA41UJzyf3cBlCLglp5rxdC5DBZFYr1ya5RDFna
        8IzXVebvq5aMy7+G5HvbF2m8LYYcPcqRtzDlbahDcZ5o9Xu3+DPoSRjnYxRMWVYT7r32/s
        rJYOC6ql5BqQPhRQDrLIbdoaEXU5hNg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-gdVXM0oiP2-7ShMTCWVvjA-1; Fri, 20 Oct 2023 06:08:11 -0400
X-MC-Unique: gdVXM0oiP2-7ShMTCWVvjA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe182913c5so4070105e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697796490; x=1698401290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DPd11sc2uBsWrWlYeP8kGG0jI+Vgzqkk7sKu4E6ndQ=;
        b=B2gj4NH0zrZH/VX1lzpYA24/eUSvS2XyxGXpqDH88biIjlDL/WA3uG0einuX+matiA
         asTM5W5SMKyAsyv4L9jbg0YFmIA6rgN32eT22zuIAakKEKQEgunc24CHdBoc3dVATzVd
         Yk40TdRXou3WZeFhthvCaOhF2dXOvtyvGyCdAKQ7luOLwoW7LWGeqvc7wFnJDT2UT9u7
         7pUplmGPCAHAPmVY9ALTu9sEliPN9jEV8fyyWG24XLRhiTWRMGwqxGBr1jq2062SrYIV
         dlOAmriz5RnkK0al1DGXGzRmRUCDw9u8gJ0Sx7pdSsCDODjJGzfIvUD/gfoexS4mJkhQ
         kdog==
X-Gm-Message-State: AOJu0YyTWnzgO8O/FS8fTIw2rBq1EJcGCE1XgR8vUBEmWQYQVtMvd7q2
        Ffj8g4TxnMm9A4gTQ7mQ0sBLsTtPqUJAPIAsvO1DiKlpQQt0rxG9B6bmDM8B9RXqAmUAkFmXVD+
        +nCSY27Wb/rAv4PJh4po8O+a/
X-Received: by 2002:a05:600c:4f12:b0:401:bdd7:49ae with SMTP id l18-20020a05600c4f1200b00401bdd749aemr1214853wmq.18.1697796489822;
        Fri, 20 Oct 2023 03:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNE9FiNbwpYdXqLcZIJ4/1YwoFZJFhOvQpn5AauT7Zhc0SVoOEu1TSydQNnfcIKDvas2A+cQ==
X-Received: by 2002:a05:600c:4f12:b0:401:bdd7:49ae with SMTP id l18-20020a05600c4f1200b00401bdd749aemr1214829wmq.18.1697796489458;
        Fri, 20 Oct 2023 03:08:09 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0040813e14b49sm6583115wmo.30.2023.10.20.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:08:08 -0700 (PDT)
Date:   Fri, 20 Oct 2023 06:08:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Message-ID: <20231020055943-mutt-send-email-mst@kernel.org>
References: <20231020092320.209234-1-suhui@nfschina.com>
 <20231020053047-mutt-send-email-mst@kernel.org>
 <1697794601.5857713-2-xuanzhuo@linux.alibaba.com>
 <20231020054140-mutt-send-email-mst@kernel.org>
 <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:50:22PM +0800, Xuan Zhuo wrote:
> On Fri, 20 Oct 2023 05:42:14 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Oct 20, 2023 at 05:36:41PM +0800, Xuan Zhuo wrote:
> > > On Fri, 20 Oct 2023 05:34:32 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Fri, Oct 20, 2023 at 05:23:21PM +0800, Su Hui wrote:
> > > > > virtqueue_resize_packed() or virtqueue_resize_split() can return
> > > > > error code if failed, so add a check for this.
> > > > >
> > > > > Signed-off-by: Su Hui <suhui@nfschina.com>
> > > > > ---
> > > > >
> > > > > I'm not sure that return directly is right or not,
> > > > > maybe there are some process should do before return.
> > > >
> > > > yes - presizely what virtqueue_enable_after_reset does.
> > > >
> > > > Error handling in virtqueue_enable_after_reset is really weird BTW.
> > > > For some reason it overrides the error code returned.
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > >  drivers/virtio/virtio_ring.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 51d8f3299c10..cf662c3a755b 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -2759,6 +2759,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > > > >  	else
> > > > >  		err = virtqueue_resize_split(_vq, num);
> > > > >
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > >  	return virtqueue_enable_after_reset(_vq);
> > > >
> > > > So I think it should be something like:
> > > >
> > > > 	int err_reset = virtqueue_enable_after_reset(_vq);
> > > > 	BUG_ON(err_reset);
> > > >
> > > > 	return err;
> > > >
> > >
> > > How about WARN and vq->broken?
> > >
> > > Thanks.
> >
> > Well, what are the cases where it can happen practically?
> 
> Device error. Such as vp_active_vq()
> 
> Thanks.

Hmm interesting. OK. But do callers know to recover?

> 
> >
> > >
> > > >
> > > >
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> > > > > --
> > > > > 2.30.2
> > > >
> >

