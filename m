Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179357E752E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbjKIXei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIXef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:34:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A244482
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 15:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699572873; x=1731108873;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=H0JgpMcIOQPK7szvm/GqrHrsCTm8xkKbQr8EOv5JXjg=;
  b=IAuYKO8zAIrlrkYE6H+PfxPSbaRwjrQ3bwjx2aI7fjwt+j5i0y5zlO7Y
   e+1CaqPJUdKh1I+jZsFiqzF8q2YJN3kXFPLTB3go69mJiBlScTWEV0iYV
   3w3vhc5vFYO20L8luFg+sdg1AKCcbL88WUBGJ+7d9HAxtSSvps19ZFqD0
   5ttFsj3s54pt1X6cPMrzm6lryPRYIApwO0Oa1luyO9ifNfklgEzDTqknk
   qqdESofb/GAAnV+hg14jQLf4iIZVHTJ2hUQtRL0qKCpnkWC1BJXkzt522
   h0IMOLiQ0GZySPzVgi3UeZgvwxeTKE9v2Z7M3WUgr63v8nqflsSsioQAX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="370303177"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="370303177"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 15:34:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="887181631"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="887181631"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 15:34:30 -0800
Date:   Fri, 10 Nov 2023 01:34:29 +0200
From:   Imre Deak <imre.deak@intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: Build fail in drivers/gpu/drm/i915/display/intel_tc.c
Message-ID: <ZU1shQH64ryxp/l5@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <4df68c74c4da46ac943ac21578e9b084@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df68c74c4da46ac943ac21578e9b084@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 10:55:38PM +0000, David Laight wrote:
> I'm seeing a build fail at line 1878 of intel_tc.c
> 
> gcc is being a bit over-enthusiastic about snprintf() formats
> and reports that "%c/TC#%d", xxx, tc_port + 1 might not fit
> in the 8 bytes available.
> 'tc_port' is an enum with values -1 to 5.
> I guess it is either allowing for the full 'int' value of
> the enum.
> Changing to '(tc_port & 7) + 1' stops the compiler bleating.
> 
> The code isn't new, so I guess the compiler flags have changed?
> 
> It might depend on the gcc version as well.
> I'm using gcc 7.5.0 from Ubuntu 18.04.

The compiler warn should be fixed/suppressed by:
https://lore.kernel.org/all/20231026125636.5080-1-nirmoy.das@intel.com

--Imre

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
