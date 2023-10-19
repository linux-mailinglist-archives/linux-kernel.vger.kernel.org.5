Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E15B7CF566
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjJSKcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSKc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:32:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB95A119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697711547; x=1729247547;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qRBkCTJbRJlP/rxYmWi5U4pxhGfUHsPS+Zw8MPdhUoY=;
  b=FE80kuSka7esHXId06HpbNaaBM4HALpX7niniGhVFlSCS7cheF3FzhhI
   EI6hneTg17cvfd7DN6FM+w/vGktMA+3GSUkqwzV3BhDLLUi8cRsWzJXro
   UhxNCGRma0psx7ulOs/FxMKoTkevaQQtwsTVNCIVA1NcrQb0ddv9f4t1i
   FAIzQwB7WkXAKU2Yhc4dbUlFeLBdapFpq+7I1fZrLVNfPnG4LP5E3XkAj
   yptobj/zU31pbTzOyDEM//A6pySaCdEGcfHSAMYdllPuXdweahVKaflfF
   lXp8pEIbK17QAVr9yF4q9YujYS0kqN9NZWFn8IDde8afMXWhrmlLBeoeO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="376596455"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="376596455"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="706807168"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="706807168"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.3.232]) ([10.213.3.232])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:31:40 -0700
Message-ID: <62e16250-63f4-4fbb-b00e-db808b600664@intel.com>
Date:   Thu, 19 Oct 2023 12:31:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-gfx] [PATCH v2] debugobjects: stop accessing objects after
 releasing spinlock
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org
Cc:     Nirmoy Das <nirmoy.das@intel.com>
References: <20230925131359.2948827-1-andrzej.hajda@intel.com>
 <87v8bak6iy.ffs@tglx>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <87v8bak6iy.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.2023 15:15, Thomas Gleixner wrote:
> On Mon, Sep 25 2023 at 15:13, Andrzej Hajda wrote:
>> After spinlock release object can be modified/freed by concurrent thread.
>> Using it in such case is error prone, even for printing object state.
> 
> It cannot be freed. If that happens then the calling code will have an
> UAF problem on the tracked item too.

Yes, and I have assumed that debugobjects are created also for detecting 
UAFs. They should be able to handle/detect 'issues due to incorrectly 
serialized concurrent accesses' scenarios as well, at least some of 
them. And even if it cannot recover it should at least provide reliable 
reporting.

Now we can have scenario:
1. Thread tries to deactivate destroyed object, debugobjects detects it, 
spin lock is released, thread is preempted.
2. Other thread frees debugobject, then allocates new one on the same 
memory location, ie 'obj' variable from 1st thread point to it - it is 
possible because there is no locking.
3. Then preemption occurs, and 1st thread reports error for wrong object.

This seems the most drastic for me, but also with lowest chances to 
happen due to delayed freeing, but there are also other more probable 
scenarios when we print the same object but in state different from the 
one when debugobject detected issue, due to modification by concurrent 
thread.

> 
> If there is a concurrent modification then again, the calling code is
> lacking serialization on the tracked object.
> 
> debugobject fundamentally relies on the call site being consistent
> simply because it _cannot_ invoke the fixup callbacks with the hash
> bucket lock held.

Hmm, if call site is consistent then 'fixup' seems unnecessary, together 
with debugobjects.
I guess 'fixup' users should take care of locking on they own in such 
case, as it is currently, nothing changed.

> 
> What's the actualy problem you are trying to solve here. The changelog
> does not explain anything except of handwaving about modified/freed.

Presented above.

Regards
Andrzej


> 
> Thanks,
> 
>          tglx

