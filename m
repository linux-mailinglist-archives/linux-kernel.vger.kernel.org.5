Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557A57941D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbjIFRDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242163AbjIFRDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:03:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22CE199B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694019790; x=1725555790;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sSnAZ5tzb4efyEc4PN+Wa/OSCcQnYXksqDJ2OYcdwIY=;
  b=PECl+1Kq4ZZJdINjhdkXrJ9Rx/S7us7UT4m097qYaa8YH7LmZdqaT7+i
   5G1R3qOpney7vh1a1tu8KhoGBc15L5pwwgKbH3ZPs3Lkfuvd8dIzNFFty
   zYiEdxTKzIr/tkZ9hCUeMhFP+l3R9WlBJEogwcDvRBPK6jh1iNcI38JPD
   RNGpyZCrLM03gNI8iZxZuGtL9CC2ALEoqEyhgqPfoXcYEEM9wHCkHjnIE
   BG/2ZbfnQmhs210PRCZde7/rPU1XjecdPW8geiQElpcCPUVHebBxeJPou
   uQURRekvKC9Oq3WmeQDTZb8yAHUMsTKztRYI95mxdf84ET9an9k4owsYr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="377038784"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="377038784"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 10:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="718332117"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="718332117"
Received: from lmgabald-mobl2.amr.corp.intel.com (HELO [10.212.242.149]) ([10.212.242.149])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 10:01:20 -0700
Message-ID: <2114d5c0-3903-f4be-795b-829c3a1e5f9f@intel.com>
Date:   Wed, 6 Sep 2023 10:01:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] x86: Remove the arch_calc_vm_prot_bits() macro from
 the uapi
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Nicolas Schier <nicolas@fjasle.eu>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
References: <20230906162658.142511-1-thuth@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230906162658.142511-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 09:26, Thomas Huth wrote:
> The arch_calc_vm_prot_bits() macro uses VM_PKEY_BIT0 etc. which are
> not part of the uapi, so the macro is completely useless for userspace.
> It is also hidden behind the CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> config switch which we shouldn't expose to userspace. Thus let's move
> this macro into a new internal header instead.
> 
> Fixes: 8f62c883222c ("x86/mm/pkeys: Add arch-specific VMA protection bits")
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Gah, sorry this got dropped.  I went to go throw it in my review queue
and saw your last version in there.  I plan to apply it (this time)
shortly after we see -rc1.

In any case:

Acked-by: Dave Hansen <dave.hansen@intel.com>
