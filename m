Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346D4771D90
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjHGJxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjHGJxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:53:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC8719AF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691402005; x=1722938005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Nc0sn8jPiREnF0nZ2Y+oxkmuIgHUt8V/8LLT+aoC7E=;
  b=WHjdDH5uwuLiWTK0FnONNhnC59PFlmurZMnbUySim0gKYJ13FY0kFAv9
   fKYuMSUqDga9htDP5grKSodFLIHiwlnwxmvn69FAe4LF9PKYuCV+7dxYh
   egOl0GYLDjc12pGdeK60vYEsMFt0r7KM0QCwkQhTAL7NK7xD2oqiMbZ2P
   igpZ7TKJZvO/Ye5MQqNXzMp7ULMyU4+2f9CDeHuIK6JRZGJJ69HGnd073
   ON1O7RDdH1SqGOTw2syOXFwL61KAkm1bsVAr1l9fBFATtnndMwgaQ8VAb
   QnGgijkPepUnGkAwR3Cq/gIrzeKkZWNrxkSh9CuSWGEpweEwGHI2+HAdA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="374178599"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="374178599"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 02:53:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="760412225"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="760412225"
Received: from aamakine-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.48.92])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 02:53:10 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9747F10A122; Mon,  7 Aug 2023 12:53:07 +0300 (+03)
Date:   Mon, 7 Aug 2023 12:53:07 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 11/12] x86/virt/tdx: Allow SEAMCALL to handle #UD and
 #GP
Message-ID: <20230807095307.l7khgiu5y55pqq22@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <659b10910c206cb4a8de314fcf7cd58814279aa6.1690369495.git.kai.huang@intel.com>
 <20230806114131.2ilofgmxhdaa2u6b@box.shutemov.name>
 <b15b45ff5dc2fcfa08dfb3171c269d9ab0349088.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b15b45ff5dc2fcfa08dfb3171c269d9ab0349088.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:14:37AM +0000, Huang, Kai wrote:
> On Sun, 2023-08-06 at 14:41 +0300, kirill.shutemov@linux.intel.com wrote:
> > On Wed, Jul 26, 2023 at 11:25:13PM +1200, Kai Huang wrote:
> > > @@ -20,6 +21,9 @@
> > >  #define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
> > >  #define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _UL(0xFFFF0000))
> > >  
> > > +#define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
> > > +#define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
> > 
> > Is there any explantion how these error codes got chosen? Looks very
> > arbitrary and may collide with other error codes in the future.
> > 
> 
> Any error code has TDX_SW_ERROR is reserved to software use so the TDX module
> can never return any error code which conflicts with those software ones.
> 
> For why to choose these two, I believe XOR the TRAP number to TDX_SW_ERROR is
> the simplest way to achieve: 1) costing minimal assembly code; 2)
> opportunistically handling #GP too, allowing caller to distinguish the two
> errors.

My problem is that it is going to conflict with errno-based errors if we
going to take this path in the future. Like these errors are the same as
(TDX_SW_ERROR | EACCES) and (TDX_SW_ERROR | ENXIO) respectively.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
