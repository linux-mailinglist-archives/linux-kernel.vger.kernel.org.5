Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950780AE26
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574737AbjLHUoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:44:11 -0500
X-Greylist: delayed 592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 12:44:17 PST
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5A7171E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:44:17 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id D933287;
        Fri,  8 Dec 2023 12:34:24 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id tbfFGu00FUj5; Fri,  8 Dec 2023 12:34:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id 5E03440;
        Fri,  8 Dec 2023 12:34:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 5E03440
Date:   Fri, 8 Dec 2023 12:34:19 -0800 (PST)
From:   Eric Wheeler <dm-devel@lists.ewheeler.net>
To:     Hongyu Jin <hongyu.jin.cn@gmail.com>
cc:     Eric Biggers <ebiggers@kernel.org>, agk@redhat.com,
        snitzer@kernel.org, mpatocka@redhat.com, zhiguo.niu@unisoc.com,
        ke.wang@unisoc.com, yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
        linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev
Subject: Re: [PATCH v2] dm verity: Inherit I/O priority from data I/O when
 read FEC and hash from disk
In-Reply-To: <20231208015403.GB1160@sol.localdomain>
Message-ID: <df68c38e-3e38-eaf1-5c32-66e43d68cae3@ewheeler.net>
References: <83e8ea6c-1d9-36d5-1c23-da686dbfaf80@redhat.com> <20231206113935.9705-1-hongyu.jin.cn@gmail.com> <20231208015403.GB1160@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023, Eric Biggers wrote:
> On Wed, Dec 06, 2023 at 07:39:35PM +0800, Hongyu Jin wrote:
> > From: Hongyu Jin <hongyu.jin@unisoc.com>
> > 
> > when read FEC and hash from disk, I/O priority are inconsistent
> >  with data block and blocked by other I/O with low I/O priority.
> > 
> > Add dm_bufio_prefetch_by_ioprio() and dm_bufio_read_by_ioprio(),
> > can pecific I/O priority for some I/O.
> > Make I/O for FEC and hash has same I/O priority with data I/O.

Hi Hongyu,

+1 for the feature, thank you for cleaning up ioprio in device mapper! 

A few years ago we proposed a similar prior patch in dm-crypt; however, it 
was never committed, and I did not have the time to shepherd it through.
Maybe this has since been addressed in some other way, or perhaps your 
work solves what we were doing with dm-crypt; either way, here is the 
link to that thread incase it is relevant to your work:
	https://www.mail-archive.com/dm-devel@redhat.com/msg03828.html

I look forward to seeing all (or at least the most common) device mapper 
targets cleanly support ioprio.

Cheers,

--
Eric Wheeler




> > Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
> > Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
> > Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
> > 
> > ---
> > Changes in v2:
> >   - Add ioprio field in struct dm_io_region
> >   - Initial struct dm_io_region::ioprio to IOPRIO_DEFAULT
> >   - Add two interface
> > ---
> >  drivers/md/dm-bufio.c           | 50 ++++++++++++++++++++++-----------
> >  drivers/md/dm-integrity.c       |  5 ++++
> >  drivers/md/dm-io.c              |  1 +
> >  drivers/md/dm-log.c             |  1 +
> >  drivers/md/dm-raid1.c           |  2 ++
> >  drivers/md/dm-snap-persistent.c |  2 ++
> >  drivers/md/dm-verity-fec.c      |  3 +-
> >  drivers/md/dm-verity-target.c   | 10 +++++--
> >  drivers/md/dm-writecache.c      |  4 +++
> >  include/linux/dm-bufio.h        |  6 ++++
> >  include/linux/dm-io.h           |  2 ++
> >  11 files changed, 66 insertions(+), 20 deletions(-)
> 
> Changing so many things in one patch should be avoided if possible.  Is there a
> way to split this patch up?  Maybe first add ioprio support to dm-io, then add
> ioprio support to dm-bufio, then make dm-verity set the correct ioprio?
> 
> >  void *dm_bufio_read(struct dm_bufio_client *c, sector_t block,
> >  		    struct dm_buffer **bp)
> > +{
> > +	return dm_bufio_read_by_ioprio(c, block, bp, IOPRIO_DEFAULT);
> > +}
> > +EXPORT_SYMBOL_GPL(dm_bufio_read);
> > +
> > +void *dm_bufio_read_by_ioprio(struct dm_bufio_client *c, sector_t block,
> > +		    struct dm_buffer **bp, unsigned short ioprio)
> >  {
> >  	if (WARN_ON_ONCE(dm_bufio_in_request()))
> >  		return ERR_PTR(-EINVAL);
> >  
> > -	return new_read(c, block, NF_READ, bp);
> > +	return new_read(c, block, NF_READ, bp, ioprio);
> >  }
> > -EXPORT_SYMBOL_GPL(dm_bufio_read);
> > +EXPORT_SYMBOL_GPL(dm_bufio_read_by_ioprio);
> >  
> >  void *dm_bufio_new(struct dm_bufio_client *c, sector_t block,
> >  		   struct dm_buffer **bp)
> > @@ -1909,12 +1918,19 @@ void *dm_bufio_new(struct dm_bufio_client *c, sector_t block,
> >  	if (WARN_ON_ONCE(dm_bufio_in_request()))
> >  		return ERR_PTR(-EINVAL);
> >  
> > -	return new_read(c, block, NF_FRESH, bp);
> > +	return new_read(c, block, NF_FRESH, bp, IOPRIO_DEFAULT);
> >  }
> >  EXPORT_SYMBOL_GPL(dm_bufio_new);
> >  
> >  void dm_bufio_prefetch(struct dm_bufio_client *c,
> >  		       sector_t block, unsigned int n_blocks)
> > +{
> > +	return dm_bufio_prefetch_by_ioprio(c, block, n_blocks, IOPRIO_DEFAULT);
> > +}
> > +EXPORT_SYMBOL_GPL(dm_bufio_prefetch);
> > +
> > +void dm_bufio_prefetch_by_ioprio(struct dm_bufio_client *c,
> > +		       sector_t block, unsigned int n_blocks, unsigned short ioprio)
> 
> I think it would be cleaner to just add the ioprio parameter to dm_bufio_read()
> and dm_bufio_prefetch(), instead of adding new functions.
> 
> > diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> > index 26adcfea0302..5945ac1dfdff 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
> > @@ -51,6 +51,7 @@ static DEFINE_STATIC_KEY_FALSE(use_tasklet_enabled);
> >  struct dm_verity_prefetch_work {
> >  	struct work_struct work;
> >  	struct dm_verity *v;
> > +	struct dm_verity_io *io;
> >  	sector_t block;
> >  	unsigned int n_blocks;
> >  };
> 
> Isn't it possible for 'io' to complete and be freed while the prefetch work is
> still running?
> 
> - Eric
> 
> 
