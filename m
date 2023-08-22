Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F85784962
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjHVS0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHVS0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3D1CCB;
        Tue, 22 Aug 2023 11:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C8BC6467E;
        Tue, 22 Aug 2023 18:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9F6C433C8;
        Tue, 22 Aug 2023 18:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692728765;
        bh=AeTos3s1IeELRlejsHXMUFjs6Kv2rG5oazFaQ4BkAQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4KvDRiCAFwEXz4j5AadWNqnDlsST7p6XnvBPGccVTe0ms8UofXi8sG+GIveQpQMr
         f/FwSYIpnpYN5NCMMvdKQJnplEXfhAMBmDwPABmepj6x4hqjc2w9lYoTQEu7+BPzYY
         1BkOqDMiUZIv0WP9fYhiPp5iB/mEh+p++NRNeUqtaf01PCwEx+b+2kFAxuXQUE+3d8
         MwBbIBdVEqNAd1tEIVcZ9J4MUNZNTr2El6wZAMQDNd8yHlejl5yJuIxvxtfJY1wEdl
         nU6DPxHpYVZDXiLQxjT2xMqixTk4rH1S3sXZmXR4oLXQ4I/gJoEsUkalHbMMAhEuyM
         GPxSSmyAul06g==
Date:   Tue, 22 Aug 2023 11:26:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 djw-vfs tree
Message-ID: <20230822182604.GB11286@frogsfrogsfrogs>
References: <20230822110551.6386dd5d@canb.auug.org.au>
 <20230822025120.GA11286@frogsfrogsfrogs>
 <20230822-turnus-quert-9b11d4e30dc9@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822-turnus-quert-9b11d4e30dc9@brauner>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:46:38AM +0200, Christian Brauner wrote:
> > Christian: I've been planning to merge the {freeze,thaw}_super @who
> > changes for 6.6; do you think more 'cooperating with the maintainer' is
> > needed, or shall I simply push my branch to Linus with a note that
> > s/down_write/super_lock_excl/ s/up_write/super_unlock_excl is needed to
> > resolve the merge the conflict?
> 
> Hm, that's not a pleasant merge conflict given that it's locking
> changes. It would probably be fine to just bring it up the way it is but
> it looks needlessly messy/uncoordinated. I'm wonder why this isn't just
> all in vfs.super since it's core vfs infra change anyway. Maybe I just
> missed the patches if so then sorry about that.

Ah, I had wondered about that. :)

> That's the two infrastructure patches in the kernel-fsfreeze
> branch/kernel-fsfreeze_2023-07-27 tag?:
> 
> ad0164493b81 ("fs: distinguish between user initiated freeze and kernel initiated freeze")
> 53f65fd7a3d5 ("fs: wait for partially frozen filesystemskernel-fsfreeze_2023-07-27kernel-fsfreeze")
> 
> If you give me a tag with your description and just the two commits or I
> just cherry pick them and cite your description in my pr that would be
> my preferred solution. How do you feel about that?

I'm happy to have you pull my xfs-linux tags into your vfs tree. :)

Here's a tag with just the two vfs patches:
https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/tag/?h=vfs-6.6-merge-2

This second tag builds on that, by adding the first actual user of
FREEZE_HOLDER_KERNEL:
https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/tag/?h=vfs-6.6-merge-3

There will be more for 6.7(+?) if Luis manages to get back to his
auto-fsfreeze during suspend, or if Shiyang finishes the series to
handle pmem media error reporting in xfs.

Thanks!
--D
