Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF9783D46
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjHVJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbjHVJqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B41B2;
        Tue, 22 Aug 2023 02:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61A2F61588;
        Tue, 22 Aug 2023 09:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B507C433C8;
        Tue, 22 Aug 2023 09:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692697602;
        bh=RWLV3/09KzFOFC/mETuJ0MDPaiySDOW5Yyo2sBkF9XA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYI7VkplKDaEvBwEfIbqhFggGq6G3HT020RL9s2tUwBGnX9lwuZQU5iH1Z5S/0eFQ
         4nHm1fsr1WhQJ/Eu77E6aYfOe/jQ+sf6JTIfXyecF0eOdtEx7vAtqtE1TrE8yTl/Gd
         /EtAtO2e/fY0y1b6T3PpU2bOc5P38POb4In51ZeTB4pCHWg93mUuelq9O5taTjCF8/
         2gq5aCgngwI3E9uQmeIq9Qv+no+DCRVtiNRRZiAZBHTXESG9M/xLjhilw3e7nd0eIO
         bTFtyQ+eXWh7lMhdJWmrgcLEzlSmNULVFqnfrkbdCBZbFIp06Y82pif7FvQDpHtGXm
         Ptf+i08AlE5XQ==
Date:   Tue, 22 Aug 2023 11:46:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 djw-vfs tree
Message-ID: <20230822-turnus-quert-9b11d4e30dc9@brauner>
References: <20230822110551.6386dd5d@canb.auug.org.au>
 <20230822025120.GA11286@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822025120.GA11286@frogsfrogsfrogs>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Christian: I've been planning to merge the {freeze,thaw}_super @who
> changes for 6.6; do you think more 'cooperating with the maintainer' is
> needed, or shall I simply push my branch to Linus with a note that
> s/down_write/super_lock_excl/ s/up_write/super_unlock_excl is needed to
> resolve the merge the conflict?

Hm, that's not a pleasant merge conflict given that it's locking
changes. It would probably be fine to just bring it up the way it is but
it looks needlessly messy/uncoordinated. I'm wonder why this isn't just
all in vfs.super since it's core vfs infra change anyway. Maybe I just
missed the patches if so then sorry about that.

That's the two infrastructure patches in the kernel-fsfreeze
branch/kernel-fsfreeze_2023-07-27 tag?:

ad0164493b81 ("fs: distinguish between user initiated freeze and kernel initiated freeze")
53f65fd7a3d5 ("fs: wait for partially frozen filesystemskernel-fsfreeze_2023-07-27kernel-fsfreeze")

If you give me a tag with your description and just the two commits or I
just cherry pick them and cite your description in my pr that would be
my preferred solution. How do you feel about that?
