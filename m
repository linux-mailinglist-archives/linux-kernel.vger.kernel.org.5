Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6E808B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443426AbjLGPTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjLGPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:19:14 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3719A;
        Thu,  7 Dec 2023 07:19:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46A52227A87; Thu,  7 Dec 2023 16:19:17 +0100 (CET)
Date:   Thu, 7 Dec 2023 16:19:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, Li Feng <fengli@smartx.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO BLOCK AND SCSI DRIVERS" 
        <virtualization@lists.linux.dev>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231207151917.GA20401@lst.de>
References: <20231207043118.118158-1-fengli@smartx.com> <20231207145159.GB2147383@fedora> <CABgObfYJUH0hF8QfNUAZS9ztR7LqeHGOXeTa0JO904svJw23_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYJUH0hF8QfNUAZS9ztR7LqeHGOXeTa0JO904svJw23_g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 03:55:17PM +0100, Paolo Bonzini wrote:
> > This seems similar to commit f8b12e513b95 ("virtio_blk: revert
> > QUEUE_FLAG_VIRT addition") where changing the default sounded good in
> > theory but exposed existing users to performance regressions. [...]
> > I don't want to be overly conservative. The virtio_blk driver has
> > undergone changes in this regard from the legacy block layer to blk-mq
> > (without an I/O scheduler) to blk-mq (mq-deadline).
> 
> IIRC there were also regressions in both virtio-blk and virtio-scsi
> when switching from the legacy block layer to blk-mq. So perhaps I
> *am* a bit more conservative, but based on past experience, this patch
> seems not to be a great idea for practical use cases.

Agreed.  I'm in fact not exactly happy about the rather odd
BLK_MQ_F_NO_SCHED_BY_DEFAULT flag to start with.
