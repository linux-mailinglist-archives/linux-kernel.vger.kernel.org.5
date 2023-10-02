Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6527B4D7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbjJBIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJBIqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:46:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF75A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:46:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98574C433C7;
        Mon,  2 Oct 2023 08:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696236367;
        bh=SFYczP14+YPquywIz+kLBBQBFxbQSUtX9DllX2+43Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnAklcyfyFtMFaYI1giLt0UCh8h+FrWL8byoDNMu37IUBE9p1mlCYiZ/lcjBMHG+v
         IgL+RUFTzDEtSOiK8ciqQu3ur11ICwdlZc/pLilHmXsWFcl4LwHF5IdyyKHFaquAq3
         rsiddk+eVqb55CzS6iD1w/Mz2O/djrOr10+kJ520=
Date:   Mon, 2 Oct 2023 10:46:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chris Leech <cleech@redhat.com>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <2023100233-salsa-joyous-6d8c@gregkh>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
 <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
 <2023093002-unlighted-ragged-c6e1@gregkh>
 <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de>
 <2023100114-flatware-mourner-3fed@gregkh>
 <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
 <20231002060424.GA781@lst.de>
 <tf2zu6gqaii2bjipbo2mn2hz64px2624rfcmyg36rkq4bskxiw@zgjzznig6e22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tf2zu6gqaii2bjipbo2mn2hz64px2624rfcmyg36rkq4bskxiw@zgjzznig6e22>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 12:50:21AM -0700, Jerry Snitselaar wrote:
> On Mon, Oct 02, 2023 at 08:04:24AM +0200, Christoph Hellwig wrote:
> > On Sun, Oct 01, 2023 at 07:22:36AM -0700, Jerry Snitselaar wrote:
> > > Changes last year to the dma-mapping api to no longer allow __GFP_COMP,
> > > in particular these two (from the e529d3507a93 dma-mapping pull for
> > > 6.2):
> > 
> > That's complete BS.  The driver was broken since day 1 and always
> > ignored the DMA API requirement to never try to grab the page from the
> > dma coherent allocation because you generally speaking can't.  It just
> > happened to accidentally work the trivial dma coherent allocator that
> > is used on x86.
> > 
> 
> re-sending since gmail decided to not send plain text:
> 
> Yes, I agree that it has been broken and misusing the API. Greg's
> question was what changed though, and it was the clean up of
> __GFP_COMP in dma-mapping that brought the problem in the driver to
> light.
> 
> I already said the other day that cnic has been doing this for 14
> years. I'm not blaming you or your __GFP_COMP cleanup commits, they
> just uncovered that cnic was doing something wrong. My apologies if
> you took it that way.

As these devices aren't being made anymore, and this api is really not a
good idea in the first place, why don't we just leave it broken and see
if anyone notices?

thanks,

greg k-h
