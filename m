Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776858033CF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjLDNHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjLDNHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:07:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C2A7;
        Mon,  4 Dec 2023 05:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701695230; x=1733231230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UXznonBwZSh6vXkSOTRxTtrLALPBPOcd61xsNDWj4+I=;
  b=jVPAaYDyH7Qfu6aYzAqic98Wlrl/0ukje+B8DWj5adDdPsVOjFd6rOmQ
   N6Fa4B0+ed1pJbgXRY2UPuomb2L9xpb7l+SXLkp3SSBUdiywbj+TAbZrU
   v8Seex1XCVqaxR6m/dOj7hd4hYLHR+v/vCg29WBMEmyUFECb/FGZkgMZC
   NvRSQGrLNZA8Cah0to6uDHZ/lEpQ1zvY3+V4c7YXgvZH3R4n1TMiPIUoD
   nfIEl+ieJZyXAr/847vedbdRgczqhqS5TuukfldvmQYaxsr0+OcVuJRv8
   8Cbvyx0v487JQIsZ8hVaBAU59nTpQ2mRO1ig+CCOXLnrpYqC4xpawvmrP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="15274919"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="15274919"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:05:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="763935407"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="763935407"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:05:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rA8dl-00000001kpu-0ppK;
        Mon, 04 Dec 2023 15:05:37 +0200
Date:   Mon, 4 Dec 2023 15:05:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v2 27/35] media: em28xx: cx231xx: fix opencoded
 find_and_set_bit()
Message-ID: <ZW3OoLzNYe2IytMn@smile.fi.intel.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-26-yury.norov@gmail.com>
 <40783b7c-4353-4366-ad49-95ac87c5f8be@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40783b7c-4353-4366-ad49-95ac87c5f8be@xs4all.nl>
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

On Mon, Dec 04, 2023 at 09:39:59AM +0100, Hans Verkuil wrote:
> On 03/12/2023 20:32, Yury Norov wrote:
> > Functions in the media/usb drivers opencode find_and_set_bit() by
> > polling on a found bit in a while-loop.

...

> It's a nice improvement.

Wouldn't it be even nicer to utilise IDA framework?

-- 
With Best Regards,
Andy Shevchenko


