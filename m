Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795FC7A3046
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbjIPMnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbjIPMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E01E21B0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 05:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694868070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/kqZRW9gXRNvc1F996eE1e2wizoKvGhnn1qjNWI2aaY=;
        b=aL/BfTCxgCh4wJRUHxlcQDWRCOz6Zka2iugI0xYLFYr8ri+N3SPK9uLbpNzIwN+iuy8RVi
        62mdC2BTPkjfexQCP9Bhm3XtoXfStUDTC4FYZ4rmKTV0tqOgF05r4NwGzCz1pRscLwbWcC
        RDgDkPXRNSEFv8o3PUmdbi1FPFlA4+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-qxep9wqRMGimdZPrcCGAcw-1; Sat, 16 Sep 2023 08:41:06 -0400
X-MC-Unique: qxep9wqRMGimdZPrcCGAcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E02785A5BA;
        Sat, 16 Sep 2023 12:41:06 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC47F2026D68;
        Sat, 16 Sep 2023 12:41:00 +0000 (UTC)
Date:   Sat, 16 Sep 2023 20:40:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org, kbusch@kernel.org,
        mst@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 2/5] blk-mq: remove RQF_MQ_INFLIGHT
Message-ID: <ZQWiVwVh3VcjA6aD@fedora>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
 <20230913151616.3164338-3-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913151616.3164338-3-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 03:16:13PM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Since the previous patch change to only account active requests when
> we really allocate the driver tag, the RQF_MQ_INFLIGHT can be removed
> and no double account problem.
> 
> 1. none elevator: flush request will use the first pending request's
>    driver tag, won't double account.
> 
> 2. other elevator: flush request will be accounted when allocate driver
>    tag when issue, and will be unaccounted when it put the driver tag.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

