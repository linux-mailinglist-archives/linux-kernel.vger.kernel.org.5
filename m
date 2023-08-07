Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8657727B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjHGO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjHGO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:28:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943CCAA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691418530; x=1722954530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lke8VT2agr4rZBXVU4jAHFn8EcNRHUeE5k8V2uYsJoQ=;
  b=TrzjhPxEqluOnAzv9DAMP2r/xoLOko5PclNXe5+MpKK3iHt9WBkCg5ja
   WxIq7BGyOl8zkuPH+NWhiTmg5BvU33SsWeMwG7lWA+SbCtBnlF1Jt+uf6
   HAUDAlMsuMjkN4DdGEBt4pmoz6zzjZnVre2yIWPEJnZv15EQhFh2aiQF3
   5wsR03Q0RxKRaTNlb6JwAQMngEw5EFXmUPz9hPoywww4gy9zhiDhHtgnJ
   wwk1JsaQkeGfiAjPs9ZthatVjXfUh7+f7qvJp6evB06QyXqLoACJ+tWmO
   dJqjT66eo9/yQXJkn1Ogi1HTPO6fgbnNfEGoYaSvaERuqPTWU2XcKCYvd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350148637"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="350148637"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="730975995"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="730975995"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.212.128.186]) ([10.212.128.186])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:28:48 -0700
Message-ID: <c21f9f42-d270-d9be-b94e-de4d4b6e5ad5@linux.intel.com>
Date:   Mon, 7 Aug 2023 07:28:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 02/53] x86/cpu/topology: Make the APIC mismatch warnings
 complete
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
References: <20230807130108.853357011@linutronix.de>
 <20230807135026.528433010@linutronix.de>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20230807135026.528433010@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/2023 6:52 AM, T
>   
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -176,6 +176,16 @@ void cpu_parse_topology(struct cpuinfo_x
>   
>   	parse_topology(&tscan, false);
>   
> +	if (c->topo.initial_apicid != c->topo.apicid) {
> +		pr_err(FW_BUG "CPU%4u: APIC ID mismatch. CPUID: 0x%04x APIC: 0x%04x\n",
> +		       cpu, c->topo.initial_apicid, c->topo.apicid);
> +	}
> +
> +	if (c->topo.apicid != cpuid_to_apicid[cpu]) {
> +		pr_err(FW_BUG "CPU%4u: APIC ID mismatch. Firmware: 0x%04x APIC: 0x%04x\n",
> +		       cpu, cpuid_to_apicid[cpu], c->topo.apicid);
> +	}
> +

while these messages are basically the same as current ones they are short one key thing for the user
... which one of the two will be used. Yes one can look up in the source code where the message comes from
and reverse engineer that... or we can just add this to these pr_err() messages


like

pr_err(FW_BUG "CPU%4u: APIC ID mismatch. CPUID: 0x%04x APIC: 0x%04x. APIC value will be used.\n",
		       cpu, c->topo.initial_apicid, c->topo.apicid);


>   	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++) {
>   		if (tscan.dom_shifts[dom] == x86_topo_system.dom_shifts[dom])
>   			continue;
> 

