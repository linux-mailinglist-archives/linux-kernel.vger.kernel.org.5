Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4BD7F1DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjKTUJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjKTUI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:08:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA003BE;
        Mon, 20 Nov 2023 12:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700510936; x=1732046936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rU+hV0Dwyl2lU7FcgPXL3hIp8mCrdq1swhV5294kYhg=;
  b=QrJ6G2ZACJSP7sKnNNRSg3ER0HU62s5+cGBpH1qgEZz73UUQ4diORoVd
   wGeuv/UG9ZZAq0IxcQLvXaPbYTcUFdxYN8bAYm9z4w+MbK85WIY7JTpLz
   BEETmXRmDuJkx4UTlTKAaTLNwIYT+FHfBuzoUVzJ6qFGswRk7f3GrkTKC
   5MPMxhU7HCTm3bQ79hToRup6NGLJodtq7jaodVPxt4ZLtt19ddsxp9F3S
   jbkrlXra01QdVLuOKI5vv++mXhlV/dnf/RZKrroZYO3eMa43NVJ4Ymh7+
   75ll0BiB3FNRxZCrhuqujUll3f3wtDRApDLsPswTIz7DHLuThGUhnZf48
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="10367114"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="10367114"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="14270125"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:08:55 -0800
Date:   Mon, 20 Nov 2023 12:08:50 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: Add inline-account tool
Message-ID: <ZVu8u+oofXO8iwyf@tassilo>
References: <20231115004932.650702-1-ak@linux.intel.com>
 <CAK7LNASS1YWdqW5TUXQ0iC3vgoDbUf-M-cRX0BvrkOV8HPyjxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASS1YWdqW5TUXQ0iC3vgoDbUf-M-cRX0BvrkOV8HPyjxg@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > +    sym_sizes = [syms[x + 1] - syms[x] for x, _ in enumerate(syms[:-1])]
> > +    sym_total = sum(sym_sizes)
> 
> 
> This is equivalent to
> 
>       sym_total = syms[-1] - syms[0]
> 
> isn't it?

No it's not when there are gaps in the symbols, which always happens in
the kernel.  The previous version used the range but that led to inbalances.

> def get_ranges(syms, threads):
> 
>     ranges = []
>     prev = syms[0]
>     i = 1
> 
>     while threads > 0:
> 
>         boundary = prev + 1 + (syms[-1] - prev - 1) // threads
> 
>         while syms[i] < boundary:
>             i += 1


Note the boundary is not the address, but the sum of symbol sizes


-Andi
