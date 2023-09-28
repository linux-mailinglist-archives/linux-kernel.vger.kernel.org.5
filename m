Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0BE7B1166
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjI1EGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1EGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9714510A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695873922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZrLjkHF0/HwoOXQ2UetFuy9QaHx8cXgataUvrO0ObDQ=;
        b=SRIkcUZ3sLmLgGjlfkYqbTTGqGBq6ub9qudt/0+6Rg5eN4kZwIfU+U+x4ODyO/BTPmXCMt
        jVBgMVTA/Z98fR3pfXqwy1fqiSHemjabro7rDxbxsHCVXXxGuNkeZ2cHx5MWFcYF/glOjS
        FKCV1gHo2h0ZNUgSJTnpZ28zz031+gU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-T1n3Zf0xOJ-gjUrloG85LQ-1; Thu, 28 Sep 2023 00:05:17 -0400
X-MC-Unique: T1n3Zf0xOJ-gjUrloG85LQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F85E85A5BD;
        Thu, 28 Sep 2023 04:05:17 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6A03C15BB8;
        Thu, 28 Sep 2023 04:05:10 +0000 (UTC)
Date:   Thu, 28 Sep 2023 12:05:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linan666@huaweicloud.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com, ming.lei@redhat.com
Subject: Re: [PATCH] nbd: pass nbd_sock to nbd_read_reply() instead of index
Message-ID: <ZRT7cVFcE6QMHfie@fedora>
References: <20230911023308.3467802-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911023308.3467802-1-linan666@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:33:08AM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> If a socket is processing ioctl 'NBD_SET_SOCK', config->socks might be
> krealloc in nbd_add_socket(), and a garbage request is received now, a UAF
> may occurs.
> 
>   T1
>   nbd_ioctl
>    __nbd_ioctl
>     nbd_add_socket
>      blk_mq_freeze_queue
> 				T2
>   				recv_work
>   				 nbd_read_reply
>   				  sock_xmit
>      krealloc config->socks
> 				   def config->socks
> 
> Pass nbd_sock to nbd_read_reply(). And introduce a new function
> sock_xmit_recv(), which differs from sock_xmit only in the way it get
> socket.
> 

I am wondering why not grab queue usage counter before calling nbd_read_reply()
for avoiding such issue, something like the following change:

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index df1cd0f718b8..09215b605b12 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -837,9 +837,6 @@ static void recv_work(struct work_struct *work)
 	while (1) {
 		struct nbd_reply reply;
 
-		if (nbd_read_reply(nbd, args->index, &reply))
-			break;
-
 		/*
 		 * Grab .q_usage_counter so request pool won't go away, then no
 		 * request use-after-free is possible during nbd_handle_reply().
@@ -852,6 +849,9 @@ static void recv_work(struct work_struct *work)
 			break;
 		}
 
+		if (nbd_read_reply(nbd, args->index, &reply))
+			break;
+
 		cmd = nbd_handle_reply(nbd, args->index, &reply);
 		if (IS_ERR(cmd)) {
 			percpu_ref_put(&q->q_usage_counter);

Thanks,
Ming

