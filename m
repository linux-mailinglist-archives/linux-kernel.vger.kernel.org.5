Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A479978B27E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjH1ODs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjH1ODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:03:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF97C7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693231420; x=1724767420;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WJuKjD+4hrIC8Mnskx1Y0gaANpnEWbb1CRxN9ym7AvE=;
  b=VKXsiWLfe0Ni32VJFKCGIVCqMFZHQvGvLOC54y2Y4bSQsfDFgr+RyEpF
   hpOp1zmRbWCCLU3Fv8QNz/ceoAmqRu3++Cic4NJNj7Ngx9yiIzq4G+un2
   DsatoZFvuThdi+uNh22O6df3brxPtGUunsxC17BktpWldgG7VCFmNwqOT
   YDtp8K239JIloUVGCgQhzmVA9dJB492jDjlC5Z5irPUJFfbEnRyB+RQKi
   /VqBKgNxiGWIdUKwgNEISV4RciVaJuepX2zH9OsAx4dAh2u/sljwC/X2S
   4yF4xDvR4sbNGTjG74nQ7tGoFZ39pACCqlVsHV9eQZZrFNsVnQb2A0yrz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="354631379"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="354631379"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 07:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="984884911"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="984884911"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.114.105]) ([10.209.114.105])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 07:03:38 -0700
Message-ID: <ba8e847c-4bec-6f9a-fb3b-573c5d6216f9@linux.intel.com>
Date:   Mon, 28 Aug 2023 07:03:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
To:     Thomas Gleixner <tglx@linutronix.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
 <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com> <87r0nn8ots.ffs@tglx>
Content-Language: en-US
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <87r0nn8ots.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/2023 3:05 AM, Thomas Gleixner wrote:
>     - Are these really different between AMD and Intel or is this some
>       naming convention issue which needs to be resolved?

if you want a 3rd name that neither uses "chiplet" could work I suppose

