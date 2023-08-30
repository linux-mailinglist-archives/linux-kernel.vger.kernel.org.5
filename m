Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A8C78E0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbjH3UaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240571AbjH3U3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:29:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3405A813B1;
        Wed, 30 Aug 2023 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693424298; x=1724960298;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=AJ3HcgOEMdGaxD6ckht/79+NbXli1Xb4U4idLGp5F08=;
  b=GylPcb34+V5PLcrSZF4T/uzb5Ht4/3x+rqjogAe6jBkt9yMg/iTU6P/A
   3s839Nh8EuH4Znqe7ywxntb4G5CdtcL6ov8VUHhd4Bv3pa6ljId7u29wF
   Llq4PpyrjMafIzEeB9YEQnHXTjJ9vbiJpQM0mOIBDPRZGUtCxbWx0EmVJ
   JF9e1uiKxubY2LUukEkoGOD0RptT1t2hrvEn7R+0scqrC5wP7kbBf11fb
   Ln2k8gTZbjUKIxcFP5poyoktBrE1+oVNXKbRAEjkVf/kMLXajqmQAF/TD
   r1WA4b+L0Sa+5aYdvBiEmDZgNTvlp8gOsqjUXE9Uzo4aU4W8CUOVRrQLX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="365937678"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="365937678"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 12:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="768517898"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="768517898"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2023 12:35:00 -0700
Received: from [10.212.2.57] (kliang2-mobl1.ccr.corp.intel.com [10.212.2.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 41997580C73;
        Wed, 30 Aug 2023 12:34:58 -0700 (PDT)
Message-ID: <127766c6-033c-dedb-2c56-7e1e7f8bd01b@linux.intel.com>
Date:   Wed, 30 Aug 2023 15:34:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/3] perf parse-events: Make common term list to strbuf
 helper
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230830070753.1821629-1-irogers@google.com>
 <20230830070753.1821629-2-irogers@google.com>
 <4de84370-29f3-75ed-9c91-330636cdd790@linux.intel.com>
 <CAP-5=fXMgeER2FkAF2jZOAP0c=sxqhU8scxew6jXQrEYjN_S=Q@mail.gmail.com>
 <CAP-5=fUXG9tfN2nahiVpBDiggkhmhFiBZYubCSN6vG4voJ_X2A@mail.gmail.com>
 <b976ef43-25ea-f24a-2c22-0976fafcf0f0@linux.intel.com>
Content-Language: en-US
In-Reply-To: <b976ef43-25ea-f24a-2c22-0976fafcf0f0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-30 2:29 p.m., Liang, Kan wrote:
>> The problem
>> is how we encode terms of an event name, it is indistinguishable when
>> the of the user field is 1. I'll probably add something to fix this
>> later, but it only impacts debug output and perf list, so I'm not
>> overly worried. 
> It should be OK for the debug output.
>

Not just the debug output. It also impacts the perf list --detail.

With the patch,
perf list --detail | grep uops_retired.heavy -A 2
  uops_retired.heavy
       [Retired uops except the last uop of each instruction. Unit:
cpu_core]
        cpu_core/event=0xc2,period=0x1e8483,umask/

Without the patch,
perf list --detail | grep uops_retired.heavy -A 2
  uops_retired.heavy
       [Retired uops except the last uop of each instruction. Unit:
cpu_core]
        cpu_core/event=0xc2,period=0x1e8483,umask=0x1/

Thanks,
Kan



