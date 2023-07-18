Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68075878A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGRV5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGRV5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:57:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2064419AF;
        Tue, 18 Jul 2023 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689717432; x=1721253432;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=R/NgUUE17suolBNGAewxu0afg5xXnbD5XrHR2rYOQ2s=;
  b=mvEdH8yXQL7leIY9LureW8QYz5EqCC+NM0UOl+8QO5uLiTU9/dHoa83f
   efJH+Nf5na3k6tVxlYPcfl89Lh7abFayX6dahv3Ma1mnrE//LggdGSLHa
   s+wJf+rjl/aChHqfLFmvSIpViN1Dd+MxLSJhRg3ipNU4iRlswYlfZRH6d
   xGKm3QvGw3hzlxb1YYO+u5ETa0FoOIibsKv+UyQOqpG4f7cXJci0dSz60
   XG+i9Mve5cEto6KiAdLn+2zU9Q6+I/Pi2KpdgsKx6hDXEAy0Dhax8oloo
   uml9SLrbEEylM+4FjckMJOatU1DkXrHLO79KHODmTwzHriBUZy/n8Aa5h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346620901"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="346620901"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="897699903"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="897699903"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Jul 2023 14:57:10 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
 <20230717202938.94989-1-haitao.huang@linux.intel.com>
 <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
 <op.18ah5mn3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <b5779418-e2a4-ca7a-866f-97e49cd272cb@intel.com>
 <op.18aontlmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <eb1aea6f-3688-f871-2335-ff911a51ef52@intel.com>
 <op.18aqz7sbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <ad2d9610-61c0-4719-9df1-0116ef317d8a@intel.com>
Date:   Tue, 18 Jul 2023 16:57:08 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18asliuzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ad2d9610-61c0-4719-9df1-0116ef317d8a@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 16:36:53 -0500, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 7/18/23 14:22, Haitao Huang wrote:
>> I agree this is the race. But for this to happen, that is at #1 you have
>> only one non-SECS page left so #3 can happen. That means it is already
>> high pressure
>
> I think our definitions of memory pressure differ.
>
> Pressure is raised by allocations and dropped by reclaim.  This
> raise->drop cycle is (or should be) time-limited and can't take forever.
>  The reclaim either works in a short period of time or something dies.
> If allocations are transient, pressure is transient.
>
> Let's say a pressure blip (a one-time event) comes along and pages out
> that second-to-last page.  That's pretty low pressure.  Years pass.  The
> enclave never gets run.  Nothing pages the second-to-last page back in.
> A second pressure blip comes along.  The SECS page gets paged out.
>
> That's two pressure blips in, say 10 years.  Is that "high pressure"?

Okay, that explains. I would consider it still triggered by high pressure  
blips :-)

But I agree we can drop the mentioning of pressure altogether and just  
state the race so no confusions.
Thanks
Haitao
