Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD04776452
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjHIPqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjHIPqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:46:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78202111
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691596008; x=1723132008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ujARW7+TwgnCssPWqb49cF4kWewzTeUeqmp0ikcWG6s=;
  b=YW6Ug1OwM5/SRv3Vr7smq9DBcbP85UBUeN/ShLHIQNtwJrq50IgcKy1q
   isQKkuOgqy+7idToV7QMa2zDsPkUR22bVk0C6ZQq014/tvCt2z/fAOYvb
   HX4w0N8hBarkqSROMi6LVMQuedyybCPAdCF9CHoxqaIkIsoIkGdc91Ak0
   pCJve3AEtFgaT0tfM4VigE8NesIZ/VfG+ueIDLnq82tjv1nmw8MZ3rEIX
   N0dLocYZfXNAZH7bb+DNBqF7r0vtkyBfYrN1h1VSYHtu+KYyHptVerJkV
   PM0w3oT7FlJrlc27Yahq6PltI0r8n0BnS0dQqRWQT0xfOyLZ9/nj/WwDj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="371145344"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="371145344"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 08:46:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="761443446"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="761443446"
Received: from sajohns2-mobl.amr.corp.intel.com (HELO [10.213.185.172]) ([10.213.185.172])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 08:46:47 -0700
Message-ID: <a54d1613-7163-ceb5-3c9a-dead97801db7@linux.intel.com>
Date:   Wed, 9 Aug 2023 08:46:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] x86/speculation: add cpu_show_gds() prototype
To:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20230809130530.1913368-1-arnd@kernel.org>
Content-Language: en-US
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20230809130530.1913368-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 06:04, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added function has two definitions but no prototypes:
> 
> drivers/base/cpu.c:605:16: error: no previous prototype for 'cpu_show_gds' [-Werror=missing-prototypes]
> 
> Add a declaration next to the other ones for this file to avoid the
> warning.
> 
> Fixes: 8974eb588283b ("x86/speculation: Add Gather Data Sampling mitigation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/cpu.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 9d43b734170d6..0abd60a7987b6 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -73,6 +73,8 @@ extern ssize_t cpu_show_retbleed(struct device *dev,
>  				 struct device_attribute *attr, char *buf);
>  extern ssize_t cpu_show_spec_rstack_overflow(struct device *dev,
>  					     struct device_attribute *attr, char *buf);
> +extern ssize_t cpu_show_gds(struct device *dev,
> +			    struct device_attribute *attr, char *buf);
>  
>  extern __printf(4, 5)
>  struct device *cpu_device_create(struct device *parent, void *drvdata,

Sorry I missed that. Shouldn't stable be CC'd here as well?

Thanks,
Dan


