Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26AD7B5076
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbjJBKi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjJBKi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:38:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D92B9D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696243134; x=1727779134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FsM7FgtD91vOAiMV4yy4j0zqoSKCI8hIp0bl71iOibQ=;
  b=aMJk963qB4fTwBY7SI6MOmUtpB28xofcfpUBbw3NIgW7ytebCFm7NdMJ
   wWpnXHaC95MMg9KKLww0r37/QQ3s60O9lHH+tSwI5+sJH1640ibOWKBhB
   Gi45bSg62QKCEPWxbLldjL4iw/5QSDgPPXsNnym/FUUrjEJL8qUYPz26p
   oiabrtObqCjTK+C+41gQm6aV6rdddk71zGS9c6XD8Y1zzi4U1GAgvdcNn
   buy9kLVWwbQawmkMWJ69mhCxNfaOulvO4RmtrAFH+/D92FwuL9D37+IV3
   2SXxQRJgYXDuUkXAXLYplX4xAkFmJKdXV7GOhXLTbjnnu9VunWDoow7M2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="372967576"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="372967576"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 03:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="779904124"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="779904124"
Received: from mdmitrza-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.41.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 03:38:51 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D7DA610A093; Mon,  2 Oct 2023 13:38:48 +0300 (+03)
Date:   Mon, 2 Oct 2023 13:38:48 +0300
From:   kirill.shutemov@linux.intel.com
To:     Yi Sun <yi.sun@intel.com>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org, heng.su@intel.com,
        yi.sun@linux.intel.com, Dongcheng Yan <dongcheng.yan@intel.com>,
        x86@kernel.org
Subject: Re: [PATCH v3] x86/tdx: Dump TDX version During the TD Bootup
Message-ID: <20231002103848.4e4pscg4wz7kxgxz@box.shutemov.name>
References: <20230930161110.3251107-1-yi.sun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230930161110.3251107-1-yi.sun@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:11:10AM +0800, Yi Sun wrote:
> It is essential for TD users to be aware of the vendor and version of
> the current TDX. Additionally, they can reference the TDX version when
> reporting bugs or issues.
> 
> Furthermore, the applications or device drivers running in TD can achieve
> enhanced reliability and flexibility by following the TDX Module ABI
> specification, because there are significant differences between different
> versions of TDX, as mentioned in the "Intel® TDX Module Incompatibilities
> between v1.0 and v1.5" reference. Here are a few examples:
> 
> MSR Name		Index		Reason
> ----------------------------------------------
> IA32_UARCH_MISC_CTL	0x1B01		From v1.5
> IA32_ARCH_CAPABILITIES	0x010A		Changed in v1.5
> IA32_TSX_CTRL		0x0122		Changed in v1.5
> 
> CPUID Leaf	Sub-leaf	Reason
> ---------------------------------------
> 0x7		2		From v1.5
> 0x22		0		From v1.5
> 0x23		0~3		From v1.5
> 0x80000007	0		From v1.5
> 
> During TD initialization, the TDX version info can be obtained by calling
> TDG.SYS.RD. This will fetch the current version of TDX, including the major
> and minor version numbers and vendor ID.
> 
> The TDCALL TDG.SYS.RD originates from TDX version 1.5. If the error
> TDCALL_INVALID_OPERAND occurs, it should be treated as TDX version 1.0.
> 
> Co-developed-by: Dongcheng Yan <dongcheng.yan@intel.com>
> Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>
> Signed-off-by: Yi Sun <yi.sun@intel.com>

Looks good to me.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

But you need to send it to x86 maintainers. I've CCed x86@, but you might
need to resend it properly to maintainers.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
