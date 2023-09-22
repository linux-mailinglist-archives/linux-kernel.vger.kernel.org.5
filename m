Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122247AADCF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjIVJ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjIVJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:26:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107C3197;
        Fri, 22 Sep 2023 02:26:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC56C433C7;
        Fri, 22 Sep 2023 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695374783;
        bh=CiplfnZWE0N96tT0Pqsa0UEZgTjTPzci1ZYFdLmLu34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsZ6FYLlqZJ0Wx9wj3oJWpkWzElbpXmmVhOT05kNCZRqqstYlKXj1B60PruPBESXx
         StdNK6XAXeDh7iImU1cuqe1zuYd7iJyCylBZTBVko2JYVYrFqUYtbbwzXrnTgSl82f
         aQzDl8nITFW6K8KN2zhfv0Kwnon8Nz3Cu/3WH2z8=
Date:   Fri, 22 Sep 2023 11:26:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Wensheng <zhangwensheng@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Hillf Danton <hdanton@sina.com>, Yu Kuai <yukuai3@huawei.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH] block: fix use-after-free of q->q_usage_counter
Message-ID: <2023092258-clothing-passerby-e0f2@gregkh>
References: <20230921182012.3965572-1-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921182012.3965572-1-saranyamohan@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:20:12AM -0700, Saranya Muruganandam wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> commit d36a9ea5e7766961e753ee38d4c331bbe6ef659b upstream.
> 
> For blk-mq, queue release handler is usually called after
> blk_mq_freeze_queue_wait() returns. However, the
> q_usage_counter->release() handler may not be run yet at that time, so
> this can cause a use-after-free.
> 
> Fix the issue by moving percpu_ref_exit() into blk_free_queue_rcu().
> Since ->release() is called with rcu read lock held, it is agreed that
> the race should be covered in caller per discussion from the two links.
> 
> Backport-notes: Not a clean cherry-pick since a lot has changed,
> however essentially the same fix.
> 
> Reported-by: Zhang Wensheng <zhangwensheng@huaweicloud.com>
> Reported-by: Zhong Jinghua <zhongjinghua@huawei.com>
> Link: https://lore.kernel.org/linux-block/Y5prfOjyyjQKUrtH@T590/T/#u
> Link: https://lore.kernel.org/lkml/Y4%2FmzMd4evRg9yDi@fedora/
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Link: https://lore.kernel.org/r/20221215021629.74870-1-ming.lei@redhat.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> ---
>  block/blk-core.c  | 2 --
>  block/blk-sysfs.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)

What stable kernel(s) are you expecting this backport to be applied to?

thanks,

greg "not a mind reader" k-h
