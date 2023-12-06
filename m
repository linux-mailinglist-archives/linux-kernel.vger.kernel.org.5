Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D65C806A44
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377140AbjLFJCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377108AbjLFJCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:02:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0BBFA;
        Wed,  6 Dec 2023 01:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ESwEwJpMWsb1q1d00f+KoCLpSfEhMR+fcQ8QnG0nZoY=; b=zdO2H/GFM5zuA/L5PBl09vu4SX
        Nj1NPCIO6UpL1CS1ZiK7pZAgkEAouwfOHdWjaB/UIFvNCMcmrJzg3APPhDLPBs5EBJHDMwWrzKYQb
        YXmIEu+cyobQvPWugKFg1wrytc6fzHyAchYm/YclQc5hNhlB1ejYW+R8HC3rcO0QbfJf4IupBinJb
        o+Gy9bIuZuAG6iUsl02KdeBjw/2gDvuFrRBxpaGBlugOAhNAcWn79lMAgdFOOf4MKaZvaz1hA7gqT
        RXkliwsSHWURz6Sp/+N0ZdxyHmni68VHPgNY1K1gj2ixWQQJ7CDTkUboZgKMJM5GlVA+YZxcOIEjZ
        I8v77+EA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAnnn-009VGi-1H;
        Wed, 06 Dec 2023 09:02:43 +0000
Date:   Wed, 6 Dec 2023 01:02:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, willy@infradead.org,
        akpm@linux-foundation.org, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <ZXA4swgzsHbkm/uB@infradead.org>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <ZXAyV/rlfvBBuDL1@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXAyV/rlfvBBuDL1@dread.disaster.area>
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

On Wed, Dec 06, 2023 at 07:35:35PM +1100, Dave Chinner wrote:
> Mixing overlapping buffered read with direct writes - especially partial block
> extending DIO writes - is a recipe for data corruption. It's not a
> matter of if, it's a matter of when.
> 
> Fundamentally, when you have overlapping write IO involving DIO, the
> result of the overlapping IOs is undefined. One cannot control
> submission order, the order that the overlapping IO hit the
> media, or completion ordering that might clear flags like unwritten
> extents. The only guarantee that we give in this case is that we
> won't expose stale data from the disk to the user read.

Btw, one thing we could do to kill these races forever is to track if
there are any buffered openers for an inode and just fall back to
buffered I/O for that case.  With that and and inode_dio_wait for
when opening for buffered I/O we'd avoid the races an various crazy
workarounds entirely.

nfs and ocfs2 do (or did, I haven't checked for a while) something
like that.

