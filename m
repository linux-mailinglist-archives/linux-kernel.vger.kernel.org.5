Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54E7D0CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376715AbjJTKRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376596AbjJTKRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:17:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8BEB6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697797061; x=1729333061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zN/p4K4GbcPbjIQW5+xyHKJeKGHLoCpuaoTv2SA47FI=;
  b=N3KOCQFBr661jiFfMUfhDnSSA5ukbnibYF6V/CDPDc27XThIlfZtCZFA
   dFgRaJ0t9DxWegO7diXG744AB1NSy7oSUvXgK5iphPMPisUf6ZQAFpT30
   NiikF80C+zxVBhsjM2sI8PymA6evoEOSA4rjN/m0psECnPB3EfSZ7W9kW
   7rlCQyA7zPxTi61S+idf+PZRNuGCMgM/wKX7mdQjQrtsJZYhW7+JPCbVX
   THAyH/RK5zN79OOCZ5obWToTuGkMcJ0MLN34LGwG9hDr0r1xHTrDSoXpk
   D4IrCjDPPP80e18OL1oOrNehM5WliE23PAarY0C+wO8zW1x1m7wgiLplx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472692460"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472692460"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="901106702"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="901106702"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:15:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtmZT-000000077Sz-30IT;
        Fri, 20 Oct 2023 13:17:35 +0300
Date:   Fri, 20 Oct 2023 13:17:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     syzbot <syzbot+bbc59256015533127d80@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        ricardo@marliere.net, skhan@linuxfoundation.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in serio_handle_event
Message-ID: <ZTJTv0hjVAgexanB@smile.fi.intel.com>
References: <000000000000f014150604d5040a@google.com>
 <000000000000701c7d06081bb14d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000701c7d06081bb14d@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 06:21:34PM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit fd6f7ad2fd4d53fa14f4fd190f9b05d043973892
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Mon Aug 28 14:58:24 2023 +0000
> 
>     driver core: return an error when dev_set_name() hasn't happened
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a45b9d680000
> start commit:   65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of git://git...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
> dashboard link: https://syzkaller.appspot.com/bug?extid=bbc59256015533127d80
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d70614680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130eedb8680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: driver core: return an error when dev_set_name() hasn't happened

> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

-- 
With Best Regards,
Andy Shevchenko


