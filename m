Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437407B6A82
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbjJCN1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbjJCN1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:27:30 -0400
Received: from out-197.mta1.migadu.com (out-197.mta1.migadu.com [95.215.58.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C36A10D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:27:18 -0700 (PDT)
Date:   Tue, 3 Oct 2023 09:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696339636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mjv6DuwAujLXffMtSe4op7ceXjyiGwTzOh9m+cMi8Vs=;
        b=e771mcc5uBUlgfXKpvdmXwBVHpXjNKLgMN5fgedhVWgWdr2nalKTR+mIV0ADMsTo70/CjF
        /w7jkesimDLcpMACnxNZZynTcxvUjqJ7JElwbaOx6/KsW9JuFhB5GJweYT3W+PrjkOHlER
        KJOlGI0tg8lEXk9+XF8/lne5ltnUhQU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jan Kara <jack@suse.cz>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20231003132711.djftyh7vltljy2hh@moria.home.lan>
References: <20230928105443.1b1ad98c@canb.auug.org.au>
 <20231002112142.bfjj54ikijf4iwfr@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002112142.bfjj54ikijf4iwfr@quack3>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:21:42PM +0200, Jan Kara wrote:
> Hi!
> 
> On Thu 28-09-23 10:54:43, Stephen Rothwell wrote:
> > After merging the vfs-brauner tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > fs/bcachefs/super-io.c: In function 'bch2_free_super':
> > fs/bcachefs/super-io.c:166:17: error: implicit declaration of function 'blkdev_put'; did you mean 'bdi_put'? [-Werror=implicit-function-declaration]
> >   166 |                 blkdev_put(sb->bdev, sb->holder);
> >       |                 ^~~~~~~~~~
> >       |                 bdi_put
> > fs/bcachefs/super-io.c: In function 'bch2_read_super':
> > fs/bcachefs/super-io.c:687:20: error: implicit declaration of function 'blkdev_get_by_path'; did you mean 'bdev_open_by_path'? [-Werror=implicit-function-declaration]
> >   687 |         sb->bdev = blkdev_get_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> >       |                    ^~~~~~~~~~~~~~~~~~
> >       |                    bdev_open_by_path
> > fs/bcachefs/super-io.c:687:18: error: assignment to 'struct block_device *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> >   687 |         sb->bdev = blkdev_get_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> >       |                  ^
> > fs/bcachefs/super-io.c:693:26: error: assignment to 'struct block_device *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> >   693 |                 sb->bdev = blkdev_get_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> >       |                          ^
> > cc1: all warnings being treated as errors
> > 
> > Caused by commit
> > 
> >   953863a5a2ff ("block: Remove blkdev_get_by_*() functions")
> > 
> > interacting with commit(s) from the bcachefs tree.
> > 
> > I would have reverted that commit for today, except I used the old
> > vfs-brauner tree due to another build failure.  Can we just delay this
> > one commit until after bcachefs has been converted (and any other
> > references that may be added are fixed)?
> 
> Yeah, I guess removing the final commit is the easiest solution at this
> point. It complicates a bit the series to disallow writing to mounted block
> devices which bases on this - either I have to pospone that to the next
> cycle after we convert bcachefs or I have to find a way for the old
> blkdev_get_by_path() API and the new functionality to coexist. I'll think
> about that.

Jan, Christain - what do you need from me for the conversion?
