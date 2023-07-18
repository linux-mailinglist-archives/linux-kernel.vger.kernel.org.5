Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037B57581E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjGRQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGRQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:16:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758BE2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u9BHQvttlzeTCBclAmv6cmgN9khV9hmdF8Tu8zmlFTU=; b=uQm6oxEIquBuljibWe2eg/7ooK
        3O2yX4DWQ0bQlHX0OzR9gmCw/hGWjVzy+xl9K7Q7YYAK5pOQgu1/aHxgoQZ49pl+ah8UV/OUBJxWU
        UmQxXrmSGQ8umVKYnzWopkASq20NyuCDsCdJ+7BxU85UyrXN3A9bS36QXUpy3DkhRqOsjPY4fyJya
        HxJyH+TFE9Gbw+AgNNoUdfIJaUvQQHGeCr6pJmS7hUsJEX1HmVVxrXs/3Vo5Dzz/BF79Y/QoTwmXu
        Eji9FUkyHXRW0+lMzX64YAi5/TkMdxjGcIiPXmPgHDqCIjBtl9zWKx0h+FItadl3zYJ2YBqMCEytm
        eWEBJjsg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLnN1-0054rl-Ja; Tue, 18 Jul 2023 16:16:15 +0000
Date:   Tue, 18 Jul 2023 17:16:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH 1/6] mm/page_io: use a folio in __end_swap_bio_read()
Message-ID: <ZLa6z+vhK6aWYePL@casper.infradead.org>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-2-zhangpeng362@huawei.com>
 <ZLVDYjdflF+3oJCG@casper.infradead.org>
 <df29af76-fc8f-b4f1-4a32-a200b5d4ba31@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df29af76-fc8f-b4f1-4a32-a200b5d4ba31@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 08:56:16PM +0800, zhangpeng (AS) wrote:
> > >   	if (bio->bi_status) {
> > > -		SetPageError(page);
> > > -		ClearPageUptodate(page);
> > > +		folio_set_error(folio);
> > I appreciate this is a 1:1 conversion, but maybe we could think about
> > this a bit.  Is there anybody who checks the
> > PageError()/folio_test_error() for this page/folio?
> 
> Maybe wait_dev_supers() checks the PageError() after write_dev_supers()
> in fs/btrfs/disk-io.c?

How does _this_ folio end up in btrfs's write_dev_supers()?  This is a
swap read.  The only folios which are swapped are anonymous and tmpfs.
btrfs takes care of doing its own I/O.  wait_dev_supers() is looking
for the error set in btrfs_end_super_write() which is the completion
routine for write_dev_supers().  The pages involved there are attached
to a btrfs address_space, not shmem or anon.

