Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C580D7FC119
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjK1Qft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK1Qfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:35:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B434D60
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701189353; x=1732725353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4RER+04drm8bLOvAPnWsEO8Ej4uQa5dTZ8BV5eVR2xk=;
  b=APepEbCYWN2C0LLtSroyObJxQdHlOkEU/CmSAqkc8dD1kLiYN7Xia/Dk
   ILHymy6dPxDsrU3n/nHfDL7Xyp5bFrKu6PCW1vP2N1fTsKEA66/J8fzqx
   vwZftu4leYsJD9C2PzSOVysNNCdIA4/waiKH21rjAOVEIpuyooQVWBHwd
   UG1oSR8URU9NiMI7Uu3wlblu6CsAZRgc9nNGjR7sO0uE2JeT0t7gAJoJi
   prhGkYE5ZhQTiQr2bI/MGy8EpuRqM6cMs09LmBFhjk2TxnLJ9mwbWkyAI
   CqzA/ySR48/2bk61M7pUVuTb7H27l3jbxSktPQeRyNU1FtuJktxvGWhoV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="391828988"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="391828988"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:35:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="797628781"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="797628781"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:35:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r813q-00000000D7N-4A2F;
        Tue, 28 Nov 2023 18:35:46 +0200
Date:   Tue, 28 Nov 2023 18:35:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     George Stark <gnstark@salutedevices.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        jic23@kernel.org, linux-kernel@vger.kernel.org,
        kernel@salutedevices.com
Subject: Re: [RFC PATCH 1/1] locking: introduce devm_mutex_init and
 devm_mutex_destroy
Message-ID: <ZWYW4nDZNAO7NADj@smile.fi.intel.com>
References: <20231128000910.73784-1-gnstark@salutedevices.com>
 <cbd2705d-9d43-4822-9b5c-ea437a2ccca7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbd2705d-9d43-4822-9b5c-ea437a2ccca7@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 08:55:18PM -0500, Waiman Long wrote:
> On 11/27/23 19:09, George Stark wrote:

...

> These APIs are specific to devres. I don't believe it is suitable to put
> them into the generic mutex.h header file. All devres_* functions are
> defined in include/linux/device.h which is probabably not included in
> mutex.h. You may consider putting these APIs into device.h instead.

+1. We have include/linux/devm-helpers.h.

-- 
With Best Regards,
Andy Shevchenko


