Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21BD771485
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 13:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHFL3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 07:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFL3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 07:29:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7D219C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691321362; x=1722857362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aENVWZ73ERq0TGITJrWWJ182YhToB6F3dDeQsx9B4sQ=;
  b=U1NyIg2ufEE+H9A7oN4vLRJB7AUStpsuPKNQrH5abuN95MHHMcKILdLE
   IxCYtgvVAWySUe9QFxr1rnWqlSrz/U+JKAz3Cn/dFVn9DyZqONVLm9pvA
   LfxmzHvn5Y+FFUUqm/7sLJYHEJKDYTmIGHx0VAEo7zghzcR5W/j7n+0Uq
   VYy/rXj98t8I1tCN6/tIGblDi8uNc5H48W23TL1XVTju/beOFyhm6lkef
   IUd2qdYDO23LG/giA+8CgUa1za1FEvys7IwbHb8BE0N4WoSB3gb5bLrWv
   SMG+jt+FC93iTvSiWkW+/pCeNOozt6gKib739XfrOo+TQrw12o17J5p8a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="369281380"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="369281380"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 04:29:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="707516685"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="707516685"
Received: from mvalka-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.63.122])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 04:29:18 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 753B010A117; Sun,  6 Aug 2023 14:29:15 +0300 (+03)
Date:   Sun, 6 Aug 2023 14:29:15 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 09/12] x86/tdx: Remove 'struct tdx_hypercall_args'
Message-ID: <20230806112915.pwolxzaz6tdteol5@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <9f0bca72a8d87a286faf32c9e306954028bbb9f6.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f0bca72a8d87a286faf32c9e306954028bbb9f6.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:11PM +1200, Kai Huang wrote:
> Now 'struct tdx_hypercall_args' is basically 'struct tdx_module_args'
> minus RCX.  Although from __tdx_hypercall()'s perspective RCX isn't
> used as shared register thus not part of input/output registers, it's
> not worth to have a separate structure just due to one register.
> 
> Remove the 'struct tdx_hypercall_args' and use 'struct tdx_module_args'
> instead in __tdx_hypercall() related code.  This also saves the memory
> copy between the two structures within __tdx_hypercall().
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
