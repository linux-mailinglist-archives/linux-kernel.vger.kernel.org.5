Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1AC7A222E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbjIOPTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbjIOPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:19:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AFAE50;
        Fri, 15 Sep 2023 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694791170; x=1726327170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C6U2cRGFP7C+v2OzQruEDcRdqN+1cAwB8dcq4EUTp58=;
  b=crH1M1wmudyfPPCiZL8YD+N8bRIcWsnrpeo0mhfHbBgqbclpvNZ3GmZC
   LbuONErGt/OgAN3rh9J1m3MjeTQp+i0n5KHE5VxR+OB43mG7dClbqR/VL
   O7jyIiRm7EVhR0ST5DZm+tsEtdCkq2nrLb6b4rJQzuPrgGEOQ/ezcQRWb
   j2rxXbfqM28X2HjBgxANaKmixLrUtfmvZPcjt4ZrAQ+rnyhOUPoEsrhyj
   o1bJ79VvpHvN3QTb8hNW+c753Bf88k5ZrpULYatZVJochqb2mdWuKEzFD
   QX+oxqOei+eGVYRq9aSB/el75ehxK0zh85doYjwV+ox+0auiIjQfAR52h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="465634362"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="465634362"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="1075832196"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="1075832196"
Received: from spswartz-mobl.amr.corp.intel.com (HELO [10.209.21.97]) ([10.209.21.97])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:19:28 -0700
Message-ID: <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com>
Date:   Fri, 15 Sep 2023 08:19:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB
 allocator
Content-Language: en-US
To:     Matteo Rizzo <matteorizzo@google.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org
Cc:     jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
References: <20230915105933.495735-1-matteorizzo@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
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

On 9/15/23 03:59, Matteo Rizzo wrote:
> The goal of this patch series is to deterministically prevent cross-cache
> attacks in the SLUB allocator.

What's the cost?
