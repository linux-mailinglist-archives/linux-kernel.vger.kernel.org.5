Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E1A7626F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjGYWjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjGYWj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:39:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089A193E6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690324371; x=1721860371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y6b8JOpE4JCii4usujU0tRnoeL9l3tVMhMzSjzkNSlo=;
  b=DEfcuL1ed4uGGdAZ5PfONHlLq6dedWnbbgPuZtNMrxBXbPGsXfsC2KzX
   gZfavMlf5wmrC9ARmBTKLjPMwsR4OaPY/0259Oe7bl5jnsm2K75qY+HHN
   rzUIVYNMPQNWOjQKGwAp3VK1qO+Ft3OA+GLl0ifHMb4fLXIHNw8hKDPj7
   gXGascnPLp8IIZQcdUzIjwF5dD5IHrqN7zpKxH9Z8q9rzCL9w0NSBw5Ai
   04BqtTcJBUmvnTTYsjPkMRL7LxU0/kQe3OkFINQPblsa28ahC7WHS6ams
   JBSOd6OwlCfLXwvWWvSVCEMvGlkw6XZkxPThz+Hz3c9cezZ7RsuSHtPcG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="348132909"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="348132909"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 15:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="755928194"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="755928194"
Received: from chrisper-mobl.amr.corp.intel.com (HELO [10.209.69.88]) ([10.209.69.88])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 15:23:45 -0700
Message-ID: <6f56c604-7580-2d8b-cab0-ad656aa0728a@intel.com>
Date:   Tue, 25 Jul 2023 15:23:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/traps: Fix load_unaligned_zeropad() handling for
 shared TDX memory
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
References: <20230724230329.3970-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wipev18s9sErt+iNO_rzgyvGTce38fr1CYO0U_hGVGy2Q@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAHk-=wipev18s9sErt+iNO_rzgyvGTce38fr1CYO0U_hGVGy2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 14:57, Linus Torvalds wrote:
> I can apply this directly (having written that ex_handler_zeropad())
> or wait for it to come from the x86 tree?

Feel free to pull it directly.  Looks fine to me as well:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
