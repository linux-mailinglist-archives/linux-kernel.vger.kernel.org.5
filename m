Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FFC7A57D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjISDVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjISDVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:21:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF7710E;
        Mon, 18 Sep 2023 20:21:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1752AC433C8;
        Tue, 19 Sep 2023 03:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695093699;
        bh=ntnvdNgkPFJ/oCD4R+vKB36VPnMr86Fi3aB8nZw/9uQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5C+B6bJQ7OP0XY2LDoG3a8uJqbs+502QTyDR1rOqTOWY4hDs076kNS4PU8HLxBat
         XS/Tmtlc5y8qjyUGCh4ibAk0p88Jgqac4S5X/AWZwV7Ja9YvfXMgMn5plncE1JSyjJ
         pct0CdY+rbnHYlAmytEINhobT1Cw5qXRToNoCSeVkhl/r8lwbyCuztuzoQyZS9NZVk
         c+sj5COXrRt0U/NDIhJA+zophJvRccqJ0/gzdiAJMS9gwjaKjeNAxXYkwsQ658ECSc
         P+irap/K7l1jN0+Ni/SE9K0Nd0KljsLjuBkCTljWFKZpDSagf76cpp5ygctP5Ad22i
         +ihjaYBCdNGEQ==
Date:   Mon, 18 Sep 2023 20:21:38 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Wang Jianchao <jianchwa@outlook.com>,
        Chandan Babu R <chandanrlinux@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] xfs: use roundup_pow_of_two instead of ffs during
 xlog_find_tail
Message-ID: <20230919032138.GC348037@frogsfrogsfrogs>
References: <63b3742c-0efe-c096-c737-a0e0419480bd@outlook.com>
 <59dd15dd-5b35-871d-6d3a-ec779975b089@outlook.com>
 <0a72f462-8b8e-4dec-6ce4-f52e33423957@outlook.com>
 <CY8PR05MB9378441D3F6430D1A414142BCDFAA@CY8PR05MB9378.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR05MB9378441D3F6430D1A414142BCDFAA@CY8PR05MB9378.namprd05.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:06:56AM +0800, Wang Jianchao wrote:
> Ping ? Do I need other update on this patch ?

Nope, I think this is ok...

> Thanks
> Jianchao
> 
> On 2023/9/13 09:38, Wang Jianchao wrote:
> > 
> > In our production environment, we find that mounting a 500M /boot
> > which is umount cleanly needs ~6s. One cause is that ffs() is
> > used by xlog_write_log_records() to decide the buffer size. It
> > can cause a lot of small IO easily when xlog_clear_stale_blocks()
> > needs to wrap around the end of log area and log head block is
> > not power of two. Things are similar in xlog_find_verify_cycle().
> > 
> > The code is able to handed bigger buffer very well, we can use
> > roundup_pow_of_two() to replace ffs() directly to avoid small
> > and sychronous IOs.
> > 
> > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Wang Jianchao <wangjc136@midea.com>

...so let's see if the release manager will take this patch.

Chandan?  Could you pull in the various one-off patches floating around
on the list that have passed review?  ;)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

PS: If you'd like to send a pull request to push things along, please do

--D

> > ---
> > 
> > Changes in V2:
> >  - Move change log below "---"
> >  - Add reviewed-by Dave Chinner tag
> > 
> > Changes in V1:
> >  - Also replace the ffs in xlog_find_verify_cycle()
> > 
> >  fs/xfs/xfs_log_recover.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> > index 82c81d20459d..13b94d2e605b 100644
> > --- a/fs/xfs/xfs_log_recover.c
> > +++ b/fs/xfs/xfs_log_recover.c
> > @@ -329,7 +329,7 @@ xlog_find_verify_cycle(
> >  	 * try a smaller size.  We need to be able to read at least
> >  	 * a log sector, or we're out of luck.
> >  	 */
> > -	bufblks = 1 << ffs(nbblks);
> > +	bufblks = roundup_pow_of_two(nbblks);
> >  	while (bufblks > log->l_logBBsize)
> >  		bufblks >>= 1;
> >  	while (!(buffer = xlog_alloc_buffer(log, bufblks))) {
> > @@ -1528,7 +1528,7 @@ xlog_write_log_records(
> >  	 * a smaller size.  We need to be able to write at least a
> >  	 * log sector, or we're out of luck.
> >  	 */
> > -	bufblks = 1 << ffs(blocks);
> > +	bufblks = roundup_pow_of_two(blocks);
> >  	while (bufblks > log->l_logBBsize)
> >  		bufblks >>= 1;
> >  	while (!(buffer = xlog_alloc_buffer(log, bufblks))) {
