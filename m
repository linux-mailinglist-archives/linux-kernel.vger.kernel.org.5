Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D123A7A689F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjISQL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISQL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:11:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250C8A1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695139911; x=1726675911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n0nndngDWookRXDE4s6YNu2oxHORVbC9GtQqMc83C1c=;
  b=FleoOC2x7CIzaqpiW8JC+zifzUHLj5nMDnqgF71ypUn32ebuNnaUShm2
   ju6EssT6bLIZidvzURAOQbK1v8g7LNF4uzAvqLYPFLNEFQxxQvccJVosO
   3wnGulxiwgfPRIQd6sgpyJnRw1sYAylsvbIZj9twhAOytUwxjSNCh8eol
   WFZGm8GSp12sMwMjLm9mRSeg7wblx9HoMTYE68YDbFxoWGQfhSLd67v5t
   N0dbMRxuquchPi6EIN7d0+uVwhmm/9hWUedUie+9sJeM3a/T06SXc6RRL
   6ouaz6CCKeiWtqW+sdXNA6z3bLqw7zJ9zwDfmzVTbg7Qxi6594C0/E0bE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="466304326"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="466304326"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="1077043484"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="1077043484"
Received: from rdromms-mobl4.amr.corp.intel.com (HELO [10.212.158.204]) ([10.212.158.204])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:11:50 -0700
Message-ID: <f40677ee-8b8e-b719-24ed-662c219c6989@intel.com>
Date:   Tue, 19 Sep 2023 09:11:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Content-Language: en-US
To:     Yin Fengwei <fengwei.yin@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
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
 <97e59c09-30c8-038a-a6f9-3d862a0d3ede@intel.com>
 <381e4ccd-47ee-955b-f7af-fe192bea0cd4@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <381e4ccd-47ee-955b-f7af-fe192bea0cd4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/23 18:11, Yin Fengwei wrote:
>> I will find a test machine to measure the performance difference of these two
>> versions by using xfs + will-it-scale. Will keep you guys updated.
> I'd like to move this bug fixing forward. Based on the test result here:
> https://lore.kernel.org/linux-mm/124631ab-eb4c-6584-12d4-f3c91e69c873@intel.com/
> There is very small performance delta between your version and Dave's.
> 
> What do you think if we propose to merge Dave's version? Or do I need collect
> more data? Thanks.

I honestly don't feel that strongly about my version versus Matthew's.
I like mine, but I'll happily ack either approach.

The thing I care about the most is getting the bug fixed ... quickly. :)
