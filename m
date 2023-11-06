Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8E17E22A0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjKFNAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjKFNAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:00:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B4BD;
        Mon,  6 Nov 2023 05:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699275648; x=1730811648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2SqN7za7Sfgm+xJRQJPZcebSUPWSYEo/BnT5IvaXfGs=;
  b=TcDXzURH1pFckFAB0dtpE11LtnL1qE552oaq5zQvDF8/2p3FY40Papjk
   Y6SqU6mU1PodYW7qurQoEae5EIr11Tgq5ECSotqRGtNk/EpY7StJXlx9t
   FSQ8RahVTdLskTfA0KDmuLBr7LWQABpPDo5UgOdMM0Sd5fEVgzhyWv4Nr
   cw0epLHER1bE1dtGey0rXM51doE/b/KFMzvNM7+NYhhD+YP0spy65Pjre
   k9u9aydQbR60M+qTv7MqSYRYKXknKgFUkF26YgG/4VHXDCSnDe4B2Hn8U
   lPZUrPnoTlgfZvEauAcLoXUmoiCZsbmpAmH3Hx0w9glP+2FFEP8cNo//W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="392135659"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="392135659"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 05:00:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="791459993"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="791459993"
Received: from jgulati-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.42.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 05:00:44 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 49FCA104790; Mon,  6 Nov 2023 16:00:41 +0300 (+03)
Date:   Mon, 6 Nov 2023 16:00:41 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, dionnaglaze@google.com,
        pgonda@google.com, seanjc@google.com, pbonzini@redhat.com
Subject: Re: [PATCH v5 09/14] x86/sev: Add Secure TSC support for SNP guests
Message-ID: <20231106130041.gqoqszdxrmdomsxl@box.shutemov.name>
References: <20231030063652.68675-1-nikunj@amd.com>
 <20231030063652.68675-10-nikunj@amd.com>
 <b5e71977-abf6-aa27-3a7b-37230b014724@amd.com>
 <55de810b-66f9-49e3-8459-b7cac1532a0c@amd.com>
 <20231102103649.3lsl25vqdquwequd@box.shutemov.name>
 <d419893f-3167-4a8f-aa4e-06e8ecd390d1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d419893f-3167-4a8f-aa4e-06e8ecd390d1@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 04:15:59PM +0530, Nikunj A. Dadhania wrote:
> On 11/2/2023 4:06 PM, Kirill A. Shutemov wrote:
> > On Thu, Nov 02, 2023 at 11:11:52AM +0530, Nikunj A. Dadhania wrote:
> >> On 10/31/2023 1:56 AM, Tom Lendacky wrote:
> >>>> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> >>>> index cb0d6cd1c12f..e081ca4d5da2 100644
> >>>> --- a/include/linux/cc_platform.h
> >>>> +++ b/include/linux/cc_platform.h
> >>>> @@ -90,6 +90,14 @@ enum cc_attr {
> >>>>        * Examples include TDX Guest.
> >>>>        */
> >>>>       CC_ATTR_HOTPLUG_DISABLED,
> >>>> +
> >>>> +    /**
> >>>> +     * @CC_ATTR_GUEST_SECURE_TSC: Secure TSC is active.
> >>>> +     *
> >>>> +     * The platform/OS is running as a guest/virtual machine and actively
> >>>> +     * using AMD SEV-SNP Secure TSC feature.
> >>>
> >>> I think TDX also has a secure TSC like feature, so can this be generic?
> >>
> >> Yes, we can do that. In SNP case SecureTSC is an optional feature, not sure if that is the case for TDX as well.
> >>
> >> Kirill any inputs ?
> > 
> > We have several X86_FEATURE_ flags to indicate quality of TSC. Do we
> > really need a CC_ATTR on top of that? Maybe SEV code could just set
> > X86_FEATURE_ according to what its TSC can do?
> 
> For SEV-SNP, SEV_STATUS MSR has the information of various features
> that have been enabled by the hypervisor. We will need a CC_ATTR for
> these optional features.

If all users of the attribute is withing x86, I would rather add synthetic
X86_FEATURE_ flags than CC_ATTR_. We have better instrumentation around
features.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
