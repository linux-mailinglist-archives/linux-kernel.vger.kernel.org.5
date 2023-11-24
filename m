Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99E37F6D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjKXHsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjKXHsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:48:53 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE4DD73;
        Thu, 23 Nov 2023 23:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=28ZlngaXvYd70NmiLVOgj+NejQ6ZUD3E3kKj3Lcl1lE=; b=TdTMLY1k87Tw14a+6kU+4Ty53L
        p+L5YjjM9q52xjNsO4xcLYPGjwx7N6B2y1D04waeHJNrPkJeWNx0NWNOjDJxP8VqFBfbRD5F9nwZg
        xKS0tJ/Qb1ThAcYhyWszcL4I0uzxTxLKtymx3zDtErFZ9tyCjC1S0g7gB/f/ncYV+iMVAs8d28mmD
        0gdJ8poMY+wj3EP1zIo6JVV/DqMXaqQrULYsXLrMcQS2XC+oEED3RiA/vo2RqED1nq5WjBo/25O7X
        U387UjiprwRrJMZws3Bz7ijxgd1EHyBANKHm8JrSUFzkcYD4VKE2reC057MlHFdPtsMr80kc+YHAw
        BpdYQYlg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6Qvp-002RzH-07;
        Fri, 24 Nov 2023 07:48:57 +0000
Date:   Fri, 24 Nov 2023 07:48:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Cedric Blancher <cedric.blancher@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: d_genocide()? What about d_holodomor(), d_massmurder(),
 d_execute_warcrimes()? Re: [PATCH 15/20] d_genocide(): move the extern into
 fs/internal.h
Message-ID: <20231124074856.GA581958@ZenIV>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
 <20231124060644.576611-15-viro@zeniv.linux.org.uk>
 <CALXu0UcCGjyM6hFfdjG1eHJcmeR=9BVSaq7Vj9rtvKxb9szJdQ@mail.gmail.com>
 <20231124065759.GT38156@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124065759.GT38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 06:57:59AM +0000, Al Viro wrote:
> > > +extern void d_genocide(struct dentry *);
> > 
> > Seriously, who came up with THAT name? "Genocide" is not a nice term,
> > not even if you ignore political correctness.
> > Or what will be next? d_holodomor()? d_massmurder()? d_execute_warcrimes()?
> 
> kill_them_all(), on the account of that being what it's doing?

To elaborate a bit: what that function does (well, tries to do - it has
serious limitations, which is why there is only one caller remaining and
that one is used only when nothing else can access the filesystem anymore)
is "kill given dentry, along with all its children, all their children,
etc."

I sincerely doubt that you will be able to come up with _any_ word
describing such action in any real-world context that would not come
with very nasty associations.

Context: a bunch of filesystems have directory tree entirely in dcache;
creating a file or directory bumps the reference count of dentry in
question, so instead of going back to 0 after e.g. mkdir(2) returns
it is left with refcount 1, which prevents its eviction.  In effect,
all positive dentries in there are artificially kept busy.  On
rmdir(2) or unlink(2) that extra reference is dropped and they
get evicted.

For filesystems like e.g. tmpfs that's a fairly obvious approach -
they don't *have* any backing store, so dcache is not just caching
the underlying objects - it's all there is.

For such filesystems there is a quick way to do an equivalent of
rm -rf - simply go over the subtree you want to remove and decrement
refcounts of everything positive.  That's fine on filesystem shutdown,
but for anything in use it is *too* quick - you'd better not do that
if there are mountpoints in the subtree you are removing, etc.

At the moment we have 3 callers in the kernel; one in selinuxfs, removing
stale directories on policy reload (not quite safe, but if attacker can
do selinux policy reload, you are beyond lost), another in
simple_fill_super() failure handling (safe, since filesystem is not
mounted at the time, but actually pointless - normal cleanup after
failure will take them out just fine) and the last one in
kill_litter_super().  That one is actually fine - we are shutting the
filesystem down and nobody can access it at that point unless the
kernel is deeply broken.

By the end of this series only that one caller remains, which is
reason for taking the declaration from include/linux/dcache.h to
fs/internal.h - making sure no new callers get added.  Not because
of the identifier having nasty connotations, but because it's
pretty hard to use correctly.
