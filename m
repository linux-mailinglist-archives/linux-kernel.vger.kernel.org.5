Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707077989AE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbjIHPOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244411AbjIHPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:14:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76871FC4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694186082; x=1725722082;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1DUKteFi87J/ZjtM43eEumr6T9NOL9on7XcA8r4tIK4=;
  b=ccoQgAR8xUIk/xmBZmw4NUBtiELNJK1dnaXohkdnRdZeyMw4pVmLyc3X
   K1ZCJjt74jInaJIcHrizoV/MFVveYxM5/gquBJCCKHgVzYndy7pg3kjeI
   5oj0sfrhRS2QxBRKKyb31plfddQD3Gbdie7qxG0MEhV+SDfzWxvwhRMWM
   GGz3F2XXHUgiJFbLiVbtA+nGpuKai/MBjd1nh9Yfjgrfjage/kz0m0hB3
   /Zs6ZDocdrAaIGByV4ODvGr4NRfotCWCycV0/OW8eooRJfgs7GqIJu7Bl
   0kVXNmCr1FwBjLL6u3Sntq+ylPM8WyZ0BMUv2mN4a2GpzAQ8FhPosgQH8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="377578743"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="377578743"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 08:14:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832690991"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="832690991"
Received: from fgilganx-mobl1.amr.corp.intel.com (HELO [10.209.17.195]) ([10.209.17.195])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 08:14:41 -0700
Message-ID: <4c49c85a-2b2e-e408-534d-586f06a8e485@intel.com>
Date:   Fri, 8 Sep 2023 08:14:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Memory protection keys: Signal handlers crash if pkey0 is
 write-disabled
Content-Language: en-US
To:     Robert Kueffner <r.m.kueffner@gmail.com>
Cc:     Kyle Huey <me@kylehuey.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <FF299375-B46F-46D0-90A9-333959FE9380@gmail.com>
 <c0159d08-e69d-0329-5ca9-68fd26cab0c8@intel.com>
 <E821837A-22AD-420C-A290-8511344E7EAF@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <E821837A-22AD-420C-A290-8511344E7EAF@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 16:07, Robert Kueffner wrote:
>> I assume that *something* is trying to access pkey-0-protected
>> memory. Any idea what that is?  Which entity is doing that access
>> and what are they accessing?  The page fault tracepoints might come
>> in handy.
> If I understand correctly, the kernel (a) pushes the processor state
> onto the stack and (b) resets PKRU=0x55555554 some time before
> switching to the signal handler. And may try between (a) and (b) to
> write pkey-0-protected memory.
Well, the "pushes the processor state onto the stack" part is probably
the problem.  That processor state _includes_ PKRU and it's also
eventually the only place that processor state exists.

That means that there's no simple solution.  You can't just move up
where PKRU gets reset because that will blow away the PKRU that you need
to save on the stack.

There are tons of complicated ways to fix this.  But the easiest way is
just to say that you need to keep PKRU set so that the signal frame can
be written at any time.
