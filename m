Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736687BBBF0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjJFPnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjJFPnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:43:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035A69E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696606984; x=1728142984;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fQsFBquArgc+9IJQ4xqInI1mZINN33gx7S35zWcm+b8=;
  b=BvrhtbOKpAMCiVsBo1jgito6EUirFAFARxx7daZeum36kPPqbD0ZRv92
   NREv97BJab6X/adCAV7HfyLvQJPKzWd0niYMPG7T6rzDpjcDSZd7aJrUO
   POtzEabiKdnk0io7r3eiL5X/hNfWBfjAu6/mK4iDk4j6e0m3ANM3CIcp1
   2TikUHhLK8EmogZOJmGA5NFpIIqVy6jXjb0Kw0kI1Col0tfjQl+EG5WGX
   aPj+YfgxfjmKQgW+c40db/roEzNbWgjh4MbWtrrb4QyyOt6l/B5ELFG4T
   DVom9/GI+Va+KfJwQdIhy7JImmNblzfWsXjJnE9G3YR7xecRfSrjdPuj7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="368849745"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="368849745"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="1083491800"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="1083491800"
Received: from dhimanbh-mobl1.amr.corp.intel.com (HELO [10.209.88.92]) ([10.209.88.92])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:43:02 -0700
Message-ID: <4325732d-f5cc-b15b-157b-e5b0e61f8976@intel.com>
Date:   Fri, 6 Oct 2023 08:43:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/tdx: Override the tsc calibration for TDX VMs
Content-Language: en-US
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sagi Shahar <sagis@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231006011255.4163884-1-vannapurve@google.com>
 <2d952c6b-2357-208b-e816-bca19c2a7ca6@intel.com>
 <CAGtprH-_C28G1WEPqmgdpHJpo3_esqOnOYad6YiKQ6g4Z+s9wg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAGtprH-_C28G1WEPqmgdpHJpo3_esqOnOYad6YiKQ6g4Z+s9wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 08:27, Vishal Annapurve wrote:
>> Would it be possible to do this by refactoring the existing code and
>> calling it directly instead of copying and pasting so much?
> One option is to call native_calibrate_tsc from tdx_calibrate_tsc and
> undo the lapic_timer_period configuration after the call. Does that
> sound reasonable?

That sounds like a hack.

Why not just refactor the code properly?
