Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566BE7B4B54
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjJBGLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjJBGLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:11:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AED49B;
        Sun,  1 Oct 2023 23:11:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9DE0168D07; Mon,  2 Oct 2023 08:11:43 +0200 (CEST)
Date:   Mon, 2 Oct 2023 08:11:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Leech <cleech@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cnic,bnx2,bnx2x: page align uio mmap allocations
Message-ID: <20231002061143.GB911@lst.de>
References: <20230929170023.1020032-1-cleech@redhat.com> <20230929170023.1020032-3-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929170023.1020032-3-cleech@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 10:00:22AM -0700, Chris Leech wrote:
> Allocations in these drivers that will be mmaped through a uio device
> should be made in multiples of PAGE_SIZE to avoid exposing additional
> kernel memory unintentionally.

dma coherent allocations are always rounded up to a page, although
the documentation for that is somewhat obscure and I wouldn't fault
anyone for not relying on it.
