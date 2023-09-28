Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FAD7B1531
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjI1Hlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjI1Hlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351568F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695886865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ik4NJ/TGlJZz+KHb//NIC0FfeN79I9S7Nn+XpOdL4hI=;
        b=LQqRx9n2vKqp3TjsbaloRgDvIRjDa/UfgzzGG00UHLHllWtgCglMXivOWaHxTAd3ru9Aj2
        Yli0862mhXdEXksaqlaS6ZY82vTCpitURAR/u2dfMGLCorNCtrgFIkoGiXIRtjbZNyqI/d
        VUkzMsO3Z8oqko95vo1XX3lKU6ncOOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-PUt-YSMNMSWUFoSPp6bpuQ-1; Thu, 28 Sep 2023 03:41:00 -0400
X-MC-Unique: PUt-YSMNMSWUFoSPp6bpuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 337CF185A79B;
        Thu, 28 Sep 2023 07:41:00 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62923C15BB8;
        Thu, 28 Sep 2023 07:40:51 +0000 (UTC)
Date:   Thu, 28 Sep 2023 15:40:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linan666@huaweicloud.com, josef@toxicpanda.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>, ming.lei@redhat.com
Subject: Re: [PATCH] nbd: pass nbd_sock to nbd_read_reply() instead of index
Message-ID: <ZRUt/vAQNGNp6Ugx@fedora>
References: <20230911023308.3467802-1-linan666@huaweicloud.com>
 <ZRT7cVFcE6QMHfie@fedora>
 <47669fb6-3700-e327-11af-93a92b0984a0@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47669fb6-3700-e327-11af-93a92b0984a0@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 02:03:28PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/09/28 12:05, Ming Lei 写道:
> > On Mon, Sep 11, 2023 at 10:33:08AM +0800, linan666@huaweicloud.com wrote:
> > > From: Li Nan <linan122@huawei.com>
> > > 
> > > If a socket is processing ioctl 'NBD_SET_SOCK', config->socks might be
> > > krealloc in nbd_add_socket(), and a garbage request is received now, a UAF
> > > may occurs.
> > > 
> > >    T1
> > >    nbd_ioctl
> > >     __nbd_ioctl
> > >      nbd_add_socket
> > >       blk_mq_freeze_queue
> > > 				T2
> > >    				recv_work
> > >    				 nbd_read_reply
> > >    				  sock_xmit
> > >       krealloc config->socks
> > > 				   def config->socks
> > > 
> > > Pass nbd_sock to nbd_read_reply(). And introduce a new function
> > > sock_xmit_recv(), which differs from sock_xmit only in the way it get
> > > socket.
> > > 
> > 
> > I am wondering why not grab queue usage counter before calling nbd_read_reply()
> > for avoiding such issue, something like the following change:
> > 
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index df1cd0f718b8..09215b605b12 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -837,9 +837,6 @@ static void recv_work(struct work_struct *work)
> >   	while (1) {
> >   		struct nbd_reply reply;
> > -		if (nbd_read_reply(nbd, args->index, &reply))
> > -			break;
> > -
> >   		/*
> >   		 * Grab .q_usage_counter so request pool won't go away, then no
> >   		 * request use-after-free is possible during nbd_handle_reply().
> > @@ -852,6 +849,9 @@ static void recv_work(struct work_struct *work)
> >   			break;
> >   		}
> 
> This break how nbd works, if there is no reply yet, recv_work() will
> wait for reply in:
> 
> nbd_read_reply
>  sock_xmit
>   sock_recvmsg
> 
> After this change, recv_work() will just return if there is no io.

OK, got it, thanks for the input.

But I feel it isn't necessary & fragile to store one extra reference of nsock in
`recv_thread_args`.

Just run a quick look, the only potential UAF on config->socks should be recv_work(),
so you can retrieve the `nsock` reference at the entry of recv_work(),
and just pass it(local variable) to nbd_read_reply() and nbd_handle_reply()
since `nsock` won't be freed.


Thanks,
Ming

