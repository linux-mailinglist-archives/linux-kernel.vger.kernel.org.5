Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B67B0793
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjI0PDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjI0PDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:03:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE24F4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695827015; x=1727363015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zpA9BsJHnzyjv+JuH8/rW2BPpXWgxhz5pbTusREsI6A=;
  b=jCY5JYFViCL9e0JbdysXvgQPIRzs/aXbw25dEmX5aLWUcIVQGbp8d1dX
   5bx8Zy2p/XaIGXrO0reQnAdOd7P1mkTzvATyu1Oivhrv/sVnswj4Gr1JV
   x9hHfiQPDDPBNMSh/cOma7Ht9L3G+ztYJ3kLGFFgUcFxprqUWEQssjem+
   wykes+rP8c1+i1NzmEADhzVTJUeHXRmxEefgX48q/N1/ChTNbN88dLEXV
   LYSZfnTiaMUyDBX3bajSkoOxGCbgCdypzBMdUJrAU6tQqIC9gT/30Rx7v
   8VA6Pp0LN6cxSfAORhoEHRDJ7gEjh89ItmRuyKsSO32aYfOJKMSU7B9jA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="379120326"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="379120326"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 08:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784349612"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="784349612"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 08:03:19 -0700
Date:   Wed, 27 Sep 2023 08:03:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Maciej =?iso-8859-1?Q?Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     Peter Newman <peternewman@google.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, fenghua.yu@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        reinette.chatre@intel.com, tglx@linutronix.de, eranian@google.com,
        x86@kernel.org
Subject: Re: [PATCH v2 1/4] x86/resctrl: Enable non-contiguous bits in Intel
 CAT
Message-ID: <ZRRENutFOc6n/rlg@agluck-desk3>
References: <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
 <20230922141441.3353077-1-peternewman@google.com>
 <xnjmmsj5pjskbqeynor2ztha5dmkhxa44j764ohtjhtywy7idb@soobjiql4liy>
 <CALPaoCgm8ed0p3Nw53d=Hgs0WnunkRUwAriyuKqu6+5Ty-QVTw@mail.gmail.com>
 <xn63zx7zfjszkp2nvpiemrxnva54dse3wed7apvadgibr23fqq@jodz2loxarsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xn63zx7zfjszkp2nvpiemrxnva54dse3wed7apvadgibr23fqq@jodz2loxarsu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 12:44:39PM +0200, Maciej Wieczór-Retman wrote:
> Writing non-contiguous bitmasks is supported starting from the upcoming
> GNR microarchitecture forward.
> 
> That's also why the new CPUID bit meaning is in the ISA pdf and not in
> the SDM one currently.

New SDM released today has the non-contiguous bit. See vol 3B Figuer
18-33.

-Tony
