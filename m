Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569BE797DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbjIGVbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIGVbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:31:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD21B4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694122274; x=1725658274;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eyplcqMShK7JduyqqjFDLu2TyYp5DTL3jHCp4kVYupU=;
  b=VZiYQY3I9rJAiUEl/BO/iycuyYe2yue20dcM9gTxvg1T0HFW5P4ixwTJ
   EhSCNgINI/Hk1Tlw1TLLT/+i85ULbvBqKCxQGM0fuQusgW3y3OBNDrbZR
   ysdeas+MEVKzHTFQPIe4bvX3hy8SgcOR6mYGijGZKoIohMUsijpsBWWdf
   CWcmtBVdmxmqhGid9S5z73RH1cEXwxs7I4QzK3mRG0eVUZDt/clPUU6gc
   v4B2yxENhad3p880oEdnOGgjoXFhmwOm5bzX5xV4LgWowo1rXCP7yzmFX
   qzedfvcTRJ6Oz7I9uEt0b9nfLHcZhpK41ltPvbIT5MyoOGHjsPsZQVFvC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="408473774"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="408473774"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:31:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="771451251"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="771451251"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:31:13 -0700
Message-ID: <c0159d08-e69d-0329-5ca9-68fd26cab0c8@intel.com>
Date:   Thu, 7 Sep 2023 14:31:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Memory protection keys: Signal handlers crash if pkey0 is
 write-disabled
Content-Language: en-US
To:     Robert Kueffner <r.m.kueffner@gmail.com>,
        Kyle Huey <me@kylehuey.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <FF299375-B46F-46D0-90A9-333959FE9380@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <FF299375-B46F-46D0-90A9-333959FE9380@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 14:22, Robert Kueffner wrote:
> Is there some way to make this work, or is it generally not possible
> to successfully handle exceptions if WD0=true?

It's theoretically possible, but it's in a grey area.  The kernel can't
easily try to respect PKRU *and* override it for things like decoding
userspace instructions.

PKRU should get reset to a value that permits reads and writes to pkey-0
before the signal frame is created.  But you're obviously tripping over
it anyway.

I assume that *something* is trying to access pkey-0-protected memory.
Any idea what that is?  Which entity is doing that access and what are
they accessing?  The page fault tracepoints might come in handy.
