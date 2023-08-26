Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B077898EA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjHZUEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjHZUEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D67172D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C0C6201E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 20:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE728C433C8;
        Sat, 26 Aug 2023 20:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693080266;
        bh=sgkW/Y9kSI6wk5rqNutVKU0iLBxONqaaG3/aHIb+tjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TBKBzvyJYGZfUE1MQBNSeMeTv3IBU1F3b5bykAeT1ELi7XzBDxJP2VFCeTkpfwEj5
         6ARz/OiAsTCp/bLqGjQk5hlrZe/62OUUdzjDnhVfUSJ54T0e6QL3NFAVS2H8rSQr6/
         RcDLKzJ9j96VW824keRAauu51iq1G8Q3lT5WnrvY=
Date:   Sat, 26 Aug 2023 22:04:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Madhavan Venkataraman <madvenka@linux.microsoft.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        James Gowans <jgowans@amazon.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Jinank Jain <jinankjain@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Introduce persistent memory pool
Message-ID: <2023082619-puzzling-viewable-fa69@gregkh>
References: <64e7cbf7.050a0220.114c7.b70dSMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082506-enchanted-tripping-d1d5@gregkh>
 <64e8f6dd.050a0220.edb3c.c045SMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082633-magnetize-cupcake-accc@gregkh>
 <64ea25cd.650a0220.642cc.50e6SMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082620-saint-petition-bb89@gregkh>
 <64ea3699.170a0220.13ee0.5c3aSMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ea3699.170a0220.13ee0.5c3aSMTPIN_ADDED_BROKEN@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:21:59PM -0700, Stanislav Kinsburskii wrote:
> On Sat, Aug 26, 2023 at 07:02:12PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 22, 2023 at 11:15:08PM -0700, Stanislav Kinsburskii wrote:
> > > On Sat, Aug 26, 2023 at 09:45:39AM +0200, Greg Kroah-Hartman wrote:
> > > > On Tue, Aug 22, 2023 at 06:36:10PM -0700, Stanislav Kinsburskii wrote:
> > > > > > > +#include <linux/bitmap.h>
> > > > > > > +#include <linux/memblock.h>
> > > > > > > +#include <linux/spinlock.h>
> > > > > > > +#include <linux/types.h>
> > > > > > > +
> > > > > > > +#include <linux/pmpool.h>
> > > > > > > +
> > > > > > > +#define VERSION			1
> > > > > > 
> > > > > > In kernel code does not need versions.
> > > > > > 
> > > > > 
> > > > > Could you elaborate on this? Should kernel version be used as a backward
> > > > > compatitbility marker instead?
> > > > 
> > > > kernel versions should never be checked for in-kernel code, so I really
> > > > don't understand the question here sorry.
> > > > 
> > > > For code that is in the kernel tree, having "versions" on them (as many
> > > > drivers used to, and now only a few do), makes no sense, especially with
> > > > the stable/lts trees getting fixes for them over time as well.
> > > > 
> > > 
> > > This version is rather an ABI version. The idea is to make sure, that
> > > any future ABI change is explicit and reflected in the version, so it
> > > can be easily noticed in case of kexec to a kernel with an older
> > > version.
> > > But I guess there are other ways to make sure, that the ABI contract is
> > > the preserved.
> > 
> > Which ABI are you referring to here.  The user/kernel one?  Or the
> > kernel/hypervisor one?  Or something else?
> > 
> 
> Yeah, I guess the "ABI" word in misleading here, especially the first
> letter. I mean something else: the old kernel/new kernel.
> This persistent memory pool (its metadata) is supposed to be passed
> across kexec with the data. That is probably the main difference in
> comparison to pmem or cma.
> Since the header can change its format between kernels, there should be
> a way to identify it.

Ah.  Hah, that's crazy, and it's never going to work, you need to just
test the version of the kernel that the image was created for (you have
that in the kernel already) and verify that it is the same before
loading the new one.

That way you never have to worry about any "version number", it's just
the kernel specific version number instead.

thanks,

greg k-h
