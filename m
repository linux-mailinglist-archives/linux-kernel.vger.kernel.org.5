Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB97AEE94
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjIZOOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjIZOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:14:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AA2CE;
        Tue, 26 Sep 2023 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695737680; x=1727273680;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k7XtlASmDnnjF+7xnuTUiyTCq8kFu7NuFwlO8H4r+XA=;
  b=nh3L7QqVUm0LQ/O1Mq+j2QwRaMa3btW4FDapH4nMggUE6I1TKJ+wu01x
   97bLLDPIkvBj8/uFIbKlBYwq6qvpAEfzzmd+U62ZcH+9iht53lPaVirTx
   HfwU+Zrzv0yLD/9e45CxQi4nTAwpuGWyuP64LGXNoDVk4lEPnt22epQ8I
   VYfLDGZWWriBHDeXK0yUTJzREQtolV08Q7+1yxcn6VpqJvNneYnlQiecI
   vhYNqZGyl/mdorb8XsigewzP5sE982ChTtJwvNl77b7Ui9vzLYOJTujXM
   9LphdOeKOfyagIRZV+EygnIxF4t4lKQsAWmHUGHKWDDGdzlmBJSPxzLH4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381472363"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="381472363"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="742377564"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="742377564"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.130.254])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:09:43 -0700
Date:   Tue, 26 Sep 2023 16:09:38 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 2/2] md: simplify md_seq_ops
Message-ID: <20230926160938.00001b1c@linux.intel.com>
In-Reply-To: <20230926025827.671407-3-yukuai1@huaweicloud.com>
References: <20230926025827.671407-1-yukuai1@huaweicloud.com>
        <20230926025827.671407-3-yukuai1@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 10:58:27 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> Before this patch, the implementation is hacky and hard to understand:
> 
> 1) md_seq_start set pos to 1;
> 2) md_seq_show found pos is 1, then print Personalities;
> 3) md_seq_next found pos is 1, then it update pos to the first mddev;
> 4) md_seq_show found pos is not 1 or 2, show mddev;
> 5) md_seq_next found pos is not 1 or 2, update pos to next mddev;
> 6) loop 4-5 until the last mddev, then md_seq_next update pos to 2;
> 7) md_seq_show found pos is 2, then print unused devices;
> 8) md_seq_next found pos is 2, stop;
> 
> This patch remove the magic value and use seq_list_start/next/stop()
> directly, and move printing "Personalities" to md_sep_start(),
> "unsed devices" to md_seq_stop():

Typo md_sep_start()
> 
> 1) md_seq_start print Personalities, and then set pos to first mddev;
> 2) md_seq_show show mddev;
> 3) md_seq_next update pos to next mddev;
> 4) loop 2-3 until the last mddev;
> 5) md_seq_stop print unsed devices;
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
LGTM. Nice one. Code looks much better now.

Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
