Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF20808B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442707AbjLGPHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbjLGPHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:07:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6CD10D8;
        Thu,  7 Dec 2023 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701961639; x=1733497639;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+GVLoJDm5SxtMSOy2cOPpF18a6NRQbOqGZnFwXI0CXM=;
  b=NqXNXEELO6Prwo1mMqQCes/Xt+rZlNLEmy4lkeTEMF9D4XcCQXGCQNSX
   qYKtUihRfI0UJTsDcKaVnLnZP64Mk054lxjBqpFBeIscvcdvEI+DKnxyO
   RGJuyo0gY7YH+DreAa8Pt9VNVAiWbAtgx3c8wBVSML/edHubFVVihfCht
   IL++lAdDig9sB6bV//b/5uQQyWwCY45uLzS6vbLJn4mgI136+V/kmc3M0
   rZ+NIc57+ef2hlaaMLHqAF3V/ZRwZ1tnZ/Vvo2xMD6iKev7kpB48mL3gf
   obttnbWxdyLifU/tvSZu1E+Hm6LWrlAdnm1JmNfEeVp6/da9Mt1PMVRc8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1123841"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1123841"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 07:05:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="837755629"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="837755629"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 07:05:58 -0800
Received: from [10.212.103.45] (kliang2-mobl1.ccr.corp.intel.com [10.212.103.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C5AC1580D4F;
        Thu,  7 Dec 2023 07:05:55 -0800 (PST)
Message-ID: <a22be949-56fb-4e18-bd5a-5db441fd53df@linux.intel.com>
Date:   Thu, 7 Dec 2023 10:05:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Clean up perf mem
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>, acme@kernel.org,
        irogers@google.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
 <0597b44c-226d-1180-d55d-bcf9bbd2e03f@amd.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <0597b44c-226d-1180-d55d-bcf9bbd2e03f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-07 9:44 a.m., Ravi Bangoria wrote:
>> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
>> etc. But I can only test it on two Intel platforms.
>> Please give it try, if you have machines with other ARCHs.
> 
> I did a quick perf mem and perf c2c test, with the fix I suggested
> in patch #1, and things seems to be working fine.
> 
> [For AMD specific changes]
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks Ravi.

Kan
