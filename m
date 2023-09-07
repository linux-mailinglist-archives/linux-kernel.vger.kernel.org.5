Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F711797E0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbjIGVmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjIGVmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:42:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8479B1BD2;
        Thu,  7 Sep 2023 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694122927; x=1725658927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yGPK4K1omlCXEBqIdMg908APtr7Mny4+WAToGCu8DlE=;
  b=jc4wmrdJyVVZhKkb00lrLBvopX3sXK4urSs3kdOEwr32QL9o5kBR+cgZ
   Z/MhPk26Y1bqPCIC9T1FapF0iIjjLIZ3aq2yOX/pZeJQIY4r26snSRFHx
   MSnSsPO/o2OC4BJv2haB8onwi2arNOp5B496N3ic+KByqLvo7fHKkI63/
   RLf0oZcdffBWNK4RSjYziBmM0cPJaOijc7ktObMhdgPu9WCSo8kmd4MWZ
   XG91Yqrl64kM8YQSQxdvyNCak1DMf9HnWFhzimX8pWWeEfFvSOB+lt6ya
   gV/dmEg0AeYGwuwQrl5M9DFHnS7DiEsVOHiFNYonuL24uMR9Wo7Jo9ODv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357796906"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="357796906"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="718875722"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="718875722"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:42:06 -0700
Message-ID: <735d3933-72ea-bbe6-be3b-767b3e44d837@intel.com>
Date:   Thu, 7 Sep 2023 14:42:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/2] ACPI: NUMA: Apply SRAT proximity domain to entire
 CFMWS window
Content-Language: en-US
To:     alison.schofield@intel.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     x86@kernel.org, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derick Marks <derick.w.marks@intel.com>
References: <cover.1689018477.git.alison.schofield@intel.com>
 <eaa0b7cffb0951a126223eef3cbe7b55b8300ad9.1689018477.git.alison.schofield@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <eaa0b7cffb0951a126223eef3cbe7b55b8300ad9.1689018477.git.alison.schofield@intel.com>
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

On 7/10/23 13:02, alison.schofield@intel.com wrote:
> +	/*
> +	 * The SRAT may have already described NUMA details for all,
> +	 * or a portion of, this CFMWS HPA range. Extend the memblks
> +	 * found for any portion of the window to cover the entire
> +	 * window.
> +	 */
> +	if (!numa_fill_memblks(start, end))
>  		return 0;

FWIW, the pieces didn't really fit together for me for this pair of
patches until I read *this* comment.

Either way:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
