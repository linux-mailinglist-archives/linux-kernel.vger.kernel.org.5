Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCCB76546D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjG0NAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjG0NAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:00:16 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4811FFC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690462815; x=1721998815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xHS7xsfQ8zvAAbvSCWBxFjUjiHKlwN7kYd5pBgiPVDs=;
  b=FDhi+8M/SLvHZ0vvBxSPpKxW0dAFWhszBRbOeVasZDWJcuJSPJ/kfTUb
   1SQqDhEJmAP1ARjVyPfDQpcuSpTLvvShdf1a0ZhPJXEyZKfgXhHPgTee4
   c03FEv5HlaQ6MpymA6dn1V0Izzp+/k5SEn1PhB+E+mJuXY+ka1juUdLXe
   Z6khw4HoRrhhsLBZvEveXNOAXg91ePGBjc1Gy+BE1/GTHNaDgaSEdApH4
   wLcJzxFNkWhk6nJj65AxW3atr9EfbY8HVq2NVtnzt5AeTKEY/N/Fqi7lz
   LiO3tMho3YJPrBCGKX/zQViuDHBNRIcUx2UCyhXZ7v6las4dTWaqBa4WG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="367179048"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367179048"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="973542437"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="973542437"
Received: from lzhiguno-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.37.222])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:00:11 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DAB09109503; Thu, 27 Jul 2023 16:00:08 +0300 (+03)
Date:   Thu, 27 Jul 2023 16:00:08 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 03/12] x86/tdx: Make macros of TDCALLs consistent with
 the spec
Message-ID: <20230727130008.jx3olv4pwpdsrui2@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <b3f5a25e72094a11add22e1a7c5dda3ea91d0e98.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3f5a25e72094a11add22e1a7c5dda3ea91d0e98.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:05PM +1200, Kai Huang wrote:
> The TDX spec names all TDCALLs with prefix "TDG".  Currently, the kernel
> doesn't follow such convention for the macros of those TDCALLs but uses
> prefix "TDX_" for all of them.  Although it's arguable whether the TDX
> spec names those TDCALLs properly, it's better for the kernel to follow
> the spec when naming those macros.
> 
> Change all macros of TDCALLs to make them consistent with the spec.  As
> a bonus, they get distinguished easily from the host-side SEAMCALLs,
> which all have prefix "TDH".
> 
> No functional change intended.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>

I remember we had few back-and-forth on naming this defines. I think
matching names to the spec is helpful for future readers:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
