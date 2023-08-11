Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD1D77892E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjHKItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHKItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:49:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5443213B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691743745; x=1723279745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ai/YRh3QCC1guJLDMJwEqRgAl522bXGJHEYxxtVq6/0=;
  b=ABp/DIfBrLwpD1irtuAwQRFVHHhTepSaRKuYZm5OvUU6F5Beo3fqrnzU
   kf8X1i4KTRcVsFCVaAh9bINEJnDwHyfPxRqHpi4DDC+hm62miwmKzj653
   F9j+qK1FmbTy7RS3W6XOiqDYPI/QfKnCapROOh9bun0Mgy0T4d5V7OaF9
   UFZCr1c7cvGDGOnvLkQorkUA5r2YmjOVLLcpbg1Nm7eTafAnaF+JezRXn
   gA7/SZFd4W4tnbtiPK9cchja06AKawSNR/8jaM1LnaARAXmbKJwGWjMIq
   usykeDIfM6EB5vFFGX//5OZH+nL7JCBdZvObYDcGm761/TFX3avNxCW0J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="402604851"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="402604851"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 01:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="732595957"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="732595957"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2023 01:48:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUNpI-007C1z-0j;
        Fri, 11 Aug 2023 11:48:56 +0300
Date:   Fri, 11 Aug 2023 11:48:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Lafreniere <peter@n8pjl.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        shiju.jose@huawei.com, jonathan.cameron@huawei.com,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/4] numa: generalize numa_map_to_online_node()
Message-ID: <ZNX19zqIDlB3pYHw@smile.fi.intel.com>
References: <20230810162442.9863-1-yury.norov@gmail.com>
 <20230810162442.9863-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810162442.9863-2-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:24:39AM -0700, Yury Norov wrote:
> The function is in fact searches for the nearest node for a given one,
> based on a N_ONLINE state. This is a common pattern to search for a
> nearest node.
> 
> This patch converts numa_map_to_online_node(node) to
> numa_nearest_node(node, state), so that others won't need opencode the
> logic.

> The following patches apply it where applicable.

Doesn't sound like should be part of the commit message.

-- 
With Best Regards,
Andy Shevchenko


