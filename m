Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191727CA118
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJPIAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPIAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:00:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCBFA1;
        Mon, 16 Oct 2023 00:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697443198; x=1728979198;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=XYXbGQsgnjt7nQUqln8pZSvBdMQSiZ+wMR4h/e3odww=;
  b=ZEY5Rk6KbsGMGQiKDLoq2+ZV/4A9PNpi9YU9Z7Wi6TcolaYbdzpb8w52
   x7X0jFU04XPdm3rERh4brEKtJwJoVs84ent9jN4HvLjgMtN75V5Ox5f63
   4SkJS1DAKvDfDPEhuwwj1vaoEdJFguki27gwlD52oJcnRaP3DH06A4Vyb
   pHGMNUK0fcM1qgpsOhUllgrDcPWs2Vsa0Jm6fScgarkkDObrTFVKwmUfk
   4NXb/LHNu7f3vDCVz1FKraDKI8CA7utSdvMWHrsvrtrxgignp3BBDj2jH
   t7z1F3MG2wXWtqJfKM3Q3twIoWxVRR2fVNnYgYSMj2UCKFUUaPAIfvGCf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="449677954"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="449677954"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 00:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790721641"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="790721641"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 00:59:56 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, akpm@linux-foundation.org,
        sthanneeru@micron.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted interleaving
References: <20231009204259.875232-1-gregory.price@memverge.com>
Date:   Mon, 16 Oct 2023 15:57:52 +0800
In-Reply-To: <20231009204259.875232-1-gregory.price@memverge.com> (Gregory
        Price's message of "Mon, 9 Oct 2023 16:42:56 -0400")
Message-ID: <87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Price <gourry.memverge@gmail.com> writes:

> v2: change memtier mutex to semaphore
>     add source-node relative weighting
>     add remaining mempolicy integration code
>
> = v2 Notes
>
> Developed in colaboration with original authors to deconflict
> similar efforts to extend mempolicy to take weights directly.
>
> == Mutex to Semaphore change:
>
> The memory tiering subsystem is extended in this patch set to have
> externally available information (weights), and therefore additional
> controls need to be added to ensure values are not changed (or tiers
> changed/added/removed) during various calculations.
>
> Since it is expected that many threads will be accessing this data
> during allocations, a mutex is not appropriate.

IIUC, this is a change for performance.  If so, please show some
performance data.

> Since write-updates (weight changes, hotplug events) are rare events,
> a simple rw semaphore is sufficient.
>
> == Source-node relative weighting:
>
> Tiers can now be weighted differently based on the node requesting
> the weight.  For example CPU-Nodes 0 and 1 may have different weights
> for the same CXL memory tier, because topologically the number of
> NUMA hops is greater (or any other physical topological difference
> resulting in different effective latency or bandwidth values)
>
> 1. Set weights for DDR (tier4) and CXL(teir22) tiers.
>    echo source_node:weight > /path/to/interleave_weight

If source_node is considered, why not consider target_node too?  On a
system with only 1 tier (DRAM), do you want weighted interleaving among
NUMA nodes?  If so, why tie weighted interleaving with memory tiers?
Why not just introduce weighted interleaving for NUMA nodes?

> # Set tier4 weight from node 0 to 85
> echo 0:85 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight
> # Set tier4 weight from node 1 to 65
> echo 1:65 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight
> # Set tier22 weight from node 0 to 15
> echo 0:15 > /sys/devices/virtual/memory_tiering/memory_tier22/interleave_weight
> # Set tier22 weight from node 1 to 10
> echo 1:10 > /sys/devices/virtual/memory_tiering/memory_tier22/interleave_weight

--
Best Regards,
Huang, Ying
