Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3867A9B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjIUSyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjIUSxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:53:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6386AA0C35
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695319057; x=1726855057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gjbxdq8y7aaWf3VCG1U9ZSnRf6AqDBw7U6aKAbhuAO4=;
  b=i0xMm4axsfilJQX1hcCklN9UC1wxkDj9yKTqQH8hvU6mfDiQbvrs0Yag
   qNll2vOohFqSf/5x2jJzq8eGapCZ2YDfYRYmfvKp8WiYt3PMWmcYYwi9Y
   51I1IdMuuHx+lrKtB7qh0GHf8PmvgOQHdr8QLafF57+tWGTVRwD8SuM0D
   3wF9admjE2EZCCIz+Rp42/k0rJlDQgqvmUs259Ep858pDL9VrrsTi0Enj
   P2psue8UNyfFEBJ8qPpeH9KC1hLFQgCYid4qvUvGFLS4axFeQ2XGnFXXF
   5xxDo33ahZ/hxMY6YQ4DjOJfz2WYKr38x8/pm+aem+JLiMBXLV15Mi48i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383341226"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="383341226"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 09:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="696820646"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="696820646"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 09:52:37 -0700
Date:   Thu, 21 Sep 2023 09:52:36 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Yi Sun <yi.sun@intel.com>, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        sohil.mehta@intel.com, ilpo.jarvinen@linux.intel.com,
        heng.su@intel.com, tony.luck@intel.com, yi.sun@linux.intel.com,
        yu.c.chen@intel.com
Subject: Re: [PATCH v7 1/3] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Message-ID: <ZQx01AfyvbJQYPsi@tassilo>
References: <20230921062900.864679-1-yi.sun@intel.com>
 <20230921062900.864679-2-yi.sun@intel.com>
 <ZQvqvpSbyub6gFZX@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQvqvpSbyub6gFZX@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems unnecessarily complex: why does it have to measure latency 
> directly? Tracepoints *by default* come with event timestamps. A latency 
> measurement tool should be able to subtract two timestamps to extract the 
> latency between two tracepoints...
> 
> In fact, function tracing is enabled on all major Linux distros:
> 
>   kepler:~/tip> grep FUNCTION_TRACER /boot/config-6.2.0-33-generic 
>   CONFIG_HAVE_FUNCTION_TRACER=y
>   CONFIG_FUNCTION_TRACER=y
> 
> Why not just enable function tracing for the affected FPU context switching 
> functions?

Or use PT address filters to get it even accurately, as described
in [1]. In any case I agree the trace points are not needed.

-Andi

[1] https://lore.kernel.org/lkml/ZPOIVmC6aY9GBtdJ@tassilo/
