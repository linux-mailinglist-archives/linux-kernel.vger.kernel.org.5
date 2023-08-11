Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322517791B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjHKOUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjHKOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:20:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2175D1994
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691763606; x=1723299606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n17uTn0Xv8VtuvUJndrciitPNhnW3//Vu5LFicJDa7Y=;
  b=dSvbp5xXgrMZsHjqn2w3lIzdFiVj1S+CQ3BPli48AFYiIc+ZLofIktPM
   2a4f2yyZB8aPRedoYtO8l0TRMeKNUZfk7K57XJjPgXXDRQIY50wKzTnmM
   C98jbJB7hz74/zltz+Muzug08T/fIVG3nLo0TReK7G0zqjwC7nqTKnjIB
   wdrV/JVVEAzf8puHOCRfIUNtaAO6kgW+JOJxNzgCeWFZFXUekGmTnm56g
   GqdTtEWyGap52WZL9AWVEHcx+Syp2mVOuzGrrVsmQF6RQjOJtPpRz0Vxa
   UijVa6rE3mYv4np63ZH3pekYH8+0x+rOltUFlUouMLstdHTwVYor5MySh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="374455653"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="374455653"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="709546588"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="709546588"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.9.154]) ([10.209.9.154])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:20:05 -0700
Message-ID: <c565b5a1-df02-8dfb-e93b-fa72254c896c@linux.intel.com>
Date:   Fri, 11 Aug 2023 07:20:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [patch 29/30] x86/microcode: Prepare for minimal revision check
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ashok Raj <ashok.raj@intel.com>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.617422055@linutronix.de>
 <20230810205427.GG212435@hirez.programming.kicks-ass.net>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20230810205427.GG212435@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/2023 1:54 PM, Peter Zijlstra wrote:
> On Thu, Aug 10, 2023 at 08:38:09PM +0200, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> Applying microcode late can be fatal for the running kernel when the update
>> changes functionality which is in use already in a non-compatible way,
>> e.g. by removing a CPUID bit.
> 
> This includes all compatibility constraints? Because IIRC we've also had
> trouble because a CPUID bit got set. Kernel didn't know about, didn't

do you have the details on that -- I don't know of any of those outside
of enumerating the sidechannel status cpuid bits.

> manage it, but userspace saw the bit and happily tried to use it.

yes it contains all the compatibility constraints the OS folks (e.g. the intel kernel folks)
could convey to the microcode team. If you think the constraints are
not complete please help us improve them

> 
> Ofc I can't remember the exact case :/ but anything that changes the
> xsave size/state would obviously cause trouble.

of course that cant' happen at runtime at all correctly.
> 

