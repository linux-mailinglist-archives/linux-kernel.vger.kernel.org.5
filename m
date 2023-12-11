Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82CC80DA43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbjLKTB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKTB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:01:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE039B;
        Mon, 11 Dec 2023 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702321323; x=1733857323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eGvwdv2hlcRULZdN4mk89Q6qzKrSqlPJ5370hlJU+rg=;
  b=ef/Rd3hORUjH6FrWjy7mSRaThxoV2i5zr9VTwywZI+QT50i1AhJqwI+m
   btzrmjnjYzZQRAW7w8Qr7f7967ZrUOTZKIlXd7LKeoL10fC4bZSiQW8IT
   ePAW5x5DSC0C0sIgjrdcX5Zyqusk96yrgxIWKXYJb1pzbFsTfh2MuRGiO
   74k88IfuxNfxAtHWkW4/aguGRYk8OYTu16n28RozWHi+FvG2oJodLwJ32
   HDfcC6j2Hp6nqPZk2li8fPttwCduOVYCexyEbojugsedjUBcC2C0JMIV3
   +SgQRm1AqbYAk2YGSC2JhEJHkSko8yKzsbkd+zKCHx3cYcwJxbScRyRrB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1840438"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1840438"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:01:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1020352399"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1020352399"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:01:42 -0800
Received: from [10.212.109.181] (kliang2-mobl1.ccr.corp.intel.com [10.212.109.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3C0E0580DA9;
        Mon, 11 Dec 2023 11:01:39 -0800 (PST)
Message-ID: <ee9db34a-2b3d-46b3-ba36-22a22b080d70@linux.intel.com>
Date:   Mon, 11 Dec 2023 14:01:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/5] perf mem: Add mem_events into the supported
 perf_pmu
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-2-kan.liang@linux.intel.com>
 <20231208102922.GB769184@leoy-huanghe.lan>
 <98863f44-4a35-4910-8db0-dbbf0474f6ae@linux.intel.com>
 <20231209063440.GE2116834@leoy-yangtze.lan>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231209063440.GE2116834@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-09 1:34 a.m., Leo Yan wrote:
> Hi Kan,
> 
> On Fri, Dec 08, 2023 at 01:14:28PM -0500, Liang, Kan wrote:
> 
> [...]
> 
>>> Now I cannot access a machine for testing Arm SPE, but I will play
>>> a bit for this patch set to ensure it can pass compilation.  After
>>> that, I will seek Arm maintainers/reviewers help for the test.
>>
>> Thanks. I guess I will hold the v3 until the test is done in case there
>> are other issues found in ARM.
> 
> I will hold on a bit for the test until this patch set addresses the
> concern for the breakage issues on Arm64. Please check my review in
> other replies.

The reviews in the other replies don't look like break any current usage
on Arm64. I think the breakage issue is what you described in this
patch, right?

If we move the check of "arm_spe_0" to arch/arm/util/pmu.c, it seems we
have to move the perf_mem_events_arm[] into arch/arm/util/mem-events.c
as well. Is it OK?

I'm not familiar with ARM and have no idea how those events are
organized under arm64 and arm. Could you please send a fix for the
building failure on aarch64? I will fold it into the V3.

Thanks,
Kan
> 
> Thanks,
> Leo
> 
