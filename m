Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5D0790146
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbjIARSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjIARSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:18:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F7F10EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693588701; x=1725124701;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=naeX2Jibq59v8eiSFU2HPolvULX1+/NaGPMxwNE7s3k=;
  b=UFAlvDeAVLROjClJrJl+O4uTYZ6tZZYOTtMe67nQ23mPFcYlMtG5BgoI
   17rmqP8bGKeMQswmVsTBMAYrTN1aiJwjtzLSKw2XnKgLJCGcQcU4n0WmQ
   XchLV3gSGmTbUx3LZO7Wu6EsAzeKLgTHJ6lvbW/SfsLin3o3uqMsTK73q
   j5HruBHdQ0hEBYYqJmXZn1NRIQbvDERlsK+oxuNrfpwK6dvm2Gw7p+zuo
   2hBHaLd82Zw4NFLYHLx6JyjK26xZPydl13Hn5MJjGyJc+ZS0rNxJKz6SJ
   e5a4yqSsRyuGA9wUFmbU305RGfmF67foXz0Gkvqb9gXPZCyu3H40YDgb3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440237999"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="440237999"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 10:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="769259566"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="769259566"
Received: from dpiercy-mobl.amr.corp.intel.com (HELO [10.209.42.233]) ([10.209.42.233])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 10:18:20 -0700
Message-ID: <ad1ff365-4160-87b9-4199-ace5ff1250e1@intel.com>
Date:   Fri, 1 Sep 2023 10:18:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/platform/uv: Use alternate source for socket to node
 data
Content-Language: en-US
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20230807141730.1117278-1-steve.wahl@hpe.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230807141730.1117278-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 07:17, Steve Wahl wrote:
> When nr_cpus is set to a smaller number than actually present, the
> cpu_to_node() mapping information for unused CPUs is not available to
> build_socket_tables().  This results in an incomplete table and will
> later cause use of a -1 value for some array indexing, and eventual
> kernel page faults.
> 
> Switch to using the __apicid_to_node array, which still contains all
> the information mapping apicids to nodes, even for CPUs disabled with
> a reduced nr_cpus setting.

Before, the lookup went:

	CPU => APICID => SOCKET

But when the CPU wasn't present, there wasn't a way to start this lookup.

So, instead of looping over all CPUs, looking up their APICIDs and
mapping those to sockets, just take CPUs out of the equation entirely.

Loop over all APICIDs which are mapped to a valid NUMA node.  Then just
extract the socket-id from the APICID.

Right?

That seems sane enough.  It's also way less code than the previous approach.
