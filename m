Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3E379D60C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbjILQR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbjILQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:17:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA7610F1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694535442; x=1726071442;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hWSb593QbyDwwL91GaPneBk/XUoXrERt+BQqoLDjF5U=;
  b=CtJfZmFM4N7K5eFmiwu9ec6yzzmqeQwR5VREHtT/mowTqqMYfw119KUH
   vVw1HnzQrgZSsQGeZ3Nr2xVZzKzY4pN1vTproBx7IW/zWJS0EC46LlzuY
   YrPUAqe+nJH9oQgT7DIVO0bt/Dn5Gi2T9L5gjp0XZ8c2RnXrzoI7REBAC
   fqDNj9jF9NPnMrHe8wY5fO6hcr5i0sAXt5OBiuJahzzwe5UanG3B/lTpF
   CK0dj7yay26QZjoeOZnPiubem8HrcxeTVR7I26X3lta2qWiInFXmgBp5k
   3Zz/tpTagjECFJi2Spsi31fyOUqCY1DqvQOpFoPEsFXAimX4nFlhqnglM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382230702"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="382230702"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="743766573"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="743766573"
Received: from smithc9x-mobl.amr.corp.intel.com (HELO [10.209.111.247]) ([10.209.111.247])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:07:40 -0700
Message-ID: <580e6672-c637-353f-a918-239ba6134c3c@intel.com>
Date:   Tue, 12 Sep 2023 09:07:39 -0700
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
> I don't think there's anything particularly strange about my .config

I just saw some DEBUG_VM #ifdefs around the area and wondered if any of
them were to blame for the bloat.
