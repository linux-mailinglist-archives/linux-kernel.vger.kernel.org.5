Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7A07814DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbjHRVkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbjHRVkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:40:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DAF30FE;
        Fri, 18 Aug 2023 14:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692394799; x=1723930799;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RfdGZ7rO3fwyeLR9BQcDHqA5uB9cvekhCEH4cNLXuR4=;
  b=QrgOco1PQCaaJzcEaV7GnbZ/hjpcrZzpUxG6a62jXK79MIaGBFeJhMo+
   ZzHIjKh0EB13bb5WhkiN6P4e3WaTa0gF20GGrO22PPgCpO3SlwVS+JX5j
   lJjsIIiFbo1hJaa5BbQEUwIYM5vFpwGYCpmjBKxWirn86iYXohrJmI/0F
   OK14KMy9z9b0vu7qZuskYM8v3Rb4b0g4xxBQj8bs1s/gQUBYRuJtND8F0
   y1ju4enmLxD8KRjCZ3qe95AXcqwq3QMYllJE1EZmjJfjV0DadCnI0erYB
   3SRVmKCtfk7VTZl9XW7dib8xTGf3FcVjb/IbUuP+VVYvZTMo421I9JgTF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="376963955"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="376963955"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 14:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="909026714"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="909026714"
Received: from wopr.jf.intel.com ([10.54.75.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 14:39:58 -0700
Message-ID: <9f3b82466e36aef3591d03176c04663c89625d4a.camel@linux.intel.com>
Subject: Re: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some
 Intel systems
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, len.brown@intel.com,
        charles.d.prestopine@intel.com, rafael.j.wysocki@intel.com
Date:   Fri, 18 Aug 2023 14:39:58 -0700
In-Reply-To: <eec91766-10a9-4d50-8e82-376f52f54be8@amd.com>
References: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
         <CUV5EXGO425W.1RGBLDQJ8GK9W@suppilovahvero>
         <5a344d1ffa66fac828feb3d1c6abce010da94609.camel@linux.intel.com>
         <CUV6EA5WZ2O5.5G3IV9BQITOG@suppilovahvero>
         <bd4890a3-419c-463d-88fe-905946122c9f@amd.com>
         <CUVTY0NCB0N6.VPFM83M83ZUR@suppilovahvero>
         <92b93b79-14b9-46fe-9d4f-f44ab75fd229@amd.com>
         <CUVV2MQRCGET.2U22LFQPX1J3G@suppilovahvero>
         <64f62f2f-91ef-4707-b1bb-19ce5e81f719@amd.com>
         <CUVVDC2QGWV6.HGLDFFEGMGGU@suppilovahvero>
         <eec91766-10a9-4d50-8e82-376f52f54be8@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-18 at 13:11 -0500, Mario Limonciello wrote:
> On 8/18/2023 13:07, Jarkko Sakkinen wrote:
> > On Fri Aug 18, 2023 at 8:57 PM EEST, Mario Limonciello wrote:
> > > On 8/18/2023 12:53, Jarkko Sakkinen wrote:
> > > > On Fri Aug 18, 2023 at 8:21 PM EEST, Mario Limonciello wrote:
> > > > > On 8/18/2023 12:00, Jarkko Sakkinen wrote:
> > > > > > On Fri Aug 18, 2023 at 4:58 AM EEST, Limonciello, Mario
> > > > > > wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 8/17/2023 5:33 PM, Jarkko Sakkinen wrote:
> > > > > > > > On Fri Aug 18, 2023 at 1:25 AM EEST, Todd Brandt wrote:
> > > > > > > > > On Fri, 2023-08-18 at 00:47 +0300, Jarkko Sakkinen
> > > > > > > > > wrote:
> > > > > > > > > > On Fri Aug 18, 2023 at 12:09 AM EEST, Todd Brandt
> > > > > > > > > > wrote:
> > > > > > > > > > > While testing S3 on 6.5.0-rc6 we've found that 5
> > > > > > > > > > > systems are seeing
> > > > > > > > > > > a
> > > > > > > > > > > crash and reboot situation when S3 suspend is
> > > > > > > > > > > initiated. To
> > > > > > > > > > > reproduce
> > > > > > > > > > > it, this call is all that's required "sudo
> > > > > > > > > > > sleepgraph -m mem
> > > > > > > > > > > -rtcwake
> > > > > > > > > > > 15".
> > > > > > > > > > 
> > > > > > > > > > 1. Are there logs available?
> > > > > > > > > > 2. Is this the test case: 
> > > > > > > > > > https://pypi.org/project/sleepgraph/ (never
> > > > > > > > > > used it before).
> > > > > > > > > 
> > > > > > > > > There are no dmesg logs because the S3 crash wipes
> > > > > > > > > them out. Sleepgraph
> > > > > > > > > isn't actually necessary to activate it, just an S3
> > > > > > > > > suspend "echo mem >
> > > > > > > > > /sys/power/state".
> > > > > > > > > 
> > > > > > > > > So far it appears to only have affected test systems,
> > > > > > > > > not production
> > > > > > > > > hardware, and none of them have TPM chips, so I'm
> > > > > > > > > beginning to wonder
> > > > > > > > > if this patch just inadvertently activated a bug
> > > > > > > > > somewhere else in the
> > > > > > > > > kernel that happens to affect test hardware.
> > > > > > > > > 
> > > > > > > > > I'll continue to debug it, this isn't an emergency as
> > > > > > > > > so far I haven't
> > > > > > > > > seen it in production hardware.
> > > > > > > > 
> > > > > > > > OK, I'll still see if I could reproduce it just in
> > > > > > > > case.
> > > > > > > > 
> > > > > > > > BR, Jarkko
> > > > > > > 
> > > > > > > I'd like to better understand what kind of TPM
> > > > > > > initialization path has
> > > > > > > run.  Does the machine have some sort of TPM that failed
> > > > > > > to fully
> > > > > > > initialize perhaps?
> > > > > > > 
> > > > > > > If you can't share a full bootup dmesg, can you at least
> > > > > > > share
> > > > > > > 
> > > > > > > # dmesg | grep -i tpm
> > > > > > 
> > > > > > It would be more useful perhaps to get full dmesg output
> > > > > > after power on
> > > > > > and before going into suspend.
> > > > > > 
> > > > > > Also ftrace filter could be added to the kernel command-
> > > > > > line:
> > > > > > 
> > > > > > ftrace=function ftrace_filter=tpm*
> > > > > > 
> > > > > > After bootup:
> > > > > > 
> > > > > > mount -t tracefs nodev /sys/kernel/tracing
> > > > > > cat /sys/kernel/tracing/trace
> > > > > > 
> > > > > > BR, Jarkko
> > > > > 
> > > > > Todd and I have gone back and forth a little bit on the
> > > > > bugzilla
> > > > > (https://bugzilla.kernel.org/show_bug.cgi?id=217804), and it
> > > > > seems that
> > > > > this isn't an S3 problem - it's a probing problem.
> > > > > 
> > > > > [    1.132521] tpm_crb: probe of INTC6001:00 failed with
> > > > > error 378
> > > > > 
> > > > > That error 378 specifically matches TPM2_CC_GET_CAPABILITY,
> > > > > which is the
> > > > > same command that was being requested.  This leads me to
> > > > > believe the TPM
> > > > > isn't ready at the time of probing.
> > > > > 
> > > > > In this case one solution is we could potentially ignore
> > > > > failures for
> > > > > that tpm2_get_tpm_pt() call, but I think we should first
> > > > > understand why
> > > > > it doesn't work at probing time for this TPM to ensure the
> > > > > actual quirk
> > > > > isn't built on a house of cards.
> > > > 
> > > > Given that there is nothing known broken (at the moment) in
> > > > production,
> > > > I think the following might be a reasonable change.
> > > > 
> > > > BR, Jarkko
> > > > 
> > > 
> > > Yeah that would prevent it.
> > > 
> > > Here's a simpler change that I think should work too though:
> > > diff --git a/drivers/char/tpm/tpm_crb.c
> > > b/drivers/char/tpm/tpm_crb.c
> > > index 9eb1a18590123..b0e9931fe436c 100644
> > > --- a/drivers/char/tpm/tpm_crb.c
> > > +++ b/drivers/char/tpm/tpm_crb.c
> > > @@ -472,8 +472,7 @@ static int crb_check_flags(struct tpm_chip
> > > *chip)
> > >           if (ret)
> > >                   return ret;
> > > 
> > > -       ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val,
> > > NULL);
> > > -       if (ret)
> > > +       if (tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val,
> > > NULL))
> > >                   goto release;
> > > 
> > >           if (val == 0x414D4400U /* AMD */)
> > > 
> > > I think Todd needs to check whether TPM works with that or not
> > > though.
> > 
> > Hmm... I'm sorry if I have a blind spot now but what is that
> > changing?
> > 
> > BR, Jarkko
> 
> It throws away the error code if it fails for some reason.
> Todd just checked it works too.  I'll drop it on the M/L for review.

I just ran 6.5.0-rc6 plus this patch on all 5 machines where the
problem was detected and they work now. It looks good.

Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>

