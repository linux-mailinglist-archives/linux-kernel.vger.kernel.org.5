Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A627800FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355716AbjHQWZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355755AbjHQWZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:25:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDF930C5;
        Thu, 17 Aug 2023 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692311116; x=1723847116;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w4PowObvRmxVD1oTiX1K4P/elTh0RZJvRqC8MRkL09E=;
  b=TLkHrjOv17l8hVRsnl60FL7mYzFi6cgUYy5k4js/VXw9c83JIWeeIovX
   I2WfM5amh9fmA0EDqwLpb0qnwQK7U+x6KlW+jE+4z6NupjNMXcbhph+1b
   JmE2+92UnwE/4T20TY/MxubZi3rNDcLocUrkCmKmm0ZWfaC7vF5GGVQfk
   xK4NqSZLKgXKWNOZSeXlJTv7oGg5big717u+rHT4Jaj6sRrXz+XboNLGb
   V6wzcjh/FUeyIbomNc4o5deXzuL4BfO7wap34hXOijBv+dMJOxPlsd4I5
   9lAVNlxzMVqh3kW3/Of0OW+PcfbjTkUSXtWer57IQt8UO8rorU3ki4wu8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="436861633"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="436861633"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 15:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="981384507"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="981384507"
Received: from wopr.jf.intel.com ([10.54.75.146])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 15:25:15 -0700
Message-ID: <5a344d1ffa66fac828feb3d1c6abce010da94609.camel@linux.intel.com>
Subject: Re: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some
 Intel systems
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     Jarkko Sakkinen <jarkko@kernel.org>, mario.limonciello@amd.com,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, len.brown@intel.com,
        charles.d.prestopine@intel.com, rafael.j.wysocki@intel.com
Date:   Thu, 17 Aug 2023 15:25:15 -0700
In-Reply-To: <CUV5EXGO425W.1RGBLDQJ8GK9W@suppilovahvero>
References: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
         <CUV5EXGO425W.1RGBLDQJ8GK9W@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-18 at 00:47 +0300, Jarkko Sakkinen wrote:
> On Fri Aug 18, 2023 at 12:09 AM EEST, Todd Brandt wrote:
> > While testing S3 on 6.5.0-rc6 we've found that 5 systems are seeing
> > a
> > crash and reboot situation when S3 suspend is initiated. To
> > reproduce
> > it, this call is all that's required "sudo sleepgraph -m mem
> > -rtcwake
> > 15".
> 
> 1. Are there logs available?
> 2. Is this the test case: https://pypi.org/project/sleepgraph/ (never
> used it before).

There are no dmesg logs because the S3 crash wipes them out. Sleepgraph
isn't actually necessary to activate it, just an S3 suspend "echo mem >
/sys/power/state".

So far it appears to only have affected test systems, not production
hardware, and none of them have TPM chips, so I'm beginning to wonder
if this patch just inadvertently activated a bug somewhere else in the
kernel that happens to affect test hardware.

I'll continue to debug it, this isn't an emergency as so far I haven't
seen it in production hardware.

> 
> I'll see if I can repeat it with QEMU + swtpm.
> 
> > I’ve created a Bugzilla to track this issue here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=217804
> 
> Thank you for reporting this.
> 
> BR, Jarkko

