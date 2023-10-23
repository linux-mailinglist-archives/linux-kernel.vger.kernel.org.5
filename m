Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDEE7D2F85
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjJWKNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjJWKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:13:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E4ED7A;
        Mon, 23 Oct 2023 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698055999; x=1729591999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lUqcNyeEWqG+/5OmMSoWR9OibhxOM4OinwmqXR7AGrI=;
  b=bWlA1dIz+SsM1q1sw2dFUxSszmA76iP/qxJLm5DZtS2WF4AOstg+P5w5
   Xrs5SQm8OIH8Gbv8PbRM/Rxx7kS1JDA6vcr78fwmWHcLBxnAkvgIhJfKG
   Op4Zqi1ridnRkid0+hXFPZZCeei4e/O33S4yrkaWdY1/OWKfMF7uP1/RI
   Xd19aJGJYgkUI54dBTl7qIGgdICfe6WxvT78PlaH6P3TZk/nDEuU5KD5e
   e6WxRvxK5S56X+irVJZoR63UdVJ0Ysz5VnPEu8K1hzNnoXTGKXcRWvXL/
   Zb4WgJwQwkE+DetB4YhRt66XgZc5vF+wR4IF/57FphWk5609+y6m8qHNA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8364947"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8364947"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 03:13:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="881716793"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="881716793"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 03:13:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qurvt-00000007uDG-1P00;
        Mon, 23 Oct 2023 13:13:13 +0300
Date:   Mon, 23 Oct 2023 13:13:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     syzbot <syzbot+b8bf7edf9f83071ea0a9@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in wpan_phy_register
Message-ID: <ZTZHObssfh+46Lm6@smile.fi.intel.com>
References: <0000000000008f824606052a2d9b@google.com>
 <000000000000af2dbf06083f7baf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000af2dbf06083f7baf@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 01:03:31PM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit fd6f7ad2fd4d53fa14f4fd190f9b05d043973892
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Mon Aug 28 14:58:24 2023 +0000
> 
>     driver core: return an error when dev_set_name() hasn't happened
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ea2e89680000
> start commit:   ac28b1ec6135 net: ipv4: fix one memleak in __inet_del_ifa()
> git tree:       net
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
> dashboard link: https://syzkaller.appspot.com/bug?extid=b8bf7edf9f83071ea0a9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14871d58680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ace678680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: driver core: return an error when dev_set_name() hasn't happened

> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

-- 
With Best Regards,
Andy Shevchenko


