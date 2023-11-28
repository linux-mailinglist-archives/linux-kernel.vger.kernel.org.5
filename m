Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491FA7FC23F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345171AbjK1RkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbjK1RkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:40:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694C5D64;
        Tue, 28 Nov 2023 09:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701193213; x=1732729213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nwg4S88oJ6FyLcG9HKMCl3XnJS49yk8sadUfeEszzH0=;
  b=QeQSHW8iSF0MUK2oRFEUw/aj4F3sMBxQRUPD89Da7k5H8/pr7O4XuUmZ
   v7gwu70HeIPMWDvGje+rmGtgnSj0DuOucuIO+2g55WudAeWB6CLn++5LJ
   sESWp+qTce1RCYGnt7FsIL7R/SzotY2gLRxJAWV1Unrx8WIPZeoXbo6sj
   xscEbqGUbxgNh367Uy02yqJkkD3MRlEAkvNAMT+oh3Fq7/n3G+m+wZgIL
   OXfxIvIQhz6Gg8UxeK82ozsP8Li+GgA5zeTXyy23my7ySD/BuT/eGJ8RR
   +sx6Yrp+H41kBbQDIPst6EU4b/mvBqL48YQ0WlmBNRWBwxFXg/kVwCETz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372350016"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="372350016"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:40:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="797647899"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="797647899"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:40:12 -0800
Date:   Tue, 28 Nov 2023 09:40:11 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] x86/split_lock: Make life miserable for split
 lockers
Message-ID: <ZWYl+ymwSRKzD+NL@agluck-desk3>
References: <6bc08e77-812f-4e9e-938a-6a13263ce9d1@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc08e77-812f-4e9e-938a-6a13263ce9d1@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 04:12:24PM +0300, Dan Carpenter wrote:
> Hello Tony Luck,
> 
> The patch b041b525dab9: "x86/split_lock: Make life miserable for
> split lockers" from Mar 10, 2022 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	arch/x86/kernel/cpu/intel.c:1179 split_lock_warn()
> 	warn: sleeping in atomic context
> 
> arch/x86/kernel/cpu/intel.c
>     1158 static void split_lock_warn(unsigned long ip)
>     1159 {
>     1160         struct delayed_work *work;
>     1161         int cpu;
>     1162 
>     1163         if (!current->reported_split_lock)
>     1164                 pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
>     1165                                     current->comm, current->pid, ip);
>     1166         current->reported_split_lock = 1;
>     1167 
>     1168         if (sysctl_sld_mitigate) {
>     1169                 /*
>     1170                  * misery factor #1:
>     1171                  * sleep 10ms before trying to execute split lock.
>     1172                  */
>     1173                 if (msleep_interruptible(10) > 0)
>     1174                         return;
>     1175                 /*
>     1176                  * Misery factor #2:
>     1177                  * only allow one buslocked disabled core at a time.
>     1178                  */
> --> 1179                 if (down_interruptible(&buslock_sem) == -EINTR)
>     1180                         return;
>     1181                 work = &sl_reenable_unlock;
>     1182         } else {
>     1183                 work = &sl_reenable;
>     1184         }
>     1185 
>     1186         cpu = get_cpu();
>     1187         schedule_delayed_work_on(cpu, work, 2);
>     1188 
>     1189         /* Disable split lock detection on this CPU to make progress */
>     1190         sld_update_msr(false);
>     1191         put_cpu();
>     1192 }
> 
> The call tree is:
> 
> kernel_exc_vmm_communication() <- disables preempt
> -> vc_raw_handle_exception()
>    -> vc_forward_exception()
>       -> exc_alignment_check()
>          -> __exc_alignment_check()
>             -> handle_user_split_lock()
>                -> split_lock_warn()
> 
> I think maybe the mismatch is that kernel_exc_vmm_communication() calls
> irqentry_nmi_enter(regs); which disable preemption but exc_alignment_check()
> does local_irq_enable() which doesn't enable it.

I think we need some arch/x86/kernel/sev.c expertise to explain the
preemption requirements in that stack trace. Adding Tom Lendacky.

> Also why does arch/x86 not have a dedicated mailing list?

Good question. X86 was once the default architecture. So everything went to
linux-kernel@vger.kernel.org. I'll add that to Cc: for this. But maybe
it's time for an x86 specific list?

> regards,
> dan carpenter

-Tony
