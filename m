Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F944810D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjLMJRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjLMJRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:17:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ABEFE;
        Wed, 13 Dec 2023 01:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rUfGZho7K3qVy9Gsxf7KYBLzMAnHb4FXaY/ImZeL51o=; b=lRHjh1f/v8TJ3gPOlHvQgTclLv
        qygO+TeqmKCyUkmIBQqo6kkTe1wCYqrgzmKOrITbYUslPzl1oIN1HYglmwMJ4BllaFEV5HCkzk8Jj
        TCJGv0hEd/E5pFRXy/WYcdAb92VhykYcrJWJFHLwISVDYvKgJD+j+TAXTWvdm2hxVC1C04frjVFJ2
        f/OOTBNue/0vBrImSJc4PchByRgPNQEmbshErUzEUreC0Vgkc/w2aQut8ItRzWy6R+PdKJbGSRQYF
        rjgt0fA4Rj1Xg7Q50y+0YF9tpws9MFJJgAmsgQggT7g8q4V8yZ6SkHzZ1vVYsXIZAngB7+8beVXTY
        UOc/tG4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDLMe-00E7rL-1b;
        Wed, 13 Dec 2023 09:17:12 +0000
Date:   Wed, 13 Dec 2023 01:17:12 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/13] btrfs: open code set_io_stripe for RAID56
Message-ID: <ZXl2mL90/2WtZgL4@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-11-b2d954d9a55b@wdc.com>
 <ZXlyPqtXO+j90vJb@infradead.org>
 <f1cc59fa-9260-4a42-b346-17862d0f8385@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1cc59fa-9260-4a42-b346-17862d0f8385@wdc.com>
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

On Wed, Dec 13, 2023 at 09:09:47AM +0000, Johannes Thumshirn wrote:
> > I think raid stripe tree handling also really should move out of
> > set_io_stripe.  Below is the latest I have, although it probably won't
> > apply to your tree:
> > 
> 
> That would work as well and replace patch 1 then. Let me think about it.

I actually really like splitting that check into a helper for
documentation purposes.  Btw, this my full tree that the patch is from
in case it is useful:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/raid-stripe-tree-cleanups
