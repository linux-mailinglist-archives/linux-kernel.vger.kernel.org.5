Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9904E7BF8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjJJKaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjJJKae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:30:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B19E;
        Tue, 10 Oct 2023 03:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696933833; x=1728469833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XakNk4GgwZEyofp6lByGxyrj3kfNwhhD+AeDdSisNVM=;
  b=m4Zyw1cdJ8/Pv/EejVZ/Hsnr9DplwOd3eeh5UPKW8ICNoY7eEmGjAe5C
   nTudD5uHvg4tP4pSnd0ZHpfgtIS4qdE1topWcer8w0gV0i+fZaDP9uras
   Y36v3jELLn8UoC1gWeOi+drkaAb7LzP3alMTCjAGU/I552XjvmTfW6rcK
   fBWP7+dn/ShGd0m6LlU2Ov6b5nIoyApY2pfst7D0wj9QFzzwMnwZuLsDT
   LVyKQVeeTjHM+jeKyjiBkNdPWX3e1uFA/d/d5TvwH++Y058H2ZFda+jni
   vLXJWytTsEZlqwwC9dp9zI+8IZRUGhB/2uKx+XpYphYYOkHGjz8p/34vg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369423611"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="369423611"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:30:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084720804"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1084720804"
Received: from albertmo-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.38])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:30:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C523910989E; Tue, 10 Oct 2023 13:30:26 +0300 (+03)
Date:   Tue, 10 Oct 2023 13:30:26 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Disable KASAN on text_poke_early() in
 apply_alternatives()
Message-ID: <20231010103026.hcjn47kvjqesxoqj@box.shutemov.name>
References: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
 <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
 <20231010101056.GF377@noisy.programming.kicks-ass.net>
 <20231010101621.GG377@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010101621.GG377@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:16:21PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 10, 2023 at 12:10:56PM +0200, Peter Zijlstra wrote:
> 
> > That said, I don't particularly like the patch, I think it should, at
> > the veyr least, cover all of apply_alternatives, not just
> > text_poke_early().
> 
> kasan_arch_is_ready() is another option, x86 doesn't currently define
> that, but that would allow us to shut kasan down harder around patching.
> Not sure if it's worth the trouble though.

IIUC, it was intended to delay KASAN usage until it is ready. KASAN is
functional well before apply_alternatives() and making
kasan_arch_is_ready() temporary false for patching feels like abuse of the
hook.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
