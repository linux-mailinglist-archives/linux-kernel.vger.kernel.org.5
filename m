Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECB179BC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359429AbjIKWQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244401AbjIKUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:22:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C664185
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694463772; x=1725999772;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J/VrWvVCpD4pfFbtFJWIVg32QCmXn6NLI50uns6mNSI=;
  b=Hzqbc+/dqtkkmPyC1TI8UIF+cV7j4v+bE9/K/fCb4T05b8TJN02W02jp
   lXarVUY1obY88br/u5qIsT7Dqe9JQCU2qpqcTOLcMgDOnEYN3D5IJi4q6
   /yLr5qzXqC4fSZ0bsVd+5sSXySyBhBF2QZ9cInix/ib4hCVKiPe85sDnJ
   JvoaCdYSsbvWNWvcyqB7Uy7r3j4r1bGSSICPNt/613A2K0LxQm5rP7Fsi
   EZ4iMf5c4dBDdcULADhnUgK8mA7g81am7uGgIn37+3lOvemnmo/wssRZD
   FZta8e7Y/oCOh1O2gjPw2NtPwst/EjXLKNqV2i2xCaBB+o5jpU6jAWOep
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378106492"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378106492"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="736890098"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="736890098"
Received: from cdaubert-mobl13.amr.corp.intel.com (HELO [10.212.203.41]) ([10.212.203.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:22:51 -0700
Message-ID: <092a9bb2-727e-5849-fa4f-18535b998efc@intel.com>
Date:   Mon, 11 Sep 2023 13:22:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yin Fengwei <fengwei.yin@intel.com>,
        syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <000000000000d099fa0604f03351@google.com>
 <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
 <ZP8VcUIXTjvR3z54@casper.infradead.org>
 <f3379aeb-f394-8c99-5143-f93e82400320@intel.com>
 <ZP9D0q5MSVFobNbZ@casper.infradead.org>
 <fb936bdb-6473-a956-8431-fe95f5940acc@intel.com>
 <ZP9mla26MWqKKUZ7@casper.infradead.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZP9mla26MWqKKUZ7@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 12:12, Matthew Wilcox wrote:
> On Mon, Sep 11, 2023 at 09:55:37AM -0700, Dave Hansen wrote:
>> On 9/11/23 09:44, Matthew Wilcox wrote:
>>> After fixing your two typos, this assembles to 176 bytes more code than
>>> my version.  Not sure that's great.
>> Maybe I'm a fool, but 176 bytes of text bloat isn't scaring me off too
>> much.  I'd much rather have that than another window into x86 goofiness
>> to maintain.
>>
>> Does that 176 bytes translate into meaningful performance, or is it just
>> a bunch of register bit twiddling that the CPU will sail through?
> I'm ... not sure how to tell.  It's 1120 bytes vs 944 bytes and crawling
> through that much x86 assembly isn't my idea of a great time.  I can
> send you objdump -dr for all three options if you like?  Maybe there's
> a quick way to compare them that I've never known about.

Working patches would be great if you're got 'em handy, plus your
.config and generally what compiler you're on.

I'll see if there's anything silly happening that's causing the
generated code to blow up.
