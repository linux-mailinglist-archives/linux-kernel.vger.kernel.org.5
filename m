Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86C76DC00
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjHCAIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjHCAHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7562E30FD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691021190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4JlhFPikF+sSc4TfuvT2iSqBvcIXhfFcOmWT8+LXOA=;
        b=Phs/Px0stJCrHap5f7DXY6XJyTB6L+SlcR96PbFC2twx8/g4g8KjjED73AdfcsHdv9PkNc
        Dzo6QFk1EMh+IpGjsYqbfpNVHZvydTi+hEGql3WRfoFjcrme6K2nQsNZ8B5/9R9vZ4v8iQ
        aG3vsVsW26m+z+Fdo8IvYWVm0DnAbCI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-y-ZaeKMtPM2ckAmg_G7-VA-1; Wed, 02 Aug 2023 20:06:25 -0400
X-MC-Unique: y-ZaeKMtPM2ckAmg_G7-VA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A16441C0782A;
        Thu,  3 Aug 2023 00:06:24 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86EBC112132D;
        Thu,  3 Aug 2023 00:06:06 +0000 (UTC)
Date:   Thu, 3 Aug 2023 08:06:00 +0800
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
Message-ID: <ZMrvaE4FjdYya72P@fedora>
References: <20230714072510.47770-1-nmi@metaspace.dk>
 <20230714072510.47770-3-nmi@metaspace.dk>
 <ZLfQjNK5j5lB68C/@x1-carbon>
 <87il9zot9c.fsf@metaspace.dk>
 <ZMkBbvb7EFyT/zGX@ovpn-8-18.pek2.redhat.com>
 <87a5v9pzx7.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5v9pzx7.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 11:09:56AM +0200, Andreas Hindborg (Samsung) wrote:
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Tue, Aug 01, 2023 at 02:11:56PM +0200, Andreas Hindborg (Samsung) wrote:
> >> 
> >> Niklas Cassel <Niklas.Cassel@wdc.com> writes:
> >> 
> >> > On Fri, Jul 14, 2023 at 09:25:10AM +0200, Andreas Hindborg wrote:
> >> >> From: Andreas Hindborg <a.hindborg@samsung.com>
> >> >
> >> > Hello Andreas!
> >> >
> >> 
> >> <snip>
> >> 
> >> >>  	/* for READ request, writing data in iod->addr to rq buffers */
> >> >> @@ -1120,6 +1404,11 @@ static void ublk_commit_completion(struct ublk_device *ub,
> >> >>  	/* find the io request and complete */
> >> >>  	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
> >> >>  
> >> >> +	if (io->flags & UBLK_IO_FLAG_ZONE_APPEND) {
> >> >
> >> > Do we really need to introduce a completely new flag just for this?
> >> >
> >> > if (req_op(req) == REQ_OP_ZONE_APPEND)
> >> >
> >> > should work just as well, no?
> >> 
> >> Makes sense, thanks.
> >
> > The above one can be replaced with req_op().
> >
> > But extra cost is added when retrieving request for the check in
> > __ublk_ch_uring_cmd().
> >
> 
> How about this (diff to v9):
> 
> @@ -1709,7 +1702,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  		goto out;
>  
>  	if (ublk_support_user_copy(ubq) &&
> -	    !(io->flags & UBLK_IO_FLAG_ZONE_APPEND) && ub_cmd->addr) {
> +	    _IOC_NR(cmd_op) != UBLK_IO_COMMIT_AND_FETCH_REQ && ub_cmd->addr) {
>  		ret = -EINVAL;
>  		goto out;
>  	}

Let's merge the above original user_copy check into 'case UBLK_IO_FETCH_REQ' &
'case UBLK_IO_COMMIT_AND_FETCH_REQ' first, then this patch can be cleaner, which
can be done as one prep change for zoned support.

> @@ -1751,6 +1744,12 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
>  			goto out;
>  
> +		if (ublk_support_user_copy(ubq) &&
> +		    req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +

Given request is available for UBLK_IO_COMMIT_AND_FETCH_REQ, this approach is
good, and UBLK_IO_FETCH_REQ cmd doesn't have OP.


Thanks,
Ming

