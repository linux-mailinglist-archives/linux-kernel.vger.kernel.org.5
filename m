Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0C77D5F54
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjJYBGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjJYBGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39846D7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698195918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMh9TC0aGjaUuBRnwLbHZHlLYYDSCkNxx3aEz5NxIz4=;
        b=NVHQQo3ajOZdJiyJKEh4R4b/qLMUx+UQ6wBU99zIV7pkvnY7GoFqiDngg9s/m/PaGqCK0V
        8CZ9aqbXchC3DYXZuODW3d9iqJ4PK/dASYypchUt8T8UPXEJJS7AcfY0gnr6ygrvESn8u2
        4vC7uy8hDyO5A2B73ucwFxjMa6jo/yI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-04EUR9UwNgW4NGA7Q-eNFw-1; Tue,
 24 Oct 2023 21:05:14 -0400
X-MC-Unique: 04EUR9UwNgW4NGA7Q-eNFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 773423811F21;
        Wed, 25 Oct 2023 01:05:14 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 683732026D4C;
        Wed, 25 Oct 2023 01:05:08 +0000 (UTC)
Date:   Wed, 25 Oct 2023 09:05:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH V2] blk-mq: don't schedule block kworker on isolated CPUs
Message-ID: <ZThpvzrLGQFqpsYb@fedora>
References: <20231013124758.1492796-1-ming.lei@redhat.com>
 <293c16d2-f556-4d42-ab06-2e0acf1cc601@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <293c16d2-f556-4d42-ab06-2e0acf1cc601@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 09:53:49AM -0700, Bart Van Assche wrote:
> 
> On 10/13/23 05:47, Ming Lei wrote:
> > @@ -3926,6 +3941,15 @@ static void blk_mq_map_swqueue(struct request_queue *q)
> >   		 */
> >   		sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
> > +		/*
> > +		 * rule out isolated CPUs from hctx->cpumask for avoiding to
> > +		 * run wq worker on isolated CPU
> > +		 */
> > +		for_each_cpu(cpu, hctx->cpumask) {
> > +			if (cpu_is_isolated(cpu))
> > +				cpumask_clear_cpu(cpu, hctx->cpumask);
> > +		}
> 
> What will happen if this code makes hctx->cpumask empty? Code like
> blk_mq_first_mapped_cpu() and blk_mq_hctx_next_cpu() assumes that
> hctx->cpumask is not empty. There may be other code that assumes that
> hctx->cpumask is not empty.

hctx->cpumask is only used for selecting next cpu to schedule run
queue now, so it is fine for hctx->cpumask to be empty.

But the patch has one hole, following the delta fix:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0917f8eabab9..1d9a7ded27af 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2159,7 +2159,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 	bool tried = false;
 	int next_cpu = hctx->next_cpu;
 
-	if (hctx->queue->nr_hw_queues == 1)
+	if (hctx->queue->nr_hw_queues == 1 || next_cpu >= nr_cpu_ids)
 		return WORK_CPU_UNBOUND;
 
 	if (--hctx->next_cpu_batch <= 0) {



Thanks,
Ming

