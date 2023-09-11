Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458F879A0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjIKAKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjIKAKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:10:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566B018B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694391012; x=1725927012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rs2RXPgE6FibMswDpiAFeGDRmtHImZ+Q9AaGonFjS3M=;
  b=VRgSQjMgZwxFbEd4gy5haaeXQGLYZ55sb6G8xyMO/dQRF2WpWYbHImiA
   8JSM2zAsCFn7xJQnc9GGYY9QcU98BcfUbwiiBvKGmgj9COb9MrGMM8R4u
   KqqZ5OZi7mtqtuEouxOYaK7vt+CPeNTX78cLZZwmaENWUY0iW1ll+t8pH
   uMbw6zcay+HQSEkFYLOud44WPzmczKn9/W8OEIq8Q2NdwSSOIxsmikQhs
   hnA/4e451WX0VdVAnTp6DShg8ILcqv/lCelM2a07u2QyGz4mkRQizOteQ
   zrJ2zOP2K7wNen2B13SwkujHAvJkk06qd3vOVKyE6ORTR5Jg0BcROwAZ9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="464332745"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="464332745"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 17:10:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="813180999"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="813180999"
Received: from rmanijac-mobl.amr.corp.intel.com (HELO [10.209.66.44]) ([10.209.66.44])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 17:10:11 -0700
Message-ID: <2371c186-ccd4-48c7-b302-e289adb30dec@linux.intel.com>
Date:   Sun, 10 Sep 2023 17:10:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20230907025405.2310931-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <da4a6c3f4cb9118e10866cb1d624ad5ec5c96d7d.camel@intel.com>
 <64fb499862936_7318294a0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <64fb499862936_7318294a0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 9:19 AM, Dan Williams wrote:
>>> Changes since previous version:
>>> * Used ConfigFS interface instead of IOCTL interface.
>>> * Used polling model for Quote generation and dropped the event notification IRQ support.
>> Can you elaborate why the notification IRQ is dropped?
> Because it was a pile of hacks and non-idiomatic complexity. It can come
> back when / if driver code can treat it like a typical interrupt.

Currently, the VMM assumes that the vCPU that executes the TDG.VP.VMCALL
<SetupEventNotifyInterrupt> hypercall as the target vCPU for event
notification IRQ. To satisfy this assumption, the guest driver that uses
this hypercall/IRQ had to include CPU/IRQ affinity related code changes. This
adds unnecessary complication to the guest driver code without any real
ARCH need or benefit. So we want to modify the GHCI ABI to let TD guest pass
the target CPU as an argument. With this change, we can hide the IRQ related
configuration in the IRQ chip code and let the guest driver treat the
event notification IRQ as a regular interrupt.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
