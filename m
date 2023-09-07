Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CD8797EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjIGWpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIGWpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:45:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2560C1BC8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694126718; x=1725662718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Q8u27xA4tbsVDLbPtOoS7PmjHKgBsW2v3Sas3J1+Bk=;
  b=T97t7kEM0Rkk65Rrc3eXOgvRShUUbDBPp836u3C45rXgqiaeve4Y1dWs
   u9hxNyfpiSOjkRz5cuaav8N2rqHDL9qpQiVr/pwuGlpe2jORCVW36l8DM
   830O8AzItNLbZdSV9ISdfRcCyzt67p39RLpbn/zjRcGKcFD4sQYQkqCsb
   wKgTNMVm6PedzLVy+DbnWQTmzPAEb6JzVahpQ3VXafvd3qJpQHqgsa3MX
   4KJAc1pr7zP6CA1Q7CoCIa9iRE689mJTXeufHW8+U4Or3uX3wumIp9/0k
   hwjFl1jyd8pn1jHCw+jP5In5j53kZshkel+DW2yXm3EjWZQQGQi6xzYDw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="356962354"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="356962354"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 15:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="885386415"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="885386415"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 15:44:47 -0700
Message-ID: <baf98f4e-0d3a-ac6f-040f-7e578525c7f7@intel.com>
Date:   Thu, 7 Sep 2023 15:45:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] x86/sev-es: Do not use copy_from_kernel_nofault in early
 #VC handler
Content-Language: en-US
To:     Adam Dunlap <acdunlap@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
 <CAMBK9=ZY7UapTq3YxbjD5vhynBou_s9m4tK=oL-wfv-BoAXQ+g@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMBK9=ZY7UapTq3YxbjD5vhynBou_s9m4tK=oL-wfv-BoAXQ+g@mail.gmail.com>
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

On 9/7/23 15:30, Adam Dunlap wrote:
>> In any case, the most straightforward way out of this mess is to
>> just move boot_cpu_data out of .bss and explicitly initialize it
>> along with some documentation explaining the situation.
> That seems totally reasonable. I tried applying the two patches that 
> you sent plus boot_cpu_data.x86_virt_bits = 0; in early_setup_idt(),

Let's just initialize boot_cpu_data to zero and get it out of .bss entirely.

> and that fixes the problems that we can see. Do you want me to send
> out a new patch with these changes together?
Well, ideally broken out in a couple of patches, but yeah, please resend
also with some revised changelogs based on what you've learned.
