Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6FE7AE75C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjIZIGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZIGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:06:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C5AD7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715553; x=1727251553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k0LY01UuWhCyxClR4WMZ+7BFAyL6E1EuK0Byohgt3O4=;
  b=I8o/be8X5ht5L2yxs8mc+uHDp90+GIDZoli1t2mEy5dnxVsuHMx7TiBq
   U3QpAJP+m7mQ6CmQu2GWea9cE8sSuU+yPqovoid7Foou9jwhs84GbFdGZ
   2CWI5BJcB2ysaNMDTbB0+XOYiM5RWhfNDuYXeQKvq1b+LaT/klFqYXB1p
   5L0GAyGEz2zYlys9ZGJRw6Y2HHOfvujgRYN/gRg/5ENfuYSt6zLNmZ+7d
   oumz8MyaKNs0UVnciD7Gwbi79j7ZX5O0Z0y5SyYSLfrlEEtOkEMNHCmtY
   ElJ9JkJAFDkWk2lwG/Xi/nGTYv014FX+ajaP92nyc7YyPt2zKhXqlr0W+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360891251"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360891251"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="778037942"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="778037942"
Received: from mtruica-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.39.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:05:51 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7C970103D52; Tue, 26 Sep 2023 11:05:48 +0300 (+03)
Date:   Tue, 26 Sep 2023 11:05:48 +0300
From:   kirill.shutemov@linux.intel.com
To:     Yi Sun <yi.sun@intel.com>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org, heng.su@intel.com,
        yi.sun@linux.intel.com, Dongcheng Yan <dongcheng.yan@intel.com>
Subject: Re: [PATCH v2] x86/tdx: Dump TDX version During the TD Bootup
Message-ID: <20230926080548.5blqyozzrhjyiq4m@box.shutemov.name>
References: <20230922080322.2071168-1-yi.sun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922080322.2071168-1-yi.sun@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 04:03:22PM +0800, Yi Sun wrote:
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
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 1d6b863c42b0..0f51123aa0b9 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -37,6 +37,27 @@
>  
>  #define TDREPORT_SUBTYPE_0	0
>  
> +/*
> + * TDX metadata base field id, used by TDCALL TDG.SYS.RD
> + * See TDX ABI Spec section 3.3.2.3 Global Metadata Fields
> + */
> +#define TDX_SYS_VENDOR_ID_FID		0x0800000200000000ULL
> +#define TDX_SYS_MINOR_FID		0x0800000100000003ULL
> +#define TDX_SYS_MAJOR_FID		0x0800000100000004ULL
> +#define TDX_VENDOR_INTEL		0x8086
> +
> +struct tdg_sys_info {
> +	u32 vendor_id;
> +	u16 major_version;
> +	u16 minor_version;
> +};
> +
> +/*
> + * Fetch TDX Module global-scope metadata field via TDG.SYS.RD TDCALL
> + * Do NOT change it once initialized.
> + */
> +static struct tdg_sys_info td_sys_info;
> +

Why here?

I think we can allocate on stack inside tdx_early_init() and pass down to
tdg_get_sysinfo() to fill. The variable is not needed after
tdx_early_init() returns.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
