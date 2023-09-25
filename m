Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2C57ADAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjIYPJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjIYPJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:09:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F1FF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695654553; x=1727190553;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=tQLVrYpCL0nfs9//RXQMdDZzJjLejMo0pgtvzV3pWm8=;
  b=S8aevG02maOvWbb95opbYS8hhj2wxEwqGsFfbS6IXT6ajcZ1s7McWkNJ
   p+rEuA3B/oSWzVwbsNGVKDtLHhiBaGOBZfzxzF7AcRws/73uijFJI8gU5
   QOmJRng/DRh/v7GW0v8Jz03ippZVp4jvUmUYYX8mocMg5PO9d8WEqHvRG
   ZeGPTRydROwqOlieFZRbQUQPmbSfrV6JwWPPEevdE6MsYYtlbfsEVODfq
   59oZdnJcPmhBB3rdAZI6zstPm1gYT7GIb3Oqf5pimHHM+cEsUKMZ1sFQ/
   mumoOGKM/oOTasJYV5yQ+QrU3iRCpuOPOH1LATe00l58cjeuVh99VEj4j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="385110537"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="385110537"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:09:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="751735492"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="751735492"
Received: from smgotth-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.46])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:09:10 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Matthew Brost <matthew.brost@intel.com>,
        "Dr. David Alan Gilbert" <dave@treblig.org>
Cc:     krzysztof.kozlowski@linaro.org, airlied@gmail.com,
        mgreer@animalcreek.com, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] ERR_PTR(0) in a couple of places
In-Reply-To: <aa6270c5-46d7-4082-ab5a-9a850616b6fe@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <ZQ+Fo9WKyGphwI8R@gallifrey>
 <ZREKJpfMx7ZEcw3n@DUT025-TGLU.fm.intel.com>
 <aa6270c5-46d7-4082-ab5a-9a850616b6fe@infradead.org>
Date:   Mon, 25 Sep 2023 18:09:07 +0300
Message-ID: <87cyy6mgrw.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2023, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/24/23 21:18, Matthew Brost wrote:
>> On Sun, Sep 24, 2023 at 12:41:07AM +0000, Dr. David Alan Gilbert wrote:
>>> Hi,
>>>   I randomly noticed there are a couple of places in the kernel that
>>> do
>>>    ERR_PTR(0);
>>>
>>> and thought that was odd - shouldn't those just be NULL's ?
>>>
>>> 1) i915
>>>   drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c : 47
>>>
>>>     if (i <= 1)
>>>       return ERR_PTR(0);
>> 
>> Yes, s/ERR_PTR(0)/ERR_PTR(NULL)/
>> 
>> Matt
>
> I agree with Dave's original suggestion since casting NULL isn't needed.

Yeah, s/ERR_PTR(0)/NULL/ would be my choice as well.

As a side note, I generally think it's better not to mix NULL and error
pointers in error return values for a function, because they're harder
to handle properly.

BR,
Jani.

>
>> 
>>>
>>>   from f9d72092cb490 
>>>
>>> 2) trf7970a
>>>   drivers/nfc/trf7970a.c : 896
>>>
>>>       trf->ignore_timeout =
>>>          !cancel_delayed_work(&trf->timeout_work);
>>>       trf->rx_skb = ERR_PTR(0);
>>>       trf7970a_send_upstream(trf);
>>>
>>>    from 1961843ceeca0
>>>
>>> Dave
>>> -- 
>>>  -----Open up your eyes, open up your mind, open up your code -------   
>>> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
>>> \        dave @ treblig.org |                               | In Hex /
>>>  \ _________________________|_____ http://www.treblig.org   |_______/

-- 
Jani Nikula, Intel
