Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE97C6C31
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378212AbjJLLYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343789AbjJLLYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:24:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8929B91;
        Thu, 12 Oct 2023 04:24:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28BCC433C7;
        Thu, 12 Oct 2023 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697109844;
        bh=xcGFBX4K3u3hA6pR8kKm1S21DpL9l6KVTqZCKLMel1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X93lfslPnVsgcUE9NA9cH6EMBdskLpoVmO7TKXQr7NvC/pQHKkbbFjMhxFtYztnmJ
         N85hkGoUAXNpZsvWKRV43cGwv6mIcHTKxsbE2FAvShOA6u1+c/pXUnz0fP7IC71T5y
         4SyfhJt7DHukUPbSD+/DrgC65KSzWMFPA524g7ac=
Date:   Thu, 12 Oct 2023 13:24:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Xiaoke Wang <xkernel.wang@foxmail.com>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] lib/test_meminit: fix off-by-one error in test_pages()
Message-ID: <2023101218-whacking-evolution-8f97@gregkh>
References: <2023101238-greasily-reiterate-aafc@gregkh>
 <CAG_fn=X-dnc06r0Yik24jBaL-f7ZzrUQiUJmMHeN9CaSa3ZveQ@mail.gmail.com>
 <2023101201-grasp-smartly-2085@gregkh>
 <2023101241-old-germinate-7a05@gregkh>
 <CAG_fn=W0cRThcNzE3G7bu5VqwOddTp_uqup3k7tZSMqM2te0_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=W0cRThcNzE3G7bu5VqwOddTp_uqup3k7tZSMqM2te0_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:14:39PM +0200, Alexander Potapenko wrote:
> On Thu, Oct 12, 2023 at 12:37 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 12, 2023 at 12:26:58PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Oct 12, 2023 at 10:40:14AM +0200, Alexander Potapenko wrote:
> > > > On Thu, Oct 12, 2023 at 10:17 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > In commit efb78fa86e95 ("lib/test_meminit: allocate pages up to order
> > > > > MAX_ORDER"), the loop for testing pages is set to "<= MAX_ORDER" which
> > > > > causes crashes in systems when run.  Fix this to "< MAX_ORDER" to fix
> > > > > the test to work properly.
> > > >
> > > > What are the crashes you are seeing? Are those OOMs?
> > >
> > > They are WARN_ON() triggers.  They are burried in the Android build
> > > system, let me see if I can uncover them.
> > >
> > > > IIUC it should be valid to allocate with MAX_ORDER.
> > >
> > > "should", but I no longer get runtime warnings with this patch applied,
> > > so something is wrong :)
> 
> I think I know what's going on. In March 2023 Kirill changed the
> semantics of MAX_ORDER to be inclusive: now alloc_pages() accepts
> 0..MAX_ORDER, whereas previously it was 0..MAX_ORDER-1:
> https://github.com/torvalds/linux/commit/23baf831a32c04f9a968812511540b1b3e648bf5
> Older kernel versions had an explicit check for order >= MAX_ORDER,
> which is what you're seeing on Android.

Thanks for digging this up.  I'll just queue this patch up for 6.1 and
older stable kernels then as the commit above you found is in 6.4 so
nothing newer than that will need this fix.

Thanks for the quick response!

greg k-h
