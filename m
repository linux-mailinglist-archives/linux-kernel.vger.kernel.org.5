Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2529777296
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjHJIPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjHJIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:15:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14254FE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:15:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A553A1F38D;
        Thu, 10 Aug 2023 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691655319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElbU9RvDenPkT7xhen9VyORMPFOizJvDYj/Km+R918Y=;
        b=fApRWQR+l08lz0VuQp0eTbUs+RC98pmwi4yDWQd4Go+W+pMrqI1TZLjirEYj87aNVb5+Gl
        7IkNlSAOZfUnJUCQhYdib46oNe0OK+pPnt3/N1TAc7tF98k4ogCeVIW3VGUuyashbBE7R9
        EZ7sgB8fiGaGCfcDCkkggOprhPFdZ74=
Received: from suse.cz (dhcp108.suse.cz [10.100.51.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3041B2C142;
        Thu, 10 Aug 2023 08:15:18 +0000 (UTC)
Date:   Thu, 10 Aug 2023 10:15:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZNScla_5FXc28k32@alley>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
 <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <ZNEJm3Mv0QqIv43y@smile.fi.intel.com>
 <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
 <ZNHjrW8y_FXfA7N_@alley>
 <ZNI5f+5Akd0nwssv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNI5f+5Akd0nwssv@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-08-08 15:47:59, Andy Shevchenko wrote:
> On Tue, Aug 08, 2023 at 08:41:49AM +0200, Petr Mladek wrote:
> > On Mon 2023-08-07 18:13:57, Andy Shevchenko wrote:
> > > On Mon, Aug 07, 2023 at 06:11:24PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Aug 07, 2023 at 06:09:54PM +0300, Andy Shevchenko wrote:
> > > > > On Mon, Aug 07, 2023 at 05:03:19PM +0200, Petr Mladek wrote:
> > > > > > On Sat 2023-08-05 20:50:26, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > > How does this sound, please?
> > > > > 
> > > > > Not every user (especially _header_) wants to have printk.h included just for
> > > > > sprintf.h that may have nothing to do with real output. So, same reasoning
> > > > > from me as keeping that in kernel.h, i.e. printk.h no better.
> > > > 
> > > > (haven't check these, just to show how many _headers_ uses sprintf() call)
> > > > 
> > > > $ git grep -lw s.*printf -- include/linux/
> > > > include/linux/acpi.h
> > > > include/linux/audit.h
> > > > include/linux/btf.h
> > > > include/linux/dev_printk.h
> > > > include/linux/device-mapper.h
> > > > include/linux/efi.h
> > > > include/linux/fortify-string.h
> > > > include/linux/fs.h
> > > > include/linux/gameport.h
> > > > include/linux/kdb.h
> > > > include/linux/kdev_t.h
> > > > include/linux/kernel.h
> > > > include/linux/mmiotrace.h
> > > > include/linux/netlink.h
> > > > include/linux/pci-p2pdma.h
> > > > include/linux/perf_event.h
> > > > include/linux/printk.h
> > > > include/linux/seq_buf.h
> > > > include/linux/seq_file.h
> > > > include/linux/shrinker.h
> > > > include/linux/string.h
> > > > include/linux/sunrpc/svc_xprt.h
> > > > include/linux/tnum.h
> > > > include/linux/trace_seq.h
> > > > include/linux/usb.h
> > > > include/linux/usb/gadget_configfs.h
> > > 
> > > Okay, revised as my regexp was too lazy
> > > 
> > > $ git grep -lw s[^[:space:]_]*printf -- include/linux/
> > > include/linux/btf.h
> > > include/linux/device-mapper.h
> > > include/linux/efi.h
> > > include/linux/fortify-string.h
> > > include/linux/kdev_t.h
> > > include/linux/kernel.h
> > > include/linux/netlink.h
> > > include/linux/pci-p2pdma.h
> > > include/linux/perf_event.h
> > > include/linux/sunrpc/svc_xprt.h
> > > include/linux/tnum.h
> > > include/linux/usb.h
> > > include/linux/usb/gadget_configfs.h
> > 
> > This is only a tiny part of the picture.
> > 
> > $> git grep sc*n*printf | cut -d : -f1 | uniq | grep "\.c$" | wc -l
> > 5254
> > $> find . -name  "*.c" | wc -l
> > 32319
> > 
> > It means that the vsprintf() family is used in 1/6 of all kernel
> > source files. They would need to include one extra header.
> 
> No, not only one. more, but the outcome of this is not using what is not used
> and unwinding the header dependency hell.
> 
> But hey, I am not talking about C files right now, it's secondary, however
> in IIO we want to get rid of kernel.h in the C files as well.

This sounds scary. Headers and C files are closely related. IMHO, it
does not makes sense to split header files without looking how
the functions are used.

Everyone agrees that kernel.h should be removed. But there are always
more possibilities where to move the definitions. For this, the use
in C files must be considered. Otherwise, it is just a try&hope approach.

> Also, please, go through all of them and tell, how many of them are using
> stuff from kernel.h besides sprintf.h and ARRAY_SIZE() (which I plan
> for a long time to split from kernel.h)?

I am all for removing vsprintf declarations from linux.h.

I provided the above numbers to support the idea of moving them
into printk.h.

The numbers show that the vsprintf function famility is used
quite frequently. IMHO, creating an extra tiny include file
will create more harm then good. By the harm I mean:

    + churn when updating 1/6 of source files

    + prolonging the list of #include lines in .c file. It will
      not help with maintainability which was one of the motivation
      in this patchset.

    + an extra work for people using vsprintf function family in
      new .c files. People are used to get them for free,
      together with printk().

Best Regards,
Petr
