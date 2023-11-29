Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043997FCF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344389AbjK2GeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2GeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:34:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1475170B;
        Tue, 28 Nov 2023 22:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ulf19nfBQHPuPxCGQHOzwBZJuVqNELpQrEmrVGly6ec=; b=n+Yx1exGjzqdszhwKYniFvLsDF
        K1pwUEBrOzoc1E4ykAB0pwVEHMBZ8OsioglebBjMv8B/xY3MQ91GWk9jlNy5FXGDo54r+6VSMGe6p
        WB8o+R5MeB3xKOZhvMFiwjTCGtr/1Iw7gyoWEm5MDAZrcx2ogosDH/stGAAZtOzoXTUZsoXC5y5dC
        sGQcMMLYgNIAVgQGmTTsyDc8dSQs/Sh97D3bKXFvbkrnl9VNsspWNsShw+TMVGdOzhS3M0zxXSyOF
        82ajo//BhyVD6Kgb7CKV84rTWE9cUUeFdZWO+jq4e2+e0wdhL+4dj8J4wc0Vti9xGA74osd9Df19p
        rfZKNWWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r8E9B-007FOS-2Y;
        Wed, 29 Nov 2023 06:34:09 +0000
Date:   Tue, 28 Nov 2023 22:34:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top
Subject: Re: [PATCH 2/2] xfs: update dir3 leaf block metadata after swap
Message-ID: <ZWbbYTKUYaGOo86O@infradead.org>
References: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
 <20231128053202.29007-3-zhangjiachen.jaycee@bytedance.com>
 <ZWZ0qGWpBTW6Iynt@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWZ0qGWpBTW6Iynt@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:15:52AM +1100, Dave Chinner wrote:
> > +	/*
> > +	 * Update the moved block's blkno if it's a dir3 leaf block
> > +	 */
> > +	if (dead_info->magic == cpu_to_be16(XFS_DIR3_LEAF1_MAGIC) ||
> > +	    dead_info->magic == cpu_to_be16(XFS_DIR3_LEAFN_MAGIC) ||
> > +	    dead_info->magic == cpu_to_be16(XFS_ATTR3_LEAF_MAGIC)) {
> 
> a.k.a.
> 
> 	if (xfs_has_crc(mp)) {
> 
> i.e. this is not specific to the buffer type being processed, it's
> specific to v4 vs v5 on-disk format. Hence it's a fs-feature check,
> not a block magic number check.

We have these magic based checks in quite a few places right now,
so I'm not surprised that Jiachen picked it up from there..

