Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3B3774173
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjHHRUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjHHRUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:20:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3327772A1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:08:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ECAA622471;
        Tue,  8 Aug 2023 06:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691476911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fn8p9+Au+wVsN8+8boY+m/Rgvhm2LtPNdNtgtmsLtSc=;
        b=jOO7Z6NLzc3q0XzXoZY6QPquzaGJhG/91JeTEmGVV/bplRZVFBhdLXHgDmVD37usC/5hxc
        1sbFRFI+ee2skGmgpy4iC6KaC/XcArC2zNBk7u+4fnkDozwacTQSWfjY+wwVwn4YuPUmBb
        LeE3BO6jBuPTpBMSDFQGPj8XvYJeARQ=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5CECE2C142;
        Tue,  8 Aug 2023 06:41:51 +0000 (UTC)
Date:   Tue, 8 Aug 2023 08:41:49 +0200
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
Message-ID: <ZNHjrW8y_FXfA7N_@alley>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
 <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <ZNEJm3Mv0QqIv43y@smile.fi.intel.com>
 <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-08-07 18:13:57, Andy Shevchenko wrote:
> On Mon, Aug 07, 2023 at 06:11:24PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 07, 2023 at 06:09:54PM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 07, 2023 at 05:03:19PM +0200, Petr Mladek wrote:
> > > > On Sat 2023-08-05 20:50:26, Andy Shevchenko wrote:
> 
> ...
> 
> > > > How does this sound, please?
> > > 
> > > Not every user (especially _header_) wants to have printk.h included just for
> > > sprintf.h that may have nothing to do with real output. So, same reasoning
> > > from me as keeping that in kernel.h, i.e. printk.h no better.
> > 
> > (haven't check these, just to show how many _headers_ uses sprintf() call)
> > 
> > $ git grep -lw s.*printf -- include/linux/
> > include/linux/acpi.h
> > include/linux/audit.h
> > include/linux/btf.h
> > include/linux/dev_printk.h
> > include/linux/device-mapper.h
> > include/linux/efi.h
> > include/linux/fortify-string.h
> > include/linux/fs.h
> > include/linux/gameport.h
> > include/linux/kdb.h
> > include/linux/kdev_t.h
> > include/linux/kernel.h
> > include/linux/mmiotrace.h
> > include/linux/netlink.h
> > include/linux/pci-p2pdma.h
> > include/linux/perf_event.h
> > include/linux/printk.h
> > include/linux/seq_buf.h
> > include/linux/seq_file.h
> > include/linux/shrinker.h
> > include/linux/string.h
> > include/linux/sunrpc/svc_xprt.h
> > include/linux/tnum.h
> > include/linux/trace_seq.h
> > include/linux/usb.h
> > include/linux/usb/gadget_configfs.h
> 
> Okay, revised as my regexp was too lazy
> 
> $ git grep -lw s[^[:space:]_]*printf -- include/linux/
> include/linux/btf.h
> include/linux/device-mapper.h
> include/linux/efi.h
> include/linux/fortify-string.h
> include/linux/kdev_t.h
> include/linux/kernel.h
> include/linux/netlink.h
> include/linux/pci-p2pdma.h
> include/linux/perf_event.h
> include/linux/sunrpc/svc_xprt.h
> include/linux/tnum.h
> include/linux/usb.h
> include/linux/usb/gadget_configfs.h

This is only a tiny part of the picture.

$> git grep sc*n*printf | cut -d : -f1 | uniq | grep "\.c$" | wc -l
5254
$> find . -name  "*.c" | wc -l
32319

It means that the vsprintf() family is used in 1/6 of all kernel
source files. They would need to include one extra header.

If you split headers into so many small pieces then all
source files will start with 3 screens of includes. I do not see
how this helps with maintainability.

Best Regards,
Petr
