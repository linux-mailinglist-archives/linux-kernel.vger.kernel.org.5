Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093698110B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378807AbjLMMCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjLMMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:02:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F45F7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702468943; x=1734004943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sU1cY2onLnbpQIDRhHnFwFsomusAlQI0iUZ6jEcMyVk=;
  b=QVDAqq9LveR4DeOddB+hwdYNRrdeU66DwcWIV437DZMpSA6CuF7llxIb
   W0mzb2clTHTkoOQ5Sb+yVeG3IRa9P78wWWx9uCul50tcF/Znuqe8dRKIJ
   UREnuJtUN0lDfANHDJuP4rRdEi84sw6JV3p5qL3XULJomshcDEoSW/N0Y
   SQWFAFCHDnA5DyPW+PtGYxDhwNUengLImCmmeLjDX84j3db7jcZbtPqOz
   8ZFkkGYjTFWCNuuPnCq0mDJYXie6q/4km9WtxwQupvAcoDHL+3jnBfOgx
   uEYgn6fSVWEhRwLmFJZV4R1ZiOFWAu2OE0EnGEhTzNLhEF6G6UVBVHq/w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2093789"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="2093789"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 04:02:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="891991996"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="891991996"
Received: from gschoede-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.110])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 04:02:18 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 51E7810A4DA; Wed, 13 Dec 2023 15:02:15 +0300 (+03)
Date:   Wed, 13 Dec 2023 15:02:15 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Yuan Yao <yuan.yao@intel.com>, Kai Huang <kai.huang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: tdx: hide unused tdx_dump_mce_info()
Message-ID: <20231213120215.64wcryk5k75cymop@box>
References: <20231212213701.4174806-1-arnd@kernel.org>
 <39cf0ad5-bbef-4fb9-81a3-9d2891cc7450@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39cf0ad5-bbef-4fb9-81a3-9d2891cc7450@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 01:42:09PM -0800, Dave Hansen wrote:
> On 12/12/23 13:36, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > When TDX is enabled but MCE is not, the tdx_dump_mce_info() function
> > fails to link:
> 
> Thanks for the report, Arnd.
> 
> The only way that TDX has to report integrity errors is an MCE.  I'm not
> sure it even makes sense to have TDX support but not MCE support.  Maybe
> we should just make TDX host support depend on MCE.

I agree. Silently ignore integrity errors is not good idea.

TDX module spec also supports it:

"The machine-check exception handler is expected to be implemented in the
VMM."

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
