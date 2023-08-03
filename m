Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30B076F5CB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjHCWmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHCWmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:42:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5BE4210
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691102536; x=1722638536;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3dGRAfaB7aed+8PrrX2ogQfre5bOEK7oH7ML4y+/71M=;
  b=fiTzEfx+vTDXng8PXDzLDcOcMNguZ3TdAO57dMwJMOv0enyAvD1jZyDI
   9mgvEf5734ruUYhc32HxPOqfLLNFLzpoUsbiFEPajZ45V7+DUWS06Fn/W
   QpXJyUoTdfpkz3RTPvp5dYAkFK84yZTMmc2Iy5g+27yoYI4ZIwaOAXVXD
   5mubgz/o8vsCmJqdZxNU7z6w1s937ToFhu7qSI4kqcdkKGCJv6zD93bXJ
   q4OfjX0/bz8qevKuJwVNH1+CLx6P9VFKfHFU5G+k4yctMAgbkBkAwSzmg
   IIjmhMgs72wsASyTGHfM4EACunJVng3uYTn3ZIQL/YlphQT4mB6vLI4/Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="370004371"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="370004371"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 15:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="976300094"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="976300094"
Received: from mgemici-mobl1.amr.corp.intel.com (HELO [10.251.12.132]) ([10.251.12.132])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 15:42:15 -0700
Message-ID: <973ae60f-15cd-19a3-7314-d165696b833c@intel.com>
Date:   Thu, 3 Aug 2023 15:42:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch V3 12/60] x86/of: Fix the APIC address registration
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20230801103042.936020332@linutronix.de>
 <20230801103815.818545643@linutronix.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230801103815.818545643@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 03:46, Thomas Gleixner wrote:
> The device tree APIC parser tries to force enable the local APIC when it is
> not set in CPUID. apic_force_enable() registers the boot CPU apic on
> success.

I went looking for how this registration happens.  I was expecting to
see something apic_force_enable() do something similar to
register_lapic_address().

But the apic_force_enable()=>apic_verify() call chain is pretty shallow
and I'm not seeing a lot of overlap.

Am I reading the "registers" part of this too literally?
