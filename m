Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CA475A56C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGTFVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTFVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:21:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970681710
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Au36BTKjh60X/IX5uvDzqozJt2g/PHKqry8jTcwngCg=; b=Agun3DfuD4Ct2W+pw6tk5K6HON
        Q95uIEriBOmCM5tQ1yhB1gg6FGiOgOjItEdMMyq13QXjCmvAeV9ZNoV8FXEIyjHQLSKhlpDsQ+4H5
        5+aL8JdjvmOksu0KvJWyLZd6QVmDLIME0H4V/Vf2YqLp6GGijpyLKXvHb6yfCiQ+HXjmYapjuQEXo
        whIbL6YnAq3ZN2jaCNAxsWMro10zZSlKy24MBEa4CYUUTKfHsW7GoING4UG1sXyo5aA9knwrpG4Hg
        xnP/3Yi4dqinFAyzb4Pm99capvHooYN0ahR2BAEA7NQlnGcG394HYAt5FLHPwzmpE4ZOE19I4fSg9
        Z3llPNsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMM64-009opH-2y;
        Thu, 20 Jul 2023 05:21:05 +0000
Date:   Wed, 19 Jul 2023 22:21:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhangpeng (AS)" <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sidhartha.kumar@oracle.com,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH 1/6] mm/page_io: use a folio in __end_swap_bio_read()
Message-ID: <ZLjEQK0OF4+80pyI@infradead.org>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-2-zhangpeng362@huawei.com>
 <ZLVDYjdflF+3oJCG@casper.infradead.org>
 <df29af76-fc8f-b4f1-4a32-a200b5d4ba31@huawei.com>
 <ZLa6z+vhK6aWYePL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLa6z+vhK6aWYePL@casper.infradead.org>
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

On Tue, Jul 18, 2023 at 05:16:15PM +0100, Matthew Wilcox wrote:
> How does _this_ folio end up in btrfs's write_dev_supers()?  This is a
> swap read.  The only folios which are swapped are anonymous and tmpfs.
> btrfs takes care of doing its own I/O.  wait_dev_supers() is looking
> for the error set in btrfs_end_super_write() which is the completion
> routine for write_dev_supers().  The pages involved there are attached
> to a btrfs address_space, not shmem or anon.

It actually operates on the block_device inode.  That does not matter
for this series, but complicates things in other ways.
