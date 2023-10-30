Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4701C7DBA11
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjJ3MoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJ3MoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090A9B4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698669792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2aGI7b6Nnnncm4UZbmNz8Ers4mK4PsonHRchB15+6Ls=;
        b=Yro60jk6jMDfXsw60jcsAa5GMBlo7Ug0WhYIt9Zz6VDr5ljfoxKpPnagIK8L8N7Yclv6cL
        s92oVuW76EoU4qurYhDjFdxdD0KxC7jHEsZpkQFnnR5MvgYtIL5P5u/TxFRFJt/7vh3Yp5
        y3B0TFpNnks1yccXjwWYOpaGrKXViYM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-TFX8POwoPzi2XVPuklgc9A-1; Mon, 30 Oct 2023 08:43:08 -0400
X-MC-Unique: TFX8POwoPzi2XVPuklgc9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF39181D8A1;
        Mon, 30 Oct 2023 12:43:07 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CCE7240C6EB9;
        Mon, 30 Oct 2023 12:43:00 +0000 (UTC)
Date:   Mon, 30 Oct 2023 20:42:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linan666@huaweicloud.com, josef@toxicpanda.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] nbd: pass nbd_sock to nbd_read_reply() instead of index
Message-ID: <ZT+kzw3Zm/3XJqD7@fedora>
References: <20230911023308.3467802-1-linan666@huaweicloud.com>
 <ZRT7cVFcE6QMHfie@fedora>
 <47669fb6-3700-e327-11af-93a92b0984a0@huaweicloud.com>
 <ZRUt/vAQNGNp6Ugx@fedora>
 <41161d21-299c-3657-6020-0a3a9cf109ec@huaweicloud.com>
 <ZRU/7Bx1ZJSX3Qg3@fedora>
 <60f9a88b-b750-3579-bdfd-5421f2040406@huaweicloud.com>
 <ZRVGWkCzKAVVL9bV@fedora>
 <bbadaad4-172e-af7b-2a47-52f7e7c83423@huaweicloud.com>
 <a6393a45-8510-5734-c174-0826c7d76675@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6393a45-8510-5734-c174-0826c7d76675@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:07:13AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/09/28 17:40, Yu Kuai 写道:
> > Hi,
> > 
> > 在 2023/09/28 17:24, Ming Lei 写道:
> > > On Thu, Sep 28, 2023 at 05:06:40PM +0800, Yu Kuai wrote:
> > > > Hi,
> > > > 
> > > > 在 2023/09/28 16:57, Ming Lei 写道:
> > > > > On Thu, Sep 28, 2023 at 04:55:03PM +0800, Yu Kuai wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > 在 2023/09/28 15:40, Ming Lei 写道:
> > > > > > > On Thu, Sep 28, 2023 at 02:03:28PM +0800, Yu Kuai wrote:
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > 在 2023/09/28 12:05, Ming Lei 写道:
> > > > > > > > > On Mon, Sep 11, 2023 at 10:33:08AM +0800,
> > > > > > > > > linan666@huaweicloud.com wrote:
> > > > > > > > > > From: Li Nan <linan122@huawei.com>
> > > > > > > > > > 
> > > > > > > > > > If a socket is processing ioctl
> > > > > > > > > > 'NBD_SET_SOCK', config->socks might be
> > > > > > > > > > krealloc in nbd_add_socket(), and a
> > > > > > > > > > garbage request is received now, a UAF
> > > > > > > > > > may occurs.
> > > > > > > > > > 
> > > > > > > > > >       T1
> > > > > > > > > >       nbd_ioctl
> > > > > > > > > >        __nbd_ioctl
> > > > > > > > > >         nbd_add_socket
> > > > > > > > > >          blk_mq_freeze_queue
> > > > > > > > > >                 T2
> > > > > > > > > >                       recv_work
> > > > > > > > > >                        nbd_read_reply
> > > > > > > > > >                         sock_xmit
> > > > > > > > > >          krealloc config->socks
> > > > > > > > > >                    def config->socks
> > > > > > > > > > 
> > > > > > > > > > Pass nbd_sock to nbd_read_reply(). And introduce a new function
> > > > > > > > > > sock_xmit_recv(), which differs from
> > > > > > > > > > sock_xmit only in the way it get
> > > > > > > > > > socket.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > I am wondering why not grab queue usage
> > > > > > > > > counter before calling nbd_read_reply()
> > > > > > > > > for avoiding such issue, something like the following change:
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > > > > > > > > index df1cd0f718b8..09215b605b12 100644
> > > > > > > > > --- a/drivers/block/nbd.c
> > > > > > > > > +++ b/drivers/block/nbd.c
> > > > > > > > > @@ -837,9 +837,6 @@ static void recv_work(struct work_struct *work)
> > > > > > > > >          while (1) {
> > > > > > > > >              struct nbd_reply reply;
> > > > > > > > > -        if (nbd_read_reply(nbd, args->index, &reply))
> > > > > > > > > -            break;
> > > > > > > > > -
> > > > > > > > >              /*
> > > > > > > > >               * Grab .q_usage_counter so
> > > > > > > > > request pool won't go away, then no
> > > > > > > > >               * request use-after-free is
> > > > > > > > > possible during nbd_handle_reply().
> > > > > > > > > @@ -852,6 +849,9 @@ static void recv_work(struct work_struct *work)
> > > > > > > > >                  break;
> > > > > > > > >              }
> > > > > > > > 
> > > > > > > > This break how nbd works, if there is no reply yet, recv_work() will
> > > > > > > > wait for reply in:
> > > > > > > > 
> > > > > > > > nbd_read_reply
> > > > > > > >     sock_xmit
> > > > > > > >      sock_recvmsg
> > > > > > > > 
> > > > > > > > After this change, recv_work() will just return if there is no io.
> > > > > > > 
> > > > > > > OK, got it, thanks for the input.
> > > > > > > 
> > > > > > > But I feel it isn't necessary & fragile to store one
> > > > > > > extra reference of nsock in
> > > > > > > `recv_thread_args`.
> > > > > > > 
> > > > > > > Just run a quick look, the only potential UAF on
> > > > > > > config->socks should be recv_work(),
> > > > > > > so you can retrieve the `nsock` reference at the
> > > > > > > entry of recv_work(),
> > > > > > 
> > > > > > I don't understand what you mean retrieve the 'nsock',
> > > > > > is following what
> > > > > > you expected?
> > > > > > 
> > > > > > blk_queue_enter() -> prevent concurrent with nbd_add_socket
> > > > > > nsock = config->socks[args->index]
> > > > > > blk_queue_exit()
> > > > > 
> > > > > Yeah, turns out you do understand, :-)
> > > > 
> > > > Ok, I was not sure about this blk_queue_enter(). By the way, this
> > > 
> > > blk_queue_enter() isn't exported, but you can grab ->config_lock
> > > for getting the `nsock`.
> > > 
> > > > remind me of what you did to fix uaf of access queue->mq_hctx[] by
> > > > convert the array to xarray.
> > > > 
> > > > 
> > > > Maybe it's better to covert config->socks[] to xarray to fix this uaf as
> > > > well?
> > > 
> > > ->socks[idx] is needed in nbd fast path, so xarray may not be one
> > > good idea
> > > since xarray_load() introduces extra load, especially ->socks[] uaf
> > > should exist in recv_work() very likely. For other cases, the active
> > > block request holds queue usage counter.
> > 
> > Thanks for the explanation, grab 'config_lock' to get 'nsock' in the
> > begining sounds good to me.
> 
> After reviewing some code, I found that it's wrong to grab config_lock,
> because other context will grab such lock and flush_workqueue(), and
> there is no gurantee that recv_work() will grab the lock first.
> 
> Will it be acceptable to export blk_queue_enter()? I can't think of
> other way to retrieve the`nsock` reference at the entry of recv_work().

Then I think it is easier to pass `nsock` from `recv_thread_args`, which
can be thought as local variable too.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

