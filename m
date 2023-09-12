Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02C379D844
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbjILSB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbjILSBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:01:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CDDE59
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694541676; x=1726077676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=luhmbwY2EvR/iFtfPRadQpf14tyBh/z3pE5E2Mu/Sy4=;
  b=VOPM0kEAeGiMm9SJoVNbkKZjD07gjrc5jJ2GsOSpDRhY7RIkKdN5w+xq
   HjpRz8a4be73NMqq8V95SXPxJfTlTBL4/jLDp9wRvG1CrnJa8rILgkYdA
   K9GiY0Kk02e4H41aHOD8GT9qUptATtbNHF0YBu7DhWh1tHWXeEci9I07i
   a4HARTCi/MgjDPSqgrkkGs7OHDNedKzweV1cecIz3u5PaurnzmVRB9HXa
   gBN1g+3q7FAa7gWDCr0t5YIB8wzaptviObsunJzpRkFW+h1qDEDKXP9wO
   JG0vZdRnbsuxyPtl4cQA0fnjZZcOujU0JGB85snDWjJOgmGLEbjIKnj9m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="444891572"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="444891572"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 11:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773134760"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="773134760"
Received: from smithc9x-mobl.amr.corp.intel.com (HELO [10.209.111.247]) ([10.209.111.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 11:01:13 -0700
Message-ID: <e3a16a25-46bf-e38f-142f-ab620d24eb4d@intel.com>
Date:   Tue, 12 Sep 2023 11:01:13 -0700
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
 <092a9bb2-727e-5849-fa4f-18535b998efc@intel.com>
 <ZP/wLVg1JCvhaEKm@casper.infradead.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZP/wLVg1JCvhaEKm@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 21:59, Matthew Wilcox wrote:
> On Mon, Sep 11, 2023 at 01:22:51PM -0700, Dave Hansen wrote:
>> On 9/11/23 12:12, Matthew Wilcox wrote:
>>> On Mon, Sep 11, 2023 at 09:55:37AM -0700, Dave Hansen wrote:
>>>> On 9/11/23 09:44, Matthew Wilcox wrote:
>>>>> After fixing your two typos, this assembles to 176 bytes more code than
>>>>> my version.  Not sure that's great.
>>>> Maybe I'm a fool, but 176 bytes of text bloat isn't scaring me off too
>>>> much.  I'd much rather have that than another window into x86 goofiness
>>>> to maintain.
>>>>
>>>> Does that 176 bytes translate into meaningful performance, or is it just
>>>> a bunch of register bit twiddling that the CPU will sail through?
>>> I'm ... not sure how to tell.  It's 1120 bytes vs 944 bytes and crawling
>>> through that much x86 assembly isn't my idea of a great time.  I can
>>> send you objdump -dr for all three options if you like?  Maybe there's
>>> a quick way to compare them that I've never known about.
>> Working patches would be great if you're got 'em handy, plus your
>> .config and generally what compiler you're on.
> gcc (Debian 13.2.0-2) 13.2.0
> 
> I don't think there's anything particularly strange about my .config
> 
> If you compile this patch as-is, you'll get your preferred code.
> Remove the #define DH and you get mine.
> 
> I would say that 176 bytes is 3 cachelines of I$, which isn't free,
> even if all the insns in it can be executed while the CPU is waiting
> for cache misses.  This ought to be a pretty tight loop anyway; we're
> just filling in adjacent PTEs.  There may not be many spare cycles
> for "free" uops to execute.

Thanks for that!

I went poking at it a bit.  One remarkable thing is how many pv_ops
calls there are.  Those are definitely keeping the compiler from helping
is out here too much.

Your version has 9 pv_ops calls while mine has 6.  So mine may have more
instructions in _this_ function, but it could easily be made up for by
call overhead and extra instructions in the pv_ops.

Also, I went looking for a way to poke at set_ptes() and profile it a
bit and get some actual numbers.  It seems like in most cases it would
be limited to use via fault around.  Is there some other way to poke at
it easily?

So, in the end, I see code which is not (as far as I can see) in a hot
path, and (again, to me) there's no compelling performance argument one
way or another.

I still like my version.  *Known* simplicity and uniformity win out in
my book over unknown performance benefits.

But, fixing the bug is the most important thing.  I don't feel strongly
about it to NAK your version either.
