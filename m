Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FBC7A4EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjIRQcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjIRQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:31:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4430F1;
        Mon, 18 Sep 2023 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695054577; x=1726590577;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mUsyv642lSfHpOACGU5mHLtbltxVExA86+s11mm3p3o=;
  b=gIFbJ5VFhy+/rNqm5hU3RxtTt5l7AKlTUPHc/7/sxcKDaq7RwBX3deuF
   FUDF0cVsAPGCf1nrhSwERcH5EdhGjoQpa4aviGNw/tpzHp8sweEJcBUXS
   kL5K9t98X4gXNPku282/DSOYiwAA2fwSV1KcXR6G/QGg7vn46R3l970S8
   eXsBcPtd0ZGGBuMf54tly0EtL3xPyGRTUGR8w5xeflyBdapaV6Wu6KMWg
   UC/Yl/5Keo+umXuFkxQwoggY1Sh8J1ELK0++1sJkGZsSGEI6pRCXtova6
   E+sLVNkKfeTCu8QBSPGqXtXBy96QWYVWKIqOXTy3AbIPrGl7FZ7D1en0/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="443784041"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="443784041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:29:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="861132842"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861132842"
Received: from nprotaso-mobl1.ccr.corp.intel.com ([10.252.49.156])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:29:33 -0700
Date:   Mon, 18 Sep 2023 19:29:31 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
cc:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>
Subject: RE: [PATCH 03/10] platform/x86/intel/ifs: Image loading for new
 generations
In-Reply-To: <SJ1PR11MB608304A84A2B662C78FDB677FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Message-ID: <a02d2957-3ec4-f89c-ebe-474c3987b237@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230913183348.1349409-4-jithu.joseph@intel.com> <ba753b39-1819-35ff-1248-6ce2c2824ae9@linux.intel.com> <e084652a-91a0-0c16-7acb-d51a3d2f7ed5@intel.com> <10fe57c-c926-9de4-be84-21a0f8abab6d@linux.intel.com>
 <SJ1PR11MB6083A4237D928F180B6DB1E1FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com> <56b486ce-2a6e-c4c7-8bc5-ceeb7119ba1@linux.intel.com> <SJ1PR11MB608304A84A2B662C78FDB677FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023, Luck, Tony wrote:

> > Since you replied, would you happen to have a pointer something that tells 
> > (in writing) how the bitfields in C are allocated in case of x86_64? I 
> > spent a bit of time trying to find something but came up nothing.
> 
> Search engines don't seem to be as good as they used to be (or I'm not as
> good at finding the right query). 
> 
> There's a bit on page 14 of:
> 
> https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf
> 
> that says bit fields are allocated right to left (which is a good
> start). But I thought there was a doc somewhere that gave
> more detail about alignment of bitfields.

Thanks, appreciated.

In this case it is not just about the bitfield itself nor the bit 
allocation order but sharing the storage unit with another member, and to 
further complicate things, members have different alignment requirement 
too (32-bit aligned u8 followed by u32 bitfield).

The document states: "Bit-fields obey the same size and alignment rules as 
other structure and union members." which seems to contradict my test 
that found that the u32 bitfield won't be 32-bit aligned but gets combined 
with the 32-bit aligned u8. Perhaps it's because the total number of bits 
still fits to 32 bits so the bitfield doesn't cross the 32-bit boundary 
even when combined with the preceeding u8.


-- 
 i.

