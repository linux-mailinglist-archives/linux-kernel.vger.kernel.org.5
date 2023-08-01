Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5676B551
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjHAM70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjHAM7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D280210E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690894716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCe2p2QN9kRBjT/3kMdEzmYcq2EYKmnX7BhNzQuR/cY=;
        b=DWxxixQWkvPTuDCjwGjTiFYiPxI8pGzfywn8aBGUfbzaG3tAfGXB7P7V/GorktSX9DBYsQ
        tZHaym19w5IJfPaXwz2ybyf7q8lBU53CSf7Mp9RMNv8i8TuNrs9PZVztTlo3km+U8rNlZd
        T40Fk0V6lhfMdhDI0ygUX/BaJonOzKM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-yAUigt5fM2WwXlu__pkf3g-1; Tue, 01 Aug 2023 08:58:34 -0400
X-MC-Unique: yAUigt5fM2WwXlu__pkf3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CE671C2BD62;
        Tue,  1 Aug 2023 12:58:34 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4767040C6CCC;
        Tue,  1 Aug 2023 12:58:26 +0000 (UTC)
Date:   Tue, 1 Aug 2023 20:58:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v9 2/2] ublk: enable zoned storage support
Message-ID: <ZMkBbvb7EFyT/zGX@ovpn-8-18.pek2.redhat.com>
References: <20230714072510.47770-1-nmi@metaspace.dk>
 <20230714072510.47770-3-nmi@metaspace.dk>
 <ZLfQjNK5j5lB68C/@x1-carbon>
 <87il9zot9c.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il9zot9c.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:11:56PM +0200, Andreas Hindborg (Samsung) wrote:
> 
> Niklas Cassel <Niklas.Cassel@wdc.com> writes:
> 
> > On Fri, Jul 14, 2023 at 09:25:10AM +0200, Andreas Hindborg wrote:
> >> From: Andreas Hindborg <a.hindborg@samsung.com>
> >
> > Hello Andreas!
> >
> 
> <snip>
> 
> >>  	/* for READ request, writing data in iod->addr to rq buffers */
> >> @@ -1120,6 +1404,11 @@ static void ublk_commit_completion(struct ublk_device *ub,
> >>  	/* find the io request and complete */
> >>  	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
> >>  
> >> +	if (io->flags & UBLK_IO_FLAG_ZONE_APPEND) {
> >
> > Do we really need to introduce a completely new flag just for this?
> >
> > if (req_op(req) == REQ_OP_ZONE_APPEND)
> >
> > should work just as well, no?
> 
> Makes sense, thanks.

The above one can be replaced with req_op().

But extra cost is added when retrieving request for the check in
__ublk_ch_uring_cmd().


Thanks,
Ming

