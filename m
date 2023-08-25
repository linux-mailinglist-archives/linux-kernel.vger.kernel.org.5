Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E499789250
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjHYX0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjHYX0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:26:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F442109
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693005964; x=1724541964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uIO2nmadjQYDMvj67tCdTbQsVnSWfYe33GKKzmnOTvg=;
  b=RMiCgsG+OXHmuLWK8+VJrdGVc+VF3zFu8tBX81CPuo8vW0wrev2qPdtj
   9uzA4OqYOE+f1J9vysci/N5nO16G28X5ph7nFNqPuTFUqRoFgg3h87dtZ
   bIDZv2yUnbVIrcbJvYptMmcDk4r3z3PzPYvdLMFKs+GFAQuHeyCSFUZa3
   obv8Fgcy2IeiXAVcoPlzUAH8jLCpaGcPbpQ5FXv9dYXqzNRHuHhUS3MSW
   1Us9QXt/RmQbWTELWVkCmg8sBmOOZb6WLXsbNgvXx+5iTv0hzkoSVyJv4
   kSiSceKTjLstnf3OZLAmy76JuOh3QoujPAO9fQGOuQ0P392xV7nbPs/3p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="355155421"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="355155421"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:26:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="852144174"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="852144174"
Received: from naikshri-mobl7.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.41.113])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:26:00 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 38BA3109FED; Sat, 26 Aug 2023 02:25:58 +0300 (+03)
Date:   Sat, 26 Aug 2023 02:25:58 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v4 02/12] x86/tdx: Skip saving output regs when SEAMCALL
 fails with VMFailInvalid
Message-ID: <20230825232558.wxdrsnomokpqykw2@box>
References: <cover.1692096753.git.kai.huang@intel.com>
 <704088f5b4d72c7e24084f7f15bd1ac5005b7213.1692096753.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <704088f5b4d72c7e24084f7f15bd1ac5005b7213.1692096753.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:01:56PM +1200, Kai Huang wrote:
> If SEAMCALL fails with VMFailInvalid, the SEAM software (e.g., the TDX
> module) won't have chance to set any output register.  Skip saving the
> output registers to the structure in this case.
> 
> Also, as '.Lno_output_struct' is the very last symbol before RET, rename
> it to '.Lout' to make it short.
> 
> Opportunistically make the asm directives unindented.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
