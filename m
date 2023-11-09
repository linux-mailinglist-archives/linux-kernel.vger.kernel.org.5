Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825507E71E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbjKITHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKITHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:07:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397C030EB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699556829; x=1731092829;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H9NI6TGeJScm7nV2p8FREAmIWZI4G/c9ms9scjZmTUY=;
  b=nqrRfjPMLorYioo4X3/yVKGU2pL9bZG5wqLRllvgplirjyHee4nUYJHI
   P6zJoxYHXjd1UWdWIH40CXJQuqya9BFILxxK8EzUlgIfaNK/RbovmLaG4
   KLZZ6Rew5pkY9E7OP7afaiPVo9CNE1JCa5ePvl5HCOHJ8fxpY3XQliizx
   C/bCB7E5qP1sVgJQMaf2nFYOcBgQuVQi/0j/6VgPPAiELudsO03YKj3WM
   epfSNsumycPUiudJV8F8fUWikizaNvZn3lLQgI9VYS3LkOtuKOg0xPOPq
   BzvfYY5upayeON96xlXbdxK28lPjpIL1j130dKs9eUob1ECYK2rgKxQBK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="421150712"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="421150712"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 11:07:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="854159219"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="854159219"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 11:07:08 -0800
Received: from [10.212.120.254] (kliang2-mobl1.ccr.corp.intel.com [10.212.120.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5B5FB580D4E;
        Thu,  9 Nov 2023 11:07:06 -0800 (PST)
Message-ID: <d142f48c-f1b8-4215-8e2f-b2e3dbeb62a8@linux.intel.com>
Date:   Thu, 9 Nov 2023 14:07:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/8] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK
 flag
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
 <20231025201626.3000228-2-kan.liang@linux.intel.com>
 <ZUlWuROfYcYJlRn4@kernel.org>
 <fb1ebf48-ac2f-499a-b480-ba8474b12200@linux.intel.com>
 <ZUpTtoCzJFHhnSdh@kernel.org> <ZUv+G+w5EvJgQS45@kernel.org>
 <a40ff4eb-5507-45b9-9f21-1d153a544e16@linux.intel.com>
 <ZU0MvXe1GF6xejlf@kernel.org>
 <7243048f-5f45-4f3d-9abb-626568359536@linux.intel.com>
 <ZU0pGuUBJH+bF1yU@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZU0pGuUBJH+bF1yU@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-09 1:46 p.m., Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 09, 2023 at 12:05:27PM -0500, Liang, Kan escreveu:
>> On 2023-11-09 11:45 a.m., Arnaldo Carvalho de Melo wrote:
>>> Em Thu, Nov 09, 2023 at 11:14:31AM -0500, Liang, Kan escreveu:
>>>> The below change should fix it. I will post a complete patch shortly.
> 
>>> Thanks for the quick response, if all that is needed are the checks
>>> below, I'll fold it into your original patch:
> 
>>> 2ae01908298426e4 perf tools: Add branch counter knob
> 
>>> So that we don't regress, ok?
> 
>> Sure.
> 
>> I also post the patch to
>> https://lore.kernel.org/lkml/20231109164007.2037721-1-kan.liang@linux.intel.com/
>> Either folding it or using the new patch is fine for me.
> 
> I folded it, retested, pushed out perf-tools-next.

Thanks!

>  
>> BTW: the new perf test case for the feature is posted here.
>> I think Ian is reviewing it.
>> https://lore.kernel.org/lkml/20231107184020.1497571-1-kan.liang@linux.intel.com/
> 
> Ok, lets wait some more.
> 
> Hey, what is SFR/GRR? Sapphire Rapids/Granite Rapids? I thought about
> testing this somehow, if possible.
> 

Sierra Forest/Grand Ridge. The feature is only available on the E-core
based server for now.

Thanks,
Kan
