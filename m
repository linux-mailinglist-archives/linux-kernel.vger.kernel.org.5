Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9101478F31D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347151AbjHaTM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjHaTM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:12:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B514CE65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693509143; x=1725045143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kG9IpANrf0SbAP1vgrILMiZ2w0Y/Ua8KzGcrqLY/NVU=;
  b=JlZBYORwdEjSIzDSd6t3WgiqZ6cGluxl4NQvpbrCEZuJexDOEhADk6Vq
   pIC/MrrdDded5VXSzgAXJ7a8IA19XYRJ+gLgm8vUI94Hc3NSp6AJgrXbY
   pAVNUbZ2MzLCLW2fSOFpU0AmNK1iBq1Ib0Zp/IC1scGwOwrEyODpxvqpQ
   wwH3mZzwBMyZAX9WEniFqcGZsR/CIMfUIupY9+mLjsqpAck9ZnjGtgoWR
   eovqkPYt6NUYhXpAddWS5QaeEU9l4jzbr2KTIv1VOC8tdWSjjJEqGej4x
   laA9ogWR75fjTeBb4gi8Y+1Hf010cxn/cy7zrOcmcc94SYYI8FO41D0Z+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361062994"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="361062994"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 12:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805132561"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="805132561"
Received: from ffondjo-mobl.amr.corp.intel.com (HELO [10.209.94.37]) ([10.209.94.37])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 12:12:21 -0700
Message-ID: <c71199d1-93b3-ff51-f571-34d60cd36c1c@intel.com>
Date:   Thu, 31 Aug 2023 12:12:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/fpu/xstate: Fix PKRU covert channel
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Tavis Ormandy <taviso@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <20230831043228.1194256-1-jmattson@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230831043228.1194256-1-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/23 21:32, Jim Mattson wrote:
> When XCR0[9] is set, PKRU can be read and written from userspace with
> XSAVE and XRSTOR, even when CR4.PKE is clear.
> 
> Clear XCR0[9] when protection keys are disabled.
> 
> Reported-by: Tavis Ormandy <taviso@google.com>
> Signed-off-by: Jim Mattson <jmattson@google.com>

Is there any way to trigger this other than "nopku" on the command-line?

I'm not sure how scary this particular covert channel is, but it does
make sense to do this even if it's only to avoid wasting XSAVE space on
a feature that nobody can use (for things other than covert channels).

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
