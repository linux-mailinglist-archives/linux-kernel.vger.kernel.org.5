Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DB87A3045
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbjIPMky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbjIPMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32A89E42
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694867989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vRi9ZR5pdwGT1p3xgTqgA4/cyNJb7odKKn0k0Q7KZbg=;
        b=fTMAQ9xM6tteGQ2VGrS3U3KpL37GlSJn/Xv3vcyRAHGOW3sow9o+8sg91QkGilY2pMCNJh
        YADKH2iZQ2Z4xF7MoKvGBYBBn/7YBtvKEqSJiZIkaBy0k8YtmyKjlboWYK/E2P+OFc+82N
        Bir1jLgXaAXRn0TAqlG7qoiGhkaMucM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-gM2Hse8-MhSM2oehvMvRRg-1; Sat, 16 Sep 2023 08:39:45 -0400
X-MC-Unique: gM2Hse8-MhSM2oehvMvRRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5E4018175A0;
        Sat, 16 Sep 2023 12:39:44 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5533A10005D3;
        Sat, 16 Sep 2023 12:39:38 +0000 (UTC)
Date:   Sat, 16 Sep 2023 20:39:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org, kbusch@kernel.org,
        mst@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 1/5] blk-mq: account active requests when get driver
 tag
Message-ID: <ZQWiBpBMM7I9L57O@fedora>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
 <20230913151616.3164338-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913151616.3164338-2-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 03:16:12PM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> There is a limit that batched queue_rqs() can't work on shared tags
> queue, since the account of active requests can't be done there.
> 
> Now we account the active requests only in blk_mq_get_driver_tag(),
> which is not the time we get driver tag actually (with none elevator).
> 
> To support batched queue_rqs() on shared tags queue, we move the
> account of active requests to where we get the driver tag:
> 
> 1. none elevator: blk_mq_get_tags() and blk_mq_get_tag()
> 2. other elevator: __blk_mq_alloc_driver_tag()
> 
> This is clearer and match with the unaccount side, which just happen
> when we put the driver tag.
> 
> The other good point is that we don't need RQF_MQ_INFLIGHT trick
> anymore, which used to avoid double account of flush request.
> Now we only account when actually get the driver tag, so all is good.
> We will remove RQF_MQ_INFLIGHT in the next patch.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---

Nice cleanup,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

