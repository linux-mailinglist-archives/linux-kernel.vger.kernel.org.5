Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17F7BCF41
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344938AbjJHQbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJHQbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 12:31:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1994
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 09:31:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54638C433C8;
        Sun,  8 Oct 2023 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696782705;
        bh=4H1CFdrVPbhVMhAIQSFk1ttFJ3fM9PrTnqbfShgjJbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bN/L4go27z9P5GTPtUWs6XiZ2ZdM4Ioqyj21R9FY3ni2VscNnGlpWNAbxSSmPXEbR
         Bay8oDOj8BeRX2GJNuixUSD4mdyQ7ABDXX/4sGBhFzzzCp3OsLosVtMo5kcZ9M3JbN
         0Ao+vRBgBd1NPl3Aop0+lN36KB+VtXAkTsLdCUqQ=
Date:   Sun, 8 Oct 2023 18:31:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Seo <james@equiv.tech>, Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Rae Moar <rmoar@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] lib/bitmap: move bitmap allocators for device to
 linux/device.h
Message-ID: <2023100840-silk-quarterly-f694@gregkh>
References: <20231007233510.2097166-1-yury.norov@gmail.com>
 <20231007233510.2097166-2-yury.norov@gmail.com>
 <2023100855-railroad-wrecking-25af@gregkh>
 <ZSLNIZxCacxioX95@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSLNIZxCacxioX95@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 08:39:13AM -0700, Yury Norov wrote:
> On Sun, Oct 08, 2023 at 06:53:49AM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Oct 07, 2023 at 04:35:09PM -0700, Yury Norov wrote:
> > > The allocators are simple wrappers around bitmap_{alloc,free}().
> > > So move them from bitmap to device sources.
> > 
> > No, they belong in the bitmap.h file, as they are devm_* versions of the
> > same functions in this file.  They don't belong in the device.h file.
> 
> OK then. I don't thing that the functions are anything wrong, and
> don't want to 'get rid of them' in any way.
> 
> But could you please elaborate? I'm not too familiar to devm_* things,
> and to me devm_alloc/free() look similar to e.g.
> vfio_dma_bitmap_alloc_all() or iova_bitmap_alloc(), which allocate
> memory for bitmap + do some other initialization things.
> 
> And they all reside in corresponding subsystems. Why devm differs? 

They are just "devm" versions of the normal functions, so they belong
next to those normal functions as well.

> > > Similarly to other device wrappers, turn them to static inlines
> > > and place in header.
> > 
> > Why do these need to be inline functions?
> 
> Because they are small. devm_bitmap_free() and devm_bitmap_zalloc()
> are pure one-line wrappers, and devm_bimap_alloc() is a 2 function
> calls followed by conditionals, which is similar  to
> __devm_add_action_or_reset() or devm_kmalloc_array() in the same file,
> and much less than some other inliners in the source tree.

Are you sure this works properly?  the _free functions for devm_* calls
are set as function pointers and you just passed in a function pointer
to an inline function in your patch.  How is that going to work?  Will
you get even more versions than the original one had (hint, I think you
will, one per file it is called in...)

> In my plans, I want to move bitmap_{z,}alloc/free() to linux/bitmap.h,
> and that way devm_bitmap_alloc() together with other users would be
> propagated __kmalloc_array() by compiler without generating pretty
> useless call/ret's, and benefit from compile-time optimizations if
> __builtin_constant_p() hits.

Does that really matter for _alloc() calls?  These should not be on a
fast path (or at least the devm_*() ones should not be.  What workload
has this as being a bottleneck?

And remember, in modern systems with retbleed mitigations enabled, there
are no 'ret' calls in the kernel at all!

thanks,

greg k-h
