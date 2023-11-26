Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66197F93CF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 17:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjKZQcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 11:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 11:32:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20FE3;
        Sun, 26 Nov 2023 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701016341; x=1732552341;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=C1szmEvCxxp64F0iuaAQ1E2knC5KLnUYXFCFe3nV1KE=;
  b=Af+UlocVkTSShDLcOqH+0uPkMMSYGUT7uX1irolSvU5z9rp6qUjSh3Ae
   4yRFA1Yy/tfC2BsN4cK8xmdfWmmbwJeIzy8jVH1OoJ+sQH7jjVR+JG909
   I2zt80PmbKi8orFeCdGoneMAfRMEic5RLjvV08dgkZPmjv+qcUhXETwsQ
   t1ehA+QUQ61tGWQPtR3SaQB7fU33VqqwI8ZtGCn00gW+T58hepUOf1mZ1
   x4fcz5zGmTp/mYIghGQXhkTCAXFfQwT/R9ixJMITyXNulM19XgfzITaf3
   DM0kpI2SRtEwrhFa5dqpSSXNkCjoTIO75t6dHRPJFpHUktlq+2mbgwM4+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="377624607"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="377624607"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 08:32:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="9407085"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.124.112.56])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Nov 2023 08:32:16 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "tj@kernel.org" <tj@kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mkoutny@suse.com" <mkoutny@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>,
        "Haitao Huang" <haitao.huang@linux.intel.com>
Cc:     "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-5-haitao.huang@linux.intel.com>
 <ad7aafb88e45e5176d15eedea60695e104d24751.camel@intel.com>
 <op.2dz4d5b2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <34a337b96a5a917612c4ec4eff2b5a378c21879b.camel@intel.com>
 <op.2d0ltsxxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <op.2d0n8tjtwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <d9ad4bac3ac51fe2e8d14931054f681a8264622c.camel@intel.com>
 <op.2e0xhigjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Date:   Mon, 27 Nov 2023 00:32:14 +0800
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2e0yv0bnwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2e0xhigjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 00:01:56 +0800, Haitao Huang  
<haitao.huang@linux.intel.com> wrote:
>>> > > > > Then here we can have something like:
>>> > > > >
>>> > > > > 	void sgx_reclaim_pages(struct sgx_epc_cg *epc_cg)
>>> > > > > 	{
>>> > > > > 		struct sgx_epc_lru_list *lru =			epc_cg ? &epc_cg->lru :
>>> > > > > &sgx_global_lru;
>>> > > > >
>>> > > > > 		sgx_reclaim_pages_lru(lru);
>>> > > > > 	}
>>> > > > >
>>> > > > > Makes sense?
>>> > > > >
>
> The reason we 'isolate' first then do real 'reclaim' is that the actual  
> reclaim is expensive and especially for eblock, etrack, etc.
Sorry this is out of context. It was meant to be in the other response for  
patch 9/12.

Also FYI I'm traveling for a vacation and email access may be sporadic.

BR
Haitao
