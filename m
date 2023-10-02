Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5AC7B4B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjJBGEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJBGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:04:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B39B;
        Sun,  1 Oct 2023 23:04:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0C27A68D1C; Mon,  2 Oct 2023 08:04:25 +0200 (CEST)
Date:   Mon, 2 Oct 2023 08:04:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chris Leech <cleech@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20231002060424.GA781@lst.de>
References: <20230929170023.1020032-1-cleech@redhat.com> <20230929170023.1020032-4-cleech@redhat.com> <2023093055-gotten-astronomy-a98b@gregkh> <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox> <2023093002-unlighted-ragged-c6e1@gregkh> <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de> <2023100114-flatware-mourner-3fed@gregkh> <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 07:22:36AM -0700, Jerry Snitselaar wrote:
> Changes last year to the dma-mapping api to no longer allow __GFP_COMP,
> in particular these two (from the e529d3507a93 dma-mapping pull for
> 6.2):

That's complete BS.  The driver was broken since day 1 and always
ignored the DMA API requirement to never try to grab the page from the
dma coherent allocation because you generally speaking can't.  It just
happened to accidentally work the trivial dma coherent allocator that
is used on x86.

