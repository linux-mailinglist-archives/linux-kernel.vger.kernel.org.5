Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8E79892E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbjIHOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243595AbjIHOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:49:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830131FC6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694184540; x=1725720540;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nWRmSNDBjYyGY2acXj+a55U9CI5D/oKEELeMyinmZXc=;
  b=L0+WW0WF+Y+mjueKaRORBwlJQdcpjghH7EdyABfv3taY6qHu7ebC/FxP
   wquSV/ToShY6EDYxXLnUGthUPTn8OL0YtsBevc4P/DR1+4r/rf51HImJZ
   Q/Y2vG4hD4Hr/8mExUxbLN/ojfhGt5YHFEovE/m+RtLW2DM9xylgEoE8b
   +YYljqwt7+Yiy7FZ4l3BGrQjdRtpFRHwV2lmuO24ffkZo0EDGHhtD7kS9
   yM2Rl5uhD0REysWuTVa47GizPqHSeyc+655tQnnLe+m79NcsIX7qKm09H
   reFIWim3TyyoE4nsZFV0HF1RvH5+bzOOn0YBdYPGLZ9yT7AR0j6cyD9OZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="441675275"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="441675275"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 07:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="742530846"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="742530846"
Received: from fgilganx-mobl1.amr.corp.intel.com (HELO [10.209.17.195]) ([10.209.17.195])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 07:48:59 -0700
Message-ID: <cc90c896-7581-62b5-4836-971e9ca8fac0@intel.com>
Date:   Fri, 8 Sep 2023 07:48:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] x86/sev-es: Do not use copy_from_kernel_nofault in early
 #VC handler
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Adam Dunlap <acdunlap@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, Jacob Xu <jacobhxu@google.com>
References: <20230906224541.2778523-1-acdunlap@google.com>
 <e037f1c0-aaf6-7951-04ea-6d27e557b61b@intel.com>
 <CAMBK9=b9V6WxYZNrVPNV5vzBZ-mT_noBAxod=ijqrV3bUXAUyA@mail.gmail.com>
 <cb958f57-6a3a-d626-da51-53ad0e61870c@intel.com>
 <CAMBK9=bk715TjXhzwss+wFqpafKganGhZ=WKWPvEuJyM5M2MCQ@mail.gmail.com>
 <ac2f3bfc-9177-abc9-d4d7-69b1fba943a6@intel.com>
 <0d8a35c9-82ca-188a-529d-65fd01c40149@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <0d8a35c9-82ca-188a-529d-65fd01c40149@amd.com>
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

On 9/8/23 06:13, Tom Lendacky wrote:
> On 9/7/23 14:12, Dave Hansen wrote:
>> But seriously, is it even *possible* to spin up a SEV-SNP VM what
>> doesn't have NX?
> 
> It is a common path, so while an SEV guest would have NX support, you
> would first have to determine that it is an SEV guest. That would take
> issuing a CPUID instruction in order to determine if a particular MSR
> can be read...

I was thinking more along the lines of telling folks that if they want
to turn SEV-SNP support on, they also have to give up on running on a
!NX system.  That would be a _bit_ nicer than just refusing to boot on
all !NX systems.

> Ultimately, we could probably pass the encryption mask from the
> decompressor to the kernel and avoid some of the checks during early
> boot of the kernel proper. Is it possible to boot an x86 kernel without
> going through the decompressor?

I think it's possible, but it's very unusual.
