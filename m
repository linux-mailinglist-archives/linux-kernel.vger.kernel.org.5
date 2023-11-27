Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771C17FAC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjK0VJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjK0VJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:09:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CBC1B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701119383; x=1732655383;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=10W0PaqCPrznnGcNMkRCZKFtSsqKmFSoUVQNEMqT+QM=;
  b=eu2JitOyNneSwDuhqF7aXoldqWZ3oUAJhiBKUrs/oIM6jSzTY30mSLDV
   4cM/pjzfr2agi0rMp8XCeeDtglRaAKi/ddvTLYlJ8n/JGeewxbuawAFpj
   gXGlguO+1QOiZULK6A9nIVKz6eijGG78xaxpKXoQmLJ4GYngZogLYHHqx
   vhZvm6ZuLRsKoH6EBWHGOIJBg2U0I/YXiasUP8t+PWn/g/W2rukoTLill
   24xMDBJtQf9AjaJXkub7qIKJnKjxtCXZAO64Rk7qV1QP57qhfCTvTEi4y
   3nz/pwuAzsnqx88tiND7RVxd29FXjBW9yScccmqKrkkOZZazsmuukCYhp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="423939907"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="423939907"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 13:09:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="886176561"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="886176561"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 13:09:43 -0800
Received: from [10.209.158.65] (kliang2-mobl1.ccr.corp.intel.com [10.209.158.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1FC32580AA7;
        Mon, 27 Nov 2023 13:09:42 -0800 (PST)
Message-ID: <04967d96-cc03-4751-91f2-9f1ff80c6860@linux.intel.com>
Date:   Mon, 27 Nov 2023 16:09:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix NULL pointer dereference issue during
 discovering UPI topology
Content-Language: en-US
To:     alexander.antonov@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kyle.meyer@hpe.com, alexey.v.bayduraev@linux.intel.com
References: <20231127185246.2371939-1-alexander.antonov@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231127185246.2371939-1-alexander.antonov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-27 1:52 p.m., alexander.antonov@linux.intel.com wrote:
> From: Alexander Antonov <alexander.antonov@linux.intel.com>
> 
> The NULL dereference happens inside upi_fill_topology() procedure in
> case of disabling one of the sockets on the system.
> 
> For example, if you disable the 2nd socket on a 4-socket system then
> uncore_max_dies() returns 3 and inside pmu_alloc_topology() memory will
> be allocated only for 3 sockets and stored in type->topology.
> In discover_upi_topology() memory is accessed by socket id from CPUNODEID
> registers which contain physical ids (from 0 to 3) and on the line:
> 
>     upi = &type->topology[nid][idx];
> 
> out-of-bound access will happen and the 'upi' pointer will be passed to
> upi_fill_topology() where it will be dereferenced.
> 
> To avoid this issue update the code to convert physical socket id to
> logical socket id in discover_upi_topology() before accessing memory.
> 
> Changed in v2:
>  1. Factor out topology_gidnid_map() with common code for GIDNIDMAP procedure
> 
> Alexander Antonov (2):
>   perf/x86/intel/uncore: Fix NULL pointer dereference issue in
>     upi_fill_topology()
>   perf/x86/intel/uncore: Factor out topology_gidnid_map()

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> 
>  arch/x86/events/intel/uncore_snbep.c | 71 ++++++++++++++++------------
>  1 file changed, 40 insertions(+), 31 deletions(-)
> 
