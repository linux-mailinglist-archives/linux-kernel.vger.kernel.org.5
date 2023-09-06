Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CCF7934E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbjIFFdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjIFFdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:33:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE17EEA;
        Tue,  5 Sep 2023 22:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693978428; x=1725514428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FZ/m7FomPfXPRk4GBSL1OiQkLTl0EuoMl+30KDzbF/A=;
  b=OIqPB/NLfvEFdCvnoP4gu8cTNelukwZygS8xOUWjbTXtT9hQs6Vas/K9
   laLqe2dmhwHEGK+gW9U+4G/GYgQuU7WS2kyI69aiU4L7n1uAn9a5ZdfkF
   ffw846z6aq+9laGCKCnpkNF3WPm+Z+ADk0VZXzH0UryO7s+UWaJsfCOBR
   2NV5/0RYc+KOx/TW5MjXXrZ2XOovZdXsOwNSXbah7yYmaul+3tFcPc2MG
   ytluHEQjm372gY/heBOzGVfpduwyyB0DvvJbSP1DSUoVVVnwWiLFcM34L
   +6gb6FtfJ+EGUp21f4/K08xRcUev2rDq84jqr39JSC419AVs+sNnRKpdH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="463358044"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="463358044"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 22:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="691177683"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="691177683"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.216.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 22:33:43 -0700
Message-ID: <7035c4ba-2432-2bde-27dc-601b4df74ea7@intel.com>
Date:   Wed, 6 Sep 2023 08:33:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v3] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Sven van Ashbrook <svenva@chromium.org>, ulf.hansson@linaro.org,
        ben.chuang@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>, jason.lai@genesyslogic.com.tw,
        skardach@google.com, Renius Chen <reniuschengl@gmail.com>,
        rafael.j.wysocki@intel.com, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org, SeanHY.chen@genesyslogic.com.tw,
        victor.shih@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20230831160055.v3.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
 <8d88df6b-20c8-cc8e-c08a-e9f09466dc41@intel.com>
 <CAG-rBig796Yc9iyTiLOLt2R9PW9SoOFtuks3a1usu4XwvkzAOQ@mail.gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAG-rBig796Yc9iyTiLOLt2R9PW9SoOFtuks3a1usu4XwvkzAOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/09/23 21:15, Sven van Ashbrook wrote:
> What do we need for Ulf to add this to the maintainer git?

Nothing, it will get processed in due course, likely making it into
one of the 6.6 release candidates, because it is a fix, and from
there to stable.

But right now is the middle of the merge window so some delay can
be expected anyway.

> What do we need for Ulf to add this to the maintainer git? There are
>                                                            There are
> released devices waiting for this fix, but picking from list generates
> lots of paperwork, so I'd prefer to pick from git.
> 
> We have a LGTM from Jason Lai, do we need one from Ben Chuang as well?
> 
> On Mon, Sep 4, 2023 at 3:42 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>

