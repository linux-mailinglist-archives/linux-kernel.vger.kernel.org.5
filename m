Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72AF7DF050
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347106AbjKBKhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346365AbjKBKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:37:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D13C2;
        Thu,  2 Nov 2023 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698921415; x=1730457415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Mbpai3S+jUr3tRS4QwqV7W+lWygfEso6vmwrk+sRRe0=;
  b=VXoLPD+CoCz/hIxoGnggCJNHh3pIODVZxbnbL4W2+VZn13qXeW2wOIEj
   Ocv+JCCl9ZjuWYgSudXMn0na/AjnmhfN6XPzatFxWy0AUwqGFr70eaBs5
   XzYIwFMGBKMC+B9/wJkzYlV7snqTkV3sku2G7B3Bb1azGgUwkOVF6D4A5
   AvdmDxppPc3KnbzEM2RC+l2nBLoEPBkb0MFFYdfpsBhpl+F1f4ZPDIafs
   S+3sf8/b2sYQRuTOMo6rmSTzG35FPJPlrZ+xF0dpvu/TUMyaJyL2W6bhm
   jJnmQj3X1t6Wh2c5lh4//jtDOP+73QOkgQyGvZM+cct/evpAWDRozI0e1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="391545866"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="391545866"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:36:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="851879415"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="851879415"
Received: from arajan-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.215.101])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:36:51 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 23428109AF7; Thu,  2 Nov 2023 13:36:49 +0300 (+03)
Date:   Thu, 2 Nov 2023 13:36:49 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, dionnaglaze@google.com,
        pgonda@google.com, seanjc@google.com, pbonzini@redhat.com
Subject: Re: [PATCH v5 09/14] x86/sev: Add Secure TSC support for SNP guests
Message-ID: <20231102103649.3lsl25vqdquwequd@box.shutemov.name>
References: <20231030063652.68675-1-nikunj@amd.com>
 <20231030063652.68675-10-nikunj@amd.com>
 <b5e71977-abf6-aa27-3a7b-37230b014724@amd.com>
 <55de810b-66f9-49e3-8459-b7cac1532a0c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55de810b-66f9-49e3-8459-b7cac1532a0c@amd.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 11:11:52AM +0530, Nikunj A. Dadhania wrote:
> On 10/31/2023 1:56 AM, Tom Lendacky wrote:
> >> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> >> index cb0d6cd1c12f..e081ca4d5da2 100644
> >> --- a/include/linux/cc_platform.h
> >> +++ b/include/linux/cc_platform.h
> >> @@ -90,6 +90,14 @@ enum cc_attr {
> >>        * Examples include TDX Guest.
> >>        */
> >>       CC_ATTR_HOTPLUG_DISABLED,
> >> +
> >> +    /**
> >> +     * @CC_ATTR_GUEST_SECURE_TSC: Secure TSC is active.
> >> +     *
> >> +     * The platform/OS is running as a guest/virtual machine and actively
> >> +     * using AMD SEV-SNP Secure TSC feature.
> > 
> > I think TDX also has a secure TSC like feature, so can this be generic?
> 
> Yes, we can do that. In SNP case SecureTSC is an optional feature, not sure if that is the case for TDX as well.
> 
> Kirill any inputs ?

We have several X86_FEATURE_ flags to indicate quality of TSC. Do we
really need a CC_ATTR on top of that? Maybe SEV code could just set
X86_FEATURE_ according to what its TSC can do?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
