Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF207EF0E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345894AbjKQKpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjKQKpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:45:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF0DBC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700217907; x=1731753907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ij9y/YkrDfTlz50Xi+Zj9XJQ6C4S7/BoXXJIz6rNYLA=;
  b=WTydDOxzqD9VNCcCAuoHG/K7GsxShYD934Yb9WeDK4lGUtSF5PcKhrtm
   MdYGwYq+2b+M3SBt3Q1HtCNlO9ctYUH3fctVVluaYrRAIvjLPOeVvT5mn
   1jsJfAsFNYGb2UxjXhDGTuHlU6rQvR5NglsomygFXgjidwIM+Bobb3dge
   vZBEUx77UHk4zXHgWo7CMhjXTDeTFnOfrgdt9c0JgXAQt9rwsnQ2hKsmJ
   qjkHh5YpDQ32tyAvhsxtqXKgYYpw0Ox5HlVIbxiFpcbjeuwjkUDqNboET
   L4Ng8182pFfBwGidw6RKheHl2glhTd95gW0Qg6kw8JvEEj6rzPqp84vXA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="477493889"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="477493889"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 02:45:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="1012895375"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1012895375"
Received: from fsforza-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.215])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 02:45:04 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4858410A325; Fri, 17 Nov 2023 13:45:02 +0300 (+03)
Date:   Fri, 17 Nov 2023 13:45:02 +0300
From:   kirill.shutemov@linux.intel.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip] x86/mm: Use %RIP-relative address in untagged_addr()
Message-ID: <20231117104502.4p53qqldwmyuyqju@box.shutemov.name>
References: <20231116191127.3446476-1-ubizjak@gmail.com>
 <20231117094103.GM8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117094103.GM8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 10:41:03AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 16, 2023 at 08:10:59PM +0100, Uros Bizjak wrote:
> > %RIP-relative addresses are nowadays correctly handled in alternative
> > instructions, so remove misleading comment and improve assembly to
> > use %RIP-relative address.
> 
> Ha!, it might've been this exact case (and Kirill grumbling) that got me
> to fix the alternative code :-)

Nice! :)

> > Also, explicitly using %gs: prefix will segfault for non-SMP builds.
> > Use macros from percpu.h which will DTRT with segment prefix register
> > as far as SMP/non-SMP builds are concerned.
> 
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> 
> Acked-byL Peter Zijlstra (Intel) <peterz@infradaed.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
