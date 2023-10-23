Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA677D3249
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjJWLSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjJWLSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C795A4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698059862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRvwFPWkQbIxAzQKKTcIQ5FvgRLAZ9CwY2jeSsJtJyI=;
        b=LBtLWdrI4RawVrrk+ub05TqO0i11YDOVmU/EKm7z+Dp93cZUTjU324gktceDZTE5ppbNUW
        cjHRXCJOFJJXPMnFWtvBGvg10aDZOisOP4TA2NA/qah8DbbUE+lRvRbg+I6z7WJnpyWChN
        c4zVSrY1RNbrgNtU9qhAtVFbmeuH2TY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-1QAhdfFrPfq8f1qTunWAkQ-1; Mon, 23 Oct 2023 07:17:41 -0400
X-MC-Unique: 1QAhdfFrPfq8f1qTunWAkQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32da47641b5so1386155f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698059859; x=1698664659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRvwFPWkQbIxAzQKKTcIQ5FvgRLAZ9CwY2jeSsJtJyI=;
        b=YaTrKexvKQ0KT/jLmADQfDQsktYUOPVgddEn82sMn8lbU1RHqSdwKVFUhQTy3GESnI
         D/ddSiYWLeR0AhBPC7elTl4Qwqn4SI+2gES4bvFWbypqGqP/VtKaoTCV1XI5BE2lbu7U
         i0d7lJh0FS7ZBjYlNyrpGNUFrmEeCMHUMXkR5/JAwlgqM6UqNdAiGOxm+KRRvjqBicEz
         xJmvBcAJDQYjU1jzua+zXtlZ9aXidzwgMUfzpv56KLpIQNMUcB733Q2Rkm3mdxEE04f+
         ZWgb9r629X5qTLItl3uuHDPq9NogaMRarlRUcvjlMZqn94pIRpWGJ/GXxTuhxWzQqM67
         R8Aw==
X-Gm-Message-State: AOJu0YxBE+SHLyCF40wX3sB7Rfp0IcUIpu13va+TKeqh7U7XRxRTyX8T
        nhNHjNVuJduc8t3Mb+RgDrgeRlBxZILGnTJCAus2FxLHapB/32WV7E6VeunIluPm0XuBlzu7d6o
        Pugj9EZB+TiuqQI5VF1zFCjhsdZNhaAm1
X-Received: by 2002:adf:e5c8:0:b0:32d:6891:f819 with SMTP id a8-20020adfe5c8000000b0032d6891f819mr6249180wrn.41.1698059859679;
        Mon, 23 Oct 2023 04:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3YM+O+5Ir2R/imQr9O2Lyuez5zl/LJuvoKLWz1oCP1WKa/8vgH0KWzIiS0y5qulyw5jOYDA==
X-Received: by 2002:adf:e5c8:0:b0:32d:6891:f819 with SMTP id a8-20020adfe5c8000000b0032d6891f819mr6249168wrn.41.1698059859310;
        Mon, 23 Oct 2023 04:17:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:e88f:2c2c:db43:583d:d30e])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d4151000000b0032d87b13240sm7629863wrq.73.2023.10.23.04.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 04:17:38 -0700 (PDT)
Date:   Mon, 23 Oct 2023 07:17:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Su Hui <suhui@nfschina.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Message-ID: <20231023071548-mutt-send-email-mst@kernel.org>
References: <20231020054140-mutt-send-email-mst@kernel.org>
 <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
 <20231020055943-mutt-send-email-mst@kernel.org>
 <1698028017.8052797-1-xuanzhuo@linux.alibaba.com>
 <d4aa3f76-3e08-a852-a948-b88226a37fdd@nfschina.com>
 <1698029596.5404413-3-xuanzhuo@linux.alibaba.com>
 <46aee820-6c01-ed8a-613b-5c57258d749e@nfschina.com>
 <1698040004.5365264-4-xuanzhuo@linux.alibaba.com>
 <6a7d1006-0988-77ea-0991-9c7b422d78e1@nfschina.com>
 <1698054722.2894735-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698054722.2894735-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 05:52:02PM +0800, Xuan Zhuo wrote:
> On Mon, 23 Oct 2023 17:50:46 +0800, Su Hui <suhui@nfschina.com> wrote:
> > On 2023/10/23 13:46, Xuan Zhuo wrote:
> > >>>>>>>> Well, what are the cases where it can happen practically?
> > >>>>>>> Device error. Such as vp_active_vq()
> > >>>>>>>
> > >>>>>>> Thanks.
> > >>>>>> Hmm interesting. OK. But do callers know to recover?
> > >>>>> No.
> > >>>>>
> > >>>>> So I think WARN + broken is suitable.
> > >>>>>
> > >>>>> Thanks.
> > >>>> Sorry for the late, is the following code okay?
> > >>>>
> > >>>> @@ -2739,7 +2739,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >>>>                         void (*recycle)(struct virtqueue *vq, void *buf))
> > >>>>     {
> > >>>>            struct vring_virtqueue *vq = to_vvq(_vq);
> > >>>> -       int err;
> > >>>> +       int err, err_reset;
> > >>>>
> > >>>>            if (num > vq->vq.num_max)
> > >>>>                    return -E2BIG;
> > >>>> @@ -2759,7 +2759,15 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >>>>            else
> > >>>>                    err = virtqueue_resize_split(_vq, num);
> > >>>>
> > >>>> -       return virtqueue_enable_after_reset(_vq);
> > >>>> +       err_reset = virtqueue_enable_after_reset(_vq);
> > >>>> +
> > >>>> +       if (err) {
> > >>> No err.
> > >>>
> > >>> err is not important.
> > >>> You can remove that.
> > >> Emm, I'm a little confused that which code should I remove ?
> > >>
> > >>
> > >> like this:
> > >> 	if (vq->packed_ring)
> > >> 		virtqueue_resize_packed(_vq, num);
> > >> 	else
> > >> 		virtqueue_resize_split(_vq, num);
> > >>
> > >> And we should set broken and warn inside virtqueue_enable_after_reset()?
> >
> > In my opinion, we should return the error code of virtqueue_resize_packed() / virtqueue_resize_split().
> > But if this err is not important, this patch makes no sense.
> > Maybe I misunderstand somewhere...
> > If you think it's worth sending a patch, you can send it :).(I'm not familiar with this code).
> 
> OK.
> 
> Thanks.

I would first try to recover by re-enabling.
If that fails we can set broken.


> 
> >
> > Thanks,
> > Su Hui
> >

