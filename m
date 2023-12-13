Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11FF807707
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442743AbjLFRxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442726AbjLFRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:53:12 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A81E122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:53:18 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-122-214.bstnma.fios.verizon.net [173.48.122.214])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B6Hodj2022646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 12:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1701885052; bh=VZDVHdtsTza1iBjsN4e9taxM8QQIzumJOYNTH51fhro=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=BH8TRkxS2KVaitLmv0fUh5MfTnRi8kxhm2QxRnobVHqRnCkm5tdQJ4YU7KzmgN2o9
         OrT5ijrdbqD+8Tpl+UWv5WlzoZ4FfBRwcoZtXGHipfp3BKDuVw8Wb3OV8JHdDL++WR
         fchowN0SphtUdvT2S+alJWDJDljYoM4HhCP8Oe9wGQPXflEuR9UupnRUlKWI1Qe2kg
         kWiBMGCDi9IQPUcNW0bRqxHb1k7h5ks+vYGOrOHkVBn6CgZz1YTgrm04q9GDpzs5AE
         AW77xm7xSTCpwyFB4QBf7egNa0Hpu3J4Iea+sXKNE2nV9yZ8sAlE3vS7vnXmXBUfDj
         Vli7wjfFyI1og==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F04EC15C057B; Wed,  6 Dec 2023 12:50:38 -0500 (EST)
Date:   Wed, 6 Dec 2023 12:50:38 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        roger.pau@citrix.com, colyli@suse.de, kent.overstreet@gmail.com,
        joern@lazybastard.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, nico@fluxnic.net,
        xiang@kernel.org, chao@kernel.org, adilger.kernel@dilger.ca,
        agruenba@redhat.com, jack@suse.com, konishi.ryusuke@gmail.com,
        willy@infradead.org, akpm@linux-foundation.org, hare@suse.de,
        p.raghav@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next RFC 01/14] block: add some bdev apis
Message-ID: <20231206175038.GJ509422@mit.edu>
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
 <20231205123728.1866699-2-yukuai1@huaweicloud.com>
 <ZXARKD0OmjLrvHmU@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXARKD0OmjLrvHmU@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:14:00PM -0800, Christoph Hellwig wrote:
> > +/*
> > + * The del_gendisk() function uninitializes the disk-specific data
> > + * structures, including the bdi structure, without telling anyone
> > + * else.  Once this happens, any attempt to call mark_buffer_dirty()
> > + * (for example, by ext4_commit_super), will cause a kernel OOPS.
> > + * This is a kludge to prevent these oops until we can put in a proper
> > + * hook in del_gendisk() to inform the VFS and file system layers.
> > + */
> > +int bdev_ejected(struct block_device *bdev)
> > +{
> > +	struct backing_dev_info *bdi = inode_to_bdi(bdev->bd_inode);
> > +
> > +	return bdi->dev == NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(bdev_ejected);
> 
> And this code in ext4 should just go away entirely.  The bdi should
> always be valid for a live bdev for years.

This was added because pulling a mounted a USB thumb drive (or a HDD
drops off the SATA bus) while the file system is mounted and actively
in use, would result in a kernel OOPS.  If that's no longer true,
that's great, but it would be good to test to make sure this is the
case....

If we really want to remove it, I'd suggest doing this as a separate
commit, so that after we see syzbot reports, or users complaining
about kernel crashes, we can revert the removal if necessary.

Cheers,

					- Ted
