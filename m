Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B7B75874A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGRVg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGRVg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:36:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3D9C0;
        Tue, 18 Jul 2023 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689716216; x=1721252216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1BDw+qUZlFSHxjhbgyBlkEgjL+F0zoRSb4egK/Yp7FI=;
  b=jJC08jRYLMdM+gxKn5rcJ9uVs6X8fknO/wjmQDHvvzQbAxAA5/t2VBPn
   hlBFgEHhL9D3vaU4bd/UqI1EHcZauxxqyy72579xeRGChRouZ0/7watek
   u8mTdvoLNllveXneHr4+jIfuzIsEu7Zs1IVw/ALqAGs/Q0jge14vh4kyM
   jGs5+H8Qw91v27JWKL1hHjrMeSKVXjrXv7sccfU7ANWk9uCSspzl2azIX
   3Rk+7aHuy2UNAxE3Ix+asuSn8nGRrJF8kcrzIzhyhMupoPB+F/AY8HIpF
   ba8YexXrNOqwOkxDHWxW8ZG9NkoW5t/YrXp8lWRDvVRODrTIcVuhOB/sj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432500416"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="432500416"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="1054464383"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="1054464383"
Received: from unknown (HELO [10.209.37.195]) ([10.209.37.195])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:36:54 -0700
Message-ID: <ad2d9610-61c0-4719-9df1-0116ef317d8a@intel.com>
Date:   Tue, 18 Jul 2023 14:36:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
 <20230717202938.94989-1-haitao.huang@linux.intel.com>
 <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
 <op.18ah5mn3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <b5779418-e2a4-ca7a-866f-97e49cd272cb@intel.com>
 <op.18aontlmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <eb1aea6f-3688-f871-2335-ff911a51ef52@intel.com>
 <op.18aqz7sbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <op.18aqz7sbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 14:22, Haitao Huang wrote:
> I agree this is the race. But for this to happen, that is at #1 you have
> only one non-SECS page left so #3 can happen. That means it is already
> high pressure 

I think our definitions of memory pressure differ.

Pressure is raised by allocations and dropped by reclaim.  This
raise->drop cycle is (or should be) time-limited and can't take forever.
 The reclaim either works in a short period of time or something dies.
If allocations are transient, pressure is transient.

Let's say a pressure blip (a one-time event) comes along and pages out
that second-to-last page.  That's pretty low pressure.  Years pass.  The
enclave never gets run.  Nothing pages the second-to-last page back in.
A second pressure blip comes along.  The SECS page gets paged out.

That's two pressure blips in, say 10 years.  Is that "high pressure"?

> because reclaimer has swapped all other non-SECS.
> In my example of two enclaves of 5 non-EPC pages. #3 won't happen
> because you don't reach #1 with only one non-SECS left.


