Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945BE80681E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377044AbjLFHVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376923AbjLFHU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:20:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ACF1B6;
        Tue,  5 Dec 2023 23:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3qSq0ZgSYyFQdhkNKKx+ay2VTuWMWagkFjN44scFJGI=; b=Hj7ctWdUPYGChKSXbjiG3ceuLC
        qJJdvlVYftwJ0JmFiiq7KgA3kS4RlnIA/MDhNrvJyEEBExXyzpZoszMTkmDa/0AcbWk3X3RegC55V
        7demvhkD/2Vm6MNZiLt23BUpT9dBqEkmj0CKPAbAJm+oIUuXhDVeLjwJaZkW3WPEmdGuSLkwjyd9+
        YyBHijcvKAnO2bAVJAUvyMRdWxJKRyTYJ1uvpasFg0q82cLUXzhXq4Wu/L7v1jx64IWttFDdMu/ca
        3J1JyfBFyObPGWrCPbNdP80bglMjq75SOxMB3QIX6GX/sagc2ovosgUjghAazuSh7ZC/geNc3PWxS
        jsvebKrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAmCo-009HjE-0N;
        Wed, 06 Dec 2023 07:20:26 +0000
Date:   Tue, 5 Dec 2023 23:20:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        roger.pau@citrix.com, colyli@suse.de, kent.overstreet@gmail.com,
        joern@lazybastard.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, nico@fluxnic.net,
        xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
        konishi.ryusuke@gmail.com, willy@infradead.org,
        akpm@linux-foundation.org, hare@suse.de, p.raghav@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next RFC 01/14] block: add some bdev apis
Message-ID: <ZXAgut2MTKw50OLI@infradead.org>
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
 <20231205123728.1866699-2-yukuai1@huaweicloud.com>
 <ZXARKD0OmjLrvHmU@infradead.org>
 <aafabc6e-fd98-f927-44d7-3ef76e2acaf8@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafabc6e-fd98-f927-44d7-3ef76e2acaf8@huaweicloud.com>
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

On Wed, Dec 06, 2023 at 02:50:56PM +0800, Yu Kuai wrote:
> I'm a litter confused, so there are 3 use cases:
> 1) use GFP_USER, default gfp from bdev_alloc.
> 2) use GFP_KERNEL
> 3) use GFP_NOFS
> 
> I understand that you're suggesting memalloc_nofs_save() to distinguish
> 2 and 3, but how can I distinguish 1?

You shouldn't.  Diverging from the default flags except for clearing
the FS or IO flags is simply a bug.  Note that things like block2mtd
should probably also ensure a noio allocation if they aren't doing that
yet.

> >   - use memalloc_nofs_save in extet instead of using
> >     mapping_gfp_constraint to clear it from the mapping flags
> >   - remove __ext4_sb_bread_gfp and just have buffer.c helper that does
> >     the right thing (either by changing the calling conventions of an
> >     existing one, or adding a new one).
> 
> Thanks for the suggestions, but I'm not sure how to do this yet, I must
> read more ext4 code.

the nofs save part should be trivial.  You can just skip the rest for
now as it's not needed for this patch series.

