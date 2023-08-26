Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6A789467
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjHZHpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 03:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjHZHpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 03:45:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B3AC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 00:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFCC160AFA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 07:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C335C433C7;
        Sat, 26 Aug 2023 07:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693035942;
        bh=jbRlaGZgeH/nIUB92IrBZ2CS9Rn4xUf81ltVeKgCTS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOmOTOehfejMw6TmNeJ0go3TdvMF1LuCEe4T8izxS2NEhgWma/BTBW+qc0da+Fcm6
         /1KSQMi6Mdt6/6j60RNIXcEOcypFugr/KwhKn/RDzRgJdv7uTrsz6VfOQ9BAwIaDh9
         5z1uBU2iM9LHkw/fb6PPjAKvpTB4ReWzhWZUvFgE=
Date:   Sat, 26 Aug 2023 09:45:39 +0200
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
Message-ID: <2023082633-magnetize-cupcake-accc@gregkh>
References: <64e7cbf7.050a0220.114c7.b70dSMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082506-enchanted-tripping-d1d5@gregkh>
 <64e8f6dd.050a0220.edb3c.c045SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e8f6dd.050a0220.edb3c.c045SMTPIN_ADDED_BROKEN@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 06:36:10PM -0700, Stanislav Kinsburskii wrote:
> > > +#include <linux/bitmap.h>
> > > +#include <linux/memblock.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/types.h>
> > > +
> > > +#include <linux/pmpool.h>
> > > +
> > > +#define VERSION			1
> > 
> > In kernel code does not need versions.
> > 
> 
> Could you elaborate on this? Should kernel version be used as a backward
> compatitbility marker instead?

kernel versions should never be checked for in-kernel code, so I really
don't understand the question here sorry.

For code that is in the kernel tree, having "versions" on them (as many
drivers used to, and now only a few do), makes no sense, especially with
the stable/lts trees getting fixes for them over time as well.

In short, there should not be a need for a "version" anywhere.

thanks,

greg k-h
