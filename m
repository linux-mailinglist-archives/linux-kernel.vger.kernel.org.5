Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7B78E517
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbjHaD3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241909AbjHaD3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:29:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BD1CD6;
        Wed, 30 Aug 2023 20:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693452539; x=1724988539;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mMebp850JOshB3+YN1rRwuWyCX0M90aaEB7z5FJE9VI=;
  b=ScauuD3sjd3M/H+zFbyF5kRLC2ORV7LCFGKU3kEbRqU0WW83g1YFDHqv
   nzfIkBn7755vsmgxkpdC5uOFtv3aZu8eynYlZIviCqESfdNjew+W3kW/n
   4XrKaRlLgIOfSMt2xZIsa14UzFyeFC1TnGlEaIKf7tWqVyxAIfNuyyaTF
   feF+1MwaJyxsX6dkRiBmFWOIBtaHpDP42aIr8d7OUUaVf3Sz+g3mK8hNy
   Qt66PJIFQ4wmLPnzyUVqbLMl2XfefUq0xFc59dXHS5yixerny2pUHed9Y
   CFvc7i4oPEQvsfPTT09g+YzWFyie+ELP410+lNKPqjTRTmsoWSZ1yyT9g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="356115591"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="356115591"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 20:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="716155798"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="716155798"
Received: from asehgal1-mobl.amr.corp.intel.com (HELO [10.212.136.74]) ([10.212.136.74])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 20:28:58 -0700
Message-ID: <934250db-b05f-4d48-8138-06986a14b3fb@linux.intel.com>
Date:   Wed, 30 Aug 2023 20:28:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] platform/x86: intel_scu_ipc: Timeout fixes
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
References: <20230831011405.3246849-1-swboyd@chromium.org>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230831011405.3246849-1-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 6:14 PM, Stephen Boyd wrote:
> I recently looked at some crash reports on ChromeOS devices that call
> into this intel_scu_ipc driver. They were hitting timeouts, and it
> certainly looks possible for those timeouts to be triggering because of
> scheduling issues. Once things started going south, the timeouts kept

Are you talking about timeouts during IPC command?

> coming. Maybe that's because the other side got seriously confused? I
> don't know. I'll poke at it some more by injecting timeouts on the
> kernel side.

Do you think it is possible due to a firmware issue?

> 
> The first two patches are only lightly tested (normal functions keep
> working), while the third one is purely speculation. I was going to make
> the interrupt delay for a long time to see if I could hit the timeout.
> 
> Stephen Boyd (3):
>   platform/x86: intel_scu_ipc: Check status after timeouts in
>     busy_loop()
>   platform/x86: intel_scu_ipc: Check status upon timeout in
>     ipc_wait_for_interrupt()
>   platform/x86: intel_scu_ipc: Fail IPC send if still busy
> 
>  drivers/platform/x86/intel_scu_ipc.c | 59 ++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
