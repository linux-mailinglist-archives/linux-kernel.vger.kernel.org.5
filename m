Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFD0755BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGQGco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjGQGcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:32:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE2CD9;
        Sun, 16 Jul 2023 23:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689575562; x=1721111562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UIvScjBMq2tJ7obc7FO/ZTmBFLS/+sEbi6AjYJ3oqcc=;
  b=BT/9+IXhbgKgcCBzQy6mYEkMXdirLWUm5Ya6iv46LOb7zqr7u/8Ow33c
   k3Fu3ZGWAV0R+uFE5IcNxzKiORB9hXy/40hkOPotLGlb0sZAbnLtUxU9P
   uVpklhfVZkVfbsgfBIN8srS7by6ZZL50whXKWeNGrfL/FAV+Z6kn/OQTr
   OzbezQAfpc7A3OFquHML5ZyQt04GqzHOMun7PQ3X3ZWTJcJPMJdrUsU9S
   BaXYtewzNhqRSyIERskt6VYh3alCGMXSMbTXrBTT4UwOFhZ0iabj/dwof
   VQiace8CR+dHfvhHo1bm8z+I8dOMCIKZSDWw6nM2al1suKn1UBFPTN9bk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="350721120"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="350721120"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 23:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="788532240"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="788532240"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.54]) ([10.13.12.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 23:32:36 -0700
Message-ID: <68dcdf3c-226c-9a94-0860-68c6d4b8ca0e@linux.intel.com>
Date:   Mon, 17 Jul 2023 09:32:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH net v3] igc: Prevent garbled TX queue
 with XDP ZEROCOPY
Content-Language: en-US
To:     Florian Kauer <florian.kauer@linutronix.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vedang Patel <vedang.patel@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Andre Guedes <andre.guedes@intel.com>,
        Simon Horman <simon.horman@corigine.com>
Cc:     netdev@vger.kernel.org, kurt@linutronix.de,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <20230630120306.8534-1-florian.kauer@linutronix.de>
From:   "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230630120306.8534-1-florian.kauer@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/2023 15:03, Florian Kauer wrote:
> In normal operation, each populated queue item has
> next_to_watch pointing to the last TX desc of the packet,
> while each cleaned item has it set to 0. In particular,
> next_to_use that points to the next (necessarily clean)
> item to use has next_to_watch set to 0.
> 
> When the TX queue is used both by an application using
> AF_XDP with ZEROCOPY as well as a second non-XDP application
> generating high traffic, the queue pointers can get in
> an invalid state where next_to_use points to an item
> where next_to_watch is NOT set to 0.
> 
> However, the implementation assumes at several places
> that this is never the case, so if it does hold,
> bad things happen. In particular, within the loop inside
> of igc_clean_tx_irq(), next_to_clean can overtake next_to_use.
> Finally, this prevents any further transmission via
> this queue and it never gets unblocked or signaled.
> Secondly, if the queue is in this garbled state,
> the inner loop of igc_clean_tx_ring() will never terminate,
> completely hogging a CPU core.
> 
> The reason is that igc_xdp_xmit_zc() reads next_to_use
> before acquiring the lock, and writing it back
> (potentially unmodified) later. If it got modified
> before locking, the outdated next_to_use is written
> pointing to an item that was already used elsewhere
> (and thus next_to_watch got written).
> 
> Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
> 
> v2 -> v3:
> Resolve merge conflict
> 
> v1 -> v2:
> I added some more context for further clarification,
> but it is also just how I interpret the code.
> Also the typo is fixed and it is reverse christmas again 😉
> 
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
