Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C927A2F03
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbjIPJYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 05:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbjIPJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42F28173C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 02:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694856208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BGEP6R3c9Jhc+DpCgSNfDoTCVIo/fpZjOC0f7OC9AbQ=;
        b=H+5xD+lRWEJoEV+yMvzwk1tSjWG6XB5eqUJV99NEKDK+huGf8YTZEgGouE6S9tbu3GLQZU
        RaYZHSc3DDyGBpNbiC0OBB3g2uVuAQt2+LBzdtSxoieAlx2fLEIKM9khJfuumESpxGPOzx
        DUcKzQiQTtLM/Dw8fFe8HCCghB3UY7k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-683-dS3atwUAML2XJhTUgDpg-Q-1; Sat, 16 Sep 2023 05:23:23 -0400
X-MC-Unique: dS3atwUAML2XJhTUgDpg-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E707945921;
        Sat, 16 Sep 2023 09:23:22 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B14D40C6EBF;
        Sat, 16 Sep 2023 09:23:15 +0000 (UTC)
Date:   Sat, 16 Sep 2023 17:23:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org, kbusch@kernel.org,
        mst@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH v2 1/5] blk-mq: account active requests when get driver
 tag
Message-ID: <ZQVz/hFxxaM8Orza@fedora>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
 <20230913151616.3164338-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913151616.3164338-2-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

RQF_MQ_INFLIGHT is only set for BLK_MQ_F_TAG_QUEUE_SHARED, so we can
avoid the extra atomic accounting for !BLK_MQ_F_TAG_QUEUE_SHARED.

But now your patch switches to account unconditionally by removing
RQF_MQ_INFLIGHT, not friendly for !BLK_MQ_F_TAG_QUEUE_SHARED.

Thanks, 
Ming

