Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0758675CA7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjGUOqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGUOqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133E930E4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689950752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CSmxBWHZqife/wyZDuG2oCanXHyMdbvWN3yQVprkoXU=;
        b=YYjhWN34Ehwg8Tj7GfqM0khJ97J3v3J4oav4Mnt9AzTDZ75JQHJycLpSqVciIVV0jcHMgz
        I61VEBo9n+CNzCP/IUE4Dd4OyA5CCgiDOI1oMRQWY19/9USPachyhLMzGJk4HJulQgpbkN
        rYQI05dIqrd67yZMnamiVPWzLVSoxsg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-JFWUYUQOMRmNkeIUhEtD7A-1; Fri, 21 Jul 2023 10:45:50 -0400
X-MC-Unique: JFWUYUQOMRmNkeIUhEtD7A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51e3713ce6eso3780381a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689950749; x=1690555549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSmxBWHZqife/wyZDuG2oCanXHyMdbvWN3yQVprkoXU=;
        b=YuZO36Bk7Xe/srRjXoQbcmjgA0jXI3phrmk1kKXp0JVjjEefseX6e02ubPIEC7PbIn
         qN/EQC1mOk9lpmJwAkEJoDpF+d3p3XypheY8UJX4k0uNKifrs0k4fDJ/+acYr7klp1xk
         DKuFZVwZgkmU7Xt45DFCRbs91cZwmLPs7oBF1aWRAYztj73M9FGktIgGrOXIL+KEMK1w
         BSsQ36adPVUTQuTGpkeT3MjmEQbeQ1B5ZOxH/Be6BS5CGpV3+vf+Ew8Tx8JroW0WRjYF
         k2Ys2pySGWH7jaIzEfasZHEYlHtVt4k+a1yrcQiYqxkAVufuXHG31ohu/G2yLT1w24gv
         PP1g==
X-Gm-Message-State: ABy/qLYdsWTGixvAsE3W5MYtjhhNFHjcTnUNCfRlgXBWgoIQjP/ktexL
        pxYM97LH1uzXzeKuwhuM2CeOkLyyWzSY6A5O2heNx+mTHsJeZWp0vxenENhRT9Nt3FXoDUv71EN
        DTnINhgIlHH+djZeJJ7VfM2E6
X-Received: by 2002:aa7:db4e:0:b0:521:29a:8ee3 with SMTP id n14-20020aa7db4e000000b00521029a8ee3mr2186349edt.5.1689950749642;
        Fri, 21 Jul 2023 07:45:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFz1BiswVaH2Ai9c9vtY6LU5i5/TJTickO+NhgBFmERPHi2WvB/4gjph5Mu4Wx8zxL3o3ikyw==
X-Received: by 2002:aa7:db4e:0:b0:521:29a:8ee3 with SMTP id n14-20020aa7db4e000000b00521029a8ee3mr2186331edt.5.1689950749277;
        Fri, 21 Jul 2023 07:45:49 -0700 (PDT)
Received: from redhat.com ([193.142.201.78])
        by smtp.gmail.com with ESMTPSA id r26-20020a056402035a00b00521a3d8474csm2212152edw.57.2023.07.21.07.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 07:45:48 -0700 (PDT)
Date:   Fri, 21 Jul 2023 10:45:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Shannon Nelson <shannon.nelson@amd.com>,
        Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230721104445-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> 
> 
> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > 
> > > > Adding cond_resched() to the command waiting loop for a better
> > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > run other task(workqueue) instead of busy looping when preemption is
> > > > not allowed on a device whose CVQ might be slow.
> > > > 
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > 
> > > This still leaves hung processes, but at least it doesn't pin the CPU any
> > > more.  Thanks.
> > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > 
> > 
> > I'd like to see a full solution
> > 1- block until interrupt
> 
> Would it make sense to also have a timeout?
> And when timeout expires, set FAILED bit in device status?

virtio spec does not set any limits on the timing of vq
processing.

> > 2- still handle surprise removal correctly by waking in that case
> > 
> > 
> > 
> > > > ---
> > > >    drivers/net/virtio_net.c | 4 +++-
> > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > >            * into the hypervisor, so the request should be handled immediately.
> > > >            */
> > > >           while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > -              !virtqueue_is_broken(vi->cvq))
> > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > +               cond_resched();
> > > >                   cpu_relax();
> > > > +       }
> > > > 
> > > >           return vi->ctrl->status == VIRTIO_NET_OK;
> > > >    }
> > > > --
> > > > 2.39.3
> > > > 
> > > > _______________________________________________
> > > > Virtualization mailing list
> > > > Virtualization@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > 

