Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC77D436B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjJWXqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWXqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A503DE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698104723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8108ZK/uYMS29R+GboAUTn6c5bPK/gI994W5VC5oVsw=;
        b=LX/WFddBOabZNb4dXlOVtHT6XNQgcFzm5krmHxL2t8h77KU74Ljr1LZLqkNdv4wu3UDfVc
        MfGn5pSoYA3QgRyhVfKDFnMG4vN+3zLBCvWG90pBBcg6iKCm38rC3/mmgA9yAhOnC0SLUH
        dPaWs8JGazhXGT2K93lD8+uyXa4Qw7c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-PQtrGROaMdOCysOffZFoLg-1; Mon,
 23 Oct 2023 19:45:20 -0400
X-MC-Unique: PQtrGROaMdOCysOffZFoLg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 887093811F2C;
        Mon, 23 Oct 2023 23:45:20 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BB8B492BD9;
        Mon, 23 Oct 2023 23:45:14 +0000 (UTC)
Date:   Tue, 24 Oct 2023 07:45:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH V2] blk-mq: don't schedule block kworker on isolated CPUs
Message-ID: <ZTcFhmdAPL0LQD7J@fedora>
References: <20231013124758.1492796-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013124758.1492796-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 08:47:58PM +0800, Ming Lei wrote:
> Kernel parameter of `isolcpus=` or 'nohz_full=' are used for isolating CPUs
> for specific task, and user often won't want block IO to disturb these CPUs,
> also long IO latency may be caused if blk-mq kworker is scheduled on these
> isolated CPUs.
> 
> Kernel workqueue only respects this limit for WQ_UNBOUND, for bound wq,
> the responsibility should be on wq user.
> 
> So don't not run block kworker on isolated CPUs by ruling out isolated CPUs
> from hctx->cpumask. Meantime in cpuhp handler, use queue map to check if
> all CPUs in this hw queue are offline, this way can avoid any cost in fast
> IO code path.
> 
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Andrew Theurer <atheurer@redhat.com>
> Cc: Joe Mario <jmario@redhat.com>
> Cc: Sebastian Jug <sejug@redhat.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- remove module parameter, meantime use queue map to check if
> 	all cpus in one hctx are offline

Hello Guys,

Ping...



Thanks,
Ming

