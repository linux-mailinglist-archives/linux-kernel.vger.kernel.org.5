Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CED77622E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjHIOPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjHIOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:15:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE571FCC;
        Wed,  9 Aug 2023 07:15:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 822116732D; Wed,  9 Aug 2023 16:15:42 +0200 (CEST)
Date:   Wed, 9 Aug 2023 16:15:42 +0200
From:   hch <hch@lst.de>
To:     Stephan Wurm <stephan.wurm@a-eberle.de>
Cc:     hch <hch@lst.de>, Richard Weinberger <richard@nod.at>,
        linux-block <linux-block@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Eigner <johannes.eigner@a-eberle.de>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
Message-ID: <20230809141542.GA32614@lst.de>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm> <1293911429.1782934.1691445776353.JavaMail.zimbra@nod.at> <20230809135308.GA32214@lst.de> <ZNOec8JmndA63Mnh@PC-LX-Wurm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNOec8JmndA63Mnh@PC-LX-Wurm>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 04:10:59PM +0200, Stephan Wurm wrote:
> Am 09. Aug 15:53 hat hch geschrieben:
> > Well, a scatterlist culd contain a highmem page, in which case sg_virt
> > isn't going to cut it and you need to kmap.  Is this a 32-bit system
> > with highmem enabled?
> I can confirm it is a 32-bit system with highmem enabled.

Yes.  So the code needs to stop using sg_virt to work on highmem
setups and do the equivalent of scsi_kmap_atomic_sg.  Best way
forward is probably to move scsi_kmap_atomic_sg to lib/scatterlist.c
(and also convert it to kmap_local instead of kmap_atomic while you're
at it) and then use that in ubiblock
