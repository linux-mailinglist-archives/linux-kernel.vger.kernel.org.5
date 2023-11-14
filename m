Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EDA7EAB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjKNIZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjKNIZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:25:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1241B2;
        Tue, 14 Nov 2023 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699950310; x=1731486310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZsluGkovvLZGSDBjAzFoyP9oHyQ46jeHVYC5LAYknI0=;
  b=a0v8gkrVcIagCXjhVf0jI3q0Fw+vrzs3joGsa4+zxeN8orUV2ihaV22f
   iGp+E7kfxUW+vz4r/ZxVpOzM+GL9XjyphibQwpUV0fQ+HBO+z37HQ0fLj
   LNF/1Cc0bujYJh7hCzXJ3Yw4ocXF7HGc46YCNc8awKoNlzAk6R1fR8evl
   fTbvdEEr5WpocMiRME9wuK9mC2Q/In8/KBx0MYaqEQnKLzBnDYAgAZHSS
   axTnLNIK1ImERsBWHg8qQK6/fMsmKi4kP3STI+MTgTugGqAyl7B+cVRQg
   dHAf5GbopeBb1EYfiQewChTxRpo0NRCyHKF8rawl4pDtdW/Vd9wVIIlvX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389467475"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="389467475"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 00:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="758099845"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="758099845"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.39.179])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 00:25:07 -0800
Message-ID: <df204135-f12b-4892-963c-a4c87b1dd3cb@intel.com>
Date:   Tue, 14 Nov 2023 10:25:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SDHCI AM654 driver delaying boot time
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>
Cc:     =?UTF-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?= 
        <joao.goncalves@toradex.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
References: <0e81af80de3d55e72f79af83fa5db87f5c9938f8.camel@toradex.com>
 <20231109175159.wylup6z45h7mgxji@clump>
 <ZU4748HsFFMx/bsT@francesco-nb.int.toradex.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZU4748HsFFMx/bsT@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 16:19, Francesco Dolcini wrote:
> Hello Nishant,
> 
> On Thu, Nov 09, 2023 at 11:51:59AM -0600, Nishanth Menon wrote:
>> On 18:56-20231108, João Paulo Silva Gonçalves wrote:
>>> Hello all, 
>>>
>>> We are trying to minimize boot time for our AM62 devices.
>>> Unfortunately, we have identified a delay of approximately 1.5
>>> seconds caused by the sdhci_am654 driver. This delay is a result of
>>> a timeout within the driver (MAX_POWER_ON_TIMEOUT) and was
>>> introduced in commit 7ca0f16 ("mmc: sdhci_am654: Add workaround for
>>> card detect debounce timer"). This issue arises only when there is
>>> no SD card present in the MMC slot.  We tested the driver with a
>>> lower timeout value and everything worked. However, as indicated in
>>> the commit message, this timeout may be related to the way the sdhci
>>> controller hardware IP works. Currently, the driver employs a sort
>>> of a "busy loop" to wait for this timeout to pass delaying the boot.
>>> Why is need to busy loop for this timeout? Is it possible to wait
>>> for it in the backgroud? Am I am missing something here? 
>>
>> I am not an mmc expert, but, Isn't this sequence part of the programmer
>> manual in the TRM[1]?
> 
> Probably original question from Joao was not fully understood.
> 
> It is clear why the code is waiting for the CD, the issue we are
> experiencing is that the whole boot is delayed by 1.5 seconds because of
> that piece of code for no reason.
> 
> - SD card exists in the system, but it's not used and the card slot is empty
> - We boot from eMMC (that has no CD pin)
> - Boot is delayed by 1.5 second because of that piece of code

So maybe don't use that code for eMMC?

