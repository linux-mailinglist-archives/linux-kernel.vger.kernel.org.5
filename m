Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803F6788C53
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjHYPS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjHYPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:18:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A7C2121;
        Fri, 25 Aug 2023 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692976714; x=1724512714;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4SuZ5OsPAW5MybHkdMLDB2TIspBmkp3UowO2L8p0FaQ=;
  b=NlK+mVrHBOZG2iJazMNzV5gut9MuET4PcfpfB9/cf0apXjZeBEbuf2ab
   roPxNfHGRZTCsHzeuEnhS7nq6YezdvL3FfR8AXBDrx5gtPcohXhlN8x2t
   ZMqusYALJ2aSNDksjrQaBX4BI90SU31ZT+UiDLCfRl9q7S/2zhKenV+Kw
   Gs713C1ZSGbmSzK6j0YmRXpWRZceB3FUMty7iNuQhvprPUGmBzaHgIGvz
   jar/dpgmHiyYdpZiTF4WFF/XjuOY54u+KOyYHdUp+9oc0PvXs+Ku/Q2hB
   GRZYDxFWqbO4rQtG0iyjjZJ1zh8fsb/6GGs129hJVTFLxN3ZPRlldRm9c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="405732486"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="405732486"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 08:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="714378664"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="714378664"
Received: from sbilgin1-mobl1.amr.corp.intel.com (HELO [10.209.78.69]) ([10.209.78.69])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 08:18:32 -0700
Message-ID: <ba319881-b4e9-7129-123f-1884bfeb50ec@intel.com>
Date:   Fri, 25 Aug 2023 08:18:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/sgx: Describe the parameters of
 sgx_calc_section_metric()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org
Cc:     stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Serge Ayoun <serge.ayoun@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <20230822102853.15078-1-jarkko@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230822102853.15078-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/23 03:28, Jarkko Sakkinen wrote:
> Cc: stable@vger.kernel.org # v5.11+
> Fixes: e7e0545299d8 ("x86/sgx: Initialize metadata for Enclave Page Cache (EPC) sections")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308221542.11UpkVfp-lkp@intel.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

-ENOCHANGELOG

>  /**
> + * sgx_calc_section_metric() - Calculate an EPC section metric
> + * @low:	low 32-bit word from CPUID:0x12:{2, ...}
> + * @high:	high 32-bit word from CPUID:0x12:{2, ...}
> + *
>   * A section metric is concatenated in a way that @low bits 12-31 define the
>   * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
>   * metric.

Shouldn't we just do:

-  /**
+  /*

?  This doesn't need kerneldoc comments.
